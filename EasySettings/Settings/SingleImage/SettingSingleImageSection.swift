//
//  SettingSingleImageSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 18.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSingleImageSectionDelegate: class {
    func settingSingleImageDidRequestImageChange(_ setting: Setting.SingleImage)
}

extension Setting {
    internal class SingleImageSection: Setting.BaseSection, SettingSingleImageCellDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.SingleImage {
            return model as! Setting.SingleImage
        }
        
        internal weak var delegate: SettingSingleImageSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override internal func cellForItem(at index: Int) -> UICollectionViewCell {
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.SingleImageCell.self, for: self, at: index) as? Setting.SingleImageCell {
                
                cell.configure(withListModel: setting)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
            }
            fatalError()
        }
        
        override internal func didUpdate(to object: Any) {
            super.didUpdate(to: object)
            delegate = (setting.delegateOverride ?? viewController) as? SettingSingleImageSectionDelegate
        }
        
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        internal func settingSingleImageDidTapOnImageView() {
            delegate?.settingSingleImageDidRequestImageChange(setting)
        }
        // ====================
        
        
    }
    
}
