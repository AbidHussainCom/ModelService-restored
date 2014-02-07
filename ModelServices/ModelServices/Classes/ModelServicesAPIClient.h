#import "AFHTTPClient.h"

@interface ModelServicesAPIClient : AFHTTPClient

+ (ModelServicesAPIClient *)sharedClient;

@end
