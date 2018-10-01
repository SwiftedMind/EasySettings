//
//  SegmentCell.swift
//  AdvancedSegmentedControl
//
//  Created by Dennis Müller on 01.10.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import SnapKit
import SwifterSwift

extension AdvancedSegmentedControl {
    
    /// The cell for the scrollable segemented control class.
    open class Cell: UICollectionViewCell {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        
        public lazy var titleLabel: UILabel = {
            let label = UILabel()
            
            label.font = .systemFont(ofSize: 16)
            label.textColor = contentView.backgroundColor?.readableTextColor
            label.textAlignment = .center
            
            contentView.addSubview(label)
            return label
        }()
        
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.backgroundColor = .clear
            
            contentView.layer.cornerRadius = 5
            contentView.layer.masksToBounds = true
            
            titleLabel.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
            }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        public func configure(withSegment segment: AdvancedSegmentedControl.Segment, tintColor: UIColor) {
            self.tintColor = tintColor
            
            titleLabel.textColor = tintColor
            titleLabel.text = segment.title
        }
        // ====================
        
    }
}
