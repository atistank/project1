//
//  ExtensionForUserDefauls.swift
//  Project1_Duy
//
//  Created by Duy on 9/10/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import Foundation
extension UserDefaults {
    
    
   
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
