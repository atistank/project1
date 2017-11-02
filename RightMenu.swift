//
//  RightMenu.swift
//  Project1_Duy
//
//  Created by Duy on 11/2/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class RightMenu: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tbViewMenuRight: UITableView!
    @IBOutlet weak var ViewTop: UIView!
    
    var Mang: [[MenuButton]] = [
        [
            MenuButton(av: "profilemeo", text: "Trang Chủ"),
            MenuButton(av: "book", text: "Chuyện Linh Tinh"),
            MenuButton(av: "inbox2", text: "Chuyện Coder"),
            ],[
                
                MenuButton(av: "setting2", text: "Cài Đặt"),
                MenuButton(av: "about2", text: "About Us"),
                
                ]
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbViewMenuRight.separatorStyle = UITableViewCellSeparatorStyle.none
        ViewTop.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        //        // cho bóng ngả màu nhẹ tý
        ViewTop.layer.shadowOffset = CGSize(width: 0, height: 0)
        ViewTop.layer.shadowOpacity = 0.8
        tbViewMenuRight.dataSource = self
        tbViewMenuRight.delegate = self
       
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
                return Mang[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellright", for: indexPath) as! rightmenuCell
        
        cell.ImgIcon.image = UIImage(named: Mang[indexPath.section][indexPath.row].Avatar)
        
        cell.LabelIcon.text = Mang[indexPath.section][indexPath.row].labelText
    
        return cell
    }

}
