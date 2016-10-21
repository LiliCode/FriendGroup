//
//  FriendItemAction.m
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "FriendItemAction.h"

@implementation FriendItemAction


+ (instancetype)friendItemWithName:(NSString *)name account:(NSString *)account avatar:(NSString *)avatarName
{
    return [[[self class] alloc] initWithName:name account:account avatar:avatarName];
}

- (instancetype)initWithName:(NSString *)name account:(NSString *)account avatar:(NSString *)avatarName
{
    if (self = [super init])
    {
        self.nickname = name;
        self.account = account;
        self.avatar = avatarName;
    }
    
    return self;
}



- (id)copyWithZone:(NSZone *)zone
{
    FriendItemAction *item = [[FriendItemAction allocWithZone:zone] init];
    
    item.account = self.account;
    item.avatar = self.avatar;
    item.nickname = self.nickname;
    
    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"nickname:%@\naccount:%@\navatar:%@", self.nickname, self.account, self.avatar];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"nickname:%@\naccount:%@\navatar:%@", self.nickname, self.account, self.avatar];
}

@end





