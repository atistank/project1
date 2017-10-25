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
            if TrangHD.background == "trang" {
                background.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            }else{
                background.image = UIImage(named: TrangHD.background)
            }
            
            
            let Mau = UIColor(white: 0.2, alpha: 1) // Màu color title
            
            
            let attributedText = NSMutableAttributedString(string: (page?.title)!, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page!.Huongdan)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15),NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)]))
            
            let VanBanStyle = NSMutableParagraphStyle()
            VanBanStyle.alignment = .center
            let DoDaiText = attributedText.string.characters.count
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: VanBanStyle, range: NSRange(location: 0, length: DoDaiText)  )
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
        Hinh.contentMode = .scaleAspectFit // giu nguyen ty le hinh
        Hinh.backgroundColor = .clear
        Hinh.image = #imageLiteral(resourceName: "page1")
        Hinh.clipsToBounds = true
        return Hinh
    }()
    let background: UIImageView = {
        
        let Hinh = UIImageView()
        Hinh.contentMode = .scaleToFill // giu nguyen ty le hinh
        Hinh.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
       
        Hinh.clipsToBounds = true
        return Hinh
    }()
    
    let MoTa: UITextView = {
        let textView = UITextView()
        textView.text = "Huong dan su dung app"
        // để text cách Hình 1 khoảng trắng 10
        textView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        textView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
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
       
        addSubview(background)
         addSubview(HinhHuongDan)
        addSubview(MoTa)
       // addSubview(LineNgang)
       background.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
       HinhHuongDan.anchor(background.topAnchor, left: background.leftAnchor, bottom: MoTa.topAnchor, right: background.rightAnchor, topConstant: 90, leftConstant: 30, bottomConstant: 30, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
  //      MoTa.anchorToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        //Neo Mô tả vào Hình HD và cách 2 bên 16
        MoTa.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 70, rightConstant: 30)
        
        MoTa.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        //Neo Đường Line
//        LineNgang.anchorToTop(nil, left: leftAnchor, bottom: MoTa.topAnchor, right: rightAnchor)
//
//        // auto layout cho chiều cao line
//        LineNgang.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
