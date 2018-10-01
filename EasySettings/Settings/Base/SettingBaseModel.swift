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
    
    /// The base model for every settings model.
    open class BaseModel: NSObject, ListDiffable {
        
        /// Normally, the listAdapter's ViewController will be used as delegate. This can override that.
        /// Keep in mind: If the delegateOverride doesn't conform to the correct protocol, a delegate cannot be set.
        public weak var delegateOverride: AnyObject?
        
        /// The default swipe items. Have to be manually used inside the setting's cell.
        open var swipeItems: [SwipeCell.Item] = []
        
        /// The default width of the swipe area. Have to be manually used inside the setting's cell.
        open var swipeWidth: CGFloat = 120
        
        /// The section controller for the model. Every subclass must override this property!
        open var sectionController: ListSectionController {
            fatalError("You need to override this")
        }
        
        /// Calculates the total height of the setting, according to height, headerHeight and insets.
        public var heightSum: CGFloat {
            var size: CGFloat = height + inset.top + inset.bottom
            size += headerTitle != "" ? headerHeight : 0
            return size
        }
        
        
        /// The identifier of the setting.
        public let id: String
        
        public var relativeWidth: CGFloat = 1.0
        
        /// The height of the setting cell.
        public var height: CGFloat = 40
        
        /// The inset used for the section that is displaying the setting.
        public var inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        
        /// The title of the header of the setting. If empty, no header will be displayed.
        public var headerTitle: String = ""
        
        /// The height of the header if it is being displayed.
        public var headerHeight: CGFloat = 40
        
        /// Public initializer.
        ///
        /// - Parameter id: The is of the setting
        public init(_ id: String) {
            self.id = id
        }
        
        public func diffIdentifier() -> NSObjectProtocol {
            return id as NSObjectProtocol
        }
        
        public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.BaseModel else { return false }
            
            return self.id == object.id && self.height == object.height && self.inset == object.inset && self.headerTitle == object.headerTitle
        }
        
    }
}
