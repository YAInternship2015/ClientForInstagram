//
//  SANCollectionViewController.m
//  BestMovies
//
//  Created by Admin on 18.08.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANCollectionViewController.h"
#import "SANDataSource.h"
#import "SANCollectionViewCell.h"

#define MIN_COUNT_CELLS 30

@interface SANCollectionViewController () < UICollectionViewDataSource,
                                            UICollectionViewDelegate,
                                            NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSMutableArray *itemChanges;
@property (nonatomic, strong) SANDataSource *dataSource;

@end

@implementation SANCollectionViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[SANDataSource alloc] initWithDelegate:self];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource modelCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"SANCollectionViewCell";
    SANCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setupWithTag:[self.dataSource modelAtIndexPath:indexPath]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
     if ([self minCellsCount]) {
        if (indexPath.row == ([self.dataSource modelCount] - 1)) {
            [self.dataSource loadTagsFromDataManager];
        }
    }
}

#pragma mark - Actions

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    CGPoint locationPoint = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:locationPoint];
    if (sender.state == UIGestureRecognizerStateBegan && indexPath) {
        [self.dataSource deleteModelAtIndex:indexPath];
    }
}

#pragma mark - Methods

- (BOOL)minCellsCount {
    return [self.dataSource modelCount] >= MIN_COUNT_CELLS;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.itemChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            if ([self minCellsCount]) {
                if (indexPath.row == ([self.dataSource modelCount] - 1)){
                    [self.dataSource loadTagsFromDataManager];
                }
            }
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            break;
    }
    [self.itemChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView performBatchUpdates:^{
        
        for (NSDictionary *change in self.itemChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        break;
                    case NSFetchedResultsChangeMove:
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        self.itemChanges = nil;
    }];
}

@end
