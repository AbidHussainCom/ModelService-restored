//
//  BaseService.h
//  ModelServices
//
//  Created by Le Abid on 07/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

#import "NetworkConstants.h"

// Success and Failure Blocks
typedef id   (^ResponseBlock) (id response);
typedef void (^SuccessBlock)(id response);
typedef void (^FailBlock) (id response);

// Define each request type here with Format RequestTypeXxxYyy.
typedef enum{
    RequestTypeGetEvents=0,
}RequestType;

// Request Method
typedef enum{
    RequestMethodPost,
    RequestMethodGet,
    RequestMethodPut,
    RequestMethodDelete
}RequestMethod;

@interface BaseService : NSObject {
    
    AFHTTPRequestOperationManager *manager;
}

@property (assign) NSUInteger pageNumber;
@property (assign) NSUInteger limit;
@property (assign) NSUInteger maxRecords;
@property (assign,getter = isRefreshing) BOOL refreshing;


- (void) executeRequestType:(RequestType)_type
              requestMethod:(RequestMethod)_method
                        URL:(NSString*)_urlAction
                 parameters:(NSMutableDictionary *)_params
              responseBlock:(ResponseBlock)_response
               successBlock:(SuccessBlock)_success
               failureBlock:(FailBlock)_fail;

@end
