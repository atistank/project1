//
//  SoTrangRealm.swift
//  Project1_Duy
//
//  Created by Duy on 11/4/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import Foundation
import RealmSwift


class SoTrangRealm: Object{
let SoTrang = RealmOptional<Int>()

    convenience init(SoTrang:Int?){
    self.init()
    self.SoTrang.value = SoTrang
    
}

func SoTrangString() -> String? {
    guard let SoTrang2 = SoTrang.value else {
        return nil
    }
    return String(SoTrang2)
    
}
}
