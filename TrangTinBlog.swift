//
//  TrangTinBlog.swift
//  Project1_Duy
//
//  Created by Duy on 11/11/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
import Material
import Motion
class TrangTinBlog: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var tbViewNoiDung: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellnoidung") as! MainTableViewCell
        return cell
    }
    
    
    
    
    @IBAction func QuayLai(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    fileprivate var buttons = [TabItem]()
    fileprivate var tabBar: TabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        prepareButtons()
     tbViewNoiDung.separatorStyle = UITableViewCellSeparatorStyle.none
        prepareTabBar()
        self.navigationItem.title = "Tôi Đi Code Dạo"
        tbViewNoiDung.dataSource = self
        tbViewNoiDung.delegate = self
    
    }
    
    
    
    
    
    
}

extension TrangTinBlog {
    fileprivate func prepareButtons() {
        let btn1 = TabItem(title: "Trang Chủ", titleColor: Color.blueGrey.base)
        btn1.pulseAnimation = .none
        buttons.append(btn1)
        
        let btn2 = TabItem(title: "Bài Viết Hay", titleColor: Color.blueGrey.base)
        btn2.pulseAnimation = .none
        buttons.append(btn2)
        
        let btn3 = TabItem(title: "Chuyện Coding", titleColor: Color.blueGrey.base)
        btn3.pulseAnimation = .none
        buttons.append(btn3)
        
        let btn4 = TabItem(title: "Chuyện Nghề Nghiệp", titleColor: Color.blueGrey.base)
        btn4.pulseAnimation = .none
        buttons.append(btn4)
        
        let btn5 = TabItem(title: "Chuyện Linh Tinh", titleColor: Color.blueGrey.base)
        btn5.pulseAnimation = .none
        buttons.append(btn5)
        
        let btn6 = TabItem(title: "About Me", titleColor: Color.blueGrey.base)
        btn6.pulseAnimation = .none
        buttons.append(btn6)
    }
    
    fileprivate func prepareTabBar() {
        tabBar = TabBar()
        tabBar.delegate = self
        
        tabBar.dividerColor = Color.grey.lighten2
        tabBar.dividerAlignment = .bottom
        
        tabBar.lineColor = Color.blue.base
        tabBar.lineAlignment = .bottom
        
        tabBar.backgroundColor = Color.grey.lighten5
        tabBar.tabItems = buttons
        
        view.layout(tabBar).horizontally().top()

    }
}






extension TrangTinBlog: TabBarDelegate {
    @objc
    func tabBar(tabBar: TabBar, willSelect tabItem: TabItem) {
        print("will select")
    }
    
    @objc
    func tabBar(tabBar: TabBar, didSelect tabItem: TabItem) {
        print("did select")
    }
}



