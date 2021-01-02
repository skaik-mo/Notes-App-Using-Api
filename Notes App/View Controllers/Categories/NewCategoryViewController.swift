//
//  NewCategoryViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var typeViewLabel: UILabel!
    
    @IBOutlet weak var titleCategoryText: UITextField!
    @IBOutlet weak var descriptionCategoryTxet: UITextField!
        
    var category: Category?
    var isUpdate: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        // Do any additional setup after loading the view.
    }
    
    private func initializeView(){
        if isUpdate!{
            titles(typeView: "LanguageUpdateCategory")
            updateView()
        }else{
            titles(typeView: "LanguageNewCategory")
        }
    }
    
    private func titles(typeView: String){
        titleViewLabel.text = NSLocalizedString("LanguageCategory", comment: "")
        typeViewLabel.text = NSLocalizedString(typeView, comment: "")
    }
    

    @IBAction func saveAction(_ sender: Any) {
        if isUpdate!{
            update()
        }else{
            create()
        }
    }
}

extension NewCategoryViewController{
    
    private func check() -> Bool{
        if !titleCategoryText.text!.isEmpty &&
            !descriptionCategoryTxet.text!.isEmpty{
            return true
        }
        //message Error
        showAlert(title: NSLocalizedString("LanguageError", comment: ""), message: NSLocalizedString("LanguageEnterInfo", comment: ""), style: .destructive)
        return false
    }
    
    private func clear(){
        titleCategoryText.text = ""
        descriptionCategoryTxet.text = ""
    }
    
    private func create(){
        if check(){
            ApiCategory.init().create(title: titleCategoryText.text!, details: descriptionCategoryTxet.text!) { (status, message) in
                if status{
                    self.showAlert(title: "", message: message, style: .default)
                    self.clear()
                }else{
                    self.showAlert(title: "", message: message, style: .destructive)
                }
            }
        }
    }
    
}

extension NewCategoryViewController{
    private func updateView(){
        titleCategoryText.text = category?.title
        descriptionCategoryTxet.text = category?.details
    }
    
    private func update(){
        if check(){
            if let _id = category?.id{
                ApiCategory.init().update(id: _id, title: titleCategoryText.text!, details: descriptionCategoryTxet.text!) { (status, message) in
                    if status{
                        self.showAlert(title: "", message: message, style: .default)
                    }else{
                        self.showAlert(title: "", message: message, style: .destructive)
                    }
                }
            }
        }
    }
    
}
