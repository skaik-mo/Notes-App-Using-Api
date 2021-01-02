//
//  NewNoteViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
          
    var category_id: Int?
    var note: Note?
    var isUpdate: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializerView()

    }
    
    private func initializerView(){
        if isUpdate!{
            updateView()
            titles(typeView: "LanguageUpdateNote")
        }else{
            titles(typeView: "LanguageNewNote")
        }
    }
    
    private func titles(typeView: String){
        titleLabel.text = NSLocalizedString("LanguageNote", comment: "")
        typeLabel.text = NSLocalizedString(typeView, comment: "")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if isUpdate!{
            update()
        }else{
            create()
        }
    }
    
}

extension NewNoteViewController{

    private func check() ->Bool{
        if !titleText.text!.isEmpty &&
            !descriptionText.text!.isEmpty{
            return true
        }
        //message Error
        showAlert(title: NSLocalizedString("LanguageError", comment: ""), message: NSLocalizedString("LanguageEnterInfo", comment: ""), style: .destructive)
        return false
    }
    
    private func clear(){
        titleText.text = ""
        descriptionText.text = ""
    }
    
    private func create(){
        if check(){
            ApiNote.init().create(title: titleText.text!, details: descriptionText.text!, category_id: category_id!) { (status, message) in
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

extension NewNoteViewController{
    private func updateView(){
        titleText.text = note?.title
        descriptionText.text = note?.details
    }
    
    private func update() -> Bool{
        if check(){
            ApiNote.init().update(title: titleText.text!, details: descriptionText.text!, note_id: (note?.id)!) { (status, message) in
                if status{
                    self.showAlert(title: "", message: message, style: .default)
                }else{
                    self.showAlert(title: "", message: message, style: .destructive)
                }
            }
        }
        return false
    }
    
}
