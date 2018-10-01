//
//  SettingsBaseClass.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

class SettingsBaseClass: BaseViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    // ========== PROPERTIES ==========
    private var _settingsHiddenViewClass: SettingsHiddenViewBaseClass?
    private var settingsHiddenViewClass: SettingsHiddenViewBaseClass {
        get {
            if self._settingsHiddenViewClass == nil {
                _settingsHiddenViewClass = setSettingsHiddenViewClassType()
            }
            
            return self._settingsHiddenViewClass!
        }
    }
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    public var pageController: UINavigationController {
        return navigationController!
    }
    
    public var settingsController: SettingsController {
        return pageController.parent as! SettingsController
    }

    public var settings: [Setting.BaseModel] {
        return []
    }
    
    lazy var listViewHolder: UIView = {
        let view = UIView()
        
        self.view.addSubview(view)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: true)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        listViewHolder.addSubview(view)
        adapter.collectionView = view
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        return view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    public var hiddenViewFinalHeight: CGFloat {
        return settingsHiddenViewClass.hiddenSettingsHeight
    }
    
    public var hiddenViewSnappedOpen: Bool = false
    private var hiddenViewConstraint: Constraint?
    
    lazy var hiddenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x333333)
        view.clipsToBounds = true
        view.alpha = 0.0
        
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var hiddenViewIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x0fbcf9)
        
        if hiddenViewFinalHeight == 0 {
             view.alpha = 0.0
        } else {
             view.alpha = 1.0
        }
        
        self.view.addSubview(view)
        return view
    }()
    // ====================
    
    // MARK: - Initializers
    // ========== INITIALIZERS ==========
    
    // ====================
    
    // MARK: - Overrides
    // ========== OVERRIDES ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0x444444)
        
        listViewHolder.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(6) // dont use hiddenViewIndicator.snp.bottom. that breaks the system due to the constraints setup
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
            
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        hiddenView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            self.hiddenViewConstraint = make.height.equalTo(0).constraint
        }
        
        hiddenViewIndicator.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalTo(self.hiddenView.snp.bottom).offset(1)
            make.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        // add hidden view
        addChild(settingsHiddenViewClass)
        settingsHiddenViewClass.didMove(toParent: self)
        hiddenView.addSubview(settingsHiddenViewClass.view)
        
        settingsHiddenViewClass.view.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(self.hiddenViewFinalHeight)
        }
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        listViewHolder.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(objectHasChanged(notif:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: mainViewContext)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // ====================
    
    
    // MARK: - Functions
    // ========== FUNCTIONS ==========
    @objc func objectHasChanged(notif: Notification) {
        guard !self.isBeingDismissed else { return }
        adapter.performUpdates(animated: true, completion: nil)
        settingsHiddenViewClass.adapter.performUpdates(animated: true, completion: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            guard traitCollection.horizontalSizeClass == .compact else { return }
            
            if keyboardFrame.minY <= collectionView.frame.maxY {
                collectionView.snp.updateConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-keyboardFrame.height - 5)
                }
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [UIView.AnimationOptions.curveEaseOut], animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard traitCollection.horizontalSizeClass == .compact else { return }
        
        collectionView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [UIView.AnimationOptions.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func handleTap(tap: UITapGestureRecognizer) {
        self.listViewHolder.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard hiddenViewFinalHeight > 0 else { return }
        if scrollView.contentOffset.y < 0 {
            hiddenViewConstraint?.update(offset: abs(scrollView.contentOffset.y))
        } else {
            hiddenViewConstraint?.update(offset: 0)
        }
        
        hiddenView.alpha = -scrollView.contentOffset.y / hiddenViewFinalHeight
        hiddenViewIndicator.alpha = 1 - -scrollView.contentOffset.y / (hiddenViewFinalHeight * 0.8)
        view.layoutIfNeeded()
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hiddenViewFinalHeight > 0 else { return }
        
        if scrollView.contentOffset.y <= -hiddenViewFinalHeight * 0.6 {
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
                scrollView.contentInset.top = self.hiddenViewFinalHeight
                //scrollView.scrollIndicatorInsets.top = self.hiddenViewFinalHeight
            }, completion: nil)
            hiddenViewSnappedOpen = true
        } else if scrollView.contentOffset.y > -hiddenViewFinalHeight * 0.6 {
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
                scrollView.contentInset.top = 0
                //scrollView.scrollIndicatorInsets.top = 0
            }, completion: nil)
            hiddenViewSnappedOpen = false
        }
    }
    
    public func setSettingsHiddenViewClassType() -> SettingsHiddenViewBaseClass {
        return SettingsHiddenViewBaseClass()
    }
    // ====================
    
}

extension SettingsBaseClass: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if listAdapter == adapter {
            return settings
        }
        
        return []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? Setting.BaseModel else { fatalError() }
        let sectionController = object.sectionController
        
        if let sectionController = sectionController as? Setting.BaseSection {
            sectionController.persistentContainer = self.persistentContainer
            sectionController.managedObjectContext = mainViewContext
        }
        
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
