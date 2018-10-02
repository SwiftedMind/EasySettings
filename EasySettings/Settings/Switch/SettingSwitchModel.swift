//
//  SettingSwitchModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 20.08.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSwitchConfiguration {
    func configured(_ setting: Setting.Switch) -> Setting.Switch
}

extension Setting {
    public typealias Switch = SwitchModel
    public class SwitchModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var text: String = ""
        public var font: UIFont = SettingsPage.defaultFont.withSize(16)
        public var textColor: UIColor = SettingsPage.defaultLightText
        public var textAlignment: NSTextAlignment = .left
        public var backgroundColor: UIColor = .clear
        public var isOn: Bool = false
        public var isEnabled: Bool = true
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override public init(_ id: String) {
            super.init(id)
            height = 45
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override open var sectionController: ListSectionController {
            return Setting.SwitchSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.SwitchModel, super.isEqual(toDiffableObject: object) else { return false }
            return self.isOn == object.isOn && self.text == object.text && self.isEnabled == object.isEnabled && self.font == object.font && self.textColor == object.textColor && self.textAlignment == object.textAlignment && self.backgroundColor == object.backgroundColor
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
