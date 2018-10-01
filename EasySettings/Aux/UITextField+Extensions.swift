//
//  UITextField+Extensions.swift
//  EasySettings
//
//  Created by Dennis Müller on 01.10.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
