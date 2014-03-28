//
//  ContentService.m
//  ModelServices
//
//  Created by Le Abid on 10/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import "CurrencyRateService.h"
#import "CurrencyRate.h"

@implementation CurrencyRateService


- (NSArray*)parse:(id)response{
    
    NSDictionary *responseDict = (NSDictionary*)response;
    
    CurrencyRate *rate = [[CurrencyRate alloc] initWithDictionary:responseDict];
    
    return @[rate];
}

- (void)getContentsWithSuccessBlock:(SuccessBlock)_success
                    andFailureBlock:(FailBlock)_fail {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    // Initialize Parameters here
    
    [self executeRequestType:RequestTypeGetCurrencyRates
               requestMethod:RequestMethodGet
                         URL:LATEST_RATES_URI
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
