//
//  View + Extensiopn.swift
//  
//
//  Created by Rath! on 11/11/24.
//

import UIKit

// MARK: - Handle Array FloatingLabelTextField
public extension UIView {
    
    public func arrayTextFieldsResignFirstResponder(textFields: [FloatingLabelTextField]) {
        textFields.forEach { $0.resignFirstResponder() }
    }
    
    public func isValidateTextField(textFields: [FloatingLabelTextField],
                                    success: @escaping (_ success: FloatingLabelTextField) -> (),
                                    failure: @escaping (_ failure: FloatingLabelTextField) -> ()) {
        textFields.forEach { item in
            if (item.text == "" || item.text == "  ") && !item.isOptionalField {
                item.isValidate = false
                failure(item)
            } else {
                success(item)
                item.isValidate = true
            }
        }
    }
}
