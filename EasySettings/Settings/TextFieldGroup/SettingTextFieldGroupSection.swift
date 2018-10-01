//
//  SettingTextFieldGroupSection.swift
//  Avalon2Tests
//
//  Created by Dennis Müller on 17.09.18.
//  Copyright © 2017 Quantm. All rights reserved.
//

import UIKit
import IGListKit

protocol SettingTextFieldGroupSectionDelegate: class {
    func settingTextFieldGroup(_ setting: Setting.TextField, didChangeToNewText text: String)
}

extension Setting {
    class TextFieldGroupSection: Setting.BaseGroupSection, SettingTextFieldCellDelegate, ListBindingSectionControllerSelectionDelegate, ListBindingSectionControllerDataSource {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        private var setting: Setting.TextFieldGroup {
            return model as! Setting.TextFieldGroup
        }
        
        public weak var delegate: SettingTextFieldGroupSectionDelegate?
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        override init() {
            super.init()
            selectionDelegate = self
            dataSource = self
            minimumLineSpacing = 2
            minimumInteritemSpacing = 4
            
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
            guard let setting = object as? Setting.TextFieldGroupModel else { return [] }
            
            self.model = setting
            delegate = (setting.delegateOverride ?? viewController) as? SettingTextFieldGroupSectionDelegate
            
            return setting.items
        }
        
        func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
            let itemCount = CGFloat(setting.items.count)
            
            assert(setting.relativeTextFieldWidths.count.cgFloat == itemCount, "Relative widths have to be set for each textField.")
            assert(setting.relativeTextFieldWidths.sum() == 1, "Relative widths have to sum up to 1")
            
            let widthFactor: CGFloat = setting.relativeTextFieldWidths[index]
            
            let width = (collectionContext!.containerSize.width - (itemCount - 1) * minimumInteritemSpacing) * widthFactor
            return CGSize(width: width, height: setting.height)
        }
        
        func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
            
        }
        
        func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didDeselectItemAt index: Int, viewModel: Any) {
            
        }
        
        func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
            guard let settingItem = viewModel as? TextField else { fatalError() }
            
            if let cell = collectionContext!.dequeueReusableCell(of: Setting.TextFieldCell.self, for: self, at: index) as? Setting.TextFieldCell {
                
                cell.itemIndex = index
                cell.configure(withListModel: settingItem)
                cell.delegate = self
                cell.itemDelegate = self
                
                return cell
                
            }
            fatalError()
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didHighlightItemAt index: Int, viewModel: Any) {
            
        }
        
        func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didUnhighlightItemAt index: Int, viewModel: Any) {
            
        }
        
        func settingTextFieldDidBecomeFirstResponder(inCell cell: Setting.TextFieldCell) {
            
        }
        
        func settingTextField(_ textField: UITextField, didChangeToNewText text: String, inCell cell: Setting.TextFieldCell) {
            delegate?.settingTextFieldGroup(setting.items[cell.itemIndex], didChangeToNewText: text)
        }
        // ====================
        
        
    }
    
}
