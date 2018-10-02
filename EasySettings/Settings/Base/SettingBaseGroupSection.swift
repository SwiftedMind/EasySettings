//
//  SettingGroupSection.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

extension Setting {
    open class BaseGroupSection: ListBindingSectionController<ListDiffable>, ListSupplementaryViewSource, SwipeCellItemDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public weak var itemDelegate: SettingSwipeCellItemsSupport?
        public var model: SettingExtension!
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init() {
            super.init()
            inset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
            minimumLineSpacing = 2
            supplementaryViewSource = self
            itemDelegate = viewController as? SettingSwipeCellItemsSupport
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        public func didTapOnItem(_ item: SwipeCell.Item) {
            itemDelegate?.didTap(onItem: item, ofSetting: model)
        }
        
        public func supportedElementKinds() -> [String] {
            if model.headerTitle == "" {
                return []
            }
            
            return [UICollectionView.elementKindSectionHeader]
        }
        
        public func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
            let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: Setting.HeaderView.self, at: index) as! Setting.HeaderView
            
            view.setTitle(to: model.headerTitle)
            
            return view
        }
        
        public func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
            return CGSize(width: collectionContext!.containerSize.width, height: model.headerHeight)
        }
        // ====================
        
    }
}
