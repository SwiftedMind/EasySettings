//
//  SettingTextFieldCell.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

internal protocol SettingTextFieldCellDelegate: class {
    func settingTextField(_ textField: UITextField, didChangeToNewText text: String, inCell cell: Setting.TextFieldCell)
    func settingTextFieldDidBecomeFirstResponder(inCell cell: Setting.TextFieldCell)
}

extension Setting {
    internal class TextFieldCell: SwipeCell, UITextFieldDelegate, ListBindable {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        internal var itemIndex: Int = 0
        internal weak var delegate: SettingTextFieldCellDelegate?
        private var listModel: Setting.TextFieldModel?
        
        override var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        private lazy var textField: PaddingTextField = {
            let textField = PaddingTextField()
            
            textField.font = SettingsPage.defaultFont.withSize(16)
            textField.textColor = SettingsPage.defaultDarkText
            textField.textAlignment = .left
            textField.borderStyle = .none
            textField.returnKeyType = .done
            //textField.attributedPlaceholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x888888)!])
            textField.delegate = self
            textField.clearButtonMode = .always
            textField.tintColor = .white
            textField.backgroundColor = SettingsPage.defaultLightBackground
            
            holderView.addSubview(textField)
            
            return textField
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            textField.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(0)
                make.top.equalToSuperview()
                make.trailing.equalToSuperview().offset(-0)
                make.bottom.equalToSuperview()
            }
        }
        
        required internal init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        internal func configure(withListModel listModel: Setting.TextFieldModel) {
            self.listModel = listModel
            
            textField.text = listModel.text
            //textField.placeholder = listModel.placeholder
            textField.attributedPlaceholder = NSAttributedString(string: listModel.placeholder, attributes: [NSAttributedString.Key.font: SettingsPage.defaultFont.withSize(16), NSAttributedString.Key.foregroundColor: SettingsPage.defaultDarkBackground])
        }
        
        internal func textFieldDidBeginEditing(_ textField: UITextField) {
            delegate?.settingTextFieldDidBecomeFirstResponder(inCell: self)
        }
        
        internal func textFieldDidEndEditing(_ textField: UITextField) {
            delegate?.settingTextField(textField, didChangeToNewText: textField.text ?? "", inCell: self)
        }
        
        internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        internal func bindViewModel(_ viewModel: Any) {
            guard let model = viewModel as? Setting.TextField else { return }
            configure(withListModel: model)
        }
        // ====================
        
        
    }
}
