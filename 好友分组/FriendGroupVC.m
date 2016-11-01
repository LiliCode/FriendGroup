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
#import "AddGroupVC.h"
#import "AddMemberVC.h"

void alert(NSString *msg)
{
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alt show];
}

@interface FriendGroupVC ()<FriendGroupCellDelegate, FriendGroupActionDelegate, PassValueDelegate>
@property (strong , nonatomic) FriendGroupAction *friendGroup;

@end

@implementation FriendGroupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendGroup = [FriendGroupAction group];   //初始化分组
    self.friendGroup.delegate = self;
    
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
        groupCell.delegate = self;
        
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
        [groupItem clickGroup:^(BOOL isDropDown) {
            //刷新列表
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    else
    {
        //点击好友
        
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row;   //除了每一个分区的第0行不能编辑，其他都可以编辑
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除好友" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //获取该分组
        FriendGroupItemAction *group = weakSelf.friendGroup.groupList[indexPath.section];
        FriendItemAction *member = group.friendList[indexPath.row - 1];
        [group removeFriendItem:member];
        //刷新分组
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    UITableViewRowAction *moveAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"移动到分组" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    moveAction.backgroundColor = [UIColor grayColor];
    
    return @[deleteAction, moveAction];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - FriendGroupCellDelegate

- (void)longPressGroup:(FriendGroupCell *)cell
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除分组" message:@"删除分组之后，该分组的好友会移动到默认分组中" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *removeAction = [UIAlertAction actionWithTitle:@"删除分组" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        FriendGroupItemAction *groupItem = self.friendGroup.groupList[indexPath.section];
        [self.friendGroup removeGroup:groupItem];   //从数据源删除
        //删除界面上的分组
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathWithIndex:0], indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:removeAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - FriendGroupActionDelegate

- (void)didReceiveFriendGroupMessage:(NSString *)msg
{
    NSLog(@"%@", msg);
    alert(msg);
}


- (IBAction)add:(UIBarButtonItem *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *addGroupAction = [UIAlertAction actionWithTitle:@"添加分组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"addGroup" sender:nil];
    }];
    
    UIAlertAction *addFriendAction = [UIAlertAction actionWithTitle:@"添加好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"addMember" sender:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:addGroupAction];
    [alert addAction:addFriendAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - PassValueDelegate

- (void)passValue:(id)sender idendifier:(NSString *)idendifier
{
    if ([idendifier isEqualToString:NSStringFromClass([AddGroupVC class])])
    {
        //分组
        [self.friendGroup addGroup:sender];
        //刷新
        [self.tableView reloadData];
    }
    else if ([idendifier isEqualToString:NSStringFromClass([AddMemberVC class])])
    {
        //成员
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[sender integerValue]] withRowAnimation:UITableViewRowAnimationNone];
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
    if ([segue.identifier isEqualToString:@"addGroup"])
    {
        AddGroupVC *vc = [segue destinationViewController];
        vc.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"addMember"])
    {
        AddMemberVC *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.group = self.friendGroup;
    }
}


@end





