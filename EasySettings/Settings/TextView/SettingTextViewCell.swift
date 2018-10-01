//
//  SettingTextViewCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 22.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

internal protocol SettingTextViewCellDelegate: class {
    func settingTextview(_ textView: UITextView, didChangeToNewText text: String)
}

extension Setting {
    internal class TextViewCell: SwipeCell, ListBindable, UITextViewDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        internal weak var delegate: SettingTextViewCellDelegate?
        private var listModel: Setting.TextViewModel?
        
        // swipe action buttons
        override open var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        lazy private var textView: UITextView = {
            let textView = UITextView()
            textView.font = .boldSystemFont(ofSize: 18)
            textView.textColor = UIColor(hex: 0xeeeeee)
            textView.textAlignment = .left
            textView.returnKeyType = .done
            textView.tintColor = .white
            textView.delegate = self
            
            holderView.addSubview(textView)
            return textView
        }()
        
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            textView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview()
                make.top.equalToSuperview()
                make.trailing.equalToSuperview()
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
        internal func configure(withListModel listModel: Setting.TextViewModel) {
            self.listModel = listModel
            self.textView.text = listModel.text
            self.textView.font = listModel.font
            self.textView.textColor = listModel.textColor
            self.textView.textAlignment = listModel.textAlignment
            self.textView.backgroundColor = listModel.backgroundColor
            self.textView.isScrollEnabled = listModel.isScrollEnabled
            self.textView.isEditable = listModel.isEditable
            
            if listModel.centerVertically {
                textView.centerVertically()
            } else {
                textView.contentOffset.y = 0
            }
        }
        
        internal func bindViewModel(_ viewModel: Any) {
            guard let viewModel = viewModel as? Setting.TextViewModel else { return }
            configure(withListModel: viewModel)
        }
        
        internal func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
            delegate?.settingTextview(textView, didChangeToNewText: textView.text)
            return true
        }
        // ====================
        
        
    }
}

