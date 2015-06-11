//
//  PSUserDefaultsMonitor.swift
//  PSUserDefaultsMonitor
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

public class PSUserDefaultsMonitor : NSObject {
    
    var webServer:GCDWebServer?
    
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
    
    
    private func doGet(request:GCDWebServerRequest) -> GCDWebServerResponse {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let dictionary = userDefaults.dictionaryRepresentation()
        
        let jsonDictionary = jsonDictionaryFromDictionary(dictionary)
        
        return GCDWebServerDataResponse(JSONObject: jsonDictionary)
    }
    
    private func jsonDictionaryFromDictionary(dictionary:[NSObject:AnyObject]) -> [NSObject:AnyObject] {
        
        var result = [NSObject:AnyObject]()
        
        for (key,value) in dictionary {
            
            if value is NSDictionary {
                result[key] = jsonDictionaryFromDictionary(value as! [NSObject:AnyObject])
            } else {
                if NSJSONSerialization.isValidJSONObject(value) {
                    result[key] = value
                } else {
                    result[key] = value.description
                }
            }
            
        }
        
        return result
    }
}
