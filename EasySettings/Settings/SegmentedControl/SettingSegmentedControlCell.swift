//
//  SettingSegmentedControlCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 15.08.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell
import AdvancedSegmentedControl

internal protocol SettingSegmentedControlCellDelegate: class {
    func segmentedControlDidchange(toNewIndex newIndex: Int)
}

extension Setting {
    internal class SegmentedControlCell: SwipeCell, ListBindable {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        internal weak var delegate: SettingSegmentedControlCellDelegate?
        private var listModel: Setting.SegmentedControlModel?
        
        // swipe action buttons
        override open var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        private lazy var segmentedControl: AdvancedSegmentedControl = {
            let control = AdvancedSegmentedControl()
            control.tintColor = SettingsPage.Style.defaultLightText
            control.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
            control.stretchSegmentsIfPossible = true
            
            holderView.addSubview(control)
            return control
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = .clear
            swipeEnabled = false
            
            segmentedControl.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10))
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
        internal func configure(withListModel listModel: Setting.SegmentedControlModel) {
            self.listModel = listModel
            segmentedControl.setSegments(listModel.segments)
            segmentedControl.selectedSegmentIndex = listModel.activeSegment
            segmentedControl.setSegmentsWidth(listModel.segmentsWidth)
        }
        
        internal func bindViewModel(_ viewModel: Any) {
            guard let viewModel = viewModel as? Setting.SegmentedControlModel else { return }
            configure(withListModel: viewModel)
        }
        
        @objc public func segmentDidChange(_ sender: UISegmentedControl) {
            delegate?.segmentedControlDidchange(toNewIndex: segmentedControl.selectedSegmentIndex)
        }
        // ====================
        
        
    }
}

