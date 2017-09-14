//
//  V2PutIOClient.h
//  Puttio
//
//  Created by orta therox on 24/03/2012.
//  Copyright (c) 2012 ortatherox.com. All rights reserved.
//

#import "PutioKit.h"
#import "AFNetworking.h"

// The v2 API uses is an AFHTTPClient, which does all networking and JSON parsing
// presenting PKObject subclasses as arguments to onComplete blocks.

// For networking issues we just pass on the AFNetworking NSErrors, they're more
// detailed and there's no point re-inventing the wheel.

NS_ASSUME_NONNULL_BEGIN

@interface V2PutIOAPIClient : AFHTTPClient

+ (id)setup;
- (BOOL)ready;

@property NSString *apiToken;

- (void)getAccount:(void(^)(PKAccount *account))onComplete failure:(void (^)(NSError *))failure;

- (void)getFolderItems:(PKFolder *)folder :(void(^)(NSArray *filesAndFolders))onComplete failure:(void (^)(NSError *_Nullable error))failure;
- (void)getAdditionalInfoForFile:(PKFile *)file :(void(^)())onComplete failure:(void (^)(NSError *_Nullable error))failure;
- (void)getMP4InfoForFile:(PKFile *)file :(void(^)(PKMP4Status *status))onComplete failure:(void (^)(NSError *_Nullable error))failure;

- (void)getTransfers:(void(^)(NSArray *transfers))onComplete failure:(void (^)(NSError * _Nullable error))failure;
- (void)cancelTransfer:(PKTransfer *)transfer :(void(^)())onComplete failure:(void (^)(NSError *_Nullable error))failure;
- (void)cleanFinishedTransfersCallback:(void (^)(id))onComplete networkFailure:(void (^)(NSError * _Nullable error))failure;

- (void)requestDeletionForDisplayItem:(NSObject <PKFolderItem> *)item :(void(^)(id userInfoObject))onComplete failure:(void (^)(NSError *_Nullable error))failure;

- (void)requestMP4ForFile:(PKFile *)file :(void(^)(PKMP4Status *status))onComplete failure:(void (^)(NSError *_Nullable error))failure;

- (void)requestTorrentOrMagnetURL:(NSURL *)URL
                         toFolder:(PKFolder *)folder
                         callback:(void(^)(id userInfoObject))onComplete
                       addFailure:(void (^)())onAddFailure
                   networkFailure:(void (^)(NSError *_Nullable error))failure;

- (void)uploadFile:(NSString *)path
          toFolder:(PKFolder *)folder
          callback:(void(^)(id userInfoObject))onComplete
        addFailure:(void (^)())onAddFailure
    networkFailure:(void (^)(NSError *_Nullable error))failure;
@end

NS_ASSUME_NONNULL_END
