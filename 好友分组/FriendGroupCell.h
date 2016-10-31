//
//  FriendGroupCell.h
//  好友分组
//
//  Created by LiliEhuu on 16/10/21.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendGroupItemAction.h"

@class FriendGroupCell;
@protocol FriendGroupCellDelegate <NSObject>
@optional
- (void)longPressGroup:(FriendGroupCell *)cell;

@end

@interface FriendGroupCell : UITableViewCell

@property (strong , nonatomic) FriendGroupItemAction *groupItem;

@property (weak , nonatomic) id<FriendGroupCellDelegate> delegate;


@end


