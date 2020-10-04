//
//  PersistentStore.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import Foundation
import CoreData

// MARK: - PersistentStoreType

enum PersistentStoreType {
    case sqLite
    case binary
    case inMemory
    var stringValue: String {
        switch self {
        case .sqLite:
            return NSSQLiteStoreType
        case .binary:
            return NSBinaryStoreType
        case .inMemory:
            return NSInMemoryStoreType
        }
    }
}
