//
//  ViewController.m
//  TFActionSheetDemo
//
//  Created by RaInVis on 16/11/11.
//  Copyright © 2016年 RaInVis. All rights reserved.
//

#import "ViewController.h"
#import "TFActionSheet.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"have title actionSheet" forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 setFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 50)];
    [button1 addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"no title actionSheet" forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 setFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 50)];
    [button2 addTarget:self action:@selector(action2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)action1
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"请完成此请完成此次请完成此次请完成此次次操作" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor redColor]                               }];
    // 设置段落
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = 30; // 首行文本缩进
    paragraphStyle.headIndent = 30;
    paragraphStyle.alignment = NSTextAlignmentCenter;  // 文本对齐方式
    paragraphStyle.tailIndent = -30; // 文本缩进(右端)
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.string.length)];
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"确定" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor grayColor]                               }];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"取消" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blueColor]                               }];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"不确定" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor yellowColor]                               }];
    [[[[[TFActionSheet alloc] initWithTitle:str cancelButtonTitle:str1] addButtonTitle:str2 buttonAction:^{
        NSLog(@"you have click the button, name:%@", str2.string);
    }] addButtonTitle:str3 buttonAction:^{
        NSLog(@"you have click the button, name:%@", str3.string);
    }] show];
}

- (void)action2
{
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"确定" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor grayColor]                               }];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"取消" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blueColor]                               }];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"不确定" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor yellowColor]                               }];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"请完成此操作" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor redColor]                               }];
    [[[[[[TFActionSheet alloc] initWithTitle:nil cancelButtonTitle:str1] addButtonTitle:str2 buttonAction:^{
        NSLog(@"you have click the button, name:%@", str2.string);

    }] addButtonTitle:str3 buttonAction:^{
        NSLog(@"you have click the button, name:%@", str3.string);

    }] addButtonTitle:str4 buttonAction:^{
        NSLog(@"you have click the button, name:%@", str4.string);

    }] show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请完成此请完成此次请完成此次请完成此次次操作" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]                               }];
    
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"哈哈" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor grayColor]                               }];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"哦哦" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blueColor]                               }];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"恩恩" attributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blueColor]                               }];
   [[[[[TFActionSheet alloc] initWithTitle:str cancelButtonTitle:str2] addButtonTitle:str1 buttonAction:^{
       
       NSLog(@"you have click the button, name:%@", str1.string);
       
   }] addButtonTitle:str3 buttonAction:^{
       NSLog(@"you have click the button, name:%@", str3.string);

   }] show];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
