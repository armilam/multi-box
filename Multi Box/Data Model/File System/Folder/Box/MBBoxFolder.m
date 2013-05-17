//
//  MBBoxFolder.m
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBBoxFolder.h"
#import "MBBoxFile.h"
#import "MBBoxUser.h"
#import "MBBoxFolderItemsResponse.h"
#import "MBBoxFileSystemUserResponse.h"
#import "MBBoxFileResponse.h"
#import "MBBoxFolderResponse.h"
#import "NSString+URLQuery.h"
#import <RestKit/RestKit.h>
#import <RestKit/RKObjectManager.h>

@interface MBBoxFolder()

@property (readwrite) NSString* id;
@property (readwrite) NSString* sequenceId;
@property (readwrite) NSString* etag;
@property (readwrite) NSString* name;
@property (readwrite) NSDate* createdAt;
@property (readwrite) NSDate* modifiedAt;
@property (readwrite) NSString* desc;
@property (readwrite) NSInteger size;
@property (readwrite) NSArray* pathCollection;
@property (readwrite) MBBoxUser* createdBy;
@property (readwrite) MBBoxUser* modifiedBy;
@property (readwrite) MBBoxUser* ownedBy;
@property (readwrite) NSString* sharedLinkUrlString;
@property (readwrite) NSString* folderUploadEmail;
@property (readwrite) MBBoxFolder* parent;
@property (readwrite) BOOL isDeleted;
@property (readwrite) NSArray* children;
@property (readwrite) NSString* syncState;

@property MBBoxUser* user;

@end

@implementation MBBoxFolder

- (MBBoxFolder*)initRootFolderForUser:(MBBoxUser*)user
{
    self = [super initRootFolderForUser:user];
    
    self.id = @"0";
    
    return self;
}

- (void)refreshContents:(void (^)(MBBoxFolder*))returnBlock
{
    //TODO: Expand folder mapping to include more properties
    RKObjectMapping* folderMapping = [RKObjectMapping mappingForClass:[MBBoxFolderResponse class]];
    [folderMapping addAttributeMappingsFromArray:@[@"name", @"id"]];

    NSArray* fileMappingItems = @[
                                 @"name", @"id", @"sequence_id", @"etag", @"description",
                                 @"size", @"created_at", @"modified_at", @"shared_link", @"item_status"
                                 ];
    RKObjectMapping* fileMapping = [RKObjectMapping mappingForClass:[MBBoxFileResponse class]];
    [fileMapping addAttributeMappingsFromArray:fileMappingItems];

    RKObjectMapping* fileUserMapping = [RKObjectMapping mappingForClass:[MBBoxFileSystemUserResponse class]];
    [fileUserMapping addAttributeMappingsFromArray:@[@"type", @"id", @"name", @"login"]];
    [fileMapping addRelationshipMappingWithSourceKeyPath:@"created_by" mapping:fileUserMapping];
    [fileMapping addRelationshipMappingWithSourceKeyPath:@"modified_by" mapping:fileUserMapping];
    [fileMapping addRelationshipMappingWithSourceKeyPath:@"owned_by" mapping:fileUserMapping];

    RKDynamicMapping* dynamicMapping = [RKDynamicMapping new];
    [dynamicMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"type" expectedValue:@"file" objectMapping:fileMapping]];
    [dynamicMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"type" expectedValue:@"folder" objectMapping:folderMapping]];
    
    //TODO: Do something with limit and offset and whatever else comes with the response
    RKObjectMapping* responseMapping = [RKObjectMapping mappingForClass:[MBBoxFolderItemsResponse class]];
    [responseMapping addRelationshipMappingWithSourceKeyPath:@"entries" mapping:dynamicMapping];
    
    NSIndexSet* statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:@"/2.0/folders/:id/items" keyPath:nil statusCodes:statusCodes];

    //TODO: Get more fields to correspond with the expanded folder and file mappings
    NSDictionary* queryItems =
    @{
//      @"limit" : @"1",
//      @"offset" : @"0",
      @"fields" : [fileMappingItems componentsJoinedByString:@","]
    };

    NSString* url = [NSString stringWithFormat:@"https://api.box.com/2.0/folders/%@/items?%@", self.id, [NSString queryStringFromDictionary:queryItems]];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", self.user.accessToken] forHTTPHeaderField:@"Authorization"];
    RKObjectRequestOperation* operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];

    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult* result)
     {
         NSMutableArray* items = [NSMutableArray arrayWithCapacity:[result.array[0] entries].count];
         for(id item in [result.array[0] entries])
         {
             if([item isKindOfClass:[MBBoxFolderResponse class]])
             {
                 [items addObject:[MBBoxFolder folderFromResponse:item withParent:self]];
             }
             else if([item isKindOfClass:[MBBoxFileResponse class]])
             {
                 [items addObject:[MBBoxFile fileFromResponse:item withParent:self]];
             }
         }
         
         self.children = [NSArray arrayWithArray:items];
         
         NSLog(@"Got folder items (%d)", (int)items.count);
         
         if(returnBlock) returnBlock(self);
     }
                                     failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         NSLog(@"Failed with error: %@", [error localizedDescription]);
         if(returnBlock) returnBlock(nil);
     }];
    [operation start];
}

/// Creates and populates an MBBoxFolder object using values from folderResponse.
/// @param folderResponse The object containing the info from Box API about the folder.
/// @param parent The parent of this folder.
/// @return A new MBBoxFolder object.
+ (MBBoxFolder*)folderFromResponse:(MBBoxFolderResponse*)folderResponse withParent:(MBBoxFolder*)parent
{
    MBBoxFolder* newFolder = [[MBBoxFolder alloc] init];
    newFolder.user = parent.user;
    newFolder.id = folderResponse.id;
    newFolder.name = folderResponse.name;

    return newFolder;
}

@end
