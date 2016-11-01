//
//  FriendItemAction.h
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FriendGroupItemAction;
@interface FriendItemAction : NSObject<NSCopying>

@property (copy , nonatomic) NSString *nickname;    //昵称
@property (copy , nonatomic) NSString *account;     //账号
@property (copy , nonatomic) NSString *avatar;      //头像名称

@property (weak , nonatomic) FriendGroupItemAction *currentGroup;   //当前所在分组

/**
 *  @author Lili, 16-10-20 16:10:29
 *
 *  创建好友对象
 *
 *  @param name       好有名称
 *  @param account    好友账号
 *  @param avatarName 好友头像名称
 *
 *  @return 返回好友对象
 */
+ (instancetype)friendItemWithName:(NSString *)name account:(NSString *)account avatar:(NSString *)avatarName;

/**
 *  @author Lili, 16-11-02 00:11:54
 *
 *  移动到分组
 *
 *  @param group 需要移动到该分组
 */
- (void)moveToGroup:(FriendGroupItemAction *)group;


@end
