//
//  NoteTableViewCell.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

protocol CheckButton{
    func status(indexPath: IndexPath, statusButton: UIButton)
}

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var descriptionNoteLabel: UILabel!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var statusButton: UIButton!
    
    var checkButtonDelegate: CheckButton?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setData(note: Note){
        titleNoteLabel.text = note.title
        descriptionNoteLabel.text = note.details
    }
    
    public func getTitle() -> String{
        return titleNoteLabel.text!
    }

    public func getDescription() -> String{
        return descriptionNoteLabel.text!
    }
    
    @IBAction func statusAction(_ sender: Any) {
        if let _checkButtonDelegate = checkButtonDelegate, let _indexPath = indexPath{
            _checkButtonDelegate.status(indexPath: _indexPath, statusButton: statusButton)
        }
    }
    
    public func isStatusButton(isStatus: Bool){
        if isStatus{
            statusButton.tintColor = UIColor(named: "#98CE63")
            return
        }
        statusButton.tintColor = UIColor(named: "#C4C4C4")
    }
}
