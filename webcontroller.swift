//
//  webcontroller.swift
//  Project1_Duy
//
//  Created by Duy on 10/20/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class webcontroller: UIViewController {

    var htmlNoiDung = ""
    
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: htmlNoiDung)!))
   //     webView.loadHTMLString(htmlNoiDung, baseURL: nil)
    
    }

    
}
