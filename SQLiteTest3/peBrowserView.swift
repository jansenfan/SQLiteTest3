//
//  peBrowserView.swift
//  SQLiteTest3
//
//  Created by jansen_fan on 2018/2/2.
//  Copyright © 2018年 jansen_fan. All rights reserved.
//

import UIKit
import WebKit

class peBrowserView: UIViewController,WKUIDelegate{
    var webView:WKWebView!
    var url:String?
    override func loadView() {
        let webconfiguration=WKWebViewConfiguration()
        webView=WKWebView(frame: .zero, configuration: webconfiguration)
        webView.uiDelegate=self
        view=webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myUrl=URL(string: url!)
        let myRequest=URLRequest(url: myUrl!)
        webView.load(myRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}

