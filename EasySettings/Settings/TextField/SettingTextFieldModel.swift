//
//  SettingTextFieldModel.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingTextFieldConfiguration {
    func configured(_ setting: Setting.TextField) -> Setting.TextField
}

extension Setting {
    public typealias TextField = Setting.TextFieldModel
    public class TextFieldModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var text: String = ""
        public var placeholder: String = ""
        public var backgroundColor: UIColor = SettingsPage.Style.defaultIntermediateBackground
        public var font: UIFont = SettingsPage.Style.defaultFont // don't check for isEqual. not important
        public var textColor: UIColor = SettingsPage.Style.defaultLightText
        public var placeholderTextColor: UIColor = SettingsPage.Style.defaultLightText.withAlphaComponent(0.4)
        public var keyboardType: UIKeyboardType = .default
        public var isEnabled: Bool = true
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
            return Setting.TextFieldSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.TextFieldModel, super.isEqual(toDiffableObject: object) else { return false }
            return self.text == object.text && self.placeholder == object.placeholder && self.backgroundColor == object.backgroundColor && self.textColor == object.textColor && self.placeholderTextColor == object.placeholderTextColor && self.isEnabled == object.isEnabled
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
}
