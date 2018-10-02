//
//  SettingsController.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 13.04.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import CoreData
import SwifterSwift

extension SettingsPage {
    open class Controller: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
        
        // MARK: - Properties
        // ========== PROPERTIES ==========
        
        /// The default status bar style (light or dark).
        public var statusBarStyle: UIStatusBarStyle = .lightContent
        
        /// The text color of the text inside the header view.
        open var headerTextColor: UIColor = UIColor(hexString: "#eeeeee")!
        
        /// The background color of the content.
        /// This will be set as the backgroundColor of any subclasses of `SettingsPage.BaseClass`.
        /// You can still set the background color there.
        open var contentBackgroundColor: UIColor = UIColor(hexString: "#222222")!
        
        /// The root settings page.
        public private(set) var rootSettingsPage: SettingsPage.BaseClass!
        
        /// The page controller that this class will set up. This property is accessible from within subclasses of `SettingsPage.BaseClass`.
        public var pageController: UINavigationController?
        
        private lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(view)
            return view
        }()
        // ====================
        
        // MARK: - Initializers
        // ========== INITIALIZERS ==========
        convenience public init(withRootSettingsPage rootSettingsPage: SettingsPage.BaseClass) {
            self.init()
            self.rootSettingsPage = rootSettingsPage
        }
        // ====================
        
        // MARK: - Overrides
        // ========== OVERRIDES ==========
        open override var preferredStatusBarStyle: UIStatusBarStyle {
            return SettingsPage.statusBarStyle
        }
        
        override open func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = rootSettingsPage.headerBackgroundColor // this view will only be visible above the safeAreaLayoutGuides (and below, if visible)
            
            pageController = UINavigationController(rootViewController: rootSettingsPage)
            pageController?.delegate = self
            pageController?.interactivePopGestureRecognizer?.delegate = self
            pageController?.interactivePopGestureRecognizer?.isEnabled = true
            addChild(pageController!)
            pageController?.didMove(toParent: self)
            
            contentView.addSubview(pageController!.view)
            
            pageController?.view.backgroundColor = contentBackgroundColor
            pageController?.view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            contentView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview()
                make.top.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
        override open var prefersStatusBarHidden: Bool {
            return false
        }
        // ====================
        
        
        // MARK: - Functions
        // ========== FUNCTIONS ==========
        
        public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        // ====================
        
    }

}
