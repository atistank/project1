//
//  PostMain.swift
//  Project1_Duy
//
//  Created by Duy on 11/2/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import Foundation
import RealmSwift

class PostMan: Object {
    @objc dynamic var titleRealm:String = ""
    @objc dynamic var DescipRealm:String = ""
    @objc dynamic var timeRealm:String = ""
    @objc dynamic var imgRealm:String = ""
    @objc dynamic var linkRealm:String = ""
     @objc dynamic var photoData: NSData?
    let commentRealm = RealmOptional<Int>()
    
    
    
    convenience init(titleRealm: String, DescipRealm: String, timeRealm: String, imgRealm:String,linkRealm : String,photoData: NSData,commentRealm:Int?) {
        self.init()
        self.titleRealm = titleRealm
        self.DescipRealm = DescipRealm
        self.timeRealm = timeRealm
        self.imgRealm = imgRealm
        self.linkRealm = linkRealm
        self.photoData = photoData
        self.commentRealm.value = commentRealm

    }

    func ChucVuString() -> String? {
        guard let commentRealm = commentRealm.value else {
            return nil
        }
        return String(commentRealm)
        
    }
    
    
}
