//
//  DownloadController.swift
//  Project1_Duy
//
//  Created by Duy on 11/8/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit


class DownloadController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellnoidung1") as! DownloadTableviewCell
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
             return "Hôm Nay"
        }else {
             return "Hôm Qua"
        }
       
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.905977726, green: 0.9301357865, blue: 0.9469040036, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }

    @IBOutlet weak var TableViewDownload: UITableView!
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewDownload.dataSource = self
        TableViewDownload.delegate = self
        
       
        
    }
    
    
   
}
