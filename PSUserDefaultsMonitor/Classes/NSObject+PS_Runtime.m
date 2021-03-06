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
    
    if( [obj isKindOfClass:[NSNull class]]) {
        return result;
    }
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(targetClass, &propertyCount);
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        char *propertyType = property_copyAttributeValue(property, "T");
        NSString* propertyTypeName = [NSString stringWithFormat:@"%s", propertyType];
        free (propertyType);
        NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
        char *iVar = property_copyAttributeValue(property, "V");
        NSString *iVarName = [NSString stringWithFormat:@"%s", iVar];
        free(iVar);
        
        if( !iVar ) {
            iVarName = propertyName;
        }
        
//        NSLog(@"cls:%@ iVarName=%@, name=%@, type=%@", targetClass, iVarName, propertyName, propertyTypeName);
        
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
    }
    free(properties);
    
    return result;
}
