//
//  UIView+Textfield.swift
//  PokeTypes
//
//  Created by Jaume on 31/10/2020.
//

import Foundation
import UIKit

extension UIView {
    func findTextfield() -> UIView? {
        if !interactions.filter({ $0 is UITextInteraction }).isEmpty {
           return self
        } else {
            for view in subviews {
                if !interactions.filter({ $0 is UITextInteraction }).isEmpty {
                    return view
                } else if let textView = view.findTextfield() {
                    return textView
                }
            }
        }
        
        return nil
    }
}
