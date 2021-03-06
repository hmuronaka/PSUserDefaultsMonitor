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
    
    // NOTE:
    // Should I use dictionary for saving managedObjectContexts or getters of managedObjectContexts?
    // Shoudl I use `weak`?
    public var managedObjectContext:NSManagedObjectContext?
    
    private override init() {
        super.init()
    }
    
    // MARK: -
    // MARK: monitoring
    
    public func startMonitor(port port:UInt) {
        
        if( webServer != nil ) {
            print("server is already run!")
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
    
    public func removeObject(key key:NSObject) {
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
                dictionary = NSUserDefaults.standardUserDefaults().dictionaryRepresentation() as NSDictionary
            } else if urlPath.hasPrefix(PSUserDefaultsMonitor.OBJECTS) {
                prefix = PSUserDefaultsMonitor.OBJECTS
                dictionary = self.objectMap
            } else if urlPath.hasPrefix(PSUserDefaultsMonitor.COREDATAS) {
                prefix = PSUserDefaultsMonitor.COREDATAS
                let match = urlPath.match("\(prefix)/([^/]+)")
                if let tableName = match[1] {
                    dictionary = self.dictionaryFromCoreData(tableName)
                }
            }
        }
        
        var jsonDictionary:NSObject! = [NSObject:AnyObject]()
        if dictionary != nil {
            let path = url.path!.substringSafety(fromIndex: prefix.utf16.count)
            if let dict = dictionary.PS_valueForDictionaryPath(path, separator: "/") as? NSObject {
                jsonDictionary = dict
            }
        }
        return GCDWebServerDataResponse(JSONObject: jsonDictionary.PS_toJsonObject())
    }
    
    private func dictionaryFromCoreData(tableName:String) -> NSDictionary! {
        
        if let objs = NSManagedObject.all(tableName: tableName, managedObjectContext: self.managedObjectContext) {
            return [tableName: objs]
        } else {
            return [tableName: "error"]
        }
    }
    
}
