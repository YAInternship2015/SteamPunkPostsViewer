

#import <Foundation/Foundation.h>

@interface SPPLoginAPIClient : NSObject

- (NSURLRequest*)oauthAuthorizeRequest;
- (void)requestUserDataWithVerifier:(NSString*)verifier;

@end
