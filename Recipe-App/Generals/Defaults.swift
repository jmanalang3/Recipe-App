//
//  Defaults.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 05/10/2020.
//

import Foundation

final class Defaults {
    
    fileprivate enum Key: String {
        case firstTimeUser
        
        static let all: [Key] = [
            .firstTimeUser,
        ]
    }
    
    static var isFirstTimeUser: Bool? {
        get {
            return UserDefaults.standard.value(forKey: Key.firstTimeUser.rawValue) as? Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.firstTimeUser.rawValue)
        }
    }
    
    class func synchronize() {
        UserDefaults.standard.synchronize()
    }
    
    class func clearAll() {
        let defaults = UserDefaults.standard
        for key in Key.all {
            defaults.removeObject(forKey: key.rawValue)
        }
        defaults.synchronize()
    }
    
}
