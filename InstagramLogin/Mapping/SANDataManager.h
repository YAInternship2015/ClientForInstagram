//
//  SANDataManager.h
//  InstagramLogin
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSFetchedResultsController;
@class NSManagedObjectContext;

@interface SANDataManager : NSObject

- (instancetype)initWithFetchResultController:(NSFetchedResultsController *)fetchedResultsController
                         managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (void)loadNextPage;

@end
