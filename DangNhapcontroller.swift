//
//  DangKycontroller.swift
//  Project1_Duy
//
//  Created by Duy on 10/28/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class DangKycontroller: UIViewController {
    @IBOutlet weak var Viewlogin: UIView!
    @IBOutlet weak var NutUser: UIView!
    
    @IBOutlet weak var NutPass: UIView!

    @IBOutlet weak var NutDangNhap: UIButton!
   
    @IBOutlet weak var ViewCover: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        customLoginView()
    }
    @IBOutlet weak var NutDangKy: UIButton!
    
    
    
    func customLoginView(){
       
     
       
        // bo tròn cell tý xíu
        Viewlogin.layer.cornerRadius = 5.0
        Viewlogin.layer.masksToBounds = false
        // đổ bóng cell
        Viewlogin.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        // cho bóng ngả màu nhẹ tý
        Viewlogin.layer.shadowOffset = CGSize(width: 0, height: 0)
        Viewlogin.layer.shadowOpacity = 0.8
        
        
        NutUser.backgroundColor = .white
      
        NutPass.backgroundColor = .white
//        NutPass.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        NutPass.layer.borderWidth = 1
        NutDangNhap.clipsToBounds = true
          NutDangNhap.layer.cornerRadius = 30
        NutDangNhap.buttonGradient(color1: #colorLiteral(red: 0, green: 0.5098039216, blue: 1, alpha: 1), color2: #colorLiteral(red: 0, green: 0.9182613996, blue: 1, alpha: 1))
//      NutDangKy.clipsToBounds = true
//       NutDangKy.layer.cornerRadius = 30
//        NutDangKy.buttonGradient(color1: #colorLiteral(red: 0, green: 0.5098039216, blue: 1, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        
    }
}
