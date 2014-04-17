//
//  BaseService.m
//  ModelServices
//
//  Created by Le Abid on 07/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

- (id)init{
    
    self  = [super init];
    
    if (self) {
        manager  = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:nil]];
        //manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

#pragma mark - Response Validation

// Handle Properly for Valid Server Responses.

- (BOOL) validdateServerResponse:(id)_response{
    
    if ([_response isKindOfClass:[NSArray class]] ||
        [_response isKindOfClass:[NSDictionary class]]){
        return YES;
    }
    return NO;
}

#pragma mark - Request Method

- (NSString *) requestMethodWithType:(RequestMethod)_method{
    
    switch (_method) {
            
        case RequestMethodPost: return @"POST"; break;
            
        case RequestMethodPut:  return @"PUT";  break;
            
        case RequestMethodDelete:return @"DELETE"; break;
            
        case RequestMethodGet:  return @"GET"; break;
            
        default:return @"GET";
    }
}

#pragma mark - Pagination

- (void) appendPaginationAndLimitToParams:(NSMutableDictionary *)_params{
    
    if (self.pageNumber > 0) {
        _params[@"offset"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.pageNumber];
    }
    
    if (self.limit > 0) {
        _params[@"limit"] = [NSString stringWithFormat:@"%lu",(unsigned long)self.limit];
    }
    
}

#pragma mark - Response Wrapper

- (NSDictionary*)infoWithRequestType:(RequestType)_type {
    return @{REQUEST_TYPE:@(_type)};
}

- (NSDictionary*)responseDictionaryWithResponse:(id)response
                                           info:(NSDictionary*)_info {
    return @{DATA:response,REQUEST_INFO:_info};
}

- (NSDictionary*)errorDictioaryWithResponse:(id)response
                                      error:(NSError*)_error
                                       info:(NSDictionary*)_info {
    return @{DATA:response,ERROR:_error,REQUEST_INFO:_info};
}

#pragma mark - Execute Request

- (void)executeRequestType:(RequestType)_type
             requestMethod:(RequestMethod)_method
                       URL:(NSString *)_urlAction
                parameters:(NSMutableDictionary *)_params
             responseBlock:(ResponseBlock)_response
              successBlock:(SuccessBlock)_success
              failureBlock:(FailBlock)_fail
{
    
    if (![manager.reachabilityManager isReachable]) {
        // Post Error here
    }
    self.refreshing = YES;
    
    // Append Pagination and limit
    //[self appendPaginationAndLimitToParams:_params];
    
    // Append Authentication
    _params[API_KEY]=API_KEY_VALUE;
    
    // Request Info
    __block NSDictionary *info = [self infoWithRequestType:_type];
    
    //?app_id=bc4edc57c5954fdd8ca80b1bb985f613
    
    NSString *string = @"http://openexchangerates.org/api/latest.json";
    
    NSError *requestError = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:[self requestMethodWithType:_method]
                                                                      URLString:string
                                                                     parameters:_params
                                                                          error:&requestError];
    
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             
                                                                             NSDictionary *response = (NSDictionary*)responseObject;
                                                                             
                                                                             if ([self validdateServerResponse:responseObject]) {
                                                                                 
                                                                                 NSArray *parsedResponse = _response(response);
                                                                                 NSDictionary *formattedResponse = [self responseDictionaryWithResponse:parsedResponse
                                                                                                                                                   info:info];
                                                                                 _success(formattedResponse);
                                                                                 
                                                                             }
                                                                             else {
                                                                                 NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Null or  invlaid response" forKey:NSLocalizedDescriptionKey];
                                                                                 NSError *error =[[NSError alloc] initWithDomain:@"WSC" code:5000 userInfo:userInfo];
                                                                                 
                                                                                 NSDictionary *formattedResponse = [self errorDictioaryWithResponse:response
                                                                                                                                              error:error
                                                                                                                                               info:info];
                                                                                 _fail(formattedResponse);
                                                                                 
                                                                             }
                                                                             
                                                                             self.refreshing = NO;
                                                                         }
                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             
                                                                             NSDictionary *formattedResponse = [self errorDictioaryWithResponse:@{}
                                                                                                                                          error:error
                                                                                                                                           info:info];
                                                                             _fail(formattedResponse);
                                                                             self.refreshing = NO;
                                                                             
                                                                         }];
    
    [operation start];
    
}

@end
