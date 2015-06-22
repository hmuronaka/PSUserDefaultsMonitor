//
//  ViewController.swift
//  PSUserDefaultsMonitor
//
//  Created by MuronakaHiroaki on 2015/06/11.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var context = TestManagedObjectContext()
    var dictionary = [String:AnyObject]()
    
    var point = (3, 5)
    var point2 = CGPointMake(10, 29)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Person.truncateAll(self.context.managedObjectContext)
        Address.truncateAll(self.context.managedObjectContext)
        
        dictionary["TEST"] = ["A":"1", "B":2,"C":[1,2,3], "D": ["AA":123]]
        dictionary["TEST-Cyclic"] = ["Child":dictionary]
        
        NSUserDefaults.standardUserDefaults().setObject(dictionary, forKey: "TEST")
        
        PSUserDefaultsMonitor.defaultMonitor.setObject(self, key:"ViewController")
        PSUserDefaultsMonitor.defaultMonitor.setObject(dictionary, key:"Test")
        PSUserDefaultsMonitor.defaultMonitor.managedObjectContext = self.context.managedObjectContext
        
        
        var address = Address.create(context.managedObjectContext) as! Address
        address.address = "A"
        
        var address2 = Address.create(context.managedObjectContext) as! Address
        address2.address = "B"
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        var p1 = Person.create(context.managedObjectContext) as! Person
        p1.name = "n1"
        p1.address = address
        
        var p2 = Person.create(context.managedObjectContext) as! Person
        p2.name = "n2"
        p2.address = address
        
        var p3 = Person.create(context.managedObjectContext) as! Person
        p3.name = "n3"
        p3.address = address2
        
        

        self.context.managedObjectContext?.save(nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

