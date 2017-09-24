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
    
    @IBOutlet weak var Nutphai: UIBarButtonItem!
    @IBOutlet weak var tbView: UITableView!
  //  @IBOutlet weak var Nut: UIBarButtonItem!
    var menuStatus: Bool = false
    private var rssItems: [RSSItem]?
    private var celltrangThai: [CellTrangThai]?
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
//        let btn1 = UIButton(type: .custom)
//        btn1.setImage(UIImage(named: "menu2"), for: .normal)
//        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btn1.addTarget(SWRevealViewController(), action: #selector(SWRevealViewController().revealToggle(_:)), for: .touchUpInside)
//        let item1 = UIBarButtonItem(customView: btn1)
//        navigationItem.leftBarButtonItem = item1
        Nut.target = SWRevealViewController()
        Nut.action = #selector(SWRevealViewController().revealToggle(_:))
        Nutphai.target = self
        Nutphai.action = #selector(handleSignOut)
        Nut.tintColor = #colorLiteral(red: 0.9625948071, green: 0.705286622, blue: 0.2028543651, alpha: 1)
        Nutphai.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        //thongbao.text = String(UserDefaults.standard.isLoggedIn())
        tbView.delegate = self
        tbView.dataSource = self
        // bỏ dòng line giữa các cell của tableview
        tbView.separatorStyle = UITableViewCellSeparatorStyle.none
        fetchData()
        
    //   navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menutron"), style: .plain, target: self, action: #selector(handleSignOut))

//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(SlideMenu))
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
  
    private func fetchData(){
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://toidicodedao.com/feed/") { (rssItems) in
            self.rssItems = rssItems
            self.celltrangThai = Array(repeating: .morong, count: rssItems.count)
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
        tableView.rowHeight = 390
        
        return tableView.rowHeight
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
 
}
