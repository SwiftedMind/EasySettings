//
//  SettingTextViewModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 22.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingTextViewConfiguration {
    func configured(_ setting: Setting.TextView) -> Setting.TextView
}

extension Setting {
    public typealias TextView = TextViewModel
    public class TextViewModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var text: String = ""
        public var font: UIFont = SettingsPage.defaultFont.withSize(18)
        public var textColor: UIColor = SettingsPage.defaultLightText
        public var textAlignment: NSTextAlignment = .left
        public var backgroundColor: UIColor = SettingsPage.defaultLightBackground
        public var isScrollEnabled: Bool = true
        public var isEditable: Bool = false
        public var centerVertically: Bool = false
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        required public init(_ id: String) {
            super.init(id)
            height = 150
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
       override public var sectionController: ListSectionController {
            return Setting.TextViewSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.TextViewModel, super.isEqual(toDiffableObject: object) else { return false }
            return self.text == object.text && self.font == object.font && self.isEditable == object.isEditable && self.textColor == object.textColor && self.isScrollEnabled == object.isScrollEnabled && self.backgroundColor == object.backgroundColor && self.textAlignment == object.textAlignment && self.centerVertically == object.centerVertically
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
