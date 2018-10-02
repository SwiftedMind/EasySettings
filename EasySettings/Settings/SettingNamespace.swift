//
//  SettingNamespace.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 12.05.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import Foundation
import SwifterSwift
import IGListKit
import SwipeCell

/// The base class that every setting has to conform to.
public protocol SettingExtension: class, ListDiffable {
    
    /// The identifier of the setting.
    var id: String { get set }
    
    /// A delegate override for the setting.
    /// Normally, the listAdapter's ViewController will be used as delegate. This can override that.
    /// Keep in mind: If the delegateOverride doesn't conform to the correct protocol, a delegate cannot be set.
    var delegateOverride: AnyObject? { get set }
    
    /// The swipe items. Have to be manually used inside the setting's cell.
    var swipeItems: [SwipeCell.Item] { get set }
    
    /// The width of the swipe area. Have to be manually used inside the setting's cell.
    var swipeWidth: CGFloat { get set }
    
    /// Calculates the total height of the setting, according to height, headerHeight and insets.
    /// This property has a default implementation that does not need to be changed normally.
    var heightSum: CGFloat { get }
    
    /// The height of the setting cell.
    var height: CGFloat { get set }
    
    /// The inset used for the section that is displaying the setting.
    var inset: UIEdgeInsets { get set }
    
    /// The title of the header of the setting. If empty, no header will be displayed.
    var headerTitle: String { get set }
    
    /// The height of the header if it is being displayed.
    var headerHeight: CGFloat { get set }
    
    /// The section controller that should be responsible for this setting
    var sectionController: ListSectionController { get }
    
    /// Public initializer.
    ///
    /// - Parameter id: The is of the setting
    init(_ id: String)
}

extension SettingExtension {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    public var heightSum: CGFloat {
        var size: CGFloat = height + inset.top + inset.bottom
        size += headerTitle != "" ? headerHeight : 0
        return size
    }
    
}

/// Namespace for all the settings. You can (though you don't have to) extend this when adding your own custom settings.
public struct Setting {}



/// Namespace for the settings pages.
public struct SettingsPage {
    
    public static var statusBarStyle: UIStatusBarStyle = .lightContent
    
    public static var defaultFont: UIFont = .systemFont(ofSize: 16)
    public static var defaultMediumFont: UIFont = .systemFont(ofSize: 16)
    public static var defaultBoldFont: UIFont = .boldSystemFont(ofSize: 16)
    
    public static var defaultLightBackground: UIColor = UIColor(hexString: "#eeeeee")!
    public static var defaultIntermediateBackground: UIColor = UIColor(hexString: "#888888")!
    public static var defaultDarkBackground: UIColor = UIColor(hexString: "#222222")!
    
    public static var defaultHeaderBackgroundColor: UIColor = UIColor(hexString: "#111111")!
    public static var defaultContentBackgroundColor: UIColor = UIColor(hexString: "#222222")!
    
    public static var defaultLightText: UIColor = SettingsPage.defaultLightBackground
    public static var defaultDarkText: UIColor = SettingsPage.defaultDarkBackground
    
    public static var defaultDangerColor: UIColor = UIColor.red
    
}
