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
@property (assign , nonatomic) BOOL dropDown;
@property (assign , nonatomic) BOOL defaultGroup;

@end

@implementation FriendGroupItemAction


+ (instancetype)groupItemWithName:(NSString *)name list:(NSMutableArray *)list
{
    return [[[self class] alloc] initWithName:name isDefaultGroup:NO list:list];
}

+ (instancetype)defaultGroupItemWithName:(NSString *)name list:(NSMutableArray *)list
{
    return [[[self class] alloc] initWithName:name isDefaultGroup:YES list:list];
}

- (instancetype)initWithName:(NSString *)name isDefaultGroup:(BOOL)defaultGroup list:(NSMutableArray *)list
{
    if (self = [super init])
    {
        self.groupName = name;
        self.defaultGroup = defaultGroup;   //是否是默认分组
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
    return self.isDropDown? [self.list copy] : nil; //根据是否打开分组，来返回列表
}

- (BOOL)isDropDown
{
    return self.dropDown;
}

- (BOOL)isDefaultGroup
{
    return self.defaultGroup;
}


- (void)addFriendItem:(FriendItemAction *)item
{
    if (item)
    {
        [self.list addObject:item];
        item.currentGroup = self;
    }
}

- (void)removeFriendItem:(FriendItemAction *)item
{
    if (item)
    {
        [self.list removeObject:item];
    }
}

- (void)removeAllFriendItem
{
    [self.list removeAllObjects];
}

- (void)clickGroup:(void (^)(BOOL))complete
{
    self.dropDown = self.isDropDown? NO : YES;
    
    if (complete)
    {
        complete(self.dropDown);
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
    return [NSString stringWithFormat:@"groupName:%@\nfriendNum:%lu\nfriendList:%@\ndefaultGroup:%d", self.groupName, self.friendNum, self.list, self.defaultGroup];
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"groupName:%@\nfriendNum:%lu\nfriendList:%@\ndefaultGroup:%d", self.groupName, self.friendNum, self.list, self.defaultGroup];
}

@end






