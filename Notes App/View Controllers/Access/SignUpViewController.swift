//
//  SignUpViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/18/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        create()
    }
    
}

extension SignUpViewController{
    
    private func check() -> Bool{
        if !firstNameText.text!.isEmpty &&
            !lastNameText.text!.isEmpty &&
            !emailText.text!.isEmpty &&
            !phoneText.text!.isEmpty &&
            !passwordText.text!.isEmpty {
                return true
        }
        //message Error
        showAlert(title: NSLocalizedString("LanguageError", comment: ""), message: NSLocalizedString("LanguageEnterInfo", comment: ""), style: .destructive)
        return false
    }
    
    private func getUser() -> User{
        return User(first_name: firstNameText.text!, last_name: lastNameText.text!, email: emailText.text!, mobile: phoneText.text!)
    }
    
    private func clear(){
        firstNameText.text = ""
        lastNameText.text = ""
        emailText.text = ""
        phoneText.text = ""
        passwordText.text = ""
    }

    private func create(){
        if check() && MainController.isValidEmail(emailAddress: emailText.text!){
            ApiUser.init().createUser(user: self.getUser(), password: passwordText.text!) { (status, message) in
                if status{
                    UserData.setStatus(status: true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
                    self.navigationController?.present(vc, animated: true, completion: nil)
                    self.clear()
                }else{
                    self.showAlert(title: "", message: message, style: .destructive)
                }
            }
        }
    }
    

    
}

