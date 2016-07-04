//
//  CommunityVC.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 surker. All rights reserved.
//

typedef enum : NSUInteger {
    topScrollImage_firstImage,
    topScrollImage_secondImage,
    topScrollImage_threeImage,
} topScrollImage;

typedef enum : NSUInteger {
    chooseBtn_trend,
    chooseBtn_attention,/**关注**/
    chooseBtn_favourite,/**红人**/
} chooseBtn;

#import "CommunityVC.h"

@interface CommunityVC ()<UIScrollViewDelegate>
{
    int offset;
}
@property(nonatomic,strong)NSMutableArray *scrollDataArr;
@property(strong,nonatomic)UIScrollView *topScroll;
@property(strong,nonatomic)UIPageControl *pageControl;
@property(strong,nonatomic)NSTimer *timer;
@end

@implementation CommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getScrollDataArr];
    
}
#pragma mark - 创建顶部scrollView
-(void)createScrollView
{
    UIView *view=[UIView new];
    [self.view addSubview:view];
    UIScrollView *topScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW, 220)];
    for (int i=0; i<self.scrollDataArr.count+1; i++) {
       
        UIButton *scrollImageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        scrollImageBtn.frame=CGRectMake(kMainBoundsW*i, 0, kMainBoundsW, 220);
        if (i==self.scrollDataArr.count) {
            CommunityScrollDataModel *model=self.scrollDataArr[0];
            [scrollImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.picUrl] forState:UIControlStateNormal];
            [scrollImageBtn addTarget:self action:@selector(chooseScrollImage:) forControlEvents:UIControlEventTouchUpInside];
            [topScroll addSubview:scrollImageBtn];
            scrollImageBtn.tag=topScrollImage_firstImage;
            break;
        }
        CommunityScrollDataModel *model=self.scrollDataArr[i];
        [scrollImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.picUrl] forState:UIControlStateNormal];
        [scrollImageBtn addTarget:self action:@selector(chooseScrollImage:) forControlEvents:UIControlEventTouchUpInside];
        scrollImageBtn.tag=topScrollImage_firstImage+i;
        [topScroll addSubview:scrollImageBtn];
    }
    topScroll.delegate=self;
    topScroll.backgroundColor=[UIColor grayColor];
    topScroll.contentSize=CGSizeMake(kMainBoundsW*(self.scrollDataArr.count+1), 220);
    topScroll.pagingEnabled=YES;
    topScroll.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:topScroll];
    _topScroll=topScroll;
    UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 244, kMainBoundsW, 40)];
    pageControl.numberOfPages=self.scrollDataArr.count;
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    [self.view addSubview:pageControl];
//    [pageControl addTarget:self action:@selector(changePageControl:) forControlEvents:UIControlEventValueChanged];
    _pageControl=pageControl;
}
#pragma mark--创建tableView
-(void)createTableView
{
    for (int i=0; i<3; i++) {
        UIButton *chooseBtn=[UIButton buttonWithType:UIButtonTypeSystem];
//        chooseBtn.tag
    }
}
#pragma mark--获取顶部scrollView的数据并绘制
-(void)getScrollDataArr
{
    if (!_scrollDataArr) {
        _scrollDataArr=[NSMutableArray new];
    }
    [_scrollDataArr removeAllObjects];
    [QHJRequestDataTools requestDataWithUrl:@"http://api-v2.mall.hichao.com/forum/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token=" andWith:^(NSArray *returnValue) {
        [_scrollDataArr addObjectsFromArray:returnValue];
        [self createScrollView];
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(changeScrollImg) userInfo:nil repeats:YES];
        }];
}
#pragma mark--选择scrollView上的image
-(void)chooseScrollImage:(UIButton *)sender
{
   
}
#pragma mark--topScrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage=scrollView.contentOffset.x/kMainBoundsW;
    if (scrollView.contentOffset.x==kMainBoundsW*self.scrollDataArr.count) {
        scrollView.contentOffset=CGPointMake(0, 0);
        _pageControl.currentPage=0;
    }
}
#pragma mark--定时器
-(void)changeScrollImg
{
    if (offset==self.scrollDataArr.count+1) {
        _topScroll.contentOffset=CGPointMake(0, 0);
        offset=0;
    }
    offset+=1;
    
    [_topScroll setContentOffset:CGPointMake(kMainBoundsW*offset, 0) animated:YES];
    if (offset==self.scrollDataArr.count+1) {
        _pageControl.currentPage=0;
        return;
        
    }
    _pageControl.currentPage=offset-1;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
