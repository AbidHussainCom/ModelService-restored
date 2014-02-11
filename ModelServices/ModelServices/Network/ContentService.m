//
//  ContentService.m
//  ModelServices
//
//  Created by Le Abid on 10/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import "ContentService.h"

#define URL_ACTION @"content"

@implementation ContentService

- (NSArray*)parse:(id)response{
    return @[];
}

- (void)getContentsWithSuccessBlock:(SuccessBlock)_success
                    andFailureBlock:(FailBlock)_fail {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    // Initialize Parameters here
    
    [self executeRequestType:RequestTypeGetEvents
               requestMethod:RequestMethodGet
                         URL:URL_ACTION
                  parameters:parameters
               responseBlock:^id(id response) {
                   
                    return [self parse:response];
                }
                successBlock:^(id response) {
                    
                    _success(response);
                }
                failureBlock:^(id response) {
                    
                    _fail(response);
                }];
    
}

@end
