//
//  SANDataManager.h
//  InstagramLogin
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SANDataManager : NSObject

- (void)mappingTagDictionary:(void(^)(NSArray *tagArray))array;

@end
