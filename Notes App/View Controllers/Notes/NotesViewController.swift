//
//  NotesViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet var noteTableView: UITableView!

    private var notes: [Note] = [Note]()
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializerView()
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let id = category?.id{
            indexNotes(category_id: id)
        }
    }
    
    private func initializerView(){
        navigation()
        initializeTableView()
    }
    
    private func navigation(){
        navigationItem.title = category?.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    
    @IBAction func newNoteAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewNoteViewController") as! NewNoteViewController
        vc.category_id = category?.id
        vc.isUpdate = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func initializeTableView(){
        noteTableView.delegate = self
        noteTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.checkButtonDelegate = self
        cell.indexPath = indexPath
        cell.setData(note: notes[indexPath.row])
        let status = doneOrWiating(status: notes[indexPath.row].status!)
        cell.isStatusButton(isStatus: status)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewNoteViewController") as! NewNoteViewController
        vc.note = notes[indexPath.row]
        vc.isUpdate = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            delete(indexPath: indexPath)
        }
    }
    
    private func delete(indexPath: IndexPath) {
        if let note_id = notes[indexPath.row].id, let category_id = category?.id {
            ApiNote.init().delete(note_id: note_id) { (status, message) in
                if status{
                    self.indexNotes(category_id: category_id)
                }
            }
        }
    }
    
    private func indexNotes(category_id: Int){
        ApiNote.init().indexNotes(category_id: category_id) { (status, notes) in
            if status{
                self.notes = notes
                self.noteTableView.reloadData()
            }
        }
    }
    
}


extension NotesViewController: CheckButton{
    
    func status(indexPath: IndexPath, statusButton: UIButton){
        if let category_id = category?.id{
            ApiNote.init().updateStatusNote(note_id: notes[indexPath.row].id!) { (status, message) in
                if status{
                    //self.indexNotes(category_id: category_id)
                    self.changeDoneOrWiating(statusButton: statusButton)
                }else{
                    
                }
            }
        }
    }

    private func doneOrWiating(status: String) -> Bool{
        if status == "Waiting"{
            return false
        }
        return true
    }
    
    private func changeDoneOrWiating(statusButton: UIButton){
        if statusButton.tintColor == UIColor(named: "#98CE63"){
            statusButton.tintColor = UIColor(named: "#C4C4C4")
            return
        }
        statusButton.tintColor = UIColor(named: "#98CE63")
    }
    
}


