//
//  SettingSeparatorCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

internal protocol SettingSeparatorCellDelegate: class {
    
}

extension Setting {
    internal class SeparatorCell: SwipeCell {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        internal weak var delegate: SettingSeparatorCellDelegate?
        private var listModel: Setting.SeparatorModel?
        
        // swipe action buttons
        override open var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        private lazy var line: UIView = {
            let view = UIView()
            
            holderView.addSubview(view)
            return view
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            line.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(1)
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
        internal func configure(withListModel listModel: Setting.SeparatorModel) {
            self.listModel = listModel
            
            holderView.alpha = listModel.alpha
            // disabled because empty space is the best separator
            //line.backgroundColor = listModel.color
        }
        // ====================
        
        
    }
}
