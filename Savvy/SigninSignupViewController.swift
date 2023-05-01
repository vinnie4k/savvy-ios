//
//  SigninSignupViewController.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import UIKit
class SigninSignupViewController: UIViewController {
    var logoImageView = UIImageView()
    var logoLabel = UILabel()
    var taglineLabel = UILabel()
    var signinButton = UIButton()
    var signupButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        let is_authenticated = UserDefaults.standard.bool(forKey: "is_authenticated") // return false if not found or stored value
        if (is_authenticated == true) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            sceneDelegate.moveToViewController()
        }
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        logoImageView.image = UIImage(named: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImageView)
        
        logoLabel.text = "savvy"
        logoLabel.textColor = .black
        logoLabel.font = .systemFont(ofSize: 56 , weight: .medium)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoLabel)
        
        taglineLabel.text = "tagline"
        taglineLabel.textColor = .black
        taglineLabel.font = .systemFont(ofSize: 20)
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(taglineLabel)
        
        signinButton.setTitle("sign in", for: .normal)
        signinButton.setTitleColor(.black, for: .normal)
        signinButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signinButton.layer.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        signinButton.layer.borderColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        signinButton.layer.cornerRadius = 24
        signinButton.layer.borderWidth = 1
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        self.view.addSubview(signinButton)
        
        signupButton.setTitle("sign up", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signupButton.layer.backgroundColor = UIColor.white.cgColor
        signupButton.layer.borderColor = UIColor.black.cgColor
        signupButton.layer.cornerRadius = 24
        signupButton.layer.borderWidth = 1
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        self.view.addSubview(signupButton)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 256),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 61),
            logoImageView.heightAnchor.constraint(equalToConstant: 61)
        ])
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            logoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoLabel.widthAnchor.constraint(equalToConstant: 154),
            logoLabel.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        NSLayoutConstraint.activate([
            taglineLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 12),
            taglineLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            taglineLabel.widthAnchor.constraint(equalToConstant: 64),
            taglineLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 120),
            signinButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signinButton.widthAnchor.constraint(equalToConstant: 248),
            signinButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: 12),
            signupButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 248),
            signupButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc func signIn() {
        print ("Open sign in page.")
        let newViewController = SigninViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func signUp() {
        print ("Open sign up page to create user.")
    }
    
    private func showAlert (title: String, message: String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
              alertMessage.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
              self.present(alertMessage, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
