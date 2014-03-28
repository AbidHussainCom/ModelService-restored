//
//  CurrencyRate.m
//  ModelServices
//
//  Created by Le Abid on 17/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import "CurrencyRate.h"

@implementation CurrencyRate

- (id)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    if (self) {
        
        self.base = dict[BASE];
        self.disclaimer = dict[DISCLAIMER];
        
        NSNumber *unixTimeStamp =dict[TIMESTAMP];
        NSTimeInterval _interval=[unixTimeStamp longLongValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"HH:MM:SS dd-MM-yyyy"];
        self.updatedAt=[_formatter stringFromDate:date];
        
        NSDictionary *rateDict = dict[RATES];
        NSMutableArray *tempRates = [NSMutableArray array];
        
        for (NSString *key in [rateDict allKeys]) {
            [tempRates addObject:@{@"code":key,@"rate":rateDict[key]}];
        }
        
        self.rates = [NSArray arrayWithArray:tempRates];
    
    }
    
    return self;
}

@end
