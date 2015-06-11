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
        
        let url = request.URL
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let dictionary = userDefaults.dictionaryRepresentation() as NSDictionary
        
        var jsonDictionary:NSObject!
        
        if let dict = dictionary.PS_valueForDictionaryPath(url.path!, separator: "/") as? NSObject {
            jsonDictionary = dict
        } else {
            jsonDictionary = [NSObject:AnyObject]()
        }
        
        return GCDWebServerDataResponse(JSONObject: jsonDictionary.PS_toJsonObject())
    }
    
}
