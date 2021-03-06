//
//  MyCardViewController.m
//  SoftCard803
//
//  Created by apple on 15/3/12.
//  Copyright (c) 2015年 iOSlearning. All rights reserved.
//

#import "MyCardViewController.h"

#import "MyDetailViewController.h"
#import "ContactInfo.h"
#import "Common.h"
#import "TheIconStore.h"
#import "TheMasterStore.h"
#import "BaseWebViewController.h"
@interface MyCardViewController ()

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *jobDescriptionLabel;

@property(nonatomic, strong)UIButton *telePhoneButton;
@property(nonatomic, strong)UIButton *mailAddressButton;

@property(nonatomic, strong)UIButton *link1Button;
@property(nonatomic, strong)UIButton *link2Button;
@property(nonatomic, strong)UIButton *link3Button;
@property(nonatomic, strong)UIButton *link4Button;

@property(nonatomic, strong)UIWebView *webView;


@end

@implementation MyCardViewController

@synthesize nameLabel, jobDescriptionLabel, telePhoneButton, mailAddressButton, link1Button, link2Button, link3Button, link4Button, webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat orginX;
    CGFloat orginY;
    CGFloat width;
    CGFloat height;
    
    if(IS_IPHONE_6_SCREEN){
        width = 375;
        height = 50;
        orginX = 0;
        orginY = 150;
        
    }else{
        width = SCREEN_WIDTH;
        height = 50;
        orginX = 0;
        orginY = 150;
    }
    
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    
    
    //最好在传值的时候就设定好item.link的属性是符合http://"的
    
    NSURL *url1 = [NSURL URLWithString:item.link1Address];
    NSURL *url2 = [NSURL URLWithString:item.link2Address];
    NSURL *url3 = [NSURL URLWithString:item.link3Address];
    NSURL *url4 = [NSURL URLWithString:item.link4Address];
    
    NSDictionary *dict = [[TheIconStore defaultStore]dictionary];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(orginX, orginY, width, height)];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    
    [nameLabel setFont:[UIFont systemFontOfSize:55.0]];
    //
    nameLabel.text = item.name;
    [self.view addSubview:nameLabel];
    
    
    orginY += height + 10;
    jobDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(orginX, orginY, width, height)];
    [jobDescriptionLabel setFont:[UIFont systemFontOfSize:17.0]];
    //设置内容居中
    [jobDescriptionLabel setTextAlignment:NSTextAlignmentCenter];
    jobDescriptionLabel.text = item.jobDescription;
    [self.view addSubview:jobDescriptionLabel];
    
    if(IS_IPHONE_6_SCREEN) {
        orginX = 85 + 27.5;
        orginY += 20 + height;
        width = 45;
        height = 45;
    }else{
        orginX = 85;
        orginY += 20 + height;
        width = 45;
        height = 45;
        
    }
    
    UIImage *image = [UIImage imageNamed:@"phone_background.png"];;
    telePhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [telePhoneButton setFrame:CGRectMake(orginX, orginY, width, height)];
    [telePhoneButton setBackgroundImage:image forState:UIControlStateNormal];
    [telePhoneButton addTarget:self action:@selector(callPeople:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telePhoneButton];
    
    orginX += width +60;
    image = [UIImage imageNamed:@"mail_background.png"];
    mailAddressButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [mailAddressButton setFrame:CGRectMake(orginX, orginY, width, height)];
    [mailAddressButton setBackgroundImage:image forState:UIControlStateNormal];
    [mailAddressButton addTarget:self action:@selector(mailPeople:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailAddressButton];
    
    
    
    
    if(IS_IPHONE_6_SCREEN) {
        orginX = 67.5;
        orginY += 94 + height;
        width = 30;
        height = 30;
        
    }else{
        orginX = 40;
        orginY += 64 + height;
        width = 30;
        height = 30;
    }
    image = [dict objectForKey:url1.host];
    
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    
    link1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [link1Button setFrame:CGRectMake(orginX, orginY, width, height)];
    
    [link1Button setBackgroundImage:image forState:UIControlStateNormal];
    [link1Button addTarget:self action:@selector(openLink1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:link1Button];
    
    orginX += 40 + width;
    image = [dict objectForKey:url2.host];
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    
    link2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [link2Button setFrame:CGRectMake(orginX, orginY, width, height)];
    [link2Button setBackgroundImage:image forState:UIControlStateNormal];
    [link2Button addTarget:self action:@selector(openLink2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:link2Button];
    
    image = [dict objectForKey:url3.host];
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    
    orginX += 40 + width;
    link3Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [link3Button setFrame:CGRectMake(orginX, orginY, width, height)];
    [link3Button setBackgroundImage:image forState:UIControlStateNormal];
    [link3Button addTarget:self action:@selector(openLink3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:link3Button];
    
    image = [dict objectForKey:url4.host];
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    
    orginX  += 40 + width;
    link4Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [link4Button setFrame:CGRectMake(orginX, orginY, width, height)];
    [link4Button setBackgroundImage:image forState:UIControlStateNormal];
    [link4Button addTarget:self action:@selector(openLink4:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:link4Button];
    
    //右侧按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editMyItem:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //左侧按钮
    /*
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
     */
    
}


-(void)editMyItem:(id)sender{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    MyDetailViewController *controller = [[MyDetailViewController alloc] init];
    [controller setHidesBottomBarWhenPushed:YES];
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
/*
-(void)login:(id)sender{
    
}
*/
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        UIImage *tabImage = [UIImage imageNamed:@"我的"];
        UITabBarItem *tbrItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:tabImage tag:1];
        self.tabBarItem = tbrItem;
        
        self.tabBarItem = tbrItem;
    }
    return self;
}


-(void)callPeople:(id)sender{
    if(webView == nil){
        webView = [[UIWebView alloc] init];
    }
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    if(item.telePhoneNumber.length > 0){
        
        NSString *target = [NSString stringWithFormat:@"tel://%@",item.telePhoneNumber];
        NSURL *url = [NSURL URLWithString:target];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }
}

-(void)mailPeople:(id)sender{
    
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    if(item.mailAddress.length > 0){
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        if([MFMailComposeViewController canSendMail]){
            
            [controller setToRecipients:@[item.mailAddress]];
            
            controller.mailComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)openLink1:(id)sender{
    BaseWebViewController *controller = [[BaseWebViewController alloc]init];
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    
    NSString *target = [NSString stringWithFormat:@"%@",item.link1Address];
    if(item.link1Address.length > 7){
        
        NSURL *url = [NSURL URLWithString:target];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[controller webView]loadRequest:request];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void)openLink2:(id)sender{
    BaseWebViewController *controller = [[BaseWebViewController alloc]init];
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    
    NSString *target = [NSString stringWithFormat:@"%@",item.link2Address];
    if(item.link2Address.length > 7){
        NSURL *url = [NSURL URLWithString:target];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[controller webView]loadRequest:request];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void)openLink3:(id)sender{
    BaseWebViewController *controller = [[BaseWebViewController alloc]init];
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    
    NSString *target = [NSString stringWithFormat:@"%@",item.link3Address];
    if(item.link3Address.length > 7){
        NSURL *url = [NSURL URLWithString:target];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[controller webView]loadRequest:request];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void)openLink4:(id)sender{
    BaseWebViewController *controller = [[BaseWebViewController alloc]init];
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    
    NSString *target = [NSString stringWithFormat:@"%@",item.link4Address];
    if(item.link4Address.length > 7){
        NSURL *url = [NSURL URLWithString:target];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[controller webView]loadRequest:request];
        [self presentViewController:controller animated:YES completion:nil];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    nameLabel.text = [[[TheMasterStore defaultStore]item]name];
    jobDescriptionLabel.text = [[[TheMasterStore defaultStore] item]jobDescription];
    
    ContactInfo *item = [[TheMasterStore defaultStore]item];
    NSURL *url1 = [NSURL URLWithString:item.link1Address];
    NSURL *url2 = [NSURL URLWithString:item.link2Address];
    NSURL *url3 = [NSURL URLWithString:item.link3Address];
    NSURL *url4 = [NSURL URLWithString:item.link4Address];
    
    NSDictionary *dict = [[TheIconStore defaultStore]dictionary];
    
    UIImage *image;
    image = [dict objectForKey:url1.host];
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    [link1Button setBackgroundImage:image forState:UIControlStateNormal];
    //
    image = [dict objectForKey:url2.host];
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    [link2Button setBackgroundImage:image forState:UIControlStateNormal];
    //
    image = [dict objectForKey:url3.host];
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    [link3Button setBackgroundImage:image forState:UIControlStateNormal];
    
    image = [dict objectForKey:url4.host];
    if(!image){
        image = [UIImage imageNamed:@"nil.png"];
    }
    [link4Button setBackgroundImage:image forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
