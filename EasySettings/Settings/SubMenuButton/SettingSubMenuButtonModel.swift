//
//  Setting.SubMenuButtonModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 16.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSubMenuButtonConfiguration {
    func configured(_ setting: Setting.SubMenuButton) -> Setting.SubMenuButton
}

extension Setting {
    public typealias SubMenuButton = SubMenuButtonModel
    
    /// Simple button with an arrow on the right side.
    ///
    /// This setting adds the swipeItems set in the model to the cell.
    public class SubMenuButtonModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var text: String = "No Button Text"
        public var backgroundColor: UIColor = Setting.defaultLightBackground
        public var textColor: UIColor = UIColor(hex: 0xeeeeee)!
        public var font: UIFont = Setting.defaultBoldFont.withSize(16)
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override public init(_ id: String) {
            super.init(id)
            height = 50
            setButtonType(to: .normal)
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override open var sectionController: ListSectionController {
            return Setting.SubMenuButtonSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.SubMenuButtonModel, super.isEqual(toDiffableObject: object) else { return false }
            
            return self.text == object.text && self.backgroundColor == object.backgroundColor && self.textColor == object.textColor && self.font == object.font
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        public func setButtonType(to type: SettingButtonType) {
            backgroundColor = type.color
            textColor = type.textColor
            font = Setting.defaultMediumFont.withSize(16)
        }
        // ====================
        
    }
}
