//
//  SANDataManager.h
//  InstagramLogin
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface SANDataManager : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (void)loadNextPage;

@end
