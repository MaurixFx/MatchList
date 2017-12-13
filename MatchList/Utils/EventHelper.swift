//
//  EventHelper.swift
//  MatchList
//
//  Created by Mauricio Figueroa olivares on 12-12-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import Foundation
import EventKit

class EventHelper {
    let appleEventStore = EKEventStore()
    var calendars: [EKCalendar]?
    
    func generateEvent(match: Matchs) {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch (status)
        {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar(match: match)
        case EKAuthorizationStatus.authorized:
            // User has access
            print("User has access to calendar")
            self.addAppleEvents(match: match)
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            noPermission()
        }
    }
    
    func noPermission() {
        print("User has to change settings...goto settings to view access")
    }
    
    func requestAccessToCalendar(match: Matchs) {
        appleEventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                DispatchQueue.main.async {
                    print("User has access to calendar")
                    self.addAppleEvents(match: match)
                }
            } else {
                DispatchQueue.main.async{
                    self.noPermission()
                }
            }
        })
    }
    
    func getValidateDate(eventDate: String) -> Int {
        let date = Date()
        return date.offsetHourFrom(date: getDateStart(date: eventDate))
    }
    
    func isValidDateToCalendarEvent(eventDate: String) -> Bool {
        return getValidateDate(eventDate: eventDate) <= -1
    }
    
    func addAppleEvents(match: Matchs) {
        let calendar = Calendar.current
        let event:EKEvent = EKEvent(eventStore: appleEventStore)
        event.title = getTitleEvent(localName: match.localTeamName!, visitName: match.visitTeamName!)
        event.startDate = calendar.date(byAdding: .month, value: 8, to: getDateStart(date: match.startDate!))
        event.endDate = calendar.date(byAdding: .hour, value: 2, to: event.startDate)
        print(event.startDate)
        print(event.endDate)
        event.notes = match.stadiumName
        event.calendar = appleEventStore.defaultCalendarForNewEvents
        // 60 seconds before
        let alarm:EKAlarm = EKAlarm(relativeOffset: -60)
        event.alarms = [alarm]
        event.isAllDay = true
        
        do {
            try appleEventStore.save(event, span: .thisEvent)
            print("events added with dates:")
        } catch let e as NSError {
            print(e.description)
            return
        }
        print("Saved Event")
    }
}
