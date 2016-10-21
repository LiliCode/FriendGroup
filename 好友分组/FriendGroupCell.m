//
//  FriendGroupCell.m
//  好友分组
//
//  Created by LiliEhuu on 16/10/21.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "FriendGroupCell.h"

@interface FriendGroupCell ()
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendNumLabel;

@end

@implementation FriendGroupCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}


- (void)setGroupItem:(FriendGroupItemAction *)groupItem
{
    _groupItem = groupItem;
    
    self.groupNameLabel.text = groupItem.groupName;
    self.friendNumLabel.text = [NSString stringWithFormat:@"%lu", groupItem.friendNum];
}


@end
