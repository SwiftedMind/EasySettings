//
//  SettingSingleImageCell.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 18.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

internal protocol SettingSingleImageCellDelegate: class {
    func settingSingleImageDidTapOnImageView()
}

extension Setting {
    internal class SingleImageCell: SwipeCell, ListBindable {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        internal weak var delegate: SettingSingleImageCellDelegate?
        private var listModel: Setting.SingleImageModel?
        
        // swipe action buttons
        override open var swipeCellItems: [SwipeCell.Item] {
            return []
        }
        
        private lazy var label: UILabel = {
            let label = UILabel()
            label.font = SettingsPage.Style.defaultFont.withSize(15)
            label.textColor = UIColor(hex: 0xeeeeee)
            label.text = "Tap to add image"
            label.textAlignment = .center
            
            holderView.addSubview(label)
            return label
        }()
        
        private lazy var imageView: UIImageView = {
            let imageView = UIImageView(image: nil)
            imageView.contentMode = .scaleAspectFit
            
            holderView.addSubview(imageView)
            return imageView
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override internal init(frame: CGRect) {
            super.init(frame: frame)
            holderView.backgroundColor = UIColor(hex: 0x444444)
            swipeEnabled = false
            
            label.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            }
            
            imageView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            imageView.addGestureRecognizer(tap)
            
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
        @objc private func handleTap(_ tap: UITapGestureRecognizer) {
            
        }
        
        internal func configure(withListModel listModel: Setting.SingleImageModel) {
            self.listModel = listModel
        }
        
        internal func bindViewModel(_ viewModel: Any) {
            guard let viewModel = viewModel as? Setting.SingleImageModel else { return }
            configure(withListModel: viewModel)
        }
        // ====================
        
        
    }
}

