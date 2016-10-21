//
//  FriendGroupItemAction.h
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendItemAction.h"

@interface FriendGroupItemAction : NSObject<NSCopying>

@property (copy , nonatomic) NSString *groupName;               //组名称
@property (assign , nonatomic , readonly) NSUInteger friendNum; //当前分组好友数量
@property (strong , nonatomic , readonly) NSArray *friendList;  //当前组好友列表
@property (assign , nonatomic , readonly) BOOL isDropDown;      //是否落下（是否打开分组）


/**
 *  @author Lili, 16-10-20 16:10:05
 *
 *  创建分组对象
 *
 *  @param name 分组名称
 *  @param list 分组中的好友列表
 *
 *  @return 返回分组
 */
+ (instancetype)groupItemWithName:(NSString *)name list:(NSMutableArray *)list;

/**
 *  @author Lili, 16-10-21 17:10:06
 *
 *  点击分组，会自动判断是否打开好友列表
 *
 *  @param complete 点击之后回调，在回调中做刷新UI的操作
 */
- (void)clickGroup:(void (^)(BOOL isDropDown))complete;

/**
 *  @author Lili, 16-10-20 16:10:24
 *
 *  添加成员
 *
 *  @param item 需要添加的好友对象
 */
- (void)addFriendItem:(FriendItemAction *)item;

/**
 *  @author Lili, 16-10-20 16:10:46
 *
 *  删除成员
 *
 *  @param item 需要删除的好友对象
 */
- (void)removeFriendItem:(FriendItemAction *)item;




@end
