//
//  PKObject.h
//  PutioKit
//
//  Created by orta therox on 29/10/2012.
//  Copyright (c) 2012 Ahmet AYGÜN. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PKObject : NSObject

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary;
- (void)updateObjectWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
