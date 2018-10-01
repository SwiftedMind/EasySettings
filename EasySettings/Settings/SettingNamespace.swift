//
//  SettingNamespace.swift
//  Comic_Collector
//
//  Created by Dennis Müller on 12.05.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import Foundation
import SwifterSwift

public struct Setting {
    
    public static var defaultFont: UIFont = .systemFont(ofSize: 16)
    public static var defaultMediumFont: UIFont = .systemFont(ofSize: 16)
    public static var defaultBoldFont: UIFont = .boldSystemFont(ofSize: 16)
    
    public static var defaultLightBackground: UIColor = UIColor(hexString: "#eeeeee")!
    public static var defaultIntermediateBackground: UIColor = UIColor(hexString: "#888888")!
    public static var defaultDarkBackground: UIColor = UIColor(hexString: "#222222")!
    
    public static var defaultLightText: UIColor = Setting.defaultLightBackground
    public static var defaultDarkText: UIColor = Setting.defaultDarkBackground
    
    public static var defaultDangerColor: UIColor = UIColor.red
    
}
