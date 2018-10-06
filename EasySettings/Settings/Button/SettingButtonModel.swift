//
//  SettingButtonModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingButtonConfiguration {
    func configured(_ setting: Setting.Button) -> Setting.Button
}

extension Setting {
    public typealias Button = ButtonModel
    
    /// Simple button.
    ///
    /// This setting adds the swipeItems set in the model to the cell.
    public class ButtonModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var text: String = "No Button Text"
        public var backgroundColor: UIColor = SettingsPage.Style.defaultIntermediateBackground
        public var textColor: UIColor = SettingsPage.Style.defaultIntermediateBackground.readableTextColor
        public var font: UIFont = SettingsPage.Style.defaultBoldFont.withSize(16)
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        required public init(_ id: String) {
            super.init(id)
            height = 45
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override public var sectionController: ListSectionController {
            return Setting.ButtonSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.ButtonModel, super.isEqual(toDiffableObject: object) else { return false }
            
            return self.text == object.text && self.backgroundColor == object.backgroundColor && self.textColor == object.textColor && self.font == object.font
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        // ====================
        
    }
    
}
