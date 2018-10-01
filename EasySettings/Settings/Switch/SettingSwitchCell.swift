//
//  SettingSwitchCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 20.08.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

internal protocol SettingSwitchCellDelegate: class {
    func switchFlipped(toNewState isOn: Bool)
}

extension Setting {
    internal class SwitchCell: SwipeCell, ListBindable {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        internal weak var delegate: SettingSwitchCellDelegate?
        private var listModel: Setting.SwitchModel?
        
        // swipe action buttons
        override open var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        private lazy var textLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            
            holderView.addSubview(label)
            return label
        }()
        
        private lazy var checkbox: UISwitch = {
            let box = UISwitch()
            
            box.onTintColor = Setting.defaultLightText
            box.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            
            holderView.addSubview(box)
            return box
        }()
        
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            textLabel.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalTo(self.checkbox.snp.leading).offset(-10)
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
            checkbox.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-15)
                make.centerY.equalToSuperview()
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
        @objc private func switchChanged() {
            delegate?.switchFlipped(toNewState: checkbox.isOn)
        }
        
        internal func configure(withListModel listModel: Setting.SwitchModel) {
            self.listModel = listModel
            
            checkbox.isOn = listModel.isOn
            checkbox.isEnabled = listModel.isEnabled
            textLabel.text = listModel.text
            textLabel.textAlignment = listModel.textAlignment
            textLabel.font = listModel.font
            textLabel.textColor = listModel.textColor
            
            holderView.backgroundColor = listModel.backgroundColor
            
        }
        
        internal func bindViewModel(_ viewModel: Any) {
            guard let viewModel = viewModel as? Setting.SwitchModel else { return }
            configure(withListModel: viewModel)
        }
        // ====================
        
        
    }
}

