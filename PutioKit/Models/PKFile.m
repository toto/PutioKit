//
//  PKFile.m
//  PutioKit
//
//  Copyright (c) 2012 Ahmet AYGÜN
//

#import "PKFolder.h"

#import "PKFile.h"
#import "NSString+DisplayName.h"

@implementation PKFile

static NSArray *ThumbnailFileTypes;
static NSArray *TextFileTypes;
static NSArray *TextFileNames;
static NSArray *AudioFileTypes;
static NSArray *ImageFileTypes;

+ (void)initialize {
    ThumbnailFileTypes = @[@"mp4", @"mov", @"wmv", @"m4v", @"mkv", @"avi", @"jpg", @"png", @"gif"];

    TextFileTypes = @[ @"txt", @"nfo", @"log", @"diz", @"xml"];
    TextFileNames = @[ @"README", @"LICENSE", @"INSTALL", @"CHANGELOG", @"AUTHORS"];
    ImageFileTypes = @[ @"jpg", @"png", @"gif"];
    AudioFileTypes = @[ @"mp3", @"aac", @"wav", @"auf"];
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary {
    PKFile *object = [super objectWithDictionary:dictionary];

    if (object) {
        if (dictionary[@"is_mp4_available"] != [NSNull null]) {
            object.isMP4Available = @( [dictionary[@"is_mp4_available"] boolValue] );
        }

        object.parentID = [(NSNumber *)dictionary[@"parent_id"] stringValue];
        object.id = [(NSNumber *)object.id stringValue];
        object.displayName = [object.name displayNameString];
    }

    return object;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@): %@", NSStringFromClass([self class]), self.id, self.displayName];
}

- (BOOL)isTextualType {
    if ([TextFileTypes containsObject:self.extension]) return YES;
    if ([TextFileNames containsObject:self.name]) return YES;
    return NO;
}

- (BOOL)isAudioType {
    if ([AudioFileTypes containsObject:self.extension]) return YES;
    return NO;
}

- (BOOL)isImageType {
    if ([ImageFileTypes containsObject:self.extension]) return YES;
    return NO;
}

- (NSString *)extension {
    return [[self.name pathExtension] lowercaseString];
}

- (BOOL)hasPreviewThumbnail {
    return [ThumbnailFileTypes containsObject:[self extension]];
}


#pragma mark NSSecureCoding

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeObject:self.isShared forKey:@"isShared"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.screenshot forKey:@"screenshot"];
    [aCoder encodeObject:self.createdAt forKey:@"createdAt"];
    [aCoder encodeObject:self.parentID forKey:@"parentID"];
    [aCoder encodeObject:self.isMP4Available forKey:@"isMP4Available"];
    [aCoder encodeObject:self.contentType forKey:@"contentType"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.size forKey:@"size"];
    [aCoder encodeObject:self.opensubtitlesHash forKey:@"opensubtitlesHash"];
    [aCoder encodeObject:self.folder forKey:@"folder"];
}

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super init];
    if (self) {
        _isShared = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"isShared"];
        _name = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _displayName = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"displayName"];
        _screenshot = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"screenshot"];
        _createdAt = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"createdAt"];
        _parentID = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"parentID"];
        _isMP4Available = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"isMP4Available"];
        _contentType = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"contentType"];
        _icon = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"icon"];
        _id = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"id"];
        _size = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"size"];
        _opensubtitlesHash = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"opensubtitlesHash"];
        _folder = [aDecoder decodeObjectOfClass:[PKFolder class] forKey:@"folder"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding;
{
    return YES;
}

@end
