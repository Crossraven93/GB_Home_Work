//
//  LoginViewController.swift
//  homeWork_1
//
//  Created by Антон (Macbook Pro) on 3/1/19.
//  Copyright © 2019 Антон (Macbook Pro). All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!

    
    @IBOutlet weak var process: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @IBAction func sign_in(_ sender: Any) {
        
        
        if let logText = login.text,
            let passText = password.text {
            
            if logText == "user" && passText == "123" {
                process.textColor = UIColor.green
                process.text = "Success"
            } else {
                
                process.textColor = UIColor.red
                process.text = "Error"
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if let logText = login.text,
            let passText = password.text {
            
            if logText == "user" && passText == "123" {
                process.textColor = UIColor.green
                process.text = "Success"
                return true
            } else {
                
                process.textColor = UIColor.red
                process.text = "Error"
                
                let alter = UIAlertController(title: "Error", message: "Incorrect data", preferredStyle: .alert)
                // Создаем кнопку для UIAlertController
                let action = UIAlertAction(title: "Try again", style: .destructive, handler: nil)
                // Добавляем кнопку на UIAlertController
                alter.addAction(action)
                // Показываем UIAlertController
                present(alter, animated: true, completion: nil)
                
                return false
                
            }
        }
        return false
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrameValue.cgRectValue.height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue){
        
    }
}
