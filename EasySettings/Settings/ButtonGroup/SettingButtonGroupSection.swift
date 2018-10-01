//
//  SettingButtonGroupSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

public protocol SettingButtonGroupSectionDelegate: class {
    func settingButtonGroup(didTapButton setting: Setting.Button)
}

extension Setting {
    internal class ButtonGroupSection: Setting.BaseGroupSection, SettingButtonCellDelegate, ListBindingSectionControllerSelectionDelegate, ListBindingSectionControllerDataSource {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.ButtonGroup {
            return model as! Setting.ButtonGroup
        }
        
        private weak var delegate: SettingButtonGroupSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init() {
            super.init()
            selectionDelegate = self
            dataSource = self
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        internal func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
            guard let setting = object as? Setting.ButtonGroupModel else { return [] }
            
            self.model = setting
            delegate = viewController as? SettingButtonGroupSectionDelegate
            
            return setting.items
        }
        
        internal func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
            guard let settingItem = viewModel as? Setting.Button else { fatalError() }
            
            let width = collectionContext!.containerSize.width
            return CGSize(width: width, height: settingItem.height)
        }
        
        internal func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
            
        }
        
        internal func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didDeselectItemAt index: Int, viewModel: Any) {
            
        }
        
        internal func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
            guard let settingItem = viewModel as? Setting.Button else { fatalError() }
            
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.ButtonCell.self, for: self, at: index) as? Setting.ButtonCell {
                
                cell.configure(withListModel: settingItem)
                cell.delegate = self
                cell.itemDelegate = self
                
                // used to determine the index of the cell when one was selected
                cell.groupIndex = index
                
                return cell
            }
            fatalError()
        }
        
        internal func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didHighlightItemAt index: Int, viewModel: Any) {}
        
        internal func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didUnhighlightItemAt index: Int, viewModel: Any) {}
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        override internal  func didSelectItem(at index: Int) {
            delegate?.settingButtonGroup(didTapButton: setting.items[index])
        }
        // ====================
        
        
    }
    
}
