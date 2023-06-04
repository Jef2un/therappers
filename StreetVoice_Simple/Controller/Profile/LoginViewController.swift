
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseCore


class LoginViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    //MARK: UI宣告
    
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
    
    private let register: UIButton = {
        var btn = UIButton()
        btn.setTitle("註冊", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()
    
    private let loginBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("登入", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    private let gmail: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "gmail"), for: .normal)
        
        return btn
    }()
    
    
    private let fb: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "facebook"), for: .normal)
        
        return btn
    }()
    
    private lazy var btnStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [gmail,fb])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 50
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "登入"
        view.addSubview(welcome)
        view.addSubview(text)
        view.addSubview(accountInput)
        view.addSubview(passwordInput)
        view.addSubview(register)
        view.addSubview(loginBtn)
        view.addSubview(btnStackView)
        
        welcomeConstraint()
        textConstraint()
        accountConstraint()
        passwordConstraint()
        registerConstraint()
        loginBtnConstraint()
        stackViewConstraint()
        
        register.addTarget(self, action: #selector(toRegister), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(authentication), for: .touchUpInside)
        gmail.addTarget(self, action: #selector(gmailAuthentication), for: .touchUpInside)
        tapToEndEdit()
        
    }
    
    
    
    //MARK: Objc Function
    
    @objc func gmailAuthentication(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                // ...
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // ...
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // ...
            Auth.auth().signIn(with: credential) { result, error in
                
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                } else {
                    ShareManager.shared.isSignIn = true
                    let tabBarVC = TabBarViewController()
                    tabBarVC.modalPresentationStyle = .fullScreen
                    present(tabBarVC, animated: true)
                    
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    //MARK: - Firebase Normal Auth
    @objc func authentication(){
        if let email = accountInput.text{
            if let password = passwordInput.text{
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    guard self != nil else { return }
                    if let error = error{
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(alert, animated: true)
                    }else{
                        ShareManager.shared.isSignIn = true
                        let tabBarVC = TabBarViewController()
                        tabBarVC.modalPresentationStyle = .fullScreen
                        self!.present(tabBarVC, animated: true)
                        
                    }
                }
            }
        }
    }
    
    @objc func toRegister(){
        let popRegVC = RegisterViewController()
        popRegVC.modalPresentationStyle = .popover
        present(popRegVC, animated: true)
        
    }
    
    
    
    func tapToEndEdit(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
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
    
    func registerConstraint(){
        register.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            register.trailingAnchor.constraint(equalTo: passwordInput.trailingAnchor),
            register.topAnchor.constraint(equalTo: passwordInput.bottomAnchor,constant: 15)
            
        ])
    }
    
    func loginBtnConstraint(){
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginBtn.topAnchor.constraint(equalTo: register.bottomAnchor,constant: 15),
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            loginBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func stackViewConstraint(){
        btnStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnStackView.leadingAnchor.constraint(equalTo: loginBtn.leadingAnchor,constant: 100),
            btnStackView.trailingAnchor.constraint(equalTo: loginBtn.trailingAnchor, constant: -100),
            btnStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100),
            btnStackView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    
}
