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
        bk.image = #imageLiteral(resourceName: "image1")
        bk.contentMode = .scaleAspectFill // giu nguyen ty le hinh
        bk.clipsToBounds = true
        return bk
    }()
    
    lazy var StarButton: UIButton = {
        let st = UIButton(type: .system)
        st.setTitle("Bắt Đầu Nào", for: .normal)
        st.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        st.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        st.addTarget(self, action: #selector(chuyenManHinhMain), for: .touchUpInside)
        return st
    }()
    
    var delegateChuyenManHinh: ChuyenManHinhLoginDelegate?
    @objc func chuyenManHinhMain(){
        delegateChuyenManHinh?.chuyenmanhinh()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundCell)
        addSubview(StarButton)
        backgroundCell.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
      _ =  StarButton.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 26, bottomConstant: 50, rightConstant: 26, widthConstant: 0, heightConstant: 50)     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
