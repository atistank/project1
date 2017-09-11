//
//  NavigationCustom.swift
//  Project1_Duy
//
//  Created by Duy on 9/10/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            //kakaka fix được bug rồi
            
            //set vc là một view Main trong storyboard ánh xạ với class main.swift
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ManHinhHome") as! Main
            
            // set màn hình khởi động là màn hình main
            let homeController = vc
            viewControllers = [homeController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    func showLoginController() {
        // nếu đã logout thì trở về viewcontroller để đăng nhập lại
        let loginController = ViewController()
        present(loginController, animated: true, completion: {
            
        })
    }
}
