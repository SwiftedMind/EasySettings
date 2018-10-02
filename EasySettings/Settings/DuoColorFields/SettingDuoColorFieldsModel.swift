//
//  SettingDuoColorFieldsModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingDuoColorFieldsConfiguration {
    func configured(_ setting: Setting.DuoColorFields) -> Setting.DuoColorFields
}

extension Setting {
    public typealias DuoColorFields = Setting.DuoColorFieldsModel
    public class DuoColorFieldsModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var colors: (left: UIColor, right: UIColor) = (.red, .green)
        public var colorLabels: (left: String, right: String) = ("Text", "Background")
        public var colorIds: (left: String, right: String) = ("", "")
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        required public init(_ id: String) {
            super.init(id)
            height = 40
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override public var sectionController: ListSectionController {
            return Setting.DuoColorFieldsSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.DuoColorFieldsModel, super.isEqual(toDiffableObject: object) else { return false }
            return self.colors == object.colors && self.colorLabels == object.colorLabels && self.colorIds == object.colorIds
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
