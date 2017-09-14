//
//  Main.swift
//  Project1_Duy
//
//  Created by Duy on 9/9/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class Main: UIViewController {

    @IBOutlet weak var thongbao: UILabel!
    @IBOutlet weak var Nut: UIBarButtonItem!
    
    var menuStatus: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        Nut.target = SWRevealViewController()
        Nut.action = #selector(SWRevealViewController().revealToggle(_:))
        thongbao.text = String(UserDefaults.standard.isLoggedIn())
        
        
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))

//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(SlideMenu))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
      
    }
    
    func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = ViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    func SlideMenu(){
    
        }
        
    
    
}
