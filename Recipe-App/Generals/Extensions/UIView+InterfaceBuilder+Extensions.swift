//
//  UIView+InterfaceBuilder+Extensions.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

// MARK: - Interfacte Builder helpers

extension UIView {
    
    func viewFromOwnedNib(named nibName: String? = nil) -> UIView {
        let bundle = Bundle(for: self.classForCoder)
        return {
            if let nibName = nibName {
                return bundle.loadNibNamed(nibName, owner: self, options: nil)!.last as! UIView
            }
            return bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)!.last as! UIView
            }()
    }
    
    /// Convenience function for creating a view from a nib file.
    /// Returns an instance of the `UIView` subclass that called the function.
    class func instantiateFromNib() -> Self {
        return self.instantiateFromNib(in: Bundle.main)
    }
    
}

fileprivate extension UIView {
    
    /// Creates a `UIView` subclass from a nib file of the same name. If an XIB file of the same name
    /// as the class does not exist and this function is invoked, a fatal error is thrown
    /// since it is a developer error that must definitely be fixed.
    class func instantiateFromNib<T>(in bundle: Bundle) -> T {
        let objects = bundle.loadNibNamed(String(describing: self), owner: self, options: nil)!
        let view = objects.last as! T
        return view
    }
    
}


