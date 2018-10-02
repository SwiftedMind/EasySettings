//
//  SettingsPage.Style.swift
//  EasySettings
//
//  Created by Dennis Müller on 02.10.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import IGListKit
import CoreData
import SwifterSwift

extension SettingsPage {
    /// The style of the settings pages and settings. Can and should be overridden to customize
    public class Style {
        public static var statusBarStyle: UIStatusBarStyle = .lightContent
        
        public static var defaultFont: UIFont = .systemFont(ofSize: 16)
        public static var defaultMediumFont: UIFont = .systemFont(ofSize: 16)
        public static var defaultBoldFont: UIFont = .boldSystemFont(ofSize: 16)
        
        public static var defaultLightBackground: UIColor = UIColor(hexString: "#eeeeee")!
        public static var defaultIntermediateBackground: UIColor = UIColor(hexString: "#888888")!
        public static var defaultDarkBackground: UIColor = UIColor(hexString: "#222222")!
        
        public static var defaultHeaderBackgroundColor: UIColor = UIColor(hexString: "#111111")!
        
        /// The background color of the content.
        /// This will be set as the backgroundColor of any subclasses of `SettingsPage.BaseClass`.
        /// You can still set the background color there.
        public static var defaultContentBackgroundColor: UIColor = UIColor(hexString: "#222222")!
        
        public static var defaultLightText: UIColor = SettingsPage.Style.defaultLightBackground
        public static var defaultDarkText: UIColor = SettingsPage.Style.defaultDarkBackground
        
        public static var defaultDangerColor: UIColor = UIColor.red
    }
}
