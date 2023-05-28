//
//  ProfileTableViewCell.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/25.
//
import Foundation
import UIKit

class ProfileTableViewCell: UITableViewCell {
    static let identifier = "ProfileTableViewCell"
    
    let icon = UIImageView()
    
    let title: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        
        iconConstraint()
        titleConstraint()

    }
    
    required init?(coder:NSCoder){
        fatalError()
    }

    func set(cell: Cells){
        icon.image = cell.image
        title.text = cell.label
    }
    
    func iconConstraint(){
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        ])
    }
    
    func titleConstraint(){
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor,constant: 5),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    
    
    
    

}
