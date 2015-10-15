//
//  SANServerManager.h
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning эта штука должна превратиться в API клиент, который отправляет запросы в сеть и прокидывает результаты в success и failure блоки. Никакого UI в этом классе не должно быть.

@interface SANServerManager : NSObject

#warning определение блоков надо перенести в typedef
- (void)getTagsDictionary:(void(^)(NSDictionary *tags))tagsBlock
                onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;
@end

