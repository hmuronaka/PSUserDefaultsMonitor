//
//  Person.h
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/21.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSManagedObject *address;

@end
