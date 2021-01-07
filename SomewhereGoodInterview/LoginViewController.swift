//
//  LoginViewController.swift
//  SomewhereGoodInterview
//
//  Created by Vanessa Flores on 1/7/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    typealias LoginCredentials = (email: String, password: String)
    
    // MARK: - Outlets
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginErrorLabel: UILabel!
    

    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginErrorLabel.isHidden = true

        configureUI()
    }
    
    // MARK: - UIConfiguration
    
    private func configureUI() {
        configureLogoImageView()
        configureInputContainer()
    }
    
    private func configureLogoImageView() {
        logoImageView.image = UIImage(named: "somewheregood-1")
    }
    
    private func configureInputContainer() {
        inputContainer.layer.cornerRadius = 50
        inputContainer.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    
    // MARK: - Helpers
    
    func isValidEmail() -> Bool {
        guard let email = emailTextField.text, !email.isEmpty else {
            return false
        }
        
        let emailRange = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[a-z]ar", options: .caseInsensitive)
        
        guard regex.firstMatch(in: email, options: [], range: emailRange) != nil else {
            return false
        }
        
        return true   
    }
    
    func isValidPassword() -> Bool {
        guard let password = passwordTextField.text, !password.isEmpty,
        password.count > 8 else {
            return false
        }
        
        return true
    }
    
    private func validLogin() -> LoginCredentials? {
        guard isValidEmail() && isValidPassword() else {
            return nil
        }
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return nil
        }
        
        return (email, password)
    }
    
    
    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        loginErrorLabel.isHidden = true
        
        if let userLogin = validLogin() {
            print("Validate login on the backend")
        } else {
            loginErrorLabel.isHidden = false
        }
    }
    

}
