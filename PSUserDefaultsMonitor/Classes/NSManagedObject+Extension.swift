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
    
    internal class func all(tableName  tableName: String, managedObjectContext:NSManagedObjectContext?) -> [AnyObject]? {
        
        if managedObjectContext == nil {
            return nil
        }
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName(tableName, inManagedObjectContext: managedObjectContext!)
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = []
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
        } catch _ {
        }
        
        return fetchedResultController.fetchedObjects
    }
    
    internal static func all(managedObjectContext:NSManagedObjectContext?) -> [AnyObject]? {
        return all(tableName:className(), managedObjectContext: managedObjectContext)
    }
    
    internal static func className() -> String {
        return className(self)
    }
    
    internal static func className(cls:AnyClass!) -> String {
        let result = NSStringFromClass(cls)
        if let className = result.removeMatchedString(pattern: "^.*\\.") {
            return className
        } else {
            return result
        }
    }
    
    internal static func create(managedObjectContext:NSManagedObjectContext?) -> NSManagedObject! {
        let result = NSEntityDescription.insertNewObjectForEntityForName(className(),
            inManagedObjectContext: managedObjectContext!) 
        
        return result
    }
    
    internal static func create(cls:AnyClass!, managedObjectContext:NSManagedObjectContext?) -> NSManagedObject! {
        
        let result = NSEntityDescription.insertNewObjectForEntityForName(className(cls),
            inManagedObjectContext: managedObjectContext!) 
        
        return result
    }
    
    internal static func truncateAll(tableName:String, managedObjectContext:NSManagedObjectContext?) {
        
        let objs = NSManagedObject.all(tableName: tableName, managedObjectContext:managedObjectContext)
        
        if let allObjs = objs as? [NSManagedObject] {
            for managedObj:NSManagedObject in allObjs {
                managedObj.deleteObject(managedObjectContext)
            }
        }
    }
    
    internal static func truncateAll(managedObjectContext:NSManagedObjectContext?) {
        
        self.truncateAll(className(), managedObjectContext: managedObjectContext)
        
    }
    
    internal func deleteObject(managedObjectContext:NSManagedObjectContext?) {
        
        if let myObj = try! managedObjectContext?.existingObjectWithID(self.objectID) {
            managedObjectContext?.deleteObject(myObj)
        }
    }
    
    
}