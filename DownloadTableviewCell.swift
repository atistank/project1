//
//  DownloadTableviewCell.swift
//  Project1_Duy
//
//  Created by Duy on 11/14/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class DownloadTableviewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!{
        didSet{
        avatar.layer.cornerRadius = 5
         avatar.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var nickemail: UILabel!
    
    @IBOutlet weak var NutFollow: UIButton!{
        didSet{
            NutFollow.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            NutFollow.layer.borderWidth = 1
           
            NutFollow.setTitle("Follow", for: .normal)
            NutFollow.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
            NutFollow.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            NutFollow.layer.cornerRadius = 5
            NutFollow.clipsToBounds = true
            NutFollow.tintColor = UIColor.white
            NutFollow.setImage(UIImage(named:"follow.png"), for: .normal)
            
            NutFollow.imageView?.contentMode = .center
            NutFollow.imageEdgeInsets = UIEdgeInsets(top: 4,left: 0,bottom: 4,right: 6)
            NutFollow.titleEdgeInsets = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
           
            
            
        }
    }
    
    @IBOutlet weak var noidung: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
