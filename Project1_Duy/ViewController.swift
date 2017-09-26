//
//  ViewController.swift
//  Project1_Duy
//
//  Created by Duy on 9/7/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit

protocol ChuyenManHinhLoginDelegate {
    func chuyenmanhinh()
}


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ChuyenManHinhLoginDelegate {

    lazy var collectionView: UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
        //cuon view sang chieu ngang
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // đường kẻ các cell = 0
        // tao colleciton view
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true // bậc tính năng canh giữa các trang
        return cv
    }()
    
    
    func chuyenmanhinh(){
       
        UserDefaults.standard.setIsLoggedIn(value: true)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Duy") as! SWRevealViewController
       // vc.modalTransitionStyle = .partialCurl
       self.present(vc, animated: true, completion: nil)
    }
    
    let cellID = "cellID"
    let MainCellID = "MainCellID"
    
    let pages: [Trang] = {
         let Trang1 = Trang(title: "Huong Dan Su Dung", Huongdan: "Nghe Nhac mien phi tu itunes rat hay va mien phi nua.", imageName: "page1")
         let Trang2 = Trang(title: "Nghe Nhac", Huongdan: "Ban co the mien tu tren mang ve roi tu nghe minh enh.", imageName: "page2")
         let Trang3 = Trang(title: "Dang ky thanh vien", Huongdan: "Dang ky thanh vien de co them nhieu quyen loi va chuc nang, nhanh tay len.", imageName: "page3")
        return [Trang1,Trang2,Trang3]
    }()
    
    //tạo index cho trang
    lazy var DieuKhienTrang:UIPageControl = {
        let dk = UIPageControl()
        dk.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.708275497, blue: 0.09586834162, alpha: 1) // màu trang hiện tại
        dk.pageIndicatorTintColor = .lightGray // màu trang chưa chọn
        
       
        dk.numberOfPages = self.pages.count + 1
        return dk
        
    }()
    
    // nút Next và Skip
    lazy var SkipButton: UIButton = {
        let skip = UIButton(type: .system)
        skip.setTitle("Skip", for: .normal)
        skip.setTitleColor(#colorLiteral(red: 1, green: 0.708275497, blue: 0.09586834162, alpha: 1), for: .normal)
        skip.addTarget(self, action: #selector(HanhdongSkip), for: .touchUpInside)
        return skip
    }()
    lazy var NextButton: UIButton = {
        let skip = UIButton(type: .system)
        skip.setTitle("Next", for: .normal)
        skip.setTitleColor(#colorLiteral(red: 1, green: 0.708275497, blue: 0.09586834162, alpha: 1), for: .normal)
        skip.addTarget(self, action: #selector(Hanhdong), for: .touchUpInside)
        return skip
    }()
    
    func Hanhdong(){
        // nếu lướt tới trang Star cuối thì nút next ko có tác dụng
        if DieuKhienTrang.currentPage == pages.count
        {
            return
        }
        // trang kế cuối
        if DieuKhienTrang.currentPage == pages.count - 1
        {
            thongtinAutolayoutForButton()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations:
                {
                self.view.layoutIfNeeded()
                
                }, completion: nil)
        }
        
        
        // index = trang tiếp thep = trang hiện tại + 1
        let Index = IndexPath(item: DieuKhienTrang.currentPage + 1 , section: 0)
        // scrolltoitem cuộn tới cell cần đến
        collectionView.scrollToItem(at: Index, at: .centeredHorizontally, animated: true)
        // update lại pagecontroll
        DieuKhienTrang.currentPage += 1
    }
    
    func HanhdongSkip(){
        collectionView.scrollToItem(at: IndexPath(item: pages.count , section: 0), at: .centeredHorizontally, animated: true)
        thongtinAutolayoutForButton()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations:
            {
                self.view.layoutIfNeeded()
                
        }, completion: nil)
    }
    
    
    
    ///////////////////////
    var pagecontrolBottomAnchor: NSLayoutConstraint?
    var SkipAnchor: NSLayoutConstraint?
    var NextAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(DieuKhienTrang)
        view.addSubview(SkipButton)
        view.addSubview(NextButton)
          // su dung auto layout cho view
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        Dangkycell()
       
        
     pagecontrolBottomAnchor =   DieuKhienTrang.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        
     SkipAnchor =   SkipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
      NextAnchor =  NextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
    }
    
    fileprivate func Dangkycell(){
    
     collectionView.register(Pagecell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: MainCellID)
    }
    
    
    // 4 cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
        
    }
    
    //CAU HINH CHO CELL
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // kiểm tra nếu trang hiện tại là trang cuối thì add thêm 1 cell nữa ( Main Cell )
        if indexPath.item == pages.count {
            let MainCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: MainCellID, for: indexPath) as! LoginCell
            
            
            MainCell2.delegateChuyenManHinh = self
            
        
            return MainCell2
        }
        // Tạo cell bình thường
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! Pagecell
        let page = pages[indexPath.item]
        cell.page = page
            return cell
    }
    
    // ke thua trong UICollectionViewDelegateFlowLayout
    // moi cell rong bang kich thuoc man hinh view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    fileprivate func thongtinAutolayoutForButton(){
    
        pagecontrolBottomAnchor?.constant = 40
        SkipAnchor?.constant = -40
        NextAnchor?.constant = -40
    }
    func finishLoggingIn() {
        //we'll perhaps implement the home controller a little later
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [Main()]
        
        UserDefaults.standard.setIsLoggedIn(value: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        
        // lấy vị trí x hiện tại chia chiều ngang của view sẽ dc vị trí trang ( số chẳn )
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        DieuKhienTrang.currentPage = pageNumber
        
        
        //nếu trượt đến trang cuối thì ẩn page control
        if pageNumber == pages.count
        {
          thongtinAutolayoutForButton()
        }
        else
        {
            pagecontrolBottomAnchor?.constant = 0
            SkipAnchor?.constant = 16
            NextAnchor?.constant = 16
            
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    // khi quay thiết bị sang chiều ngang
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let index = IndexPath(item: DieuKhienTrang.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
}





