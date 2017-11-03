//
//  ViewController.swift
//  Project1_Duy
//
//  Created by Duy on 9/7/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import RealmSwift
protocol ChuyenManHinhLoginDelegate {
    func chuyenmanhinh()
    func dangky()
    func dangnhap()
}


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ChuyenManHinhLoginDelegate {
    

    
    var dict : [String : AnyObject]!

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
    
    func dangky(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
         let dangkyview = sb.instantiateViewController(withIdentifier: "dangnhap") as! DangKycontroller
        present(dangkyview, animated: true, completion: nil)
    }
    func dangnhap(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let dangkyview = sb.instantiateViewController(withIdentifier: "DangKy") as! DangKyUserController
        present(dangkyview, animated: true, completion: nil)
    }
    
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
        let Trang1 = Trang(title: "Welcome to DevBlog", Huongdan: "Ứng dụng xem tài liệu trực tuyến dành cho dev, lưu trữ offline và xem mọi lúc mọi nơi, hàng trăm bài viết cập nhật mỗi ngày 😎 ", imageName: "intro5",background: "backgroung1")
        let Trang2 = Trang(title: "Nghe Nhac", Huongdan: "Ban co the mien tu tren mang ve roi tu nghe minh enh.Ban co the mien tu tren mang ve roi tu nghe minh enh", imageName: "intro9", background: "trang")
        let Trang3 = Trang(title: "Dang ky thanh vien", Huongdan: "Dang ky thanh vien de co them nhieu quyen loi va chuc nang, nhanh tay len.", imageName: "intro9", background: "trang")
        return [Trang1,Trang2,Trang3]
    }()
    
    //tạo index cho trang
    lazy var DieuKhienTrang:UIPageControl = {
        let dk = UIPageControl()
        dk.currentPageIndicatorTintColor = #colorLiteral(red: 0.003921568627, green: 0.4862745098, blue: 0.9098039216, alpha: 1) // màu trang hiện tại
        dk.pageIndicatorTintColor = .lightGray // màu trang chưa chọn
        
       
        dk.numberOfPages = self.pages.count + 1
        return dk
        
    }()
    
    // nút Next và Skip
    lazy var SkipButton: UIButton = {
        let skip = UIButton(type: .system)
        skip.setTitle("Skip", for: .normal)
        skip.setTitleColor(#colorLiteral(red: 0.003921568627, green: 0.4862745098, blue: 0.9098039216, alpha: 1), for: .normal)
        skip.addTarget(self, action: #selector(HanhdongSkip), for: .touchUpInside)
        return skip
    }()
    lazy var NextButton: UIButton = {
        let skip = UIButton(type: .system)
        skip.setTitle("Next", for: .normal)
        skip.setTitleColor(#colorLiteral(red: 0.00455649849, green: 0.4850453734, blue: 0.9079882503, alpha: 1), for: .normal)
        skip.addTarget(self, action: #selector(Hanhdong), for: .touchUpInside)
        return skip
    }()
    

    
    
    
    
    lazy var StarButton: UIButton = {
        let st = UIButton(type: .system)
        st.setTitle("Log In with Facebook", for: .normal)
        st.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        st.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5254901961, blue: 0.9803921569, alpha: 1)
        st.layer.cornerRadius = 27
        st.clipsToBounds = true
        st.tintColor = UIColor.white
    
        st.setImage(UIImage(named:"facebook2.png"), for: .normal)
     //   st.imageView?.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        st.imageView?.contentMode = .center
        st.imageEdgeInsets = UIEdgeInsets(top: 6,left: 0,bottom: 6,right: 14)
        st.titleEdgeInsets = UIEdgeInsets(top: 0,left: 30,bottom: 0,right: 34)
        st.addTarget(self, action: #selector(loginfacebook), for: .touchUpInside)
        return st
    }()
    
    
   
    
    func loginfacebook(){
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                print(fbloginresult)
                if (result?.isCancelled)!{
                    print("da cancel")
                    return
                }
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    print("da lay thong tin")
                    print(fbloginresult.token.tokenString)
                  

                    let fbReq = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"name,email,first_name,cover,picture.type(large)"])
                    fbReq?.start(completionHandler: { (connect, info, err) in
                        guard let info = info else {return}
                        print("========================================")
                        self.dict = info as! [String : AnyObject]
                       // print(info)
                        print(self.dict)
                        let name: String  = (self.dict["name"] as? String)!
                        let IDjson: String  = (self.dict["id"] as? String)!
                        let email: String  = (self.dict["email"] as? String)!
                        let firstname: String  = (self.dict["first_name"] as? String)!
                        let picture:  [String : AnyObject]  = (self.dict["picture"] as?  [String : AnyObject])!
                        let data:  [String : AnyObject] = (picture["data"] as?  [String : AnyObject]!)!
                        let avatarFacebook:  String  = (data["url"] as? String)!
                        let cover:  [String : AnyObject]  = (self.dict["cover"] as?  [String : AnyObject])!
                        let CoverFacebook:  String = (cover["source"] as?  String!)!


                        

                        print(name)
                        print(IDjson)
                        print(email)
                        print(firstname)
                        print(avatarFacebook)
                        print(CoverFacebook)

                        
                        
                        
                        
                        
                        let newUser = UserRealm(email: email, avatarRealm: avatarFacebook, coverRealm: CoverFacebook, nameRealm: name, FirstnameRealm: firstname, ChucVuRealm: 0)
                        RealmService.shared.create(newUser)
                        
                        
                        
                        
                        
                        let url = URL(string: "https://blogdevtoidicodedao.herokuapp.com/add_user")
                        var request:URLRequest = URLRequest(url: url!)
                        request.httpMethod = "POST"
                        request.httpBody = "username=\(name)&email=\(email)&password=\("123")&avatar=\(avatarFacebook)&cover=\(CoverFacebook)&quyenhan=1&trangthai=1&like=0".data(using: .utf8)
                        
                        URLSession.shared.dataTask(with: request, completionHandler: { (data, res, err) in
                            if err != nil {
                                
                                print(err)
                                return
                            }
                            print(String(data: data!, encoding: .utf8)!)
                        }).resume()
                        
                    })
                    print(String(describing: Realm.Configuration.defaultConfiguration.fileURL))
                    
                     self.chuyenmanhinh()
                    //
                    //me?fields=name,email,picture.type(large),cover
                }
            }
     }
//
    }
    
    
 
    
    @objc func Hanhdong(){
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
    
    @objc func HanhdongSkip(){
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
    var startAnchor: NSLayoutConstraint?
    
    
    override func viewWillAppear(_ animated: Bool) {
        let IndexSoTrang = SoTrangRealm(SoTrang: 1)
        RealmService.shared.create(IndexSoTrang)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(DieuKhienTrang)
        view.addSubview(SkipButton)
        view.addSubview(NextButton)
        view.addSubview(StarButton)
        
        
        
          // su dung auto layout cho view
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        Dangkycell()
       
        
     pagecontrolBottomAnchor =   DieuKhienTrang.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 100, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        
     SkipAnchor =   SkipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
      NextAnchor =  NextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
        startAnchor = StarButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 26 , bottomConstant: 50, rightConstant: 26, widthConstant: 0, heightConstant: 50)[1]
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
        cell.page = pages[indexPath.item]
     
        
            return cell
    }
    
    // ke thua trong UICollectionViewDelegateFlowLayout
    // moi cell rong bang kich thuoc man hinh view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        if indexPath.row != 0 {
            // vi tri luc dau từ bên trái (-255) ở trên (20) đi xuống
            cell.alpha = 0
            let vitricell = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0 )
            cell.layer.transform = vitricell
            // sau 1 giây hiện ra và quay lai vi tri mac dinh
            
            UIView.animate(withDuration: 0.8) {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            }
        }
        
       
        
        
    }
    
    fileprivate func thongtinAutolayoutForButton(){
       startAnchor?.constant = 50
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
            pagecontrolBottomAnchor?.constant = -100
            
            SkipAnchor?.constant = 16
            NextAnchor?.constant = 16
           startAnchor?.constant = -50
            
            
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





