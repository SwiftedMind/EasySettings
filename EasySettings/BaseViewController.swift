//
//  BaseViewController.swift
//  EasySettings
//
//  Created by Dennis Müller on 30.09.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit
import CoreData

class BaseViewController: UIViewController {

    // MARK: - @IBOutlets
    // ========== IBOUTLETS ==========
    
    // ====================
    
    
    // MARK: - Properties
    // ========== PROPERTIES ==========
    public var persistentContainer: NSPersistentContainer!
    public var mainViewContext: NSManagedObjectContext!
    // ====================
    
    // MARK: - Initializers
    // ========== INITIALIZERS ==========
    convenience init(persistentContainer: NSPersistentContainer, mainViewContext: NSManagedObjectContext) {
        self.init()
        self.persistentContainer = persistentContainer
        self.mainViewContext = mainViewContext
    }
    // ====================
    
    // MARK: - Overrides
    // ========== OVERRIDES ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // ====================
    
    
    // MARK: - Functions
    // ========== FUNCTIONS ==========
    
    // ====================

}
