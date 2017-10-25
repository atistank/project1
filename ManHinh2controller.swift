//
//  ManHinh2controller.swift
//  Project1_Duy
//
//  Created by Duy on 10/21/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class ManHinh2controller: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.clipsToBounds = true
    
        button.layer.cornerRadius = 6
        button.buttonGradient(color1: UIColor(red: 112.0/255.0, green: 219.0/255.0, blue: 155.0/255.0, alpha: 1.0), color2: UIColor(red: 86.0/255.0, green: 197.0/255.0, blue: 238.0/255.0, alpha: 1.0))
     // button.buttonGradient2(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color3: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), color4: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
    }

    
}
