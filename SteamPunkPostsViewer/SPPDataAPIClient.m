

#import "SPPDataAPIClient.h"
#import "SPPPostModel.h"
#import "SPPUserDataModel.h"
#import <MagicalRecord/MagicalRecord.h>
#import <AFNetworking/AFNetworking.h>
#import "SPPDataManager.h"
#import "NSDictionary+SPPFetchTokenFromUserData.h"


static NSString *const pathStringForGettingPostsWithSteamPunkTag =  @"https://api.instagram.com/v1/tags/SteamPunk/media/recent";

@implementation SPPDataAPIClient

+ (SPPDataAPIClient *)sharedManager {
    static SPPDataAPIClient *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SPPDataAPIClient alloc] init];
    });
    return manager;
}

- (void)loadPostsFirstPageWithCompletionBlock:(SPPDataAPIClientBlock)completion {
    NSDictionary *parameters = [NSDictionary fetchTokenFromUserData];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:pathStringForGettingPostsWithSteamPunkTag parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             completion(responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];

}

- (void)loadPostsNextPageWithCompletionBlock:(SPPDataAPIClientBlock)completion {
    NSDictionary *parameters = [NSDictionary fetchTokenWithNextMaxTagID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:pathStringForGettingPostsWithSteamPunkTag parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             completion(responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

@end
