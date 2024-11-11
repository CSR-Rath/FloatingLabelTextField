//
//  Label + Extension.swift
//  
//
//  Created by Rath! on 11/11/24.
//

import UIKit

public extension UILabel {
    func setAttributedTextWithColors(text: String, rangesAndColors: [(range: NSRange, color: UIColor)]) {
        let attributedString = NSMutableAttributedString(string: text)
        
        for rangeAndColor in rangesAndColors {
            attributedString.addAttribute(.foregroundColor, value: rangeAndColor.color, range: rangeAndColor.range)
        }
        
        self.attributedText = attributedString
    }
}
