//
//  Main.swift
//  Project1_Duy
//
//  Created by Duy on 9/9/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class Main: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var Nut: UIBarButtonItem!
    
    @IBOutlet var ViewChinh: UIView!
    @IBOutlet weak var Nutphai: UIBarButtonItem!
    @IBOutlet weak var tbView: UITableView!
  //  @IBOutlet weak var Nut: UIBarButtonItem!
    var menuStatus: Bool = false
    private var rssItems: [RSSItem]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Nut.target = SWRevealViewController()
        Nut.action = #selector(SWRevealViewController().revealToggle(_:))
        Nutphai.target = self
        Nutphai.action = #selector(handleSignOut)
        Nut.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        Nutphai.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        //thongbao.text = String(UserDefaults.standard.isLoggedIn())
        tbView.delegate = self
        tbView.dataSource = self
        // bỏ dòng line giữa các cell của tableview
        tbView.separatorStyle = UITableViewCellSeparatorStyle.none
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
   //     self.navigationController?.view.backgroundColor = UIColor.clear
      
     navigationItem.title = "Trang Chủ"
        
        fetchData()
        
    //   navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menutron"), style: .plain, target: self, action: #selector(handleSignOut))

//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(SlideMenu))
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
  
    private func fetchData(){
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://toidicodedao.com/feed/") { (rssItems) in
            self.rssItems = rssItems
           
            OperationQueue.main.addOperation {
                // reload phải trong luồng chính
                  self.tbView.reloadSections(IndexSet(integer: 0), with: .left) // reload section tableview
            }
        }   
    }
    func handleSignOut() {
        print("thanh menu")
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = ViewController()
        present(loginController, animated: true, completion: nil)
    }
    /// cài đặt tableview
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // nếu ko get dc rsstem thì trả về 0, còn dc thì số cell trả về số mảng
        guard  let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath) as! MainTableViewCell
        
        if let item = rssItems?[indexPath.item]{
            cell.item = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     //   tableView.estimatedRowHeight = 400
        tableView.rowHeight = 395
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.performSegue(withIdentifier: "chuyennoidung", sender: nil)
    }
}
