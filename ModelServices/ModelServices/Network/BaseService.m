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
        manager  = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    }
    return self;
}

@end
