//
//  TrinhDuyetController.swift
//  Project1_Duy
//
//  Created by Duy on 11/4/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class TrinhDuyetController: UIViewController {
    var lichsu:Array<String> = Array<String>()
    var indexViTri:Int = 0
    
    @IBAction func btnBack(_ sender: Any) {
        // nút back
        if lichsu.count > 0
        {
            print("tao ne")
            indexViTri -= 1
            if indexViTri < 0
            {
                indexViTri = 0
            }
            let url:URL = URL(string: lichsu[indexViTri])!
            let req:URLRequest = URLRequest(url: url)
            web.loadRequest(req)
        }
        
    }
    
    @IBAction func btnNext(_ sender: Any) {
        //nút Next
        if lichsu.count > 0
        {
            indexViTri += 1
            if indexViTri > lichsu.count - 1
            {
                indexViTri =  lichsu.count - 1 // nếu vị trí vượt qua giới hạn thi đặt ở ở cuối
            }
            let url:URL = URL(string: lichsu[indexViTri])!
            let req:URLRequest = URLRequest(url: url)
            web.loadRequest(req)
        }
        
    }
    
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var Link: UITextField!
    
    @IBAction func reload(_ sender: Any) {
        web.reload()
        
    }
    
    @IBAction func Go(_ sender: Any) {
        
        if  let url = URL(string: Link.text!)
        {
            var link:String = Link.text!
            if link.hasPrefix("http://") || link.hasPrefix("https://")
            {
                lichsu.append(link)
                let req: URLRequest = URLRequest(url: url)
                
                web.loadRequest(req)
                
                
                
                
            }
            else
            {
                // thêm hppt vào url ko có http
                link = "http://\(link)"
                lichsu.append(link)
                
                let url2:URL = URL(string: link)!
                let req: URLRequest = URLRequest(url: url2)
                
                web.loadRequest(req)
            }
            indexViTri = lichsu.count - 1
        }
        else
        {
            print("loi")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         let url2 = URL(string: "https://www.google.com.vn")
        let req: URLRequest = URLRequest(url: url2!)
        web.loadRequest(req)
        
    }
    
   
    
    
}
