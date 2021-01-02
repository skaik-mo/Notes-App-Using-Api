//
//  UserData.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/26/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation

class UserData {
    
    private static let KeyFisrtName: String = "FISRTNAME"
    private static let KeyLastName: String = "LASTNAME"
    private static let KeyEmail: String = "EMAIL"
    private static let KeyPhone: String = "PHONE"
    private static let KeyStatus: String = "STATUS"
    private static let KeyToken: String = "TOKEN"
    private static let KeyCategoriesCount: String = "CATEGORIESCOUNT"
    private static let KeyNotesCount: String = "NOTESCOUNT"

    public static func setData(user: User){
        UserDefaults.standard.set(user.first_name, forKey: KeyFisrtName)
        UserDefaults.standard.set(user.last_name, forKey: KeyLastName)
        UserDefaults.standard.set(user.email, forKey: KeyEmail)
        UserDefaults.standard.set(user.mobile, forKey: KeyPhone)
        UserDefaults.standard.set(user.token, forKey: KeyToken)
        UserDefaults.standard.set(user.categories_count, forKey: KeyCategoriesCount)
        UserDefaults.standard.set(user.notes_count, forKey: KeyNotesCount)

    }
  
    public static func getToken() -> String{
        return UserDefaults.standard.string(forKey: KeyToken) ?? ""
    }
    
    public static func setEmail(email: String){
        UserDefaults.standard.set(email, forKey: KeyEmail)
    }
    
    public static func clearUserDefault(){
        UserDefaults.standard.removeObject(forKey: KeyFisrtName)
        UserDefaults.standard.removeObject(forKey: KeyLastName)
        UserDefaults.standard.removeObject(forKey: KeyEmail)
        UserDefaults.standard.removeObject(forKey: KeyPhone)
        UserDefaults.standard.removeObject(forKey: KeyToken)
        UserDefaults.standard.removeObject(forKey: KeyCategoriesCount)
        UserDefaults.standard.removeObject(forKey: KeyNotesCount)
    }
    
    public static func setStatus(status: Bool){
        UserDefaults.standard.set(status, forKey: KeyStatus)
    }

    public static func getStatus() -> Bool{
        return UserDefaults.standard.bool(forKey: KeyStatus)
    }

    public static func setCategoriesCount(categories_count: Int){
        UserDefaults.standard.set(categories_count, forKey: KeyCategoriesCount)
    }

    public static func getCategoriesCount() -> Int{
        return UserDefaults.standard.integer(forKey: KeyCategoriesCount)
    }
    
    public static func getData() -> User{
        let first_name = UserDefaults.standard.string(forKey: KeyFisrtName) ?? ""
        let last_name = UserDefaults.standard.string(forKey: KeyLastName) ?? ""
        let email = UserDefaults.standard.string(forKey: KeyEmail) ?? ""
        let mobile = UserDefaults.standard.string(forKey: KeyPhone) ?? ""
        let token = UserDefaults.standard.string(forKey: KeyToken) ?? ""
        let categories_count = UserDefaults.standard.integer(forKey: KeyCategoriesCount)
        let notes_count = UserDefaults.standard.integer(forKey: KeyNotesCount)
        return User(first_name: first_name, last_name: last_name, email: email, mobile: mobile, token: token, categories_count: categories_count, notes_count: notes_count)
    }
    
}
