//
//  SettingSingleImageModel.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 18.05.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingSingleImageConfiguration {
    func configured(_ setting: Setting.SingleImage) -> Setting.SingleImage
}

extension Setting {
    public typealias SingleImage = SingleImageModel
    public class SingleImageModel: Setting.BaseModel {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        public var image: UIImage = UIImage()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        required public init(_ id: String) {
            super.init(id)
            height = 200
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        override public var sectionController: ListSectionController {
            return Setting.SingleImageSection()
        }
        
        override public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            guard let object = object as? Setting.SingleImageModel, super.isEqual(toDiffableObject: object) else { return false }
            return self.image.pngData() == object.image.pngData()
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        // ====================
        
    }
    
}
