//
//  FriendGroupAction.m
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "FriendGroupAction.h"

@interface FriendGroupAction ()
@property (strong , nonatomic) NSMutableArray *group;

@end

@implementation FriendGroupAction

+ (instancetype)group
{
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    if (self = [super init])
    {
        //初始化
        [self loadGroup];   //加载分组
    }
    
    return self;
}

- (void)loadGroup
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"friendList.json" ofType:nil];
    NSDictionary *info = [self readJSONContentsOfFile:jsonPath];
    
    //得到分组列表
    NSArray *group = info[@"group"];
    
    //遍历分组
    for (NSDictionary *groupDic in group)
    {
        //获取当前分组的好友列表
        NSArray *friendList = groupDic[@"friendList"];
        NSMutableArray *tempFriendList = [NSMutableArray new];  //临时好友列表
        //遍历好友
        for (NSDictionary *friendDic in friendList)
        {
            //得到好友数据
            FriendItemAction *friendItem = [FriendItemAction friendItemWithName:friendDic[@"nickname"] account:friendDic[@"account"] avatar:friendDic[@"avatar"]];
            //添加到临时好友列表
            [tempFriendList addObject:friendItem];
        }
        
        //得到好友分组
        FriendGroupItemAction *groupItem = [FriendGroupItemAction groupItemWithName:groupDic[@"groupName"] list:[tempFriendList mutableCopy]];
        //添加到分组列表
        [self addGroup:groupItem];
    }
}

- (NSMutableArray *)group
{
    if (!_group)
    {
        _group = [NSMutableArray new];
    }
    
    return _group;
}

- (void)addGroup:(FriendGroupItemAction *)group
{
    if (group)
    {
        [self.group addObject:group];
    }
}

- (void)removeGroup:(FriendGroupItemAction *)group
{
    if (group)
    {
        [self.group removeObject:group];
    }
}

- (NSArray *)groupList
{
    return [self.group copy];
}


//解析json成字典
- (NSDictionary *)readJSONContentsOfFile:(NSString *)path
{
    NSData *json_data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json_data options:0 error:&error];
    if(error)
    {
        NSLog(@"解析JSON错误详情:%@",error.description);
        return nil;
    }
    return dic;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"group:%@", self.groupList];
}

@end


