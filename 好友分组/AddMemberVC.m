//
//  AddMemberVC.m
//  好友分组
//
//  Created by LiliEhuu on 16/11/1.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "AddMemberVC.h"
#import "FriendItemAction.h"
#import "UIAlertAction+Extension.h"

@interface AddMemberVC ()
@property (weak, nonatomic) IBOutlet UITextField *memberNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectGroupButton;   //选择分组按钮
@property (strong , nonatomic) FriendGroupItemAction *groupItem;    //选择的分组
@property (assign , nonatomic) NSUInteger index;    //选择分组的下标

@end

@implementation AddMemberVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (IBAction)add:(UIButton *)sender
{
    if (self.memberNameTextField.text.length && self.accountTextField.text.length)
    {
        if ([self.delegate respondsToSelector:@selector(passValue:idendifier:)])
        {
            [self.groupItem addFriendItem:[FriendItemAction friendItemWithName:self.memberNameTextField.text account:self.accountTextField.text avatar:@"meinv.jpg"]];
            [self.delegate passValue:@(self.index) idendifier:NSStringFromClass(self.class)];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)selectGroup:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择分组" message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSUInteger index = 0;
    for (FriendGroupItemAction *groupItem in self.group.groupList)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:groupItem.groupName style:UIAlertActionStyleDefault index:index++ handler:^(UIAlertAction * _Nonnull action) {
            [self clickGroupName:action.index];
        }];
        
        [alert addAction:action];
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault index:index handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)clickGroupName:(NSUInteger)index
{
    self.groupItem = self.group.groupList[index];
    
    self.index = index;
    self.selectGroupButton.titleLabel.text = self.groupItem.groupName;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end



