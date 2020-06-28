//
//  Validations.swift
//  WalletX
//
//  Created by ElintMinds_11 on 19/03/20.
//  Copyright © 2020 ElintMinds_11. All rights reserved.
//

import UIKit


func isValidEmail(emailTextField:FloatingTextField) -> Bool{
    let isValid = isValidEmail(email: emailTextField.text)
    
    if !isValid{
        UIImpactFeedbackGenerator.init(style: .heavy).impactOccurred()
        emailTextField.vibrate()
        emailTextField.errorMessage = invalidEmail
    }
    return isValid
}

func isValidPassword(passwordTextField:FloatingTextField) -> Bool{
    let isValid = isValidPassword(password: passwordTextField.text)
    if !isValid{
        UIImpactFeedbackGenerator.init(style: .heavy).impactOccurred()
        passwordTextField.vibrate()
        passwordTextField.errorMessage = invalidPassword
    }
    
    return isValid
}


func isValidEmail(email: String?) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email ?? "")
}

func isValidPassword(password: String?) -> Bool {
    return (password ?? "").count  >= 6
}

extension UIView{
    func vibrate(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 4, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 4, y: center.y))

        layer.add(animation, forKey: "position")
    }
}
