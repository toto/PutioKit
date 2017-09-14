//
//  PKMP4Status.h
//  PutioKit
//
//  Created by orta therox on 03/11/2012.
//  Copyright (c) 2012 PutIOKit. All rights reserved.
//

#import "PKObject.h"

typedef NS_ENUM(NSInteger, PKMP4StatusType) {
    PKMP4StatusCompleted,
    PKMP4StatusConverting,
    PKMP4StatusQueued,
    PKMP4StatusNotAvailable,
    PKMP4StatusUnknown
};

NS_ASSUME_NONNULL_BEGIN

@interface PKMP4Status : PKObject

/** Status of MP4. */
@property (assign, nonatomic) PKMP4StatusType mp4Status;

/** Progress is status is currently converting. */
@property (strong, nonatomic) NSNumber *progress;

@end

NS_ASSUME_NONNULL_END
