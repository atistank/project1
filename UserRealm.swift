//
//  UserRealm.swift
//  Project1_Duy
//
//  Created by Duy on 10/31/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import Foundation
import RealmSwift

class UserRealm: Object {
    @objc dynamic var email:String? = nil
    @objc dynamic var avatarRealm:String = ""
    @objc dynamic var coverRealm:String = ""
    @objc dynamic var nameRealm:String = ""
    @objc dynamic var FirstnameRealm:String = ""
    let ChucVuRealm = RealmOptional<Int>()
    
    convenience init(email: String, avatarRealm: String, coverRealm: String, nameRealm:String,FirstnameRealm : String,ChucVuRealm:Int?) {
        self.init()
        self.email = email
        self.avatarRealm = avatarRealm
        self.coverRealm = coverRealm
        self.nameRealm = nameRealm
        self.FirstnameRealm = FirstnameRealm
        self.ChucVuRealm.value = ChucVuRealm
        
    }
    
    func ChucVuString() -> String? {
        guard let ChucVuRealm = ChucVuRealm.value else {
            return nil
        }
        return String(ChucVuRealm)
        
    }
    
    
}
