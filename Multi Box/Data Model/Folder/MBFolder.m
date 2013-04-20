//
//  MBFolder.m
//  Multi Box
//
//  Created by Aaron Milam on 4/4/13.
//  Copyright (c) 2013 Milamsoft. All rights reserved.
//

#import "MBFolder.h"
#import "MBUser.h"
#import "MBFolderItemsResponse.h"
#import "MBFileResponse.h"
#import "MBFolderResponse.h"
#import "NSString+URLQuery.h"
#import <RestKit/RestKit.h>
#import <RestKit/RKObjectManager.h>

@interface MBFolder()

@property (nonatomic, strong, readwrite) NSString* bid;
@property (nonatomic, strong, readwrite) NSString* sequenceId;
@property (nonatomic, strong, readwrite) NSString* etag;
@property (nonatomic, strong, readwrite) NSString* name;
@property (nonatomic, strong, readwrite) NSDate* createdAt;
@property (nonatomic, strong, readwrite) NSDate* modifiedAt;
@property (nonatomic, strong, readwrite) NSString* bdescription;
@property (nonatomic, assign, readwrite) NSInteger size;
@property (nonatomic, strong, readwrite) NSArray* pathCollection;
@property (nonatomic, strong, readwrite) MBUser* createdBy;
@property (nonatomic, strong, readwrite) MBUser* modifiedBy;
@property (nonatomic, strong, readwrite) MBUser* ownedBy;
@property (nonatomic, strong, readwrite) NSString* sharedLinkUrlString;
@property (nonatomic, strong, readwrite) NSString* folderUploadEmail;
@property (nonatomic, strong, readwrite) MBFolder* parent;
@property (nonatomic, strong, readwrite) NSString* itemStatus;
@property (nonatomic, strong, readwrite) NSArray* itemCollection;
@property (nonatomic, strong, readwrite) NSString* syncState;

@property (nonatomic, strong, readwrite) MBUser* user;

@end

@implementation MBFolder

- (MBFolder*)initRootFolderForUser:(MBUser*)user
{
    self = [self init];
    
    self.bid = @"0";
    self.user = user;
    
    return self;
}

- (void)refreshContents:(void (^)(MBFolder *))returnBlock
{
    //TODO: Expand folder mapping
    RKObjectMapping* folderMapping = [RKObjectMapping mappingForClass:[MBFolderResponse class]];
    [folderMapping addAttributeMappingsFromArray:@[@"name", @"id"]];
    
    //TODO: File mapping
    
    //TODO: Do something with limit and offset and whatever else comes with the response
    RKObjectMapping* responseMapping = [RKObjectMapping mappingForClass:[MBFolderItemsResponse class]];
    [responseMapping addRelationshipMappingWithSourceKeyPath:@"entries" mapping:folderMapping];
    
    NSIndexSet* statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:@"/2.0/folders/:id/items" keyPath:nil statusCodes:statusCodes];
    
    NSDictionary* queryItems =
    @{
      @"limit" : @"1",
      @"offset" : @"0",
      @"fields" : @"name,id"
    };
    
    NSString* url = [NSString stringWithFormat:@"https://api.box.com/2.0/folders/%@/items?%@", self.bid, [NSString queryStringFromDictionary:queryItems]];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", self.user.accessToken] forHTTPHeaderField:@"Authorization"];
    RKObjectRequestOperation* operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];

    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult* result)
     {
         NSMutableArray* items = [NSMutableArray arrayWithCapacity:[result.array[0] entries].count];
         for(id item in [result.array[0] entries])
         {
             if([item isKindOfClass:[MBFolderResponse class]])
             {
                 [items addObject:[MBFolder folderFromResponse:item withParent:self]];
             }
             else if([item isKindOfClass:[MBFileResponse class]])
             {
                 //TODO: parse file and add to item collection
             }
         }
         
         self.itemCollection = [NSArray arrayWithArray:items];
         
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

/// Creates and populates an MBFolder object using values from folderResponse.
/// @param folderResponse The object containing the info from Box API about the folder.
/// @param parent The parent of this folder.
/// @return A new MBFolder object.
+ (MBFolder*)folderFromResponse:(MBFolderResponse*)folderResponse withParent:(MBFolder*)parent
{
    MBFolder* newFolder = [[MBFolder alloc] init];
    newFolder.user = parent.user;
    newFolder.bid = folderResponse.id;
    newFolder.name = folderResponse.name;

    return newFolder;
}

@end
