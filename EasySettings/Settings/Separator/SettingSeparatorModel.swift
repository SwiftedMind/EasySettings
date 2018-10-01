//
//  SettingSeparatorModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingSeparatorConfiguration {
    func configured(_ setting: Setting.Separator) -> Setting.Separator
}

extension Setting {
    typealias Separator = Setting.SeparatorModel
    class SeparatorModel: Setting.BaseModel {
        
        
        public var color: UIColor = Setting.defaultDarkBackground
        public var alpha: CGFloat = 0.1
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(_ id: String) {
            super.init(id)
            height = 20
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override var sectionController: ListSectionController {
            return Setting.SeparatorSection()
        }
        
        override func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.SeparatorModel, super.isEqual(toDiffableObject: object) else { return false }
            return self.color == object.color && self.alpha == object.alpha
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}