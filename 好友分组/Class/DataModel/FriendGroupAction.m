//
//  FriendGroupAction.m
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "FriendGroupAction.h"
#import <UIKit/UIKit.h>

@interface FriendGroupAction ()
@property (strong , nonatomic) NSMutableArray *group;
@property (assign , nonatomic) BOOL has_default_group;
@property (strong , nonatomic) FriendGroupItemAction *default_group;

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
        //加载默认分组
        [self loadDefaultGroup];
        //初始化
        [self loadGroup];   //加载分组
    }
    
    return self;
}

- (void)loadDefaultGroup
{
    FriendGroupItemAction *dGroup = [FriendGroupItemAction defaultGroupItemWithName:@"我的好友" list:nil];
    [self addGroup:dGroup];
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
        //得到好友分组
        FriendGroupItemAction *groupItem = [FriendGroupItemAction groupItemWithName:groupDic[@"groupName"] list:[NSMutableArray new]];
        //遍历好友
        for (NSDictionary *friendDic in friendList)
        {
            //得到好友数据
            FriendItemAction *friendItem = [FriendItemAction friendItemWithName:friendDic[@"nickname"] account:friendDic[@"account"] avatar:friendDic[@"avatar"]];
            //添加到好友分组
            [groupItem addFriendItem:friendItem];
        }
        
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
        //将要添加分组...
        //添加分组是判断是否有多有默认分组,只能有一个默认分组
        NSAssert(!(self.hasDefaultGroup && group.isDefaultGroup), @"不能有多个默认分组");
        //设置是否有默认分组标示
        if (!self.hasDefaultGroup && group.isDefaultGroup)
        {
            self.has_default_group = YES;
            //设置默认分组
            self.default_group = group;
            //添加默认分组 默认分组必须是置顶
            [self.group insertObject:group atIndex:0];
            
            return;
        }
        
        //添加分组
        [self.group addObject:group];
    }
}

- (void)removeGroup:(FriendGroupItemAction *)group
{
    if (group)
    {
        //将要删除分组...
        //删除分组时，将好友移动到默认分组中去
        //1.判断是否是默认分组，若是默认分组则不能删除
        if (group.isDefaultGroup)
        {
            if ([self.delegate respondsToSelector:@selector(didReceiveFriendGroupMessage:)])
            {
                [self.delegate didReceiveFriendGroupMessage:@"不能删除默认分组!"];
            }
            
            return;
        }
        
        //2.判断是否有默认分组,若没有就创建
        if (!self.hasDefaultGroup)
        {
            [self loadDefaultGroup];
        }
        
        //3.将该分组的成员移动到默认分组中去
        //展开分组
        if (!group.isDropDown)
        {
            [group clickGroup:nil];
        }
        
        for (FriendItemAction *member in group.friendList)
        {
            [self.defaultGroup addFriendItem:[member copy]];
        }
        
        //删除分组
        [group removeAllFriendItem];
        [self.group removeObject:group];
    }
}

- (void)moveIndexPath:(NSIndexPath *)originIndexPath toGroup:(FriendGroupItemAction *)group
{
    //获取分组
    FriendGroupItemAction *friendGroup = self.groupList[originIndexPath.section];
    //获取成员
    FriendItemAction *friendItem = friendGroup.friendList[originIndexPath.row];
    //移动
    [friendItem moveToGroup:group];
}



- (NSArray *)groupList
{
    return [self.group copy];
}

- (BOOL)hasDefaultGroup
{
    return self.has_default_group;
}

- (FriendGroupItemAction *)defaultGroup
{
    return self.default_group;
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


