

#import <Foundation/Foundation.h>

typedef void (^SPPDataAPIClientBlock)(id responseObject);

@interface SPPDataAPIClient : NSObject

+ (SPPDataAPIClient *)sharedManager;
- (void)loadPostsFirstPageWithCompletionBlock:(SPPDataAPIClientBlock)completion;
- (void)loadPostsNextPageWithCompletionBlock:(SPPDataAPIClientBlock)completion;

@end
