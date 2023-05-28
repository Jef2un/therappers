//
//  ActifityDetailViewController.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/23.
//

import UIKit



class ActifityDetailViewController: UIViewController {
    
    var report: Report?
    
    let titleImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.clipsToBounds = true
        // 超出 musicImageView 边界的内容将被裁剪掉
        return imageView
    }()
    
    let titleText: UILabel = {
        var title = UILabel()
        title.numberOfLines = 0
        title.font = .boldSystemFont(ofSize: 16)
        // 文本行数设置为 0 将根据內容自动换行，以适应其内容的长度
        title.adjustsFontSizeToFitWidth = true
        // 自动调整字体大小属性，文本内容超出了可用空间的宽度，文本的字体大小将自动缩小以适应可用空间
        return title
    }()
    
    let content: UILabel = {
        var title = UILabel()
        title.numberOfLines = 0
        // 文本行数设置为 0 将根据內容自动换行，以适应其内容的长度
        //  title.adjustsFontSizeToFitWidth = true
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
    
    func set(){
        titleImageView.image = UIImage(named: "therappers")
        titleText.text = report?.managerName
        content.text = report?.content
        contentImageView.image = report?.contentImage

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleImageView)
        view.addSubview(titleText)
        view.addSubview(content)
        view.addSubview(contentImageView)
        
        contentImageConstraint()
        titleImgConstraint()
        titleConstraint()
        contentConstraint()
        set()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleImageView.layer.cornerRadius = titleImageView.frame.size.width / 2
    }
    
    func titleImgConstraint(){
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/6),
            titleImageView.widthAnchor.constraint(equalTo: titleImageView.heightAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            
        ])
    }
    
    func titleConstraint(){
        titleText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleText.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor),
            titleText.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor,constant: 10),
            
        
        ])
    }
    
    func contentConstraint(){
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: titleImageView.leadingAnchor),
            content.topAnchor.constraint(equalTo: titleImageView.bottomAnchor,constant: 5),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15)
        
        ])

        
    }
    
    
    func contentImageConstraint(){
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            contentImageView.leadingAnchor.constraint(equalTo: titleImageView.leadingAnchor),
            contentImageView.topAnchor.constraint(equalTo: content.bottomAnchor),
            contentImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15)
        ])
    }
}
