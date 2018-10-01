//
//  SettingHeadingSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 18.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingHeadingSectionDelegate: class {
    
}

extension Setting {
    internal class HeadingSection: Setting.BaseSection, SettingHeadingCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.Heading {
            return model as! Setting.Heading
        }
        
        internal weak var delegate: SettingHeadingSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override internal func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.HeadingCell.self, for: self, at: index) as? Setting.HeadingCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override internal func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = viewController as? SettingHeadingSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
        
    }
    
}
