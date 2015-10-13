//
//  SANPageObject.h
//  InstagramLogin
//
//  Created by Admin on 12.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SANPageObject : NSManagedObject

@property (nonatomic, retain) NSString * nextPageUrl;

@end
