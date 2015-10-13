//
//  SANDataManager.m
//  InstagramLogin
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANDataManager.h"
#import "SANServerManager.h"

@implementation SANDataManager

- (void)mappingTagDictionary:(void(^)(NSArray *tagArray, NSString *nextPageUrl))completionBlock {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    SANServerManager *manager = [[SANServerManager alloc] init];
    
    [manager getTagsDictionary:^(NSDictionary *tags) {
   
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
        
        completionBlock(tempArray, nextPageUrl);

    } onFailure:^(NSError *error, NSInteger statusCode) {
        completionBlock(nil, nil);
    }];
}

@end
