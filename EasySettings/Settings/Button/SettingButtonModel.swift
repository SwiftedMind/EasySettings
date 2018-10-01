//
//  SettingButtonModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public enum SettingButtonType {
    case custom
    case normal
    case destructive
    case bright
    
    public var color: UIColor {
        switch self {
        case .normal:
            return Setting.defaultIntermediateBackground
        case .destructive:
            return Setting.defaultDarkBackground
        case .bright:
            return Setting.defaultLightText
        case .custom:
            return .black
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .normal:
            return SettingButtonType.normal.color.readableTextColor
        case .destructive:
            return Setting.defaultDangerColor
        case .bright:
            return SettingButtonType.bright.color.readableTextColor
        case .custom:
            return .black
        }
    }
}

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
        public var backgroundColor: UIColor = SettingButtonType.normal.color
        public var textColor: UIColor = SettingButtonType.normal.textColor
        public var font: UIFont = Setting.defaultBoldFont.withSize(16)
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override public init(_ id: String) {
            super.init(id)
            height = 50
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override open var sectionController: ListSectionController {
            return Setting.ButtonSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.ButtonModel, super.isEqual(toDiffableObject: object) else { return false }
            
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
