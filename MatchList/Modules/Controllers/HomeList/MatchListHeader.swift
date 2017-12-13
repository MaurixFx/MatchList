//
//  MatchListHeader.swift
//  MatchList
//
//  Created by Mauricio Figueroa olivares on 11-12-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import UIKit

class MatchListHeader: UICollectionViewCell {
    
    //Create containerView with Label
    let containerView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "LISTADO DE PARTIDOS"
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.textColor = COLOR_TEXT
        view.addSubview(label)
        label.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 30)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = COLOR_PRINCIPAL
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        // Add container to view
        addSubview(containerView)
        //config constraint
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
