//
//  FriendGroupAction.h
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendGroupItemAction.h"

@interface FriendGroupAction : NSObject
//分组个数
@property (assign , nonatomic , readonly) NSUInteger groupNum;
//全部好友数
@property (assign , nonatomic , readonly) NSUInteger friendNum;
//分组列表
@property (strong , nonatomic , readonly) NSArray *groupList;

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


@end



