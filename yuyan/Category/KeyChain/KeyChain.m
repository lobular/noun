//
//  KeyChain.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "KeyChain.h"
#import "UICKeyChainStore.h"
#import <UIKit/UIKit.h>

#define MainBundleIdentifier ([[NSBundle mainBundle] bundleIdentifier])

@implementation KeyChain


+ (id)objectWithKey:(NSString *)key;
{
    id re = nil;
    re = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!re) {
        re=[self objectFromKeyChainStore:MainBundleIdentifier WithKey:key];
    }
    return re;
}

+ (id)objectFromKeyChainStore:(NSString *)Service WithKey:(NSString *)key
{
    UICKeyChainStore *keyChainStore = [UICKeyChainStore keyChainStoreWithService:Service];
    return keyChainStore[key];
}


+ (void)saveObject:(id)object Forkey:(NSString *)key ToKeyChainStore:(BOOL)toKeyChainStore;
{
    if (!object || !key || [key isEqualToString:@""]) {
        return;
    }
    
    if (toKeyChainStore) {
        [self saveToKeyChainStore:MainBundleIdentifier Object:object Key:key];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

+ (void)saveToKeyChainStore:(NSString *)Service Object:(id)object Key:(NSString *)key;{
    UICKeyChainStore *keyChainStore = [UICKeyChainStore keyChainStoreWithService:Service];
    if (!keyChainStore) {
        keyChainStore = [[UICKeyChainStore alloc]initWithService:Service];
    }
    keyChainStore[key] = object;
}


+ (void)clearObjects:(NSArray *)keys;
{
    for (NSString *key in keys) {
        [self clearObjectWithKey:key];
    }
}

+ (void)clearObjectWithKey:(NSString *)key{
    id re = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!re) {
        UICKeyChainStore *keyChainStore = [UICKeyChainStore keyChainStoreWithService:MainBundleIdentifier];
        if (keyChainStore) {
            [keyChainStore removeItemForKey:key];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

@end
