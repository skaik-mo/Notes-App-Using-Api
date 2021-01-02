//
//  Tools.swift
//  Notes App
//
//  Created by Mohamed Skaik on 1/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    
    func showAlert(title: String, message: String, style: UIAlertAction.Style){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("LanguageOK", comment: ""), style: style, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
