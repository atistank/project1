//
//  Main.swift
//  Project1_Duy
//
//  Created by Duy on 9/9/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
import RealmSwift
import Social



class Main: UIViewController,UITableViewDelegate,UITableViewDataSource {

     var postRealmClass: Results<PostMan>!
     var SoTrangKiemTra: Results<SoTrangRealm>!
   
   
    var indexCuaSugeu:Int = 0

    @IBOutlet weak var Nut: UIBarButtonItem!
    
    @IBOutlet weak var Nutphai: UIBarButtonItem!
    @IBOutlet var ViewChinh: UIView!

    @IBOutlet weak var tbView: UITableView!
  //  @IBOutlet weak var Nut: UIBarButtonItem!
    var menuStatus: Bool = false
    private var rssItemsSuorce: [RSSItem]? = []
    private var postRealmCatche: [PostMan]? = []

   
    
    @IBAction func NutShare(_ sender: Any) {
        // cau hinh cho action sheet ( hien tu duoi len ) khong them textfield vao dc
        let actionsheet: UIAlertController = UIAlertController(title: "Share Bài Viết", message: "Chia sẽ tri thức", preferredStyle: UIAlertControllerStyle.actionSheet)
        // them nut ok vao action sheet
        let btnOk: UIAlertAction = UIAlertAction(title: "Share qua Facebook", style: .default) { (action) in
            print("share1")
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                print("share2")
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                post.setInitialText("asd")
            //    post.add(#imageLiteral(resourceName: "hinh1-1"))
                self.present(post, animated: true, completion: nil)
            }
            else{
                print("share3")
                self.showThongbaoLoiShare()
            }
        }
        actionsheet.addAction(btnOk)
        // hien thi
        present(actionsheet, animated: true, completion: nil)
    }
    
    func showThongbaoLoiShare()
    {
        print("thong bao loi")
        let thongbao = UIAlertController(title: "Lỗi", message: "Bạn chưa kết nối đến facebook :(", preferredStyle: .alert)
        let action = UIAlertAction(title: "Hiểu rồi", style: .cancel, handler: nil)
        thongbao.addAction(action)
        present(thongbao, animated: true, completion: nil)
    }
  
    func setThongsoUI() {
        Nut.target = SWRevealViewController()
        Nut.action = #selector(SWRevealViewController().revealToggle(_:))
        Nutphai.target = self
        Nutphai.action = #selector(handleSignOut)
        Nut.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        Nutphai.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        navigationItem.title = "Trang Chủ"
//       navigationController?.hidesBarsOnSwipe = true
//        navigationController?.hidesBarsOnTap = true
        
    }

    private func fetchData(index: Int){
      
        DispatchQueue.global().async {
           let feedParser = FeedParser()
            feedParser.parseFeedRealm(url: "https://toidicodedao.com/feed/?paged=\(index)") { (data) in
             
                print("da vao day")
                DispatchQueue.main.async {
                    
              // nếu vào trang 1 và đã load sẳn 1 trang 10 item mà chưa load more
                    if index == 1 && self.postRealmClass.count == 10 {
                        print("vog lap index == 1 mang = 10")
                  //    RealmService.shared.deleteAll()
                        data.forEach({ (phantu) in
                            print("vong lap 1")
                            var kiemtra:Int = 0
                            for i in 0...self.postRealmClass.count {
                                if self.postRealmClass[i].titleRealm == phantu.titleRealm
                                {
                                    print("giong")
                                   kiemtra = 1
                                   break
                                }
                            }
                            if kiemtra == 0 {
                                print("kiem tra = 0")
                                RealmService.shared.create(phantu)
                                   self.tbView.reloadSections(IndexSet(integer: 0), with: .right) // reload section tableview
                            }
                            
                        })
                     
                    }
                    else if index == 1 && self.postRealmClass.count == 0  // lần đầu tiên load luôn, chưa có gì
                    {
                        print("vog lap cd")
                        
                        
                        RealmService.shared.createArr(data)
                           self.tbView.reloadSections(IndexSet(integer: 0), with: .right) // reload section tableview
                    }
                    else if index != 1  // đã load more rồi
                    {
                        print("vong lap loadmore")
                        
                       RealmService.shared.createArr(data)
                        
                        self.tbView.reloadSections(IndexSet(integer: 0), with: .right) // reload section tableview
                    }
                    
                  
                }
            }
        }
        
        
    }
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        setThongsoUI()
        tbView.delegate = self
        tbView.dataSource = self
        // realm
        print("cau lenh nay")
        let realm = RealmService.shared.realm
        postRealmClass = realm.objects(PostMan.self)
         SoTrangKiemTra = realm.objects(SoTrangRealm.self)
        print("thi ra la vay")
        // bỏ dòng line giữa các cell của tableview
        tbView.separatorStyle = UITableViewCellSeparatorStyle.none
        fetchData(index: 1)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        
        UIView.animate(withDuration: 6) {
        self.tabBarController?.tabBar.isHidden = false
        }
       
    
    }
  
   
    @objc func handleSignOut() {
        print("thanh menu")
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = ViewController()
        present(loginController, animated: true, completion: nil)
    }
   
}

extension Main{
    
    /// cài đặt tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // nếu ko get dc rsstem thì trả về 0, còn dc thì số cell trả về số mảng
    
        return postRealmClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
       
            cell.itemRealm = postRealmClass[indexPath.row]
            
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //   tableView.estimatedRowHeight = 400
        tableView.rowHeight = 387
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    indexCuaSugeu = indexPath.row
        
    self.performSegue(withIdentifier: "vaonoidung", sender: self)
    
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let manhinhNoiDung = segue.destination as! webcontroller
        manhinhNoiDung.htmlNoiDung = postRealmClass![indexCuaSugeu].linkRealm
          self.hidesBottomBarWhenPushed = true
        UIView.animate(withDuration: 1, animations: {
             self.tabBarController?.tabBar.isHidden = true
        }, completion: nil)

        // 3 dòng dưới đây dùng để paste nội dung content đã parsing, dùng link web thì khỏi dùng.
//        var TheInDam1 = "<h3><strong>" + String(describing: self.rssItems![indexCuaSugeu].title) + "</strong></h3>"
//        manhinhNoiDung.htmlNoiDung = TheInDam1
//        manhinhNoiDung.htmlNoiDung += String(describing: self.rssItems![indexCuaSugeu].noidung)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // vi tri luc dau từ bên trái (-255) ở trên (20) đi xuống
   
//            cell.alpha = 0
//            let vitricell = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0 )
//            cell.layer.transform = vitricell
//       
//            UIView.animate(withDuration: 0.8) {
//                cell.alpha = 1.0
//                cell.layer.transform = CATransform3DIdentity
//            }

        if indexPath.row == (self.postRealmClass?.count)! - 1 {
            print("Load more")
            
            var x = Int(SoTrangKiemTra[0].SoTrangString()!)
            print("so trang chua cong la \(x!)")
            x = x! + 1
            
            
            RealmService.shared.update(SoTrangKiemTra[0], with: ["SoTrang" : x])
             print("so trang da cong la \(x!)")
            fetchData(index: x!)
           
          }

        }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    }
}
