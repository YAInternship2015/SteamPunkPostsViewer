

#import <Foundation/Foundation.h>

//#warning лучше SPPDataAPIClient

typedef void (^SPPDataAPIClientBlock)(id responseObject);

@interface SPPDataAPIClient : NSObject

+ (SPPDataAPIClient *)sharedManager;
#warning не хватает пробела после "-", и также тип блока надо объявлять через typedef. Еще стоит отметить, что блоки предпочтительнее делать идут последними параметрами. И на счет NextMaxID:(BOOL)boolIdentifier - NextMaxID звучит как число или строка, но никак не bool, переименуйте параметр, чтобы было понятно, что он значит
- (void)haveUseMaxIDFromeCoreDataInRequest:(BOOL)boolIdentifier andLoadPostsWithCompletionBlock:(SPPDataAPIClientBlock)completion;
@end
