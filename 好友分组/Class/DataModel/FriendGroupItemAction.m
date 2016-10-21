//
//  FriendGroupItemAction.m
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "FriendGroupItemAction.h"

@interface FriendGroupItemAction ()
@property (strong , nonatomic) NSMutableArray *list;


@end

@implementation FriendGroupItemAction


+ (instancetype)groupItemWithName:(NSString *)name list:(NSMutableArray *)list
{
    return [[[self class] alloc] initWithName:name list:list];
}

- (instancetype)initWithName:(NSString *)name list:(NSMutableArray *)list
{
    if (self = [super init])
    {
        self.groupName = name;
        [self.list addObjectsFromArray:[list copy]];
    }
    
    return self;
}

- (NSMutableArray *)list
{
    if (!_list)
    {
        _list = [NSMutableArray new];
    }
    
    return _list;
}

- (NSUInteger)friendNum
{
    return [self.list count];
}

- (NSArray *)friendList
{
    return [self.list copy];
}

- (void)addFriendItem:(FriendItemAction *)item
{
    if (item)
    {
        [self.list addObject:item];
    }
}

- (void)removeFriendItem:(FriendItemAction *)item
{
    if (item)
    {
        [self.list removeObject:item];
    }
}



- (id)copyWithZone:(NSZone *)zone
{
    FriendGroupItemAction *group = [[FriendGroupItemAction allocWithZone:zone] init];
    
    group.groupName = self.groupName;
    group.list = [self.list mutableCopy];
    
    return group;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"groupName:%@\nfriendNum:%lu\nfriendList:%@", self.groupName, self.friendNum, self.list];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"groupName:%@\nfriendNum:%lu\nfriendList:%@", self.groupName, self.friendNum, self.list];
}

@end






