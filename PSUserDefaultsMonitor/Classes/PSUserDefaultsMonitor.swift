//
//  PSUserDefaultsMonitor.swift
//  PSUserDefaultsMonitor
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation
import CoreData

public class PSUserDefaultsMonitor : NSObject {
    
    public static let defaultMonitor = PSUserDefaultsMonitor()
    
    // UserDefaults
    private static let USER_DEFAULTS = "/U"
    
    // Objects Map
    private static let OBJECTS = "/O"
    
    // CoreData
    private static let COREDATAS = "/C"
    
    private var webServer:GCDWebServer?
    
    private var objectMap = [NSObject:AnyObject]()
    
    public var managedObjectContext:NSManagedObjectContext?
    
    private override init() {
        super.init()
    }
    
    // MARK: -
    // MARK: monitoring
    
    public func startMonitor(#port:UInt) {
        
        if( webServer != nil ) {
            println("server is already run!")
            return
        }
        
        webServer = GCDWebServer()
        webServer?.addDefaultHandlerForMethod("GET", requestClass: GCDWebServerRequest.self,
            processBlock: { [unowned self] (request:GCDWebServerRequest!) -> GCDWebServerResponse! in
                return self.doGet(request)
        })
        webServer?.startWithPort(port, bonjourName: nil)
    }
    
    
    public func stopMonitor() {
        webServer?.stop()
        webServer = nil
    }
    
    // MARK: -
    // MARK: object map.
    
    public func setObject(object:AnyObject, key:NSObject) {
        self.objectMap[key] = Weak(value: object)
    }
    
    public func removeObject(#key:NSObject) {
        self.objectMap.removeValueForKey(key)
    }
    
    // MARK: -
    // MARK: HTTP Server
    
    private func doGet(request:GCDWebServerRequest) -> GCDWebServerResponse {
        
        let url = request.URL
        var dictionary: NSDictionary!
        var prefix:String!
        
        if let urlPath = url.path {
            
            if urlPath.hasPrefix(PSUserDefaultsMonitor.USER_DEFAULTS) {
                prefix = PSUserDefaultsMonitor.USER_DEFAULTS
                    urlPath.substringFromIndex(advance(urlPath.startIndex, count(PSUserDefaultsMonitor.USER_DEFAULTS.utf16)))
                dictionary = NSUserDefaults.standardUserDefaults().dictionaryRepresentation() as NSDictionary
            } else if urlPath.hasPrefix(PSUserDefaultsMonitor.OBJECTS) {
                prefix = PSUserDefaultsMonitor.OBJECTS
                dictionary = self.objectMap
            } else if urlPath.hasPrefix(PSUserDefaultsMonitor.COREDATAS) {
                prefix = PSUserDefaultsMonitor.COREDATAS
                let tableName = url.path!.substringFromIndex(advance(url.path!.startIndex, count(prefix.utf16) + 1 ))
                dictionary = self.dictionaryFromCoreData(tableName)
            }
            
        }
        
        var jsonDictionary:NSObject! = [NSObject:AnyObject]()
        if dictionary != nil {
            let path = url.path!.substringFromIndex(advance(url.path!.startIndex, count(prefix.utf16)))
            if let dict = dictionary.PS_valueForDictionaryPath(path, separator: "/") as? NSObject {
                jsonDictionary = dict
            }
        }
        return GCDWebServerDataResponse(JSONObject: jsonDictionary.PS_toJsonObject())
    }
    
    private func dictionaryFromCoreData(var tableName:String) -> NSDictionary! {
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName(tableName, inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = []
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.performFetch(nil)
        
        if let objs = fetchedResultController.fetchedObjects {
            return [tableName: objs]
        } else {
            return [tableName: "error"]
        }
    }
    
}
