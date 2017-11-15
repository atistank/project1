//
//  TrinhDuyetController.swift
//  Project1_Duy
//
//  Created by Duy on 11/4/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
import Whisper

class TrinhDuyetController: UIViewController {
    var lichsu:Array<String> = Array<String>()
    var indexViTri:Int = 0
    
    @IBOutlet weak var NaviGia: UIVisualEffectView!
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
        
        var link:String = Link.text!
        link = link.replacingOccurrences(of: " ", with: "%")
//        if  let url = URL(string: link)
//        {
        
            
            if link.hasPrefix("http://") || link.hasPrefix("https://")
            {
                lichsu.append(link)
                if  let url = URL(string: link){
                    let req: URLRequest = URLRequest(url: url)
                    web.loadRequest(req)
                }
                
            }
            else
            {
                if link.suffix(4) == ".com" || link.suffix(3) == (".vn")
                {
                    // thêm hppt vào url ko có http
                    link = "http://\(link)"
                    print(link)
                    lichsu.append(link)
                    
                    
                    let url2:URL = URL(string: link)!
                    let req: URLRequest = URLRequest(url: url2)
                    
                    web.loadRequest(req)
                }
                else
                {
                    // thêm hppt vào url ko có http
                    link = "http://google.com/search?q=\(link)"
                    lichsu.append(link)
                      print(link)
                    if let url2:URL = URL(string: link) {
                        let req: URLRequest = URLRequest(url: url2)
                        web.loadRequest(req)
                    }
                   
                    
                }
            }
            indexViTri = lichsu.count - 1

    //    }
//        else
//        {
//            let murmur = Murmur(title: "Lổi rồi bồ !!!")
//            Whisper.show(whistle: murmur, action: .show(0.5))
//        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         let url2 = URL(string: "https://www.google.com.vn")
        let req: URLRequest = URLRequest(url: url2!)
        web.loadRequest(req)
    
        
    }
    
   
    
    
}
