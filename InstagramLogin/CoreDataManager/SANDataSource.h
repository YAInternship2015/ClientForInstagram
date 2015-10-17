//
//  SANDataSource.h
//  ClientForInstagram
//
//  Created by Admin on 08.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SANTagObject;

@interface SANDataSource : NSObject

- (void)loadTagsFromDataManager;
- (NSInteger)modelCount;
- (instancetype)initWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (void)deleteModelAtIndex:(NSIndexPath *)index;
- (SANTagObject *)modelAtIndexPath:(NSIndexPath *)indexPath;
- (void)saveContext;

@end

