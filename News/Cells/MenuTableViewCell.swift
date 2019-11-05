//
//  MenuTableViewCell.swift
//  News
//
//  Created by Igor Lungis on 11/4/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    static let reuseId = "MenuTableCell"
    let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(myLabel)
        backgroundColor = .clear
        myLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
