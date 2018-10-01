//
//  SettingsPageCoreDataSupport.swift
//  EasySettings
//
//  Created by Dennis Müller on 30.09.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import CoreData

internal protocol SettingsPageCoreDataSupport {
    var persistentContainer: NSPersistentContainer! { get set }
    var mainViewContext: NSManagedObjectContext! { get set }
}
