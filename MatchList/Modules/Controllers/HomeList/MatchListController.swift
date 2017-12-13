//
//  MatchListController.swift
//  MatchList
//
//  Created by Mauricio Figueroa olivares on 11-12-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import UIKit

class MatchListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var matchLit = [Matchs]()
    let manager = ApiManager()
    var refresh: UIRefreshControl!
    let matchs = Matchs()
    var page: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        // Register headerCell
        collectionView?.register(MatchListHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        // Register contentCell
        collectionView?.register(MatchListContent.self, forCellWithReuseIdentifier: "cellId")
        //Load Match
        loadMatchs()
    }
    
    func loadMatchs() {
        manager.loadApiMatchs(page: page) { (matchs, message, error) in
            if !error {
                guard let list = matchs else { return }
                DispatchQueue.main.async {
                    self.matchLit = list
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // create header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! MatchListHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matchLit.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MatchListContent
        cell.matchs = matchLit[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 320)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork() {
            if indexPath.item == self.matchLit.count - 1 {
                page = page == 0 ? page : page - 1
                if page > 0 {
                    DispatchQueue.main.async {
                        self.manager.loadApiMatchs(page: self.page, callback: { (matchs, message, error) in
                            guard let list = matchs else { return }
                            self.matchLit = list
                            self.collectionView?.reloadData()
                        })
                    }
                }
            }
        }
    }
}
