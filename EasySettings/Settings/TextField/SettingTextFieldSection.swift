//
//  SettingTextFieldSection.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import SwipeCell

public protocol SettingTextFieldSectionDelegate: class {
    func settingTextField(_ setting: Setting.TextField, didChangeToNewText text: String)
}

extension Setting {
    internal class TextFieldSection: Setting.BaseSection, SettingTextFieldCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.TextField {
            return model as! Setting.TextField
        }
        
        internal weak var delegate: SettingTextFieldSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override internal func sizeForItem(at  index: Int) -> CGSize {
            let width = collectionContext!.containerSize.width
            return CGSize(width: width, height: model.height)
        }
        
        override internal func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.TextFieldCell.self, for: self, at: index) as? Setting.TextFieldCell {
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                return cell
            }
            fatalError()
        }
        
        override internal func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingTextFieldSectionDelegate
            //actionDelegate = viewController as? SettingSwipeCellActionsSupport
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        internal func settingTextField(_ textField: UITextField, didChangeToNewText text: String, inCell cell: Setting.TextFieldCell) {
            delegate?.settingTextField(setting, didChangeToNewText: text)
        }
        
        internal func settingTextFieldDidBecomeFirstResponder(inCell cell: Setting.TextFieldCell) {
            
        }
        // ====================
        
        
    }
}
