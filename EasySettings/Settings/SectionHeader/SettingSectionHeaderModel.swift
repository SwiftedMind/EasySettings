//
//  SettingSectionHeaderModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSectionHeaderConfiguration {
    func configured(_ setting: Setting.SectionHeader) -> Setting.SectionHeader
}

extension Setting {
    public typealias SectionHeader = Setting.SectionHeaderModel
    public class SectionHeaderModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        required public init(_ id: String) {
            super.init(id)
            height = 40
            inset.top += 8
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override public var sectionController: ListSectionController {
            return Setting.SectionHeaderSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.SectionHeaderModel, super.isEqual(toDiffableObject: object) else { return false }
            return true
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
