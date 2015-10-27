

#import <Foundation/Foundation.h>

//#warning лучше SPPLoginAPIClient
@interface SPPLoginAPIClient : NSObject

- (NSURLRequest*)oauthAuthorizeRequest;
//#warning requestUserDataWithVerifier:
- (void)requestUserDataWithVerifier:(NSString*)verifier;

@end
