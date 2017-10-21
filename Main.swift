//
//  Main.swift
//  Project1_Duy
//
//  Created by Duy on 9/9/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit




class Main: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    

    var indexCuaSugeu:Int = 0

    @IBOutlet weak var Nut: UIBarButtonItem!
    
    @IBOutlet weak var Nutphai: UIBarButtonItem!
    @IBOutlet var ViewChinh: UIView!

    @IBOutlet weak var tbView: UITableView!
  //  @IBOutlet weak var Nut: UIBarButtonItem!
    var menuStatus: Bool = false
    private var rssItems: [RSSItem]? = []
 
    var soTrang: Int = 1 // số trang
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
    func setThongsoUI() {
        Nut.target = SWRevealViewController()
        Nut.action = #selector(SWRevealViewController().revealToggle(_:))
        Nutphai.target = self
        Nutphai.action = #selector(handleSignOut)
        Nut.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        Nutphai.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        navigationItem.title = "Trang Chủ"
       navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsOnTap = true
        
    }
    
    func loadMore(index: Int){
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://toidicodedao.com/feed?paged=\(index)") { (rssItems) in
            self.rssItems?.append(contentsOf: rssItems)
            OperationQueue.main.addOperation {
                // reload phải trong luồng chính
               self.tbView.reloadData()
            
               // self.tbView.reloadSections(IndexSet(integer: 0), with: .left) // reload section tableview
            }
        }
        
    }
    
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
      
        DispatchQueue.global().async {
           let feedParser = FeedParser()
            feedParser.parseFeed(url: "https://toidicodedao.com/feed/") { (rssItems) in
               
                self.rssItems = rssItems
                OperationQueue.main.addOperation {
                    // reload phải trong luồng chính
                    self.tbView.reloadSections(IndexSet(integer: 0), with: .left) // reload section tableview
                }
            }
        }
        
        
    }
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        loadAnh()
        setThongsoUI()
        tbView.delegate = self
        tbView.dataSource = self
        
       
        // bỏ dòng line giữa các cell của tableview
        tbView.separatorStyle = UITableViewCellSeparatorStyle.none
        fetchData()
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
        guard  let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        DispatchQueue(label: "haha").async {
            if let item =  self.rssItems?[indexPath.item]{
                DispatchQueue.main.async {
                    cell.item = item
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //   tableView.estimatedRowHeight = 400
        tableView.rowHeight = 395
        
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    indexCuaSugeu = indexPath.row
        
    self.performSegue(withIdentifier: "vaonoidung", sender: self)
    
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let manhinhNoiDung = segue.destination as! webcontroller
        manhinhNoiDung.htmlNoiDung = self.rssItems![indexCuaSugeu].link
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
        if indexPath.row == (rssItems?.count)! - 1 {
            soTrang += 1
           loadMore(index: soTrang)
           
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
