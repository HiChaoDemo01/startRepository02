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
#import "QHJCusTableViewCell.h"
@interface CommunityVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int offset;
    UIButton *haveChoosenBtn;
}
@property(nonatomic,strong)NSMutableArray *scrollDataArr;
@property(strong,nonatomic)UIScrollView *topScroll;
@property(strong,nonatomic)UIPageControl *pageControl;
@property(strong,nonatomic)NSTimer *timer;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *tableDataArr;
@property(strong,nonatomic)UIView *sildeTwig;
@end

@implementation CommunityVC
#pragma mark--视图将要出现时开启定时器
-(void)viewWillAppear:(BOOL)animated
{
    [_timer setFireDate:[NSDate distantPast]];
}
#pragma mark--视图消失时关闭定时器
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_timer setFireDate:[NSDate distantFuture]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
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
    _pageControl=pageControl;
}
#pragma mark--创建tableView
-(void)createTableView
{

    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+_topScroll.size.height, kMainBoundsW, kMainBoundsH-64-_topScroll.size.height) style:UITableViewStylePlain];
    table.backgroundColor=[UIColor grayColor];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    _tableView=table;
    [_tableView registerClass:[QHJCusTableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark--获取数据
-(void)getData
{
    if (!_scrollDataArr) {
        _scrollDataArr=[NSMutableArray new];
    }
    [_scrollDataArr removeAllObjects];
    [QHJRequestDataTools requestDataWithUrl:@"http://api-v2.mall.hichao.com/forum/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token=" andWith:^(NSArray *returnValue) {
        [_scrollDataArr addObjectsFromArray:returnValue];
        [self createScrollView];
        _timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeScrollImg) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        }];
    if (!_tableDataArr) {
        _tableDataArr=[NSMutableArray new];
    }
    [_tableDataArr removeAllObjects];
    [QHJRequestDataTools requestTableViewDataWithUrl:@"http://api-v2.mall.hichao.com/forum/timeline?nav_id=5&nav_name=%E7%83%AD%E9%97%A8&flag=&user_id=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token=" andWith:^(NSMutableArray *returnValue) {
        [_tableDataArr addObjectsFromArray:returnValue];
        [self createTableView];
    }];
    
}
#pragma mark--选择分类的button点击事件
-(void)chooseCategory:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        _sildeTwig.center=CGPointMake(sender.center.x, _sildeTwig.center.y);
    } completion:nil];
    [haveChoosenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorWithRed:255/255.0 green:0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    haveChoosenBtn=sender;
    
}
#pragma mark--tableView的区头设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 45)];
        NSArray *btnTitle=@[@"热门",@"关注",@"红人"];
        for (int i=0; i<3; i++) {
            UIButton *chooseBtn=[UIButton buttonWithType:0];
            chooseBtn.tag=chooseBtn_trend+i;
            [chooseBtn setTitle:btnTitle[i] forState:UIControlStateNormal];
            chooseBtn.frame=CGRectMake(kMainBoundsW/3*i, 5, kMainBoundsW/3, 35);
            
            [chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           
            chooseBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            
            [chooseBtn addTarget:self action:@selector(chooseCategory:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:chooseBtn];
        }
    UIView *slideTwig=[[UIView alloc]initWithFrame:CGRectMake(0, 42, kMainBoundsW/3, 3)];
    slideTwig.backgroundColor=[UIColor colorWithRed:1 green:0 blue:102/255.0 alpha:1];
    [headerView addSubview:slideTwig];
    _sildeTwig=slideTwig;
    return headerView;
    
}

#pragma mark--tableView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArr.count;
}
#pragma mark--设置区头高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
#pragma mark--设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}
#pragma mark--设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QHJCusTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model=self.tableDataArr[indexPath.row];
    [cell removeView];
    return cell;
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
    
    if (offset==self.scrollDataArr.count) {
        _topScroll.contentOffset=CGPointMake(0, 0);
        offset=0;
        _pageControl.currentPage=0;
    }
    offset+=1;
    [_topScroll setContentOffset:CGPointMake(kMainBoundsW*offset, 0) animated:YES];
    _pageControl.currentPage=offset;
    
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
