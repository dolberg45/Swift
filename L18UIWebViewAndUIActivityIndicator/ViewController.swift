//
//  ViewController.swift
//  L18UIWebViewAndUIActivityIndicator
//
//  Created by Григорий on 29.10.2020.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: - Application outlets.
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var goBackButtonItem: UIBarButtonItem!
    @IBOutlet weak var goForwardButtonItem: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let application = UIApplication.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.sizeToFit()
        
//        if let urlPdf = Bundle.main.url(forResource: "4", withExtension: "pdf") {
//            let request = URLRequest(url: urlPdf)
//            webView.load(request)
//        }
        
        
        if let myUrl = URL(string: "https://yandex.ru/") {
            let request = URLRequest(url: myUrl)
            webView.load(request)
            print("port ------   \(myUrl.port)")
        }

        
    }
    
    
    //MARK: - WKUIDelegate
    
    //Equivalent of webViewDidStartLoad
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isWorkIndicator(isAnimated: true, indicator: self.activityIndicator)
        self.goBackButtonItem.isEnabled = false
        self.goForwardButtonItem.isEnabled = false
    }
    
    //Equivalent of webViewDidFinishLoad
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isWorkIndicator(isAnimated: false, indicator: self.activityIndicator)
        if webView.canGoBack {
            self.goBackButtonItem.isEnabled = true
        } else if webView.canGoForward {
            self.goForwardButtonItem.isEnabled = true
        }
    }
    
    //Equivalent of shouldStartLoadWithRequest
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var action: WKNavigationActionPolicy?
        
        defer {
            decisionHandler(action ?? .allow)
        }

        guard let url = navigationAction.request.url else {
            return
        }
        print("shouldStartLoadWithReques: \(url)")
        
//        if navigationAction.navigationType == .linkActivated, url.absoluteString.hasPrefix("https://developer.apple.com/") {
//                    action = .cancel  // Stop in WebView
//                    UIApplication.shared.open(url)
//                }
    }
    
    
    
    //MARK: - Action/target methods.
    @IBAction func goBackAction(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardAction(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    //MARK: - Worked methods.
    func isWorkIndicator(isAnimated: Bool, indicator: UIActivityIndicatorView) {
        if isAnimated == true {
            indicator.startAnimating()
            indicator.isHidden = false
        } else if isAnimated == false {
            indicator.stopAnimating()
            indicator.isHidden = true
        }
    }
    
}

