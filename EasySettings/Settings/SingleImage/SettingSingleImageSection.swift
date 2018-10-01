//
//  SettingSingleImageSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 18.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingSingleImageSectionDelegate: class {
    func settingSingleImageDidRequestImageChange(_ setting: Setting.SingleImage)
}

extension Setting {
    class SingleImageSection: Setting.BaseSection, SettingSingleImageCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.SingleImage {
            return model as! Setting.SingleImage
        }
        
        public weak var delegate: SettingSingleImageSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.SingleImageCell.self, for: self, at: index) as? Setting.SingleImageCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingSingleImageSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        func settingSingleImageDidTapOnImageView() {
            delegate?.settingSingleImageDidRequestImageChange(setting)
        }
        // ====================
        
        
    }
    
}
