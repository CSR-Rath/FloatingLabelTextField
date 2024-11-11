//
//  View + Extensiopn.swift
//  
//
//  Created by Rath! on 11/11/24.
//

import UIKit

// MARK: - Handle Array FloatingLabelTextField
public extension UIView {
    
    func arrayTextFieldsResignFirstResponder(textFields: [FloatingLabelTextField]) {
        textFields.forEach { $0.resignFirstResponder() }
    }
    
    func isValidateTextField(textFields: [FloatingLabelTextField],
                                    success: @escaping (_ success: FloatingLabelTextField) -> (),
                                    failure: @escaping (_ failure: FloatingLabelTextField) -> ()) {
        textFields.forEach { item in
            if (item.text == "" || item.text == "  ") && !item.isOptionalField {
                item.isShowWarning(status: false)
                failure(item)
            } else {
                item.isShowWarning(status: true)
                success(item)
            }
        }
    }
}
