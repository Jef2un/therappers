//
//  RegisterViewController.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    private let welcome:UILabel = {
        var text = UILabel()
        text.text = "歡迎來到TheRappers"
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.numberOfLines = 0
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    private let text:UILabel = {
        var text = UILabel()
        text.text = "立即登入啟用完整的個人化功能"
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.numberOfLines = 0
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    private let accountInput:UITextField = {
        var account = UITextField()
        account.placeholder = "  電子郵件"
        account.borderStyle = .line
        account.layer.borderColor = UIColor.secondaryLabel.cgColor
        account.layer.borderWidth = 1.0
        return account
    }()
    
    private let passwordInput:UITextField = {
        var password = UITextField()
        password.placeholder = "  密碼"
        password.isSecureTextEntry = true
        password.borderStyle = .line
        password.layer.borderColor = UIColor.secondaryLabel.cgColor
        password.layer.borderWidth = 1.0
        return password
    }()
    
    private let registerBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("註冊", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "登入"
        view.addSubview(welcome)
        view.addSubview(text)
        view.addSubview(accountInput)
        view.addSubview(passwordInput)
        view.addSubview(registerBtn)
        
        welcomeConstraint()
        textConstraint()
        accountConstraint()
        passwordConstraint()
        registerBtnConstraint()
        
        registerBtn.addTarget(self, action: #selector(authentication), for: .touchUpInside)
        
    }
    
    @objc func authentication(){
        if let email = accountInput.text{
            if let password = passwordInput.text{
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error{
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }else{
                        self.dismiss(animated: true, completion: nil)

                    }
                }
            }
        }

    }
    
    func welcomeConstraint(){
        welcome.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcome.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
    }
    func textConstraint(){
        text.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            text.topAnchor.constraint(equalTo: welcome.bottomAnchor,constant: 5)
        
        ])
    }
    
    func accountConstraint(){
        accountInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountInput.topAnchor.constraint(equalTo: text.bottomAnchor,constant: 15),
            accountInput.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            accountInput.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            accountInput.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func passwordConstraint(){
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: accountInput.bottomAnchor,constant: 5),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            passwordInput.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func registerBtnConstraint(){
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerBtn.topAnchor.constraint(equalTo: passwordInput.bottomAnchor,constant: 15),
            registerBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            registerBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            registerBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
