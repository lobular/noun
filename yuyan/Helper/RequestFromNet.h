//
//  RequestFromNet.h
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(NSDictionary *dataDic);
typedef void (^Fault)(NSError *error);


@interface RequestFromNet : NSObject

@end

