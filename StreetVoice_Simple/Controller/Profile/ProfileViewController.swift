//
//  ProfileViewController.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?

    private let loginImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "therappers")
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        return image
    }()
    
    private let text:UILabel = {
        var text = UILabel()
        text.text = "還沒登入呢"
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.numberOfLines = 0
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    private let loginBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("登入", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    @objc func buttonTapped(){
        let popVC = LoginViewController()
        popVC.modalPresentationStyle = .popover
        present(popVC, animated: true)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "我的"

        addView()
        loginBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        subviewConstrain()
        

    }

    private func addView(){
        view.addSubview(loginBtn)
        view.addSubview(loginImage)
        view.addSubview(text)
    }
    
    private func subviewConstrain(){
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginImage.widthAnchor.constraint(equalToConstant: 100),
            loginImage.heightAnchor.constraint(equalToConstant: 100),
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.topAnchor.constraint(equalTo: loginImage.bottomAnchor,constant: 10),
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.topAnchor.constraint(equalTo: text.bottomAnchor,constant: 10),
            loginBtn.widthAnchor.constraint(equalToConstant: 50),

            
        ])
        
    }
}
