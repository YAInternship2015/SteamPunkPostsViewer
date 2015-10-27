

#import <Foundation/Foundation.h>

//#warning лучше SPPDataAPIClient

typedef void (^SPPDataAPIClientBlock)(id responseObject);

@interface SPPDataAPIClient : NSObject

+ (SPPDataAPIClient *)sharedManager;
#warning снова то же замечание - haveUseMaxIDFromeCoreDataInRequest: и дальше BOOL. Лучше как-то вроде. Я тут попытался вникнуть, параметр влияет на то, грузится первая страница или следующие. Так вот, лучше вместо одного метода сделать два, loadPostsFirstPageWithCompletionBlock: и loadPostsNextPageWithCompletionBlock:
- (void)haveUseMaxIDFromeCoreDataInRequest:(BOOL)boolIdentifier andLoadPostsWithCompletionBlock:(SPPDataAPIClientBlock)completion;
@end
