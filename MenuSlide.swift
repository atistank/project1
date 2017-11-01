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
import RealmSwift

class MenuSlide: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var userRealmClass: Results<UserRealm>!
    
    
    
    @IBAction func logOut(_ sender: Any) {
     
        let manager = FBSDKLoginManager()
        manager.logOut()
        // xoá thông tin facebook
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
        
        // set trạng thái dang nhap = false
        UserDefaults.standard.setIsLoggedIn(value: false)
        // đăng xuất thì xoá user hiện tại trong csdl local
        let userHientai = userRealmClass[0]
        RealmService.shared.delete(userHientai)
        print("da xoa realm")
        
        let loginController = ViewController()
        present(loginController, animated: true, completion: nil)
    }
    @IBOutlet weak var Dangxuat: UIButton!
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var coverView: UIImageView!
    
    @IBOutlet weak var ChucVu: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    
  
    
    var ButtonMenu: [String] = ["cell","cell1","cell2"]
//    var name: [String] = ["Home","Setting","Thông Tin"]
//    var Hinh: [String] = ["hinh1","hinh2","hinh3"]
    
    var Mang: [[MenuButton]] = [
        [
        MenuButton(av: "profilemeo", text: "Account"),
        MenuButton(av: "book", text: "Đã Lưu Trữ"),
        MenuButton(av: "inbox2", text: "Inbox"),
        ],[
            
            MenuButton(av: "setting2", text: "Cài Đặt"),
            MenuButton(av: "about2", text: "About Us"),
    
          ]
    
    ]
    
    @IBOutlet weak var TableView: UITableView!
    
    
    func loaduser(){
//        let fbReq = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"name,email,first_name,cover,picture.type(large)"])
//        fbReq?.start(completionHandler: { (connect, info, err) in
//            guard let info = info else {return}
//            print("========================================")
//            self.dict = info as! [String : AnyObject]
//            // print(info)
//            print(self.dict)
//            let name: String  = (self.dict["name"] as? String)!
//            let IDjson: String  = (self.dict["id"] as? String)!
//            let email: String  = (self.dict["email"] as? String)!
//            let firstname: String  = (self.dict["first_name"] as? String)!
//            let picture:  [String : AnyObject]  = (self.dict["picture"] as?  [String : AnyObject])!
//            let data:  [String : AnyObject] = (picture["data"] as?  [String : AnyObject]!)!
//            let avatarFacebook:  String  = (data["url"] as? String)!
//            let cover:  [String : AnyObject]  = (self.dict["cover"] as?  [String : AnyObject])!
//            let CoverFacebook:  String = (cover["source"] as?  String!)!
//
        print("so phan tu user \(userRealmClass.count)")
        if userRealmClass.count == 1 {
            self.ChucVu.text = "Administrator"
            self.userName.text = userRealmClass[0].nameRealm
            self.email.text = userRealmClass[0].email
            let urlCover = URL(string: userRealmClass[0].coverRealm)
            let dataCover = try? Data(contentsOf: (urlCover)!)
            self.coverView.image = UIImage(data: dataCover!)
            let urlAvatar = URL(string: userRealmClass[0].avatarRealm)
            let dataAvatar = try? Data(contentsOf: (urlAvatar)!)
            self.avatarUser.image = UIImage(data: dataAvatar!)
            //                                print(name)
            //                                print(email)
            //                                print(firstname)
            //                                print(avatarFacebook)
            //                                print(CoverFacebook)
        }
        
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
      
        
        // realm
        let realm = RealmService.shared.realm
        userRealmClass = realm.objects(UserRealm.self)
        // load menu
        loaduser()
        
        setStyleForAvatar()
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        Dangxuat.buttonGradient(color1: #colorLiteral(red: 0, green: 0.8198698163, blue: 1, alpha: 1) , color2: #colorLiteral(red: 0.2602163553, green: 0.5214319825, blue: 1, alpha: 1) )
        
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL?.path)
//
//
        
        
      
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
            return "Thông Tin Cá Nhân"
        case 1:
            return "Tuỳ Chọn"
            
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 14)!
        header.backgroundView?.backgroundColor = UIColor.clear
    }
}
