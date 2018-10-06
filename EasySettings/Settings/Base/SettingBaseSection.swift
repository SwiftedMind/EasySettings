//
//  Setting.BaseSection.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import CoreData
import IGListKit
import SwipeCell

public protocol SettingSwipeCellItemsSupport: class {
    func didTap(onItem item: SwipeCell.Item, ofSetting setting: SettingExtension)
}

extension Setting {
    /// Base list section controller. Can be subclassed to avoid most of the boilerplate
    open class BaseSection: ListSectionController, SwipeCellItemDelegate, ListSupplementaryViewSource {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========        
        public weak var itemDelegate: SettingSwipeCellItemsSupport?
        public var model: SettingExtension!
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override public init() {
            super.init()
            //inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
            supplementaryViewSource = self
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override open func sizeForItem(at index: Int) -> CGSize {
            let width = collectionContext!.containerSize.width
            return CGSize(width: width, height: model.height)
        }
        
        override open func didUpdate(to object: Any) {
            guard let object = object as? SettingExtension else { return }
            self.model = object
            inset = object.inset
            itemDelegate = (model.delegateOverride ?? viewController) as? SettingSwipeCellItemsSupport
        }
        
        
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
