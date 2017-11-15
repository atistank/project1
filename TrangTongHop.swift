//
//  TrangTongHop.swift
//  Project1_Duy
//
//  Created by Duy on 11/9/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

class TrangTongHop: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var NaviView: UIView!
    var Mang: [[MenuButton]] = [
        [
            MenuButton(av: "9code4", text: "Tôi Đi Code Dạo"),
       
            ],[
                
                MenuButton(av: "9code3", text: "CodeaHolicGuy"),
                MenuButton(av: "9code7", text: "JusFunny"),
                
                ],
              [MenuButton(av: "defaulte", text: "Niviki"),
               MenuButton(av: "fptbanner", text: "The Full Snack Developer"),
               MenuButton(av: "9code5", text: "CodeaHolicGuy"),
               MenuButton(av: "9codeholic", text: "CodeaHolicGuy")]
        
    ]
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
       self.navigationItem.title = "Trang Chủ"
        
    }

   

}

extension TrangTongHop{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
       
       self.performSegue(withIdentifier: "chuyenquablog", sender: self)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 2
        }
        else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TrangTinTongHopView
        cell.HinhDaiDienBlog.image = UIImage(named: Mang[indexPath.section][indexPath.row].Avatar)
        cell.TitleBlog.text = Mang[indexPath.section][indexPath.row].labelText
     
        return cell
    }
    
    // cau hinh cell
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

       print(indexPath.section)
        if indexPath.section == 0 {
            let cellWidth = view.frame.width - 10
            let cellHeight = (cellWidth + 100) / 2
            return CGSize(width: cellWidth, height: cellHeight)
        }
        if indexPath.section == 1 {
            let cellWidth = view.frame.width/2 - 5
            let cellHeight = (cellWidth + 0) / 1.5
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else {
            let cellWidth = view.frame.width - 10
            let cellHeight = (cellWidth + 100 ) / 3
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
       
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
 

    
    
    
}
