//
//  MatchListContent.swift
//  MatchList
//
//  Created by Mauricio Figueroa olivares on 11-12-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import UIKit
import SDWebImage

class MatchListContent: UICollectionViewCell {
    
    let eventHelper = EventHelper()
    let alert = SCLAlertView()
    var matchs: Matchs? {
        didSet {
            guard let myMatchs = matchs else { return }
            setupViewMatch(match: myMatchs)
        }
    }
    
    // Create Container View
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
     // Create Labels
    let nameTournamentLabel: UILabel = {
        let label = UILabel()
        label.text = "CAMPEONATO NACIONAL"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = COLOR_PRINCIPAL
        return label
    }()
    
    let detailMatchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = COLOR_PRINCIPAL
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        return label
    }()
    
    let stadiumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = COLOR_PRINCIPAL
        label.font = UIFont(name: "AvenirNext-Regular", size: 15)
        return label
    }()
    
    let localGoalsLabel: UILabel = {
        let label = UILabel()
        label.textColor = COLOR_GOALS
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Bold", size: 40)
        return label
    }()
    
    let separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .center
        label.textColor = COLOR_GOALS
        label.font = UIFont(name: "AvenirNext-Bold", size: 40)
        return label
    }()
    
    let visitGoalsLabel: UILabel = {
        let label = UILabel()
        label.textColor = COLOR_GOALS
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Bold", size: 40)
        return label
    }()
    
    let nameTeamLocalLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = COLOR_PRINCIPAL
        label.font = UIFont(name: "AvenirNext-Bold", size: isSmallPhone() ? 14 : 16)
        return label
    }()
    
    let nameTeamVisitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = COLOR_PRINCIPAL
        label.font = UIFont(name: "AvenirNext-Bold", size: isSmallPhone() ? 14 : 16)
        return label
    }()
    
    // Create Image Teams
    let localTeamImageView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "team-icon-antofa_prueba"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let visitTeamImageView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "team-icon-antofa_prueba"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    // Create Button Image Calendar
    let calendarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "time").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let nameTitleRemember: UILabel = {
        let label = UILabel()
        label.text = "Recordar"
        label.textAlignment = .center
        label.textColor = COLOR_PRINCIPAL
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        calendarButton.addTarget(self, action: #selector(MatchListContent.addEventToCalendar), for: .touchUpInside)
    }
    
    func setupView() {
        // Add compoments to View
        addSubview(containerView)
        containerView.addSubview(nameTournamentLabel)
        containerView.addSubview(detailMatchLabel)
        containerView.addSubview(stadiumLabel)
        containerView.addSubview(localTeamImageView)
        containerView.addSubview(visitTeamImageView)
        // Config constraints
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        nameTournamentLabel.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 30)
        nameTournamentLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        detailMatchLabel.anchor(top: nameTournamentLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 30)
        stadiumLabel.anchor(top: detailMatchLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 30)
        detailMatchLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        stadiumLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        containerView.addSubview(localTeamImageView)
        localTeamImageView.anchor(top: stadiumLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 30, paddingRight: 0, paddingBottom: 0, width: isSmallPhone() ? 80 : 100, height: isSmallPhone() ? 80 : 100)
        containerView.addSubview(visitTeamImageView)
        visitTeamImageView.anchor(top: localTeamImageView.topAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 30, paddingBottom: 0, width: isSmallPhone() ? 80 : 100, height: isSmallPhone() ? 80 : 100)
        
        // Config Stack View Goals
        setupStackViewGoals()
    }
    
    func setupStackViewGoals() {
        // Create a StackView
        let stackView = UIStackView(arrangedSubviews: [localGoalsLabel, separatorLabel, visitGoalsLabel])
        stackView.backgroundColor = .lightGray
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        self.containerView.addSubview(stackView)
        // Create separator
        let dividerView = UIView()
        dividerView.backgroundColor = COLOR_SEPARATOR_VIEW

        // Add constraints to StackView
        stackView.anchor(top: stadiumLabel.bottomAnchor, left: localTeamImageView.rightAnchor, bottom: nil, right: visitTeamImageView.leftAnchor, paddingTop: 30, paddingLeft: 10, paddingRight: 10, paddingBottom: 0, width: 0, height: 50)

        //Add team Names
        containerView.addSubview(nameTeamLocalLabel)
        containerView.addSubview(nameTeamVisitLabel)
        containerView.addSubview(dividerView)
        //Config Constraints
        nameTeamLocalLabel.anchor(top: localTeamImageView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: isSmallPhone() ? 100 : 120, height: 50)
        nameTeamVisitLabel.anchor(top: visitTeamImageView.bottomAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 20, paddingBottom: 0, width: isSmallPhone() ? 100 : 120, height: 50)
        containerView.addSubview(calendarButton)
        containerView.addSubview(nameTitleRemember)
        dividerView.anchor(top: nil, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 8)
        nameTitleRemember.anchor(top: nil, left: nil, bottom: dividerView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 5, width: 60, height: 30)
        nameTitleRemember.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        calendarButton.anchor(top: nil, left: nil, bottom: nameTitleRemember.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 30, height: 30)
        calendarButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    func setupViewMatch(match: Matchs) {
        // Asign values to Component of View
        nameTeamLocalLabel.text = match.localTeamName
        nameTeamVisitLabel.text = match.visitTeamName
        localGoalsLabel.text = "\(match.localGoals)"
        visitGoalsLabel.text = "\(match.visitGoals)"
        detailMatchLabel.text = getDetailMatch(match: match)
        stadiumLabel.text = match.stadiumName
        self.localTeamImageView.sd_setImage(with: URL(string: match.localTeamImage!), placeholderImage: nil, options: [.continueInBackground, .progressiveDownload])
        self.visitTeamImageView.sd_setImage(with: URL(string: match.visitTeamImage!), placeholderImage: nil, options: [.continueInBackground, .progressiveDownload])
    }
    
    func getDetailMatch(match: Matchs) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: match.startDate!)
        let time = getTextoFTime(hour: calendar.component(.hour, from: date!), minutes: calendar.component(.minute, from: date!))
        let day = calendar.component(.day, from: date!)
        let month = getTextOfMonth(month: calendar.component(.month, from: date!))
        let finalString = "\(day) \(month) - \(time)"
        return finalString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addEventToCalendar() {
        guard let myMatchs = matchs else { return }
        if !eventHelper.isValidDateToCalendarEvent(eventDate: myMatchs.startDate!) {
            alert.showError("Ups", subTitle: "El partido ya se jugó")
        } else {
            // Add event to calendar
            eventHelper.generateEvent(match: myMatchs)
        }
    }
}
