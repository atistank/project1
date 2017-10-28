//
//  MenuSlide.swift
//  Project1_Duy
//
//  Created by Duy on 9/14/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class MenuSlide: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBAction func logOut(_ sender: Any) {
    }
    @IBOutlet weak var Dangxuat: UIButton!
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var coverView: UIImageView!
    
    @IBOutlet weak var ChucVu: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    var dict : [String : AnyObject]!
    
    
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
    
    
    func loaduser(){
        let fbReq = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"name,email,first_name,cover,picture.type(large)"])
                            fbReq?.start(completionHandler: { (connect, info, err) in
                                guard let info = info else {return}
                                print("========================================")
                                self.dict = info as! [String : AnyObject]
                               // print(info)
                                print(self.dict)
                                let name: String  = (self.dict["name"] as? String)!
                                let IDjson: String  = (self.dict["id"] as? String)!
                                let email: String  = (self.dict["email"] as? String)!
                                let firstname: String  = (self.dict["first_name"] as? String)!
                                let picture:  [String : AnyObject]  = (self.dict["picture"] as?  [String : AnyObject])!
                                let data:  [String : AnyObject] = (picture["data"] as?  [String : AnyObject]!)!
                                let avatarFacebook:  String  = (data["url"] as? String)!
                                let cover:  [String : AnyObject]  = (self.dict["cover"] as?  [String : AnyObject])!
                                let CoverFacebook:  String = (cover["source"] as?  String!)!

                                print(name)
                                print(email)
                                print(firstname)
                                print(avatarFacebook)
                                print(CoverFacebook)
        
                            })
        
    }
    
    
    func setStyleForAvatar(){
        
        
        avatarUser.layer.cornerRadius = 1
        avatarUser.layer.masksToBounds = false
        avatarUser.layer.borderWidth = 2
        avatarUser.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       
        // đổ bóng cell
        avatarUser.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
//        // cho bóng ngả màu nhẹ tý
        avatarUser.layer.shadowOffset = CGSize(width: 0, height: 0)
        avatarUser.layer.shadowOpacity = 0.8
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
//        let fbloginresult = FBSDKLoginManager()
//        fbloginresult.logIn(withReadPermissions:  ["public_profile", "email"], from: self) { (result, err) in
//            print(result)
        loaduser()
        
        setStyleForAvatar()
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        Dangxuat.buttonGradient(color1: #colorLiteral(red: 0, green: 0.8198698163, blue: 1, alpha: 1) , color2: #colorLiteral(red: 0.2602163553, green: 0.5214319825, blue: 1, alpha: 1) )
        
    }

   
}






extension MenuSlide{
    
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
