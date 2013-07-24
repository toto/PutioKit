//
//  PKTransfer.m
//  PutioKit
//
//  Copyright (c) 2012 Ahmet AYGÜN
//


#import "PKTransfer.h"
#import "PKFile.h"
#import "NSString+DisplayName.h"

@implementation PKTransfer

- (void)updateObjectWithDictionary:(NSDictionary *)dictionary;
{
    [super updateObjectWithDictionary:dictionary];
    
    self.identifier = [NSString stringWithFormat:@"%@", dictionary[@"id"]];
    self.saveParentID = @([dictionary[@"save_parent_id"] intValue]);
    self.fileID = dictionary[@"file_id"];
    
    NSString *statusType = dictionary[@"status"];
    
    if ([statusType isEqualToString:@"ERROR"]) {
        self.transferStatus = PKTransferStatusError;
    }
    else if ([statusType isEqualToString:@"DOWNLOADING"]) {
        self.transferStatus = PKTransferStatusDownloading;
    }
    else if ([statusType isEqualToString:@"SEEDING"]) {
        self.transferStatus = PKTransferStatusSeeding;
    }
    else if ([statusType isEqualToString:@"COMPLETED"]) {
        self.transferStatus = PKTransferStatusCompleted;
    }
    else if ([statusType isEqualToString:@"IN_QUEUE"]) {
        self.transferStatus = PKTransferStatusQueued;
    }
    else {
        NSAssert(NO, @"Unknown status: %@", statusType);
        self.transferStatus = PKTransferStatusUnknown;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@): %@ - %@", NSStringFromClass([self class]), self.identifier, self.name, self.statusMessage];
}

- (NSString *)displayName {
    return [_name displayNameString];
}

@end
