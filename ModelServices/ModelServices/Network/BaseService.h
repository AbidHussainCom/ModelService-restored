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

@interface BaseService : NSObject {
    
    AFHTTPRequestOperationManager *manager;
}

@end
