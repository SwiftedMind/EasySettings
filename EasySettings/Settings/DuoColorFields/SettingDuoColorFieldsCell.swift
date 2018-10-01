//
//  SettingDuoColorFieldsCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

protocol SettingDuoColorFieldsCellDelegate: class {
    func didTap(onLeftColor color: UIColor)
    func didTap(onRightColor color: UIColor)
}

extension Setting {
    class DuoColorFieldsCell: SwipeCell {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public weak var delegate: SettingDuoColorFieldsCellDelegate?
        private var listModel: Setting.DuoColorFieldsModel?
        
        override var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        lazy var colorLeftButton: UIButton = {
            let button = UIButton()
            button.setTitle("Text", for: UIControl.State.normal)
            button.addTarget(self, action: #selector(handleTap(_:)), for: UIControl.Event.touchUpInside)
            
            return button
        }()
        
        lazy var colorRightButton: UIButton = {
            let button = UIButton()
            button.setTitle("Background", for: UIControl.State.normal)
            button.addTarget(self, action: #selector(handleTap(_:)), for: UIControl.Event.touchUpInside)
            
            return button
        }()
        
        lazy var colorButtonsStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [colorLeftButton, colorRightButton])
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            
            holderView.addSubview(stackView)
            return stackView
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            colorButtonsStackView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().offset(-10)
                make.bottom.equalToSuperview()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        @objc private func handleTap(_ sender: UIButton) {
            if sender == colorLeftButton {
                delegate?.didTap(onLeftColor: colorLeftButton.backgroundColor!)
            } else if sender == colorRightButton {
                delegate?.didTap(onRightColor: colorRightButton.backgroundColor!)
            }
        }
        
        public func configure(withListModel listModel: Setting.DuoColorFieldsModel) {
            
            self.listModel = listModel
            
            colorLeftButton.backgroundColor = listModel.colors.left
            colorRightButton.backgroundColor = listModel.colors.right
            
            colorLeftButton.setTitle(listModel.colorLabels.left, for: UIControl.State.normal)
            colorRightButton.setTitle(listModel.colorLabels.right, for: UIControl.State.normal)
            
            colorLeftButton.setTitleColor(listModel.colors.left.readableTextColor, for: UIControl.State.normal)
            colorRightButton.setTitleColor(listModel.colors.right.readableTextColor, for: UIControl.State.normal)
        }
        // ====================
        
        
    }
    
}
