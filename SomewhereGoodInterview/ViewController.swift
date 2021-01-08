//
//  ViewController.swift
//  SomewhereGoodInterview
//
//  Created by Alejandro Luperon on 11/20/20.
//

import UIKit

enum InputType: String {
    case Email = "Email"
    case Password = "Password"
}

class ViewController: UIViewController, UITextFieldDelegate {

    lazy var emailTextField = UITextField.setTextField(with: "Email")
    lazy var passwordField =  UITextField.setTextField(with: "Password")
    
    var logInView = InterfaceLayouts.logInView
    var logInButton = InterfaceLayouts.logInButton
    
    var loginViewTopAnchor = NSLayoutConstraint()

    // in product, for security these 2 need to be in an encrapted class
    var emailContent = ""
    var passwordContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // graident
        view.layer.backgroundColor = UIColor(red: 62/255, green: 64/255, blue: 186/255, alpha: 1).cgColor
        // set delegate
        passwordField.delegate = self
        emailTextField.delegate = self
        
        // add events
        logInButton.addTarget(self, action: #selector(logInAction), for: .touchUpInside)
        
        // add keyboard event listeners
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDismiss), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // draw UI
        drawUIElements()
    }
    
    func drawUIElements() {
        
        view.addSubview(logInView)
        
        loginViewTopAnchor = logInView.constrainToSafeAreaLayout(of: view, padding: UIEdgeInsets(top: UIScreen.main.bounds.height * (1/3), left: 0, bottom: 0, right: 0))
        
        InterfaceLayouts.layout(emailTextField: emailTextField,
                                passwordField: passwordField,
                                logInButton: logInButton,
                                inside: logInView)
    }
    
    func resetLogInButton() {
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .clear
    }
    
    @objc func logInAction() {
        // log in action
        keyboardWillDismiss()
        
        let isEmailValid = validateInput(type: .Email)
        let isPasswordValid = validateInput(type: .Password)
        
        if (isEmailValid && isPasswordValid) {
            // do log in action
            resetLogInButton()
        } else  {
            logInButton.setTitle("Not valid", for: .normal)
            logInButton.backgroundColor = .red
        }
    }
    
    @objc func keyboardWillShow() {
        resetLogInButton()
        
        loginViewTopAnchor.constant = 0
        logInView.setNeedsLayout()
    }
    
    @objc func keyboardWillDismiss() {
        
        loginViewTopAnchor.constant = UIScreen.main.bounds.height * (1/3)
        logInView.setNeedsDisplay()
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        guard let fieldType = textField.placeholder else { return false }
        
        switch InputType(rawValue: fieldType) {
        case .Email:
            emailContent.append(string)
        case .Password:
            passwordContent.append(string)
        case .none:
            print("oops, something went wrong")
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func dismissKeyboard(){
        emailTextField.resignFirstResponder()
    }
    
    func validateInput(type: InputType) -> Bool {
        
        switch type {
        case .Email:
            return (emailContent.contains("@") && emailContent.count >= 2 )
        case .Password:
            return (passwordContent.count >= 8)
        }
    }
    
    
    /**
     
     email check @
     password check >= 8
     
     */
    
}


