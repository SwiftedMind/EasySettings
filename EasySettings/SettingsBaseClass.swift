//
//  SettingsPage.BaseClass.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 14.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit
import CoreData

extension SettingsPage {
    open class BaseClass: UIViewController, UIScrollViewDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========        
        private var _settingsHiddenViewClass: SettingsPage.HiddenViewBaseClass?
        private var settingsHiddenViewClass: SettingsPage.HiddenViewBaseClass {
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
        
        public var settingsController: SettingsPage.Controller {
            return pageController.parent as! SettingsPage.Controller
        }
        
        open var settings: [SettingExtension] {
            return []
        }
        
        public lazy var listViewHolder: UIView = {
            let view = UIView()
            
            self.view.addSubview(view)
            return view
        }()
        
        public lazy var collectionView: UICollectionView = {
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
        
        public lazy var adapter: ListAdapter = {
            return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
        }()
        
        public var hiddenViewFinalHeight: CGFloat {
            return settingsHiddenViewClass.hiddenSettingsHeight
        }
        
        public var hiddenViewSnappedOpen: Bool = false
        private var hiddenViewConstraint: Constraint?
        
        private lazy var hiddenView: UIView = {
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
        override open func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = SettingsPage.Style.defaultContentBackgroundColor
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
            pageController.navigationBar.titleTextAttributes = [.foregroundColor: SettingsPage.Style.defaultHeaderBackgroundColor.darken(by: 0.1).readableTextColor]
            pageController.navigationBar.tintColor = SettingsPage.Style.defaultHeaderBackgroundColor.darken(by: 0.1).readableTextColor
            pageController.navigationBar.barTintColor = SettingsPage.Style.defaultHeaderBackgroundColor.darken(by: 0.1)
            pageController.navigationBar.backgroundColor = SettingsPage.Style.defaultHeaderBackgroundColor
            pageController.navigationBar.barStyle = .black
            
            listViewHolder.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(4)
                
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-4)
                } else {
                    make.top.equalToSuperview().offset(6)
                    make.bottom.equalToSuperview().offset(-4)
                }
                
                make.trailing.equalToSuperview().offset(-4)
            }
            
            collectionView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            hiddenView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview()
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                } else {
                    make.top.equalToSuperview()
                }
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
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        @objc public func closeButtonTapped() {
            settingsController.dismiss(animated: true, completion: nil)
        }
        
        @objc private func objectHasChanged(notif: Notification) {
            guard !self.isBeingDismissed && !pageController.isBeingDismissed else { return }
            adapter.performUpdates(animated: true, completion: nil)
            settingsHiddenViewClass.adapter.performUpdates(animated: true, completion: nil)
        }
        
        @objc public func keyboardWillShow(notification: Notification) {
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
        
        @objc public func keyboardWillHide(notification: Notification) {
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
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
        
        public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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
        
        open func setSettingsHiddenViewClassType() -> SettingsPage.HiddenViewBaseClass {
            return SettingsPage.HiddenViewBaseClass()
        }
        // ====================
        
    }
}

extension SettingsPage.BaseClass: ListAdapterDataSource {
   open func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if listAdapter == adapter {
            return settings
        }
        
        return []
    }
    
   public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let object = object as? SettingExtension else { fatalError() }
        let sectionController = object.sectionController
    
        return sectionController
    }
    
   public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
