//
//  DangKyUserController.swift
//  Project1_Duy
//
//  Created by Duy on 11/1/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class DangKyUserController: UIViewController {

    @IBOutlet weak var NutDangKyOutlet: UIButton!
    
    @IBOutlet weak var NutHuyoutlet: UIButton!
    @IBOutlet weak var Nametxt: UITextField!
    
    @IBOutlet weak var Emailtxt: UITextField!
    
    @IBOutlet weak var Passtxt: UITextField!
    
    @IBAction func Huybtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func NutDangKyAction(_ sender: Any) {
        let nameuser = Nametxt.text
        let emailUser = Emailtxt.text
        let password = Passtxt.text
        
        let url = URL(string: "https://blogdevtoidicodedao.herokuapp.com/add_user")
        var request:URLRequest = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = "username=\(nameuser!)&email=\(emailUser!)&password=\(password!)&avatar=\("http://s3.amazonaws.com/37assets/svn/765-default-avatar.png")&cover=\("https://cache.oceanhub.com/img/front/cag/default-cover.jpg")&quyenhan=1&trangthai=1&like=0".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
            if err != nil {
            
            print(err)
                return
            }
                  print(String(data: data!, encoding: .utf8)!)
        }).resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        NutHuyoutlet.clipsToBounds = true
        NutHuyoutlet.layer.cornerRadius = 27
        NutHuyoutlet.buttonGradient(color1: #colorLiteral(red: 1, green: 0.1884425879, blue: 0, alpha: 1), color2: #colorLiteral(red: 0.9966098666, green: 0.3500299454, blue: 0.724849999, alpha: 1))
        // Do any additional setup after loading the view.
     
        NutDangKyOutlet.clipsToBounds = true
        NutDangKyOutlet.layer.cornerRadius = 27
        NutDangKyOutlet.buttonGradient(color1: #colorLiteral(red: 0, green: 0.5098039216, blue: 1, alpha: 1), color2: #colorLiteral(red: 0, green: 0.9182613996, blue: 1, alpha: 1))
        // Do any additional setup after loading the view.
    }

    

}
