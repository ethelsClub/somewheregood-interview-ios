
import UIKit

class InterfaceLayouts {
    
    static var logInButton: UIButton {
        
        let button = UIButton(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 2, right: 10)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.titleLabel?.font =  UIFont(name: "Menlo", size: 20)
        
        return button
    }
    
    static var logInView: UIView {
        let logInView = UIView(frame: CGRect.zero)
        logInView.backgroundColor = .orange
        logInView.translatesAutoresizingMaskIntoConstraints = false
        // could add gradient layer
        
        return logInView
    }
    
    static func layout(emailTextField: UITextField, passwordField:UITextField, logInButton: UIButton, inside logInView: UIView ) {
        let screenSize = UIScreen.main.bounds
        
        logInView.addSubview(emailTextField)
        logInView.addSubview(passwordField)
        logInView.addSubview(logInButton)
        
        emailTextField.constrainToParentView(of: logInView,
                                             padding: UIEdgeInsets(top: screenSize.width/3,
                                                                   left: 25,
                                                                   bottom: 0,
                                                                   right: -25),
                                             heightConstant: 50)
        
        passwordField.constrainToParentView(of: logInView,
                                            padding: UIEdgeInsets(top: screenSize.width/1.9,
                                                                  left: 25,
                                                                  bottom: 0,
                                                                  right: -25),
                                            heightConstant: 50)
        
        logInButton.constrainToParentView(of: logInView, padding: UIEdgeInsets(top: 300, left: 75, bottom: 10, right: -75), heightConstant: 55)
    }
    
}


extension UITextField {
    
    static func setTextField(with placeHolder: String) -> UITextField {
        
        let thisTextField = UITextField(frame: CGRect.zero)
        
        thisTextField.placeholder = placeHolder
        thisTextField.layer.cornerRadius = 15
        thisTextField.backgroundColor = .white
        thisTextField.layer.borderColor = UIColor.lightGray.cgColor
        thisTextField.clearsOnBeginEditing = true
        thisTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return thisTextField
    }
    
}

extension UIView {
    
    func constrainToSafeAreaLayout(of parentView: UIView, padding: UIEdgeInsets) -> NSLayoutConstraint {
        let topConstraint = topAnchor.constraint(equalTo: parentView.topAnchor,
                                                 constant: padding.top)
        topConstraint.isActive = true
        
        leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor,
                                 constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor,
                                  constant: padding.right).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor,
                                constant: padding.bottom).isActive = true
        return topConstraint
    }
    
    func constrainToParentView(of parentView: UIView, padding: UIEdgeInsets, heightConstant: CGFloat) {
        
        topAnchor.constraint(equalTo: parentView.topAnchor,
                             constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor,
                                 constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor,
                                  constant: padding.right).isActive = true
        heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        
    }
}

