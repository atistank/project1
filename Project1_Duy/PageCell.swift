//
//  PageCell.swift
//  Project1_Duy
//
//  Created by Duy on 9/7/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
class Pagecell: UICollectionViewCell {
    var page: Trang?{
        didSet {
            guard  let TrangHD = page else {
                return
            }
            HinhHuongDan.image = UIImage(named: TrangHD.imageName )
            
            let Mau = UIColor(white: 0.2, alpha: 1) // Màu color
            
            let attributedText = NSMutableAttributedString(string: (page?.title)!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium), NSForegroundColorAttributeName: Mau])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page!.Huongdan)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName: Mau]))
            
            let VanBanStyle = NSMutableParagraphStyle()
            VanBanStyle.alignment = .center
            let DoDaiText = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: VanBanStyle, range: NSRange(location: 0, length: DoDaiText)  )
      //      MoTa.text = page?.title + "\n\n" + page?.Huongdan
            MoTa.attributedText = attributedText
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        CaiDat()
    }
    let HinhHuongDan: UIImageView = {
        
        let Hinh = UIImageView()
        Hinh.contentMode = .scaleAspectFill // giu nguyen ty le hinh
        Hinh.backgroundColor = #colorLiteral(red: 1, green: 0.708275497, blue: 0.09586834162, alpha: 1)
        Hinh.image = #imageLiteral(resourceName: "page1")
        Hinh.clipsToBounds = true
        return Hinh
    }()
    let MoTa: UITextView = {
        let textView = UITextView()
        textView.text = "Huong dan su dung app"
        // để text cách Hình 1 khoảng trắng 24
        textView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        
        textView.isEditable = false
        return textView
        
    }()
    // tạo một line ngang
    let LineNgang:UIView = {
        let Line = UIView()
        Line.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return Line
    }()
    
    
    func CaiDat(){
        // Add vao view
        addSubview(HinhHuongDan)
        addSubview(MoTa)
        addSubview(LineNgang)
        HinhHuongDan.anchorToTop(topAnchor, left: leftAnchor, bottom: MoTa.topAnchor, right: rightAnchor)
        
  //      MoTa.anchorToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        //Neo Mô tả vào Hình HD và cách 2 bên 16
        MoTa.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        MoTa.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        //Neo Đường Line
        LineNgang.anchorToTop(nil, left: leftAnchor, bottom: MoTa.topAnchor, right: rightAnchor)
        
        // auto layout cho chiều cao line
        LineNgang.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
