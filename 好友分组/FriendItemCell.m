//
//  FriendItemCell.m
//  好友分组
//
//  Created by LiliEhuu on 16/10/21.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "FriendItemCell.h"

@interface FriendItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@end

@implementation FriendItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

- (void)setFriendItem:(FriendItemAction *)friendItem
{
    _friendItem = friendItem;
    
    self.avatarImageView.image = [UIImage imageNamed:friendItem.avatar];
    self.nicknameLabel.text = friendItem.nickname;
}


@end



