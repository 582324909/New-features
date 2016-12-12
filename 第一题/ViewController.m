//
//  ViewController.m
//  第一题
//
//  Created by brother on 16/1/25.
//  Copyright © 2016年 brother. All rights reserved.
//

#import "ViewController.h"
#import "XDLConstant.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic ,weak) UIPageControl *pageControl;

@end

#define ImageCount 2

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 1; i <= ImageCount; i++) {
        CGFloat imageViewX = (i - 1)* scrollViewW;
        CGFloat imageViewY = 0;
        CGFloat imageViewW = scrollViewW;
        CGFloat imageViewH = scrollViewH;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
        NSString *imageName = [NSString stringWithFormat:@"%02d",i];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(scrollViewW*ImageCount, scrollViewH);
    
    UIPageControl *pageContro = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    CGPoint tempPoint = CGPointMake(scrollViewW/2, scrollViewH*0.9);
    tempPoint.y += 70;
    pageContro.center = tempPoint;
    pageContro.pageIndicatorTintColor = [UIColor blueColor];
    pageContro.currentPageIndicatorTintColor = [UIColor redColor];
    pageContro.numberOfPages = ImageCount;
    self.pageControl = pageContro;
    [self.view addSubview:pageContro];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollView == scrollView) {
        CGFloat contentOffSetX = scrollView.contentOffset.x;
        CGFloat scrollViewW = scrollView.frame.size.width;
        self.pageControl.currentPage = (contentOffSetX + scrollViewW * 0.5) / scrollViewW ;
    }
    if (self.pageControl.currentPage == 1) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*(ImageCount - 0.5 ) - 50, self.view.frame.size.height*0.7, 100, 50)];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"开始体验" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }
}

-(void)enterClick {
    [XDLUserDefault setDouble:[AppVersionStr doubleValue] forKey:@"versionId"];
    [XDLUserDefault synchronize];
    [self performSegueWithIdentifier:@"mainView" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
