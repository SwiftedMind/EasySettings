//
//  Setting.SubMenuButtonModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 16.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingSubMenuButtonConfiguration {
    func configured(_ setting: Setting.SubMenuButton) -> Setting.SubMenuButton
}

extension Setting {
    typealias SubMenuButton = SubMenuButtonModel
    class SubMenuButtonModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var text: String = "No Button Text"
        public var backgroundColor: UIColor = Setting.defaultLightBackground
        public var textColor: UIColor = UIColor(hex: 0xeeeeee)!
        public var font: UIFont = Setting.defaultBoldFont.withSize(16)
        
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(_ id: String) {
            super.init(id)
            height = 50
            setButtonType(to: .normal)
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override var sectionController: ListSectionController {
            return Setting.SubMenuButtonSection()
        }
        
        override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.SubMenuButtonModel, super.isEqual(toDiffableObject: object) else { return false }
            
            return self.text == object.text && self.backgroundColor == object.backgroundColor && self.textColor == object.textColor && self.font == object.font
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        func setButtonType(to type: SettingButtonType) {
            backgroundColor = type.color
            textColor = type.textColor
            font = Setting.defaultMediumFont.withSize(16)
        }
        // ====================
        
    }
}
