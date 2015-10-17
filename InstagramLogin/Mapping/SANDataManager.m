//
//  SANDataManager.m
//  InstagramLogin
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANDataManager.h"
#import "SANServerManager.h"
#import "SANTagObject.h"
#import <CoreData/CoreData.h>
#import "SANDataSource.h"

typedef void(^SANMappingBlock)(NSArray *tagArray, NSString *nextPage);

@interface SANDataManager()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation SANDataManager

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super init];
    if (self) {
        self.managedObjectContext = context;
    }
    return self;
}

- (void)loadNextPage {
    [self mappingTagDictionary:^(NSArray *tagArray, NSString *nextPage) {
        
    }];
    
}

-(void)mappingTagDictionary:(SANMappingBlock)completionBlock {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *url = [userDefaults objectForKey:@"nextPageUrl"];
    
    SANServerManager *manager = [[SANServerManager alloc] init];
    
    __weak SANDataManager *weakManager = self;
    
    [manager loadTagsFromServerWithPageUrl:url
                            TagsDictionary:^(NSDictionary *tags) {
                                NSLog(@"TAGS %@", tags);
         NSArray *dataArray = [tags objectForKey:@"data"];
         
         for (int i = 0; i < [dataArray count]; i++) {
             NSDictionary *dict = dataArray[i];
             NSDictionary *captionDictionary = [dict objectForKey:@"caption"];
             NSString *text = [captionDictionary objectForKey:@"text"];
             
             NSDictionary *imageDictionary = [dict objectForKey:@"images"];
             NSDictionary *thumbnailDict = [imageDictionary objectForKey:@"thumbnail"];
             NSString *imagePath = [thumbnailDict objectForKey:@"url"];
             
             NSString *modelId = [captionDictionary objectForKey:@"id"];
             
             NSDictionary *dictionaty = @{
                                          @"text"      : text,
                                          @"imagePath" : imagePath,
                                          @"modelId"   : modelId
                                          };
             
             [tempArray addObject:dictionaty];
         }
         
         NSDictionary *dict = [tags objectForKey:@"pagination"];
         NSString *nextPageUrl = [dict objectForKey:@"next_url"];
         
        for (int i = 0; i < [dataArray count]; i++) {
            [weakManager addModelWithImagePath:[dataArray[i] objectForKey:@"imagePath"]
                                          name:[dataArray[i] objectForKey:@"text"]
                                       modelId:[dataArray[i] objectForKey:@"modelId"]];
        }
           NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
           [userDefaults setObject:nextPageUrl forKey:@"nextPageUrl"];
           [userDefaults synchronize];

    
                                
                                SANDataSource *d = [SANDataSource new];
                                [d modelCount];
         completionBlock(tempArray, nextPageUrl);
        
     } onFailure:^(NSError *error, NSInteger statusCode) {
         completionBlock(nil, nil);
     }];
}

- (void)addModelWithImagePath:(NSString *)imagePath name:(NSString *)name modelId:(NSString *)modelId {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"SANTagObject"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(modelId = %@)", modelId];
    [request setPredicate:predicate];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    if ([resultArray count] > 0) {
        SANTagObject *model = resultArray[0];
        model.text = name;
        model.imagePath = imagePath;
        model.date = [NSDate date];
        [model.managedObjectContext save:nil];
    } else {
       
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"SANTagObject"
                                                                          inManagedObjectContext:self.managedObjectContext];
        
        [newManagedObject setValue:imagePath forKey:@"imagePath"];
        [newManagedObject setValue:name forKey:@"text"];
        [newManagedObject setValue:modelId forKey:@"modelId"];
        [newManagedObject setValue:[NSDate date] forKey:@"date"];
        NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        // Save the context.
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
