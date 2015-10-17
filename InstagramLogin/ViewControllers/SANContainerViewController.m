//
//  ContainerViewController.m
//  BestMovies
//
//  Created by Admin on 18.08.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANContainerViewController.h"
#import "SANTableViewController.h"
#import "SANCollectionViewController.h"
//#import "SANLoginViewController.h"

#define ANIMATION_DURATION_IN_SECONDS 0.25

typedef enum {
    tableViewController,
    collectionViewController
} ActiveViewController;

static NSString * const SANTableControllerStoryboardID = @"SANTableViewController";
static NSString * const SANCollectionControllerStoryboardID = @"SANCollectionViewController";

@interface SANContainerViewController ()

@property (nonatomic, assign) ActiveViewController *activeVC;
@property (nonatomic, strong) SANTableViewController *tableVC;
@property (nonatomic, strong) SANCollectionViewController *collectionVC;

@end

@implementation SANContainerViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self authorization];
    
    self.activeVC = tableViewController;
    
    self.tableVC = [self.storyboard instantiateViewControllerWithIdentifier:SANTableControllerStoryboardID];
    [self addChildViewController:self.tableVC];
    [self.view addSubview:self.tableVC.view];
    [self.tableVC didMoveToParentViewController:self];
}

#pragma mark - Actions

- (IBAction)switchAction:(UIBarButtonItem *)sender {
    if (self.activeVC == tableViewController) {
        self.collectionVC = [self.storyboard instantiateViewControllerWithIdentifier:SANCollectionControllerStoryboardID];
        [self swapFromViewController:self.tableVC toViewController:self.collectionVC];
        self.activeVC = collectionViewController;
    }else{
        self.tableVC = [self.storyboard instantiateViewControllerWithIdentifier:SANTableControllerStoryboardID];
        [self swapFromViewController:self.collectionVC toViewController:self.tableVC];
        self.activeVC = tableViewController;
    }
}

#pragma mark - Methods
/*
- (void)authorization {
    SANLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SANLoginViewController"];
    UIViewController *mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    [mainVC presentViewController:loginViewController animated:YES completion:nil];
}
*/
- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    self.navigationController.navigationBar.translucent = NO;

    toViewController.view.frame = self.view.bounds;
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:ANIMATION_DURATION_IN_SECONDS
                               options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    }];
    self.navigationController.navigationBar.translucent = YES;
}

@end