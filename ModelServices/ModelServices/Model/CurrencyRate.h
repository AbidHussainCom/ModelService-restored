//
//  CurrencyRate.h
//  ModelServices
//
//  Created by Le Abid on 17/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrencyRate : NSObject

@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) NSString *disclaimer;
@property (nonatomic, strong) NSArray  *rates;
@property (nonatomic, strong) NSString *updatedAt;

- (id)initWithDictionary:(NSDictionary*)dict;

@end
