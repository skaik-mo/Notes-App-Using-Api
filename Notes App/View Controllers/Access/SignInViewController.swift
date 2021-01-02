//
//  SignInViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/18/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeController()
    }
    
    private func initializeController(){
        navigation()
    }
    
    private func navigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
           login()
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        clear()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SignInViewController{
    
    private func check() -> Bool{
        if !emailText.text!.isEmpty &&
            !passwordText.text!.isEmpty{
            return true
        }
        //message Error
        showAlert(title: NSLocalizedString("LanguageError", comment: ""), message: NSLocalizedString("LanguageEnterInfo", comment: ""), style: .destructive)
        return false
    }
    
    private func clear(){
        emailText.text = ""
        passwordText.text = ""
    }
    
    private func login(){
        if check(){
            ApiUser.init().login(email: emailText.text!, password: passwordText.text!) { (status, message) in
                if status{
                    UserData.setStatus(status: true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")  as! UINavigationController
                    self.navigationController?.present(vc, animated: true, completion: nil)
                    self.clear()
                }else{
                    self.showAlert(title: "", message: message, style: .destructive)
                }
            }
        }
    }
    
}

