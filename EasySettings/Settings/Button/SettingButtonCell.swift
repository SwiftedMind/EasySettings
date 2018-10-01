//
//  SettingButtonCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

protocol SettingButtonCellDelegate: class {
}

extension Setting {
    class ButtonCell: SwipeCell, ListBindable {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        override var isHighlighted: Bool {
            didSet {
                if isHighlighted {
                    UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [.allowUserInteraction], animations: {
                        self.button.backgroundColor = self.listModel?.backgroundColor.darken(by: 0.03)
                    }, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [.allowUserInteraction], animations: {
                        self.button.backgroundColor = self.listModel?.backgroundColor
                    }, completion: nil)
                }
            }
        }
        
        /// For when used in a binding section.
        public var groupIndex: Int = 0
        
        public weak var delegate: SettingButtonCellDelegate?
        private var listModel: Setting.ButtonModel?
        
        // swipe action buttons
        override var swipeCellItems: [SwipeCell.Item] {
            return listModel?.swipeActions ?? []
        }
        
        override var swipeWidth: CGFloat {
            return listModel?.swipeWidth ?? 120
        }
        
        lazy var button: UIButton = {
            let button = UIButton()
            
            button.isUserInteractionEnabled = false
            button.setTitleColor(Setting.defaultLightText, for: UIControl.State.normal)
            
            holderView.addSubview(button)
            return button
        }()
        
        private lazy var topLineView: UIView = {
            let view = UIView()
            
            holderView.addSubview(view)
            return view
        }()
        
        private lazy var bottomLineView: UIView = {
            let view = UIView()
            
            holderView.addSubview(view)
            return view
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            button.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            bottomLineView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(2)
                make.trailing.equalToSuperview().offset(-2)
                make.bottom.equalToSuperview().offset(-2)
                make.height.equalTo(1)
            }
            
            topLineView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(2)
                make.trailing.equalToSuperview().offset(-2)
                make.top.equalToSuperview().offset(2)
                make.height.equalTo(1)
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
        public func configure(withListModel listModel: Setting.ButtonModel) {
            self.listModel = listModel
            swipeEnabled = swipeCellItems.count > 0
            
            button.setTitle(listModel.text, for: UIControl.State.normal)
            button.backgroundColor = listModel.backgroundColor
            button.setTitleColor(listModel.textColor, for: UIControl.State.normal)
            button.titleLabel?.font = listModel.font
            
            topLineView.backgroundColor = listModel.backgroundColor.lighten(by: 0.05)
            bottomLineView.backgroundColor = listModel.backgroundColor.lighten(by: 0.05)
        }
        
        func bindViewModel(_ viewModel: Any) {
            guard let viewModel = viewModel as? Setting.ButtonModel else { return }
            configure(withListModel: viewModel)
            
        }
        // ====================
        
        
    }
    
}
