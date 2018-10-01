//
//  Setting.BaseModel.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCell

extension Setting {
    class BaseModel: NSObject, ListDiffable {
        
        /// Normally, the listAdapter's ViewController will be used as delegate. This can override that.
        /// Keep in mind: If the delegateOverride doesn't conform to the correct protocol, a delegate cannot be set.
        public weak var delegateOverride: AnyObject?
        
        public var swipeActions: [SwipeCell.Item] = []
        public var swipeWidth: CGFloat = 120
        
        var sectionController: ListSectionController {
            fatalError("You need to override this")
        }
        
        var heightSum: CGFloat {
            var size: CGFloat = height + inset.top + inset.bottom
            size += headerTitle != "" ? headerHeight : 0
            return size
        }
        
        let id: String
        var relativeWidth: CGFloat = 1.0
        var height: CGFloat = 40
        public var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        public var headerTitle: String = ""
        public var headerHeight: CGFloat = 40
        
        init(_ id: String) {
            self.id = id
        }
        
        func diffIdentifier() -> NSObjectProtocol {
            return id as NSObjectProtocol
        }
        
        func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.BaseModel else { return false }
            
            return self.id == object.id && self.height == object.height && self.inset == object.inset && self.headerTitle == object.headerTitle
        }
        
    }
}
