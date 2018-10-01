//
//  SettingSwitchSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 20.08.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingSwitchSectionDelegate: class {
    func settingSwitch(_ setting: Setting.Switch, changedTo isOn: Bool)
}

extension Setting {
    class SwitchSection: Setting.BaseSection, SettingSwitchCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.Switch {
            return model as! Setting.Switch
        }
        
        public weak var delegate: SettingSwitchSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.SwitchCell.self, for: self, at: index) as? Setting.SwitchCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingSwitchSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        func switchFlipped(toNewState isOn: Bool) {
            delegate?.settingSwitch(setting, changedTo: isOn)
        }
        // ====================
        
        
    }
    
}
