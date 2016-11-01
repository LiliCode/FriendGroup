//
//  AddGroupVC.m
//  好友分组
//
//  Created by LiliEhuu on 16/11/1.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "AddGroupVC.h"
#import "FriendGroupItemAction.h"

@interface AddGroupVC ()
@property (weak, nonatomic) IBOutlet UITextField *groupNameTextField;

@end

@implementation AddGroupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (IBAction)add:(UIButton *)sender
{
    if (self.groupNameTextField.text.length)
    {
        if ([self.delegate respondsToSelector:@selector(passValue:idendifier:)])
        {
            //创建组
            FriendGroupItemAction *group = [FriendGroupItemAction groupItemWithName:self.groupNameTextField.text list:nil];
            //传值
            [self.delegate passValue:group idendifier:NSStringFromClass(self.class)];
            //返回
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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



