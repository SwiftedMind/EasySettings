//
//  SettingSectionHeaderSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSectionHeaderSectionDelegate: class {
    
}

extension Setting {
    internal class SectionHeaderSection: Setting.BaseSection, SettingSectionHeaderCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.SectionHeaderModel {
            return model as! Setting.SectionHeaderModel
        }
        
        internal weak var delegate: SettingSectionHeaderSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override internal func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.SectionHeaderCell.self, for: self, at: index) as? Setting.SectionHeaderCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                
                return cell
            }
            fatalError()
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        override internal func supportedElementKinds() -> [String] {
            return []
        }
        // ====================
        
        
    }
    
}
