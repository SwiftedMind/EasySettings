//
//  SettingSwitchSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 20.08.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSwitchSectionDelegate: class {
    func settingSwitch(_ setting: Setting.Switch, changedTo isOn: Bool)
}

extension Setting {
    internal class SwitchSection: Setting.BaseSection, SettingSwitchCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.Switch {
            return model as! Setting.Switch
        }
        
        internal weak var delegate: SettingSwitchSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override internal func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.SwitchCell.self, for: self, at: index) as? Setting.SwitchCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override internal func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingSwitchSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        internal func switchFlipped(toNewState isOn: Bool) {
            delegate?.settingSwitch(setting, changedTo: isOn)
        }
        // ====================
        
        
    }
    
}
