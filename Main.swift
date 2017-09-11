//
//  Main.swift
//  Project1_Duy
//
//  Created by Duy on 9/9/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class Main: UIViewController {

    @IBAction func VuotSangPhai(_ sender: Any) {
        
        SlideMenu()
    }
    @IBAction func VuotSangTrai(_ sender: Any) {
        SlideMenu()
    }
    
    @IBOutlet weak var ViewMain: UIView!
    
    
    @IBOutlet weak var SlideMenuV: UIView!
    var menuStatus: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewMain.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        //navigationItem.title = "Home"
        // menu lúc đầu ẩn
        SlideMenuV.frame.origin.x = -SlideMenuV.frame.width
       // SlideMenuV.frame.origin.y = 20 + (navigationController?.navigationBar.frame.height)!
        //NutMenu()
      
        
        
        
        
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        
        
        
    //    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(SlideMenu))
        
      
        
       
        
        
        
        
        /// Auto layout
       ViewMain.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        
       
    }
    
    func NutMenu(){
        let btmenu = UIButton(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        btmenu.setBackgroundImage(#imageLiteral(resourceName: "MenuImage"), for: .normal)
        navigationController?.navigationBar.addSubview(btmenu)
        btmenu.addTarget(self, action: #selector(SlideMenu), for: .touchUpInside)
        
    }
    
    
    func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = ViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    func SlideMenu(){
       menuStatus = !menuStatus
        
        switch menuStatus {
        case true:
             SlideMenuV.frame.origin.x = 0
            
           
            
        case false:
             SlideMenuV.frame.origin.x = -SlideMenuV.frame.width
            
            
        }
        
    }
    
}
