//
//  PKFriend.h
//  PutioKit
//
//  Copyright (c) 2012 Ahmet AYGÜN
//


#import "PKObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 This class provides a PKObject subclass in type of PKFriend.
 */
@interface PKFriend : PKObject

/**---------------------------------------------------------------------------------------
 * @name Properties
 *  ---------------------------------------------------------------------------------------
 */
/** Username of friend. */
@property (strong, nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
