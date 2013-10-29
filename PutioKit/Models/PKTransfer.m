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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    self.createdAt = [dateFormatter dateFromString:dictionary[@"created_at"]];
    
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
    else if ([statusType isEqualToString:@"COMPLETING"]) {
        self.transferStatus = PKTransferStatusCompleting;
    }
    else if ([statusType isEqualToString:@"COMPLETED"]) {
        self.transferStatus = PKTransferStatusCompleted;
    }
    else if ([statusType isEqualToString:@"IN_QUEUE"]) {
        self.transferStatus = PKTransferStatusQueued;
    }
    else if ([statusType isEqualToString:@"WAITING"]) {
        self.transferStatus = PKTransferStatusWaiting;
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


#pragma mark NSSecureCoding

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeObject:self.uploaded forKey:@"uploaded"];
    [aCoder encodeObject:self.estimatedTime forKey:@"estimatedTime"];
    [aCoder encodeObject:self.peersGettingFromUs forKey:@"peersGettingFromUs"];
    [aCoder encodeObject:self.extract forKey:@"extract"];
    [aCoder encodeObject:self.currentRatio forKey:@"currentRatio"];
    [aCoder encodeObject:self.size forKey:@"size"];
    [aCoder encodeObject:self.upSpeed forKey:@"upSpeed"];
    [aCoder encodeObject:self.isSeeding forKey:@"isSeeding"];
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.subscriptionID forKey:@"subscriptionID"];
    [aCoder encodeObject:self.statusMessage forKey:@"statusMessage"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.downSpeed forKey:@"downSpeed"];
    [aCoder encodeObject:self.peersConnected forKey:@"peersConnected"];
    [aCoder encodeObject:self.downloaded forKey:@"downloaded"];
    [aCoder encodeObject:self.fileID forKey:@"fileID"];
    [aCoder encodeObject:self.peersSendingToUs forKey:@"peersSendingToUs"];
    [aCoder encodeObject:self.percentDone forKey:@"percentDone"];
    [aCoder encodeObject:self.trackerMessage forKey:@"trackerMessage"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.createdAt forKey:@"createdAt"];
    [aCoder encodeObject:self.errorMessage forKey:@"errorMessage"];
    [aCoder encodeObject:self.saveParentID forKey:@"saveParentID"];
    [aCoder encodeInteger:self.transferStatus forKey:@"transferStatus"];
}

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super init];
    if (self) {
        _uploaded = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"uploaded"];
        _estimatedTime = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"estimatedTime"];
        _peersGettingFromUs = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"peersGettingFromUs"];
        _extract = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"extract"];
        _currentRatio = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"currentRatio"];
        _size = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"size"];
        _upSpeed = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"upSpeed"];
        _isSeeding = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"isSeeding"];
        _identifier = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"identifier"];
        _source = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"source"];
        _subscriptionID = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"subscriptionID"];
        _statusMessage = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"statusMessage"];
        _status = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"status"];
        _downSpeed = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"downSpeed"];
        _peersConnected = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"peersConnected"];
        _downloaded = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"downloaded"];
        _fileID = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"fileID"];
        _peersSendingToUs = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"peersSendingToUs"];
        _percentDone = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"percentDone"];
        _trackerMessage = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"trackerMessage"];
        _name = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _createdAt = [aDecoder decodeObjectOfClass:[NSDate class] forKey:@"createdAt"];
        _errorMessage = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"errorMessage"];
        _saveParentID = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"saveParentID"];
        _transferStatus = [aDecoder decodeIntegerForKey:@"transferStatus"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding;
{
    return YES;
}

@end
