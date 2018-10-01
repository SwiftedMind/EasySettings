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

protocol SettingSeparatorCellDelegate: class {
    
}

extension Setting {
    class SeparatorCell: SwipeCell {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public weak var delegate: SettingSeparatorCellDelegate?
        private var listModel: Setting.SeparatorModel?
        
        // swipe action buttons
        override var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        lazy var line: UIView = {
            let view = UIView()
            
            holderView.addSubview(view)
            return view
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(frame: CGRect) {
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
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        public func configure(withListModel listModel: Setting.SeparatorModel) {
            self.listModel = listModel
            
            holderView.alpha = listModel.alpha
            // disabled because empty space is the best separator
            //line.backgroundColor = listModel.color
        }
        // ====================
        
        
    }
}
