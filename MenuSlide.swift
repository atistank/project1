//
//  MenuSlide.swift
//  Project1_Duy
//
//  Created by Duy on 9/14/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class MenuSlide: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var ButtonMenu: [String] = ["cell","cell1","cell2"]
//    var name: [String] = ["Home","Setting","Thông Tin"]
//    var Hinh: [String] = ["hinh1","hinh2","hinh3"]
    
    var Mang: [MenuButton] = [
        MenuButton(av: "hinh1", text: "Home"),
        MenuButton(av: "hinh2", text: "Cài đặt"),
        MenuButton(av: "hinh3", text: "đăng xuất"),
    ]
    
    
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Mang.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Dòng " + String(section)
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCusTableViewCell
       
        cell.LabelText.text = Mang[indexPath.row].labelText
        cell.Img.image = UIImage(named: Mang[indexPath.row].Avatar)
        
        return cell
    }
    
    
}
