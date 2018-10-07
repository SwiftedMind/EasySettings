//
//  SettingSegmentedControlModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 15.08.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSegmentedControlConfiguration {
    func configured(_ setting: Setting.SegmentedControl) -> Setting.SegmentedControl
}

extension Setting {
    public typealias SegmentedControl = SegmentedControlModel
    public class SegmentedControlModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var segments: [String] = []
        public var activeSegment: Int = 0
        public var segmentsWidth: CGFloat = 100
        public var reloadUIOnChange: Bool = false
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        required public init(_ id: String) {
            super.init(id)
            height = 50
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override public var sectionController: ListSectionController {
            return Setting.SegmentedControlSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard reloadUIOnChange else { return true }
            guard let object = object as? Setting.SegmentedControlModel, super.isEqual(toDiffableObject: object) else { return false }
            return self.segments == object.segments && self.activeSegment == object.activeSegment && self.segmentsWidth == object.segmentsWidth
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
