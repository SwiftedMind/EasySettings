//
//  SettingButtonSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingButtonSectionDelegate: class {
    func settingButton(didTapButton setting: Setting.Button)
}

extension Setting {
    class ButtonSection: Setting.BaseSection, SettingButtonCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.Button {
            return model as! Setting.Button
        }
        
        public weak var delegate: SettingButtonSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.ButtonCell.self, for: self, at: index) as? Setting.ButtonCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingButtonSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        override func didSelectItem(at index: Int) {
            delegate?.settingButton(didTapButton: setting)
        }
        
        override func didDeselectItem(at index: Int) {
            
        }
        // ====================
        
        
    }
    
}
