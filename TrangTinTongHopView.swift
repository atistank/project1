//
//  TrangTinTongHopView.swift
//  Project1_Duy
//
//  Created by Duy on 11/10/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class TrangTinTongHopView: UICollectionViewCell {
    
    @IBOutlet weak var KhungView: UIView!{
        didSet{
        
//            // bo tròn cell tý xíu
//            KhungView.layer.cornerRadius = 3.0
            KhungView.layer.masksToBounds = false
         
            KhungView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            // cho bóng ngả màu nhẹ tý
            KhungView.layer.shadowOffset = CGSize(width: 0, height: 0)
            KhungView.layer.shadowOpacity = 0.8
        }
    }
    
    @IBOutlet weak var HinhDaiDienBlog: UIImageView!
        {
        didSet{
           
         
           
        }
    }
    @IBOutlet weak var khungtitle: UIVisualEffectView!{
        didSet{
            
//            // bo tròn cell tý xíu
//            khungtitle.layer.cornerRadius = 5.0
//            khungtitle.layer.masksToBounds = true
//
            
        }
    }
    
    @IBOutlet weak var TitleBlog: UILabel!
    
}
