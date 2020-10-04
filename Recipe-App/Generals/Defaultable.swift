//
//  Defaultable.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import Foundation

protocol Defaultable {
    static var defaultValue: Self { get }
}

extension Optional where Wrapped: Defaultable {
    var unwrappedValue: Wrapped { return self ?? Wrapped.defaultValue }
}

extension Int: Defaultable {
    static var defaultValue: Int { return 0 }
}

extension String: Defaultable {
    static var defaultValue: String { return "" }
}

extension Array: Defaultable {
    static var defaultValue: Array<Element> { return [] }
}





