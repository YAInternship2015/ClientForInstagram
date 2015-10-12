//
//  SANTagObject.h
//  InstagramLogin
//
//  Created by Admin on 11.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SANTagObject : NSManagedObject

@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * modelId;

@end
