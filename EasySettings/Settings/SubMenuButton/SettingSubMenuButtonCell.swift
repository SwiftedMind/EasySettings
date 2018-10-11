//
//  Setting.SubMenuButtonCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 16.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

internal protocol SettingSubMenuButtonCellDelegate: class {
    //func didTapButton()
}

extension Setting {
    internal class SubMenuButtonCell: SwipeCell, ListBindable {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        override internal var isHighlighted: Bool {
            didSet {
                if isHighlighted {
                    UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [.allowUserInteraction], animations: {
                        self.arrowImageView.transform = CGAffineTransform(translationX: 10, y: 0)
                        self.button.backgroundColor = self.listModel?.backgroundColor.darken(by: 0.03)
                    }, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [.allowUserInteraction], animations: {
                        self.arrowImageView.transform = .identity
                        self.button.backgroundColor = self.listModel?.backgroundColor
                    }, completion: nil)
                }
            }
        }
        
        internal weak var delegate: SettingSubMenuButtonCellDelegate?
        private var listModel: Setting.SubMenuButtonModel?
        
        // swipe action buttons
        override open var swipeCellItems: [SwipeCell.Item] {
            return listModel?.swipeItems ?? []
        }
        
        override var swipeWidth: CGFloat {
            return listModel?.swipeWidth ?? 120
        }
        
        private lazy var button: UIButton = {
            let button = UIButton()
            button.isUserInteractionEnabled = false
            
            holderView.addSubview(button)
            return button
        }()
        
        private lazy var arrowImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "rightArrow", in: Bundle(for: SettingsPage.Controller.self), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate))
            imageView.contentMode = .scaleAspectFit
            
            holderView.addSubview(imageView)
            return imageView
        }()
        
        
        private lazy var topLineView: UIView = {
            let view = UIView()
            
            view.backgroundColor = SettingsPage.Style.defaultIntermediateBackground
            
            holderView.addSubview(view)
            return view
        }()
        
        private lazy var bottomLineView: UIView = {
            let view = UIView()
            
            view.backgroundColor = SettingsPage.Style.defaultLightBackground
            
            holderView.addSubview(view)
            return view
        }()
        
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            
            button.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            arrowImageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(15)
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(-15)
                make.width.equalTo(50)
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
        
        required internal init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        internal func configure(withListModel listModel: Setting.SubMenuButtonModel) {
            self.listModel = listModel
            
            button.setTitle(listModel.text, for: UIControl.State.normal)
            button.backgroundColor = listModel.backgroundColor
            button.setTitleColor(listModel.textColor, for: UIControl.State.normal)
            button.titleLabel?.font = listModel.font
            arrowImageView.tintColor = listModel.backgroundColor.readableTextColor
            
            swipeEnabled = swipeCellItems.count > 0
            
            topLineView.backgroundColor = listModel.backgroundColor.lighten(by: 0.05)
            bottomLineView.backgroundColor = listModel.backgroundColor.lighten(by: 0.05)
        }
        
        internal func bindViewModel(_ viewModel: Any) {
            guard let viewModel = viewModel as? Setting.SubMenuButtonModel else { return }
            configure(withListModel: viewModel)
        }

        // ====================
        
    }
}
