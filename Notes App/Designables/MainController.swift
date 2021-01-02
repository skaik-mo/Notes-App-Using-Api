//
//  MainController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 7/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import TTGSnackbar

class MainController {
    
    public static func showMessage(message:String, isError: Bool = true){
        let snackbar = TTGSnackbar(message: message, duration: .middle)
        snackbar.messageTextFont = UIFont(name: "Droid Arabic Kufi", size: 15)!
        
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
    
    public static func isValidEmail(emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailAddress)
    }
    
    public static func isConnectedToInternet() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
    
    public static func getString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    public static func setCustomCorners(view: UIView, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomRightRadius:CGFloat, bottomLeftRadius: CGFloat) {
        print("MIN Y: \(view.layer.bounds.minY)")
        let minx = view.layer.bounds.minX
        let miny = view.layer.bounds.minY
        let maxx = view.layer.bounds.maxX
        let maxy = view.layer.bounds.maxY
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minx + topLeftRadius, y: miny))
        
        path.addLine(to: CGPoint(x: maxx - topRightRadius, y: miny))
        path.addArc(withCenter: CGPoint(x: maxx - topRightRadius, y: miny + topRightRadius), radius: topRightRadius, startAngle:CGFloat(3 * (Double.pi/2)), endAngle: 0, clockwise: true)
        
        path.addLine(to: CGPoint(x: maxx, y: maxy - bottomRightRadius))
        path.addArc(withCenter: CGPoint(x: maxx - bottomRightRadius, y: maxy - bottomRightRadius), radius: bottomRightRadius, startAngle: 0, endAngle: CGFloat((Double.pi/2)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx + bottomLeftRadius, y: maxy))
        path.addArc(withCenter: CGPoint(x: minx + bottomLeftRadius, y: maxy - bottomLeftRadius), radius: bottomLeftRadius, startAngle: CGFloat((Double.pi/2)), endAngle: CGFloat((Double.pi)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx, y: miny + topLeftRadius))
        path.addArc(withCenter: CGPoint(x: minx + topLeftRadius, y: miny + topLeftRadius), radius: topLeftRadius, startAngle: CGFloat((Double.pi)), endAngle: CGFloat(3 * (Double.pi/2)), clockwise: true)
        path.close()
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    public static func addBackButton(back: UIBarButtonItem){
        var image: UIImage;
        if L102Language.currentAppleLanguage().elementsEqual("en"){
            image = UIImage(named: "ic_header_back_right.png")!
        }else{
            image = UIImage(named: "ic_header_back_left.png")!
        }
        image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        back.image = image
    }
    
    public static func openWebsite(website: String){
        if let url = URL(string: website) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    public static func controlBackItem(backItem: UIBarButtonItem){
        if L102Language.currentAppleLanguage().elementsEqual("ar"){
            if let _img = backItem.image {
                backItem.image =  UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
            }
        }
    }
    
}


