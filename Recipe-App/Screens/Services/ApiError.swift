//
//  ApiError.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

struct ApiError: LocalizedError {
    
    let message: String
    
    var errorDescription: String? {
        return message
    }
    
    var localizedDescription: String {
        return message
    }
    
    init(_ message: String) {
        self.message = message
    }
    
    static func unexpected(_ message: String) -> ApiError {
        return ApiError("Unexpected error: \(message)")
    }
    
    static func fromServer(_ message: String) -> ApiError {
        return ApiError("Server returned the message:\n\(message)")
    }
    
}

struct AppError: LocalizedError {
    
    let message: String
    
    var errorDescription: String? {
        return message
    }
    
    var localizedDescription: String {
        return message
    }
    
    init(_ message: String) {
        self.message = message
    }
    
}

