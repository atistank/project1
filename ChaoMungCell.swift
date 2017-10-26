//
//  ChaoMungCell.swift
//  Project1_Duy
//
//  Created by Duy on 9/9/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell{
    let backgroundCell: UIImageView = {
        let bk = UIImageView()
        bk.image = #imageLiteral(resourceName: "programmer")
      bk.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bk.contentMode = .scaleAspectFit // giu nguyen ty le hinh
        bk.clipsToBounds = true
        return bk
    }()
    
  
    
    let labeltext: UILabel = {
       let l = UILabel()
        l.text  = "Welcome to my App"
        l.sizeToFit()
        l.font = UIFont(name: "Helvetica", size: 30.0)
        
        l.textAlignment = .center
        l.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    
    let textdescription: UILabel = {
        let l = UILabel()
        l.text  = "You’ve worked hard to develop an app or game that people will find useful and enjoy using ?"
        l.sizeToFit()
        l.font = UIFont(name: "system", size: 9.0)
        l.numberOfLines = 3
        l.textAlignment = .center
        l.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    
    let hoacText: UILabel = {
        let l = UILabel()
        l.text  = "Hoặc"
        l.sizeToFit()
        l.font = UIFont(name: "system", size: 9.0)
        l.numberOfLines = 3
        l.textAlignment = .center
        l.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return l
    }()
    
    
    lazy var google: UIButton = {
        let st = UIButton(type: .system)
        st.setTitle("Log in with facebook", for: .normal)
        st.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        st.backgroundColor = #colorLiteral(red: 0.171889931, green: 0.3709711432, blue: 0.9556652904, alpha: 1)
        st.layer.cornerRadius = 27
        st.clipsToBounds = true
        
        st.addTarget(self, action: #selector(chuyenManHinhMain), for: .touchUpInside)
        return st
    }()
    
    
    lazy var StarButton: UIButton = {
        let st = UIButton(type: .system)
        st.setTitle("Đăng ký nào !", for: .normal)
        st.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        st.backgroundColor = #colorLiteral(red: 0.9985899329, green: 0.2290443182, blue: 0.09162571281, alpha: 1)
        st.layer.cornerRadius = 27
        st.clipsToBounds = true
      
        st.addTarget(self, action: #selector(chuyenManHinhMain), for: .touchUpInside)
        return st
    }()
    
    
    var delegateChuyenManHinh: ChuyenManHinhLoginDelegate?
    @objc func chuyenManHinhMain(){
        delegateChuyenManHinh?.chuyenmanhinh()
    }
    
  
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        addSubview(textdescription)
        addSubview(labeltext)
        addSubview(backgroundCell)
        addSubview(google)
        addSubview(hoacText)
        addSubview(StarButton)
        let gradientx = CAGradientLayer()
        gradientx.colors = [UIColor.blue,UIColor.red]
        gradientx.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientx.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientx.frame = StarButton.bounds
        StarButton.layer.insertSublayer(gradientx, at: 0)
        
        labeltext.anchor(topAnchor, left: leftAnchor, bottom: textdescription.topAnchor, right: rightAnchor, topConstant: 70, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 50)
        
        textdescription.anchor(labeltext.bottomAnchor, left: leftAnchor, bottom: backgroundCell.topAnchor, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 70)
       
        _ = backgroundCell.anchor(topAnchor, left: leftAnchor, bottom: StarButton.topAnchor, right: rightAnchor, topConstant: 180, leftConstant: 40, bottomConstant: 150, rightConstant: 40, widthConstant: 0, heightConstant: 0)
        _ = google.anchor(nil, left: leftAnchor, bottom: hoacText.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 26, bottomConstant: 10, rightConstant: 26, widthConstant: 0, heightConstant: 50)
       
        _ = hoacText.anchor(nil, left: leftAnchor, bottom: StarButton.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 26, bottomConstant: 10, rightConstant: 26, widthConstant: 0, heightConstant: 0)
      _ =  StarButton.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 26, bottomConstant: 50, rightConstant: 26, widthConstant: 0, heightConstant: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
