//
//  FriendGroupVC.m
//  好友分组
//
//  Created by LiliEhuu on 16/10/21.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "FriendGroupVC.h"
#import "FriendItemCell.h"
#import "FriendGroupCell.h"
#import "FriendGroupAction.h"

@interface FriendGroupVC ()
@property (strong , nonatomic) FriendGroupAction *friendGroup;

@end

@implementation FriendGroupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendGroup = [FriendGroupAction group];   //初始化分组
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.friendGroup.groupList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FriendGroupItemAction *groupItem = self.friendGroup.groupList[section];
    //返回每一个分组的成员数 + 当前分组
    return groupItem.friendList.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    //分组
    FriendGroupItemAction *groupItem = self.friendGroup.groupList[indexPath.section];
    
    if (!indexPath.row)
    {
        //组
        FriendGroupCell *groupCell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
        groupCell.groupItem = groupItem;
        
        cell = groupCell;
    }
    else
    {
        //成员
        FriendItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
        itemCell.friendItem = groupItem.friendList[indexPath.row - 1];
        
        cell = itemCell;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row)
    {
        return 60.0f;
    }
    
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //得到当前分组
    FriendGroupItemAction *groupItem = self.friendGroup.groupList[indexPath.section];
    
    if (!indexPath.row)
    {
        //点击当前分组
        __weak typeof(self) weakSelf = self;
        [groupItem clickGroup:^(BOOL isDropDown) {
            //刷新列表
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    else
    {
        //点击好友
        
    }
}


#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
