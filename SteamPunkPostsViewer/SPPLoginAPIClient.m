

#import "SPPLoginAPIClient.h"
#import "AFNetworking.h"
#import "SPPUserDataModel.h"
#import "SPPDataManager.h"
#import <MagicalRecord/MagicalRecord.h>

static NSString *kClientID = @"33bc09c63c934786a26cde59f150b768";
static NSString *kClientSecret = @"3e9ef127f8554d5f8f608eb1a16152da";
static NSString *callbackURL = @"http://steampunkpostsviewer.com/";
static NSString *kBaseURL= @"https://api.instagram.com/";
static NSString *oauthRequestURL = @"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code";
static NSString *kBaseURLWithOauthAndToken = @"https://api.instagram.com/oauth/access_token";
static NSString *kUser = @"user";

@implementation SPPLoginAPIClient

- (NSURLRequest*)oauthAuthorizeRequest {
    NSString *url = [NSString stringWithFormat:oauthRequestURL ,kClientID,callbackURL];
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}

- (void)requestUserDataWithVerifier:(NSString*)verifier{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"client_id" : kClientID,
                                 @"client_secret" : kClientSecret,
                                 @"grant_type" : @"authorization_code",
                                 @"redirect_uri" : callbackURL,
                                 @"code" : verifier};
    [manager POST:kBaseURLWithOauthAndToken parameters:parameters                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
//#warning здесь нужен weakSelf
#warning weakSelf объявляется перед блоком, иначе смысла не имеет. Разберитесь с управлением памятью в блоках, этот вопрос может вам попасться на собеседовании
         __weak typeof(self) weakSelf = self;
        [weakSelf saveUserDataAndLoadFirstPackOfPosts:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)saveUserDataAndLoadFirstPackOfPosts:(NSDictionary *)userData{
   __block SPPUserDataModel *newUser = nil;
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext){
        NSArray *existedUsers = [SPPUserDataModel MR_findAllWithPredicate:
#warning съехало выравнивание
            [NSPredicate predicateWithFormat:@"accessToken == %@", userData[@"access_token"]]];
//#warning знаки "<", ">", "=" надо выделять пробелами с обоих сторон
        if ([existedUsers count] > 0) {
            newUser = existedUsers[0];
        } else {
            newUser=[SPPUserDataModel MR_createEntityInContext:localContext];
        }
//#warning выравнивание "поехало"
        newUser.accessToken = userData[@"access_token"];
        newUser.userID = userData[kUser][@"id"];
        newUser.username = userData [kUser][@"username"];
        newUser.fullName = userData [kUser][@"full_name"];
        newUser.profilePicture = userData [kUser][@"profile_picture"];
        
    }];
    [[SPPDataManager sharedManager] loadRecentPostsAndSetupNextMaxID];

}

@end
