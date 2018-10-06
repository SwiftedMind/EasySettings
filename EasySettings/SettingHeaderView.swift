//
//  SettingHeaderView.swift
//  EasySettings
//
//  Created by Dennis Müller on 01.10.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import SnapKit

internal protocol SettingHeaderViewDelegate: class {
    func didTap()
}

extension Setting {
    internal class HeaderView: UICollectionReusableView {
        // MARK: - @IBOutlets
        // ========== IBOUTLETS ==========
        
        // ====================
        
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        weak public var delegate: SettingHeaderViewDelegate?
        
        private lazy var tap: UITapGestureRecognizer = {
            return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        }()
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            
            label.font = SettingsPage.Style.defaultFont.withSize(14)
            label.textColor = SettingsPage.Style.defaultDarkText.lighten()
            label.textAlignment = .center
            
            addSubview(label)
            
            return label
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override init(frame: CGRect) {
            super.init(frame: frame)
            alpha = 0.5
            isUserInteractionEnabled = true
            titleLabel.isUserInteractionEnabled = true
            
            backgroundColor = .clear
            
            titleLabel.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        @objc private func handleTap(_ tap: UITapGestureRecognizer) {
            delegate?.didTap()
        }
        
        public func setTitle(to title: String) {
            titleLabel.text = title.uppercased()
        }
        
        public func setEnabled(to enabled: Bool) {
            alpha = enabled ? 1.0 : 0.2
        }
        // ====================
        
    }
    

}
