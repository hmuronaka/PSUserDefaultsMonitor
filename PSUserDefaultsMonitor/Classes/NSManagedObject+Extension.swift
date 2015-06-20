//
//  NSManagedObject+Extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/21.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    internal static func all(# tableName: String, managedObjectContext:NSManagedObjectContext?) -> [AnyObject]? {
        
        if managedObjectContext == nil {
            return nil
        }
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName(tableName, inManagedObjectContext: managedObjectContext!)
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = []
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.performFetch(nil)
        
        return fetchedResultController.fetchedObjects
    }
    
    internal static func all(managedObjectContext:NSManagedObjectContext?) -> [AnyObject]? {
        return all(tableName:NSStringFromClass(self), managedObjectContext: managedObjectContext)
    }
    
}