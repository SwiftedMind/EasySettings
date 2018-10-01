//
//  SettingSegmentedControlSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 15.08.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingSegmentedControlSectionDelegate: class {
    func settingSegmentedControl(_ setting: Setting.SegmentedControl, didChangeToNewIndex newIndex: Int)
}

extension Setting {
    class SegmentedControlSection: Setting.BaseSection, SettingSegmentedControlCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.SegmentedControl {
            return model as! Setting.SegmentedControl
        }
        
        public weak var delegate: SettingSegmentedControlSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.SegmentedControlCell.self, for: self, at: index) as? Setting.SegmentedControlCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingSegmentedControlSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        func segmentedControlDidchange(toNewIndex newIndex: Int) {
            delegate?.settingSegmentedControl(setting, didChangeToNewIndex: newIndex)
        }
        // ====================
        
        
    }
    
}
