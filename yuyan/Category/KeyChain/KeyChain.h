//
//  KeyChain.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KeyChain : NSObject

+ (id)objectWithKey:(NSString *)key;

+ (void)saveObject:(id)object Forkey:(NSString *)key ToKeyChainStore:(BOOL)toKeyChainStore;

+ (void)clearObjects:(NSArray *)keys;


@end

