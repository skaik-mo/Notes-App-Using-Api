//
//  ProfileViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/22/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var characterUsernameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var countCategoryLabel: UILabel!
    @IBOutlet weak var countDoneNotesLabel: UILabel!
    @IBOutlet weak var countWittingNotesLabel: UILabel!

    var user: User?
    var oldFirstName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializerContrlloer()
        // Do any additional setup after loading the view.
    }
    
    private func initializerContrlloer(){
        initializeUser()
        settingsUser()
        getData()
        countCategory()
    }
    
    private func countCategory(){
        countCategoryLabel.text = String(describing: UserData.getCategoriesCount())
        countDoneNotesLabel.text = "??!"
        countWittingNotesLabel.text =  "??!"
 
    }
    
    private func settingsUser(){
        if let _user = user{
            characterUsernameLabel.text = _user.first_name!.prefix(1).uppercased()
            oldFirstName = _user.first_name ?? ""
            let fullName: String = "\(_user.first_name ?? "") \(_user.last_name ?? "")"
            userNameLabel.text = fullName
            emailLabel.text = _user.email ?? ""
        }
    }
    
    private func getData(){
        if let _user = user{
            firstNameText.text = _user.first_name
            lastNameText.text = _user.last_name
            phoneText.text = _user.mobile
            emailText.text = _user.email
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        Update()
    }
}

extension ProfileViewController{
    
    private func initializeUser(){
        user = UserData.getData()
    }
    
    private func check() -> Bool{
        if !firstNameText.text!.isEmpty &&
            !lastNameText.text!.isEmpty &&
            !phoneText.text!.isEmpty &&
            !emailText.text!.isEmpty{
            return true
        }
        return false
    }
    
    private func getUser() -> User{
        return User(first_name: firstNameText.text!, last_name: lastNameText.text!, email: emailText.text!, mobile: phoneText.text!)
    }
    
    private func Update(){
        if check(){
            ApiUser.init().updateUser(user: self.getUser()) { (status, message) in
                if status{
                    self.showAlert(title: "", message: message, style: .default)
                    self.initializeUser()
                    self.settingsUser()
                    self.getData()
                }else{
                    self.showAlert(title: "", message: message, style: .destructive)
                }
            }
        }
    }
    
}
