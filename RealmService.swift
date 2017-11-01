//
//  RealmService.swift
//  Project1_Duy
//
//  Created by Duy on 10/31/17.
//  Copyright © 2017 Duy. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {

    private init(){}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    
    func create<T: Object>(_ object: T)
    {
        do
        {
            try realm.write
            {
                realm.add(object)
            }
            
        }catch
        {
            print("loi create realm")
        }
        
    }
    
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?])
    {
        do
        {
            try realm.write
            {
                for (key,value) in dictionary
                {
                    object.setValue(value, forKey: key)
                }
            }
            
        }
        catch
        {
            print("loi update realm")
        }
        
        
    }
    func delete<T: Object>(_ object: T)
    {
        do
        {
            try realm.write
            {
                realm.delete(object)
            }
        }
        catch
        {
            print("loi delete realm")
        }
        
    }
    
    func post(_ error: Error)
    {
        
    }
    
    
}

