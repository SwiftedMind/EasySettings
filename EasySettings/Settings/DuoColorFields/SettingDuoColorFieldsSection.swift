//
//  SettingDuoColorFieldsSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingDuoColorFieldsSectionDelegate: class {
    func settingDuoColorFields(_ setting: Setting.DuoColorFields, requestsLeftColorChange fromColor: UIColor)
    func settingDuoColorFields(_ setting: Setting.DuoColorFields, requestsRightColorChange fromColor: UIColor)
}

extension Setting {
    class DuoColorFieldsSection: Setting.BaseSection, SettingDuoColorFieldsCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.DuoColorFields {
            return model as! Setting.DuoColorFields
        }
        
        public weak var delegate: SettingDuoColorFieldsSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.DuoColorFieldsCell.self, for: self, at: index) as? Setting.DuoColorFieldsCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                
                return cell
            }
            fatalError()
        }
        
        override func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingDuoColorFieldsSectionDelegate
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        func didTap(onLeftColor color: UIColor) {
            delegate?.settingDuoColorFields(setting, requestsLeftColorChange: color)
        }
        
        func didTap(onRightColor color: UIColor) {
            delegate?.settingDuoColorFields(setting, requestsRightColorChange: color)
        }
        
        
        // ====================
        
        
    }
    
}
