//
//  SettingButtonGroupModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit


/// Always includes SettingButtonConfiguration because that's needed.
public protocol SettingButtonGroupConfiguration: SettingButtonConfiguration {
    func configured(_ setting: Setting.ButtonGroup) -> Setting.ButtonGroup
}

extension Setting {
    public typealias ButtonGroup = ButtonGroupModel
    public class ButtonGroupModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var items: [Setting.Button] = []
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
            let section = Setting.ButtonGroupSection()
            section.inset = inset
            
            return section
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.ButtonGroupModel, super.isEqual(toDiffableObject: object) else { return false }
            return true
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
