//
//  ManHinh2controller.swift
//  Project1_Duy
//
//  Created by Duy on 10/21/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ManHinh2controller: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0.0, y: 0.0, width: 180.0, height: 40.0)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        
        
        
        button.clipsToBounds = true
    
        button.layer.cornerRadius = 6
        button.buttonGradient(color1: UIColor(red: 112.0/255.0, green: 219.0/255.0, blue: 155.0/255.0, alpha: 1.0), color2: UIColor(red: 86.0/255.0, green: 197.0/255.0, blue: 238.0/255.0, alpha: 1.0))
     // button.buttonGradient2(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color3: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), color4: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        
        
        
        
    }
   
    
    
    func login(){
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                print(fbloginresult)
            if (result?.isCancelled)!{
                print("da cancel")
                return
            }
            if(fbloginresult.grantedPermissions.contains("email"))
                {
                    print("da lay thong tin")
                }
            }
        }

    }
}
