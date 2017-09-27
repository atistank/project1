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
    var cellCache: [RSSItem] = []
    var imagecache: [UIImage] = []
    var sourceImage: [String] = [
        "https://anhdephd.com/wp-content/uploads/2017/04/hinh-nen-thien-nhien-phong-canh-dep-nhat.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/Anh-girl-xinh-han-quoc-heo-yun-mi-dep-sexy-660x440.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/Hinh-nen-i-Love-You-dep-nhat-16-768x480.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/hinh-nen-thien-nhien-phong-canh-dep-nhat.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/Anh-girl-xinh-han-quoc-heo-yun-mi-dep-sexy-660x440.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/Hinh-nen-i-Love-You-dep-nhat-16-768x480.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/hinh-nen-thien-nhien-phong-canh-dep-nhat.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/Anh-girl-xinh-han-quoc-heo-yun-mi-dep-sexy-660x440.jpg",
        "https://anhdephd.com/wp-content/uploads/2017/04/Hinh-nen-i-Love-You-dep-nhat-16-768x480.jpg",
         "https://anhdephd.com/wp-content/uploads/2017/04/Hinh-nen-i-Love-You-dep-nhat-16-768x480.jpg",
          "https://anhdephd.com/wp-content/uploads/2017/04/Hinh-nen-i-Love-You-dep-nhat-16-768x480.jpg"
    ]
    
    
    func loadAnh(){
        for (index,imgString) in sourceImage.enumerated() {
            imagecache.append(#imageLiteral(resourceName: "defaulte"))
            guard let u = URL(string: imgString) else {return}
            let req = URLRequest(url: u)
            URLSession.shared.dataTask(with: req, completionHandler: { (dulieu, repond, error) in
                guard let dulieu = dulieu else {return}
                DispatchQueue.main.async
                    {
                        self.imagecache[index] = UIImage(data: dulieu)!
                     //   self.tbView.reloadData()
                    }
            }).resume()
        }
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
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        loadAnh()
        
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
    
        self.navigationController?.hidesBarsOnSwipe = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
   //     self.navigationController?.view.backgroundColor = UIColor.clear
      
     navigationItem.title = "Trang Chủ"
        fetchData()
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
  
   
    @objc func handleSignOut() {
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
        DispatchQueue(label: "haha").async {
            if let item =  self.rssItems?[indexPath.item]{
                DispatchQueue.main.async {
                     cell.item = item
                 
                }
               
            }
          
           
        }
       cell.imAvatar.image = self.imagecache[indexPath.row]
      // tbView.reloadData()
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
