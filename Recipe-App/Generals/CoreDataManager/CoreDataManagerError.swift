//
//  CoreDataManagerError.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import Foundation

struct CoreDataManagerError: Error {
    
    static var showLogError = true
    
    // MARK: Properties
    
    private static var mustCallSetupMethodErrorMessage = "must be set up using setUp(withDataModelName:bundle:persistentStoreType:) before it can be used."
    
    private let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var localizedDescription: String {
        return message
    }
    
}

extension CoreDataManagerError {
    
    // MARK: - CoreDataManagerError Helper
    
    static func unexpected(_ message: String) -> CoreDataManagerError {
        return CoreDataManagerError("Unexpected error: \(message)")
    }
    
    static func errorSetUpMessage() -> CoreDataManagerError {
        return CoreDataManagerError("CoreDataManager : \(mustCallSetupMethodErrorMessage)")
    }
    
    static func log(error: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        guard showLogError == true else {
            return
        }
        print("[CoreDataManagerError - \(function) line \(line)] Error: \(error.localizedDescription)")
    }
    
}
