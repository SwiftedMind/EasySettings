//
//  SettingSectionHeaderCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

protocol SettingSectionHeaderCellDelegate: class {
    
}

extension Setting {
    class SectionHeaderCell: SwipeCell {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public weak var delegate: SettingSectionHeaderCellDelegate?
        private var listModel: Setting.SectionHeaderModel?
        
        override var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 24)
            label.textColor = UIColor(hex: 0xeeeeee)
            
            holderView.addSubview(label)
            return label
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            label.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(15)
                make.bottom.equalToSuperview().offset(-5)
                make.trailing.equalToSuperview().offset(-10)
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
        public func configure(withListModel listModel: Setting.SectionHeaderModel) {
            self.listModel = listModel
            label.text = listModel.headerTitle
        }
        // ====================
        
        
    }
    
}
