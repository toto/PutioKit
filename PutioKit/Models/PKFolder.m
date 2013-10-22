//
//  PKFolder.m
//  PutioKit
//
//  Created by orta therox on 01/11/2012.
//  Copyright (c) 2012 PutIOKit. All rights reserved.
//

#import "PKFolder.h"
#import "PKFile.h"
#import "NSString+DisplayName.h"

@implementation PKFolder

- (NSArray *)orderedItems {
    return [_items.allObjects sortedArrayUsingComparator:^(NSObject <PKFolderItem>* a, NSObject <PKFolderItem>* b) {
        return [a.name localizedStandardCompare:b.name];
    }];
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary; {
    PKFolder *object = [super objectWithDictionary:dictionary];
    if (object) {
        object.screenshot =  dictionary[@"icon"];
        object.parentID = [dictionary[@"parent_id"] stringValue];
        object.displayName = [object.name displayNameString];
        object.id = [(NSNumber *)object.id stringValue];
    }
    return object;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@): %@", NSStringFromClass([self class]), self.id, self.displayName];
}


#pragma mark NSSecureCoding

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeObject:self.screenshot forKey:@"screenshot"];
    [aCoder encodeObject:self.parentID forKey:@"parentID"];
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.size forKey:@"size"];
    [aCoder encodeObject:self.items forKey:@"items"];
    [aCoder encodeObject:self.items forKey:@"id"];    
    [aCoder encodeInteger:self.numberOfParentFolders forKey:@"numberOfParentFolders"];
}

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super init];
    if (self) {
        _id = [aDecoder decodeObjectOfClass:[NSString class]
                                             forKey:@"id"];
        _screenshot = [aDecoder decodeObjectOfClass:[NSString class]
                                             forKey:@"screenshot"];
        _parentID = [aDecoder decodeObjectOfClass:[NSString class]
                                           forKey:@"parentID"];
        _displayName = [aDecoder decodeObjectOfClass:[NSString class]
                                              forKey:@"displayName"];
        _name = [aDecoder decodeObjectOfClass:[NSString class]
                                       forKey:@"name"];
        _size = [aDecoder decodeObjectOfClass:[NSString class]
                                       forKey:@"size"];
        _items = [aDecoder decodeObjectOfClass:[NSArray class]
                                        forKey:@"items"];
        _numberOfParentFolders = [aDecoder decodeIntegerForKey:@"numberOfParentFolders"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding;
{
    return YES;
}


@end
