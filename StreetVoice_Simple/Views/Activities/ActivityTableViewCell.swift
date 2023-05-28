//
//  ActivityTableViewCell.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/23.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    static let identify = "ActivityTableViewCell"
    
    let titleImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        // 超出 musicImageView 边界的内容将被裁剪掉
        return imageView
    }()
    
    let title: UILabel = {
        var title = UILabel()
        title.numberOfLines = 0
        // 文本行数设置为 0 将根据內容自动换行，以适应其内容的长度
        title.adjustsFontSizeToFitWidth = true
        // 自动调整字体大小属性，文本内容超出了可用空间的宽度，文本的字体大小将自动缩小以适应可用空间
        return title
    }()
    
    let content: UILabel = {
        var title = UILabel()
        title.numberOfLines = 0
        // 文本行数设置为 0 将根据內容自动换行，以适应其内容的长度
        title.adjustsFontSizeToFitWidth = true
        // 自动调整字体大小属性，文本内容超出了可用空间的宽度，文本的字体大小将自动缩小以适应可用空间
        return title
    }()
    
    let contentImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        // 超出 musicImageView 边界的内容将被裁剪掉
        return imageView
    }()
    
//    let shareBtn: UIButton = {
//        var button = UIButton()
//        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
//        return button
//    }()
//    
//    let loveBtn: UIButton = {
//        var button = UIButton()
//        button.setImage(UIImage(systemName: "heart"), for: .normal)
//        return button
//    }()
//    
//    let commentBtn: UIButton = {
//        var button = UIButton()
//        button.setImage(UIImage(systemName: "ellipsis.bubble"), for: .normal)
//        return button
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleImageView)
        addSubview(title)
        addSubview(content)
        addSubview(contentImageView)
        
        configureFonts()
        setTitleImageConstrain()
        setTitleConstrain()
        setContentConstrain()
        setContentImageConstrain()
        

    }
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    func configureFonts() {
        // 設置字体样式
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        content.font = UIFont.systemFont(ofSize: 14)
    }
    
    func setTitleImageConstrain(){
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        // 向左對齊且y軸要一起置中對齊
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: topAnchor,constant: 15),
            titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            titleImageView.heightAnchor.constraint(equalToConstant: 70),
            titleImageView.widthAnchor.constraint(equalTo: titleImageView.heightAnchor)
        ])
    }
    
    func set(report: Report){
        titleImageView.image = UIImage(named: "therappers")
        title.text = report.managerName
        content.text = report.content
        contentImageView.image = report.contentImage
    }
    
    func setTitleConstrain(){
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: titleImageView.topAnchor),
            title.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor,constant: 8),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
    
    func setContentConstrain(){
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 5),
            content.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor,constant: 8),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func setContentImageConstrain(){
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: content.bottomAnchor,constant: 5),
            contentImageView.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor,constant: 8),
            contentImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentImageView.heightAnchor.constraint(equalToConstant: 250),
            contentImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
