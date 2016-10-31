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
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(groupLongPress:)];
    [self addGestureRecognizer:longPress];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}


- (void)groupLongPress:(UILongPressGestureRecognizer *)sender
{
    //长按
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        if ([self.delegate respondsToSelector:@selector(longPressGroup:)])
        {
            [self.delegate longPressGroup:self];
        }
    }
}


- (void)setGroupItem:(FriendGroupItemAction *)groupItem
{
    _groupItem = groupItem;
    
    self.groupNameLabel.text = groupItem.groupName;
    self.friendNumLabel.text = [NSString stringWithFormat:@"%lu", groupItem.friendNum];
}


@end
