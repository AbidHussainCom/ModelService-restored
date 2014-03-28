//
//  ContentService.h
//  ModelServices
//
//  Created by Le Abid on 10/02/2014.
//  Copyright (c) 2014 Coeus Solutions GmbH. All rights reserved.
//

#import "BaseService.h"

@interface CurrencyRateService : BaseService

- (void)getContentsWithSuccessBlock:(SuccessBlock)_success
                    andFailureBlock:(FailBlock)_fail;

@end
