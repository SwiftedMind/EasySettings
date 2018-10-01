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
protocol SettingButtonGroupConfiguration: SettingButtonConfiguration {
    func configured(_ setting: Setting.ButtonGroup) -> Setting.ButtonGroup
}

extension Setting {
    typealias ButtonGroup = ButtonGroupModel
    class ButtonGroupModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var items: [Setting.Button] = []
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(_ id: String) {
            super.init(id)
            height = 45
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override var sectionController: ListSectionController {
            let section = Setting.ButtonGroupSection()
            section.inset = inset
            
            return section
        }
        
        override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.ButtonGroupModel, super.isEqual(toDiffableObject: object) else { return false }
            return true
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
