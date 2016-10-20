//
//  FriendGroupItemAction.h
//  好友分组
//
//  Created by LiliEhuu on 16/10/20.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendItemAction.h"

@interface FriendGroupItemAction : NSObject

@property (copy , nonatomic) NSString *groupName;    //组名称
@property (strong , nonatomic) NSNumber *friendNum;  //当前分组好友数量
@property (strong , nonatomic , readonly) NSArray *friendList;  //当前组好友列表


- (void)addFriendItem:(FriendItemAction *)item;


@end
