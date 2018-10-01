//
//  Setting.SubMenuButtonSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 16.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingSubMenuButtonSectionDelegate: class {
    func settingSubMenuButton(didTapSubMenuButton setting: Setting.SubMenuButtonModel)
}

extension Setting {
    class SubMenuButtonSection: Setting.BaseSection, SettingSubMenuButtonCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.SubMenuButton {
            return model as! Setting.SubMenuButton
        }
        
        public weak var delegate: SettingSubMenuButtonSectionDelegate?
        
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.SubMenuButtonCell.self, for: self, at: index) as? Setting.SubMenuButtonCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingSubMenuButtonSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        override func didSelectItem(at index: Int) {
            delegate?.settingSubMenuButton(didTapSubMenuButton: setting)
        }
        
        override func didDeselectItem(at index: Int) {
            
        }
        
//        func didTapButton() {
//            delegate?.settingSubMenuButton(didTapSubMenuButton: setting)
//        }
        // ====================
        
    }
}

