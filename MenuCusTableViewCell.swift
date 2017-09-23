//
//  MenuCusTableViewCell.swift
//  Project1_Duy
//
//  Created by Duy on 9/14/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class MenuCusTableViewCell: UITableViewCell {
    @IBOutlet weak var LabelText: UILabel!
    @IBOutlet weak var Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     // Configure the view for the selected state
    }

}
