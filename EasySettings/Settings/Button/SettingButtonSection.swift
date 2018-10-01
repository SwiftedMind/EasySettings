//
//  SettingButtonSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingButtonSectionDelegate: class {
    func settingButton(didTapButton setting: Setting.Button)
}

extension Setting {
    internal class ButtonSection: Setting.BaseSection, SettingButtonCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.Button {
            return model as! Setting.Button
        }
        
        private weak var delegate: SettingButtonSectionDelegate?
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
        
        override internal func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingButtonSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        override internal func didSelectItem(at index: Int) {
            delegate?.settingButton(didTapButton: setting)
        }
        
        override internal func didDeselectItem(at index: Int) {
            
        }
        // ====================
        
        
    }
    
}
