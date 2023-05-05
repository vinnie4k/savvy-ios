//
//  SigninViewController.swift
//  Savvy
//
//  Created by Jenny Yu on 4/30/23.
//

import UIKit

class SigninViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let signinLabel = UILabel()
    let usernameLabel = UILabel()
    var usernameTextField = UITextField()
    let passwordLabel = UILabel()
    var passwordTextField = UITextField()
    var signinButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
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
        
        signinLabel.text = "Sign in to continue"
        signinLabel.textColor = .black
        signinLabel.font = .systemFont(ofSize: 20)
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signinLabel)
        
        usernameLabel.text = "Username"
        usernameLabel.textColor = .black
        usernameLabel.font = .systemFont(ofSize: 16)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(usernameLabel)
        
        usernameTextField.textColor = UIColor.black
        usernameTextField.font = .systemFont(ofSize: 14 , weight: .medium)
        usernameTextField.layer.cornerRadius = 9
        usernameTextField.layer.borderWidth = 2
        usernameTextField.layer.borderColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.layer.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        usernameTextField.autocapitalizationType = .none
        view.addSubview(usernameTextField)
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = .black
        passwordLabel.font = .systemFont(ofSize: 16)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordLabel)
        
        passwordTextField.textColor = UIColor.black
        passwordTextField.font = .systemFont(ofSize: 14 , weight: .medium)
        passwordTextField.layer.cornerRadius = 9
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
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
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 190),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 61),
            logoImageView.heightAnchor.constraint(equalToConstant: 61)
        ])
        
        NSLayoutConstraint.activate([
            signinLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            signinLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signinLabel.widthAnchor.constraint(equalToConstant: 176),
            signinLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: signinLabel.bottomAnchor, constant: 53),
            usernameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 17),
            usernameTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            usernameTextField.widthAnchor.constraint(equalToConstant: 318),
            usernameTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 28),
            passwordLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 17),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            passwordTextField.widthAnchor.constraint(equalToConstant: 318),
            passwordTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 62),
            signinButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signinButton.widthAnchor.constraint(equalToConstant: 318),
            signinButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    @objc func signIn() {
        
        guard let netid = usernameTextField.text, !netid.isEmpty else {
                showAlert(message: "Please enter your username")
                return
            }
            guard let password = passwordTextField.text, !password.isEmpty else {
                showAlert(message: "Please enter your password")
                return
            }
            if let user = getUser(netid: netid) {
                if user.password == password {
                    print("User authenticated!")
                    UserDefaults.standard.set(true, forKey: "is_authenticated")
                    UserDefaults.standard.set(user.id, forKey: "id")
                    UserDefaults.standard.set(netid, forKey: "netid")
                    UserDefaults.standard.set(user.name, forKey: "userName")
                    UserDefaults.standard.set(user.password, forKey: "password")
                    UserDefaults.standard.set(user.classYear, forKey: "classYear")
                    do {
                        let encodedData = try JSONEncoder().encode(user.savedPosts)
                        UserDefaults.standard.set(encodedData, forKey: "savedPosts")
                    } catch {
                        // Failed to encode Contact to Data
                    }
                    
                    UserDefaults.standard.synchronize()
                    let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                    sceneDelegate.moveToViewController()
                    self.dismiss(animated: true, completion: nil)
                } else {
                    showAlert(message: "Incorrect password")
                }
            } else {
                showAlert(message: "User not found")
            }
    }
    
    
    private func showAlert (message: String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
              alertMessage.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
              self.present(alertMessage, animated: true, completion: nil)
    }
    
    private func getUser(netid: String) -> User? {
        for user in users {
                if user.netid == netid {
                    return user
                }
            }
            return nil
    }
}
