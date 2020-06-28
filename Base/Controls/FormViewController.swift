//
//  FormViewController.swift
//  WalletX
//
//  Created by ElintMinds_11 on 05/03/20.
//  Copyright © 2020 ElintMinds_11. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    var returnKeyType:UIReturnKeyType = .go
    
    var emailField:FloatingTextField?
    var passwordFields = [FloatingTextField]()
    
    var fields:Array<UITextField> = []{
        didSet{
            for field in fields{
                field.returnKeyType = .next
                if field ==  fields.last{
                    field.returnKeyType = returnKeyType
                }
                field.delegate = self
            }
        }
    }
    
    
    func doneAction(){
        
    }
    
}

extension FormViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        for (index,field) in fields.enumerated(){
            if field == textField && index != fields.count - 1{
                fields[index + 1].becomeFirstResponder()
                break
            }else{
                field.resignFirstResponder()
                if index == fields.count - 1{
                    doneAction()
                }
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string:textField.text!).replacingCharacters(in: range, with: string)
        
        if let textField = textField as? FloatingTextField{
            if textField == emailField{
                if  isValidEmail(email:text){
                    emailField?.errorMessage =  nil
                }
            }else if passwordFields.contains(textField){
                if isValidPassword(password: text){
                    textField.errorMessage = nil
                }
            }else if text.count > 0 {
                textField.errorMessage = nil
            }
            
        }
        
        return true
        
    }
    
    
}
