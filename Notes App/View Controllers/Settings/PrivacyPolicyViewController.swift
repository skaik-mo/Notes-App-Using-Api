//
//  PrivacyPolicyViewController.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var forwardBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        // Do any additional setup after loading the view.
    }
    
    private func initializeView(){
        BaseApiController.init().internetConnectionChecker { (status) in
            if status{
                self.setupWebView()
            }
        }
        MainController.controlBackItem(backItem: backBarButtonItem)
        MainController.controlBackItem(backItem: forwardBarButtonItem)
    }
    
    @IBAction func backAction(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
}

extension PrivacyPolicyViewController: WKNavigationDelegate{
    
    private func setupWebView(){
        let url = URL(string: "https://www.apple.com/")
        let urlRequset = URLRequest(url: url!)
        webView.load(urlRequset)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //BaseApiController.init().showLoading()
        print("start..")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //BaseApiController.init().hideLoading()
        print("fin...")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //BaseApiController.init().showFailLoading()
        print("error")
    }
    
}
