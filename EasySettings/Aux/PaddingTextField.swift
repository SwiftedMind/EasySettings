//
//  PaddingTextField.swift
//  EasySettings
//
//  Created by Dennis Müller on 01.10.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit

/// UITextField with padding on the left and right
internal class PaddingTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9);
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
