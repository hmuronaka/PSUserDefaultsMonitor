//
//  ViewController.swift
//  PSUserDefaultsMonitor
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dictionary = [String:AnyObject]()
    
    var point = (3, 5)
    var point2 = CGPointMake(10, 29)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dictionary["TEST"] = ["A":"1", "B":2,"C":[1,2,3], "D": ["AA":123]]
        dictionary["TEST-Cyclic"] = ["Child":dictionary]
        
        NSUserDefaults.standardUserDefaults().setObject(dictionary, forKey: "TEST")
        
        PSUserDefaultsMonitor.defaultMonitor.setObject(self, key:"ViewController")
        PSUserDefaultsMonitor.defaultMonitor.setObject(dictionary, key:"Test")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

