//
//  MenuSlide.swift
//  Project1_Duy
//
//  Created by Duy on 9/14/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class MenuSlide: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var avatarUser: UIImageView!
    
    
    
    
    var ButtonMenu: [String] = ["cell","cell1","cell2"]
//    var name: [String] = ["Home","Setting","Thông Tin"]
//    var Hinh: [String] = ["hinh1","hinh2","hinh3"]
    
    var Mang: [[MenuButton]] = [
        [
        MenuButton(av: "hinh1", text: "Chuyện Coder"),
        MenuButton(av: "hinh2", text: "Chuyện Nghề Nghiệp"),
        MenuButton(av: "hinh3", text: "Chuyện Linh Tinh"),
        ],[
            
            MenuButton(av: "hinh2", text: "Cài đặt"),
            MenuButton(av: "hinh3", text: "đăng xuất"),
    
          ]
    
    ]
    
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        
        avatarUser.layer.cornerRadius = avatarUser.frame.width / 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return Mang[section].count
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        switch section {
        case 0:
            return "Tôi Đi Code Dạo"
        case 1:
            return "TopDev"
        
        default:
            return "..."
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCusTableViewCell
       
        cell.LabelText.text = Mang[indexPath.section][indexPath.row].labelText
        cell.Img.image = UIImage(named: Mang[indexPath.section][indexPath.row].Avatar)
        
        return cell
    }   
}
