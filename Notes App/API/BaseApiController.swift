//
//  BaseApiController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 7/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import TTGSnackbar
import SCLAlertView
import SVProgressHUD

class BaseApiController {
    
    func showMessage(message:String, isError: Bool = true){
        let snackbar = TTGSnackbar(message: message, duration: .middle)
        //snackbar.messageTextFont = UIFont(name: "DIN Next LT W23", size: 15)!
        
        if isError{
            snackbar.actionTextColor = UIColor.white
            snackbar.backgroundColor = UIColor.red
        }else{
            snackbar.actionTextColor = UIColor.blue
            snackbar.messageTextColor = UIColor.blue
            snackbar.backgroundColor = UIColor.white
        }
        snackbar.show()
    }
    
    public func noInternetErrorMessage(callback: @escaping InternetConnectionChecker){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false,
            shouldAutoDismiss: false
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Try Again") {
            if MainController.isConnectedToInternet(){
                alertView.hideView()
//                self.blurView.removeBlurView()
                callback(true)
            }else{
                callback(false)
            }
        }
        alertView.showError("Internt Connection", subTitle: "Check your internet connection")
    }
    
    public func internetConnectionChecker(callback: @escaping InternetConnectionChecker){
        if MainController.isConnectedToInternet() {
            //callback intenrt connection available
            callback(true)
        }else{
//            self.blurView.showBlurView()
            noInternetErrorMessage(callback: callback)
        }
    }
    
    public func showLoading(){
//        SVProgressHUD.setForegroundColor(UIColor.gray)
//        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.show()
    }

    public func hideLoading(){
        SVProgressHUD.dismiss()
    }
    
    public func showFailLoading(){
        SVProgressHUD.showError(withStatus: "Failed")
    }
    
}
