//
//  SettingTextViewSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 22.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingTextViewSectionDelegate: class {
    func settingTextView(_ setting: Setting.TextView, didChangeToNewText text: String)
}

extension Setting {
    class TextViewSection: Setting.BaseSection, SettingTextViewCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.TextView {
            return model as! Setting.TextView
        }
        
        public weak var delegate: SettingTextViewSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.TextViewCell.self, for: self, at: index) as? Setting.TextViewCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = viewController as? SettingTextViewSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        func settingTextview(_ textView: UITextView, didChangeToNewText text: String) {
            delegate?.settingTextView(setting, didChangeToNewText: text)
        }
        // ====================
        
        
    }
    
}
