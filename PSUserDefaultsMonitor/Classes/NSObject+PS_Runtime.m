//
//  NSObject+PS_Runtime.m
//
//
//  Created by Muronaka Hiroaki on 2015/06/14.
//
//

#import "NSObject+PS_Runtime.h"
#import <CoreData/CoreData.h>

#import "objc/runtime.h"

NSDictionary* PS_dictionaryFromProperties(NSObject* obj) {
    
    NSMutableDictionary* result = [NSMutableDictionary new];
    
    Class targetClass = obj.class;
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(targetClass, &propertyCount);
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        char *propertyType = property_copyAttributeValue(property, "T");
        NSString* propertyTypeName = [NSString stringWithFormat:@"%s", propertyType];
        NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
        char *iVar = property_copyAttributeValue(property, "V");
        NSString *iVarName = nil;
        
        if( !iVar ) {
            iVarName = propertyName;
        }
        
        NSLog(@"iVarName=%@, name=%@, type=%@", iVarName, propertyName, propertyTypeName);
//        if( iVar ) {
//            switch (propertyType[0]) {
//                case 'i': // int
//                case 's': // short
//                case 'l': // long
//                case 'q': // long long
//                case 'I': // unsigned int
//                case 'S': // unsigned short
//                case 'L': // unsigned long
//                case 'Q': // unsigned long long
//                case 'f': // float
//                case 'd': // double
//                case 'B': // BOOL
//                    NSLog(@"value=%@, name=%@, type=%@", [self valueForKey:iVarName], propertyName, propertyTypeName);
//                    //                [aCoder encodeInteger:[[self valueForKey:iVarName] intValue] forKey:propertyName];
//                    break;
//                default:
//                    NSLog(@"object=%@, name=%@ type=%@", [self valueForKey:iVarName], propertyName, propertyTypeName);
//                    //                [aCoder encodeObject:[self valueForKey:iVarName] forKey:propertyName];
//            }
        
        if( [obj respondsToSelector:NSSelectorFromString(iVarName)] ) {
            @try {
                if( [obj valueForKey:iVarName] == nil ) {
                    result[propertyName] = [NSNull null];
                } else {
                    id value = [obj valueForKey:iVarName];
                    if( [value isKindOfClass:[NSObject class]] ) {
                        result[propertyName] = value;
                    } else {
                        result[propertyName] = [NSString stringWithFormat:@"%@", value];
                    }
                }
            } @catch(NSException* e) {
                result[propertyName] = [NSNull null];
            }
        } else {
            result[propertyName] = [NSNull null];
        }
        free(iVar);
        free (propertyType);
    }
    free(properties);
    
    return result;
}
