//
//  FriendGroupAction.h
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendGroupItemAction.h"

@class NSIndexPath;
@protocol FriendGroupActionDelegate <NSObject>

@optional
/**
 *  @author Lili, 16-10-31 11:10:04
 *
 *  收到消息
 *
 *  @param msg 消息文本
 */
- (void)didReceiveFriendGroupMessage:(NSString *)msg;

@end

@interface FriendGroupAction : NSObject
//分组个数
@property (assign , nonatomic , readonly) NSUInteger groupNum;
//全部好友数
@property (assign , nonatomic , readonly) NSUInteger friendNum;
//分组列表
@property (strong , nonatomic , readonly) NSArray *groupList;
//是否有默认分组
@property (assign , nonatomic , readonly) BOOL hasDefaultGroup;
//获取默认分组
@property (strong , nonatomic , readonly) FriendGroupItemAction *defaultGroup;

//消息代理
@property (weak , nonatomic) id<FriendGroupActionDelegate> delegate;


/**
 *  @author Lili, 16-10-20 17:10:34
 *
 *  创建好友分组
 *
 *  @return 返回整个好友分组
 */
+ (instancetype)group;

/**
 *  @author Lili, 16-10-20 17:10:00
 *
 *  添加分组
 *
 *  @param group 需要添加的分组
 */
- (void)addGroup:(FriendGroupItemAction *)group;

/**
 *  @author Lili, 16-10-20 17:10:21
 *
 *  移除分组
 *
 *  @param group 需要删除的分组
 */
- (void)removeGroup:(FriendGroupItemAction *)group;

/**
 *  @author Lili, 16-11-02 00:11:40
 *
 *  移动某一分组下的成员到另一个分组
 *
 *  @param originIndexPath 需要移动的成员的IndexPath
 *  @param toGroup         移动到该分组
 */
- (void)moveIndexPath:(NSIndexPath *)originIndexPath toGroup:(FriendGroupItemAction *)group;


@end



