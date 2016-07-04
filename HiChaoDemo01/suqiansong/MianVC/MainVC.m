//
//  MainVC.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()<UIScrollViewDelegate>
{
    UIScrollView *_topScrollView;
    UIPageControl *_topPC;
    
    
    
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollVIew;
@property (nonatomic,strong)NSMutableArray *topImageArr;
@property (nonatomic,strong)NSMutableArray *timelimitArr;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTopScrollView];
    [self createTimelimitView];
    
    //scrollView和pageControll的联动定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollViewAndPageControlll) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

#pragma mark----懒加载初始化数组
- (NSMutableArray *)topImageArr {
    
    if (!_topImageArr) {
        
        
        _topImageArr = [NSMutableArray array];
    }
    
    return _topImageArr;
   
}

- (NSMutableArray *)timelimitArr {
    if (!_timelimitArr) {
        
        
        _timelimitArr = [NSMutableArray array];
    }
    
    return _timelimitArr;
    
    
    
}
                                 
#pragma mark------创建顶部的scrollView
- (void)createTopScrollView {
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.frame = CGRectMake(0, 0, kMainBoundsW, 300);
    [_bgScrollVIew addSubview:bgView];
    
    //创建topscroView
    UIScrollView *topScrollView = [[UIScrollView alloc]init];

    topScrollView.frame =CGRectMake(0, 0, kMainBoundsW, 300);
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.delegate = self;
    topScrollView.pagingEnabled = YES;
    [bgView addSubview:topScrollView];
    _topScrollView = topScrollView;
    [SQSRequest sendRequestForMianVcTopScrollViewImage:^(NSArray *imageArray) {
        [self.topImageArr addObjectsFromArray:imageArray];
        topScrollView.contentSize = CGSizeMake(kMainBoundsW *_topImageArr.count +1, 0);
        
        for (NSInteger i = 0; i < imageArray.count + 1; i++) {
            
           UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(kMainBoundsW *i , 0, kMainBoundsW, 300);
            if (i == imageArray.count ) {
                
                [imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_topImageArr[0]] forState:UIControlStateNormal];
            }else {
                
                [imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_topImageArr[i]] forState:UIControlStateNormal];

                
            }
            
            [topScrollView addSubview:imageButton];
            
        }
        UIPageControl *topPC = [[UIPageControl alloc]initWithFrame:CGRectMake(50, 280, 300, 20)];
        topPC.numberOfPages = _topImageArr.count + 1;

        topPC.currentPageIndicatorTintColor = [UIColor redColor];
        [topPC addTarget:self action:@selector(changeTopScrollViewImage) forControlEvents:UIControlEventValueChanged];
        
        [bgView addSubview:topPC];
        _topPC = topPC;
        
    }];
    
  
    
}

#pragma mark-----创建限时抢购模块
- (void)createTimelimitView {
    
    
    [SQSRequest sendRequestForTimelimitInfo:^(NSArray *infoArr) {
        
        [self.timelimitArr addObjectsFromArray:infoArr];
        
        
        for (NSInteger i = 0; i < _timelimitArr.count; i++) {
            
            UIButton *timeLimitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SQSTimelimitModel *modle = self.timelimitArr[i];
           
            [timeLimitButton sd_setBackgroundImageWithURL:[NSURL URLWithString:modle.img_index] forState:UIControlStateNormal];
            timeLimitButton.frame =CGRectMake(10 + (192 + 10) *i, 320, 192, 250);
            
            
            
            
            [_bgScrollVIew addSubview:timeLimitButton];
            
            UILabel *endLabel = [UILabel new];
            endLabel.frame = CGRectMake(20, 50, 60, 30);
            endLabel.text = @"距结束";
            endLabel.font = [UIFont systemFontOfSize:15];
            [timeLimitButton addSubview:endLabel];
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"HH:mm:ss"];
            NSDate *cuuentDate = [NSDate date];
            NSLog(@"%@",cuuentDate);
            
            
        }
        
        
    }];
    
}




#pragma mark------scrollView和pageControlle的联动
- (void)scrollViewAndPageControlll {
    
    static int speed = 0;
    speed++;
    
    if (speed == _topImageArr.count + 1) {
        
        _topScrollView.contentOffset = CGPointMake(0, 0);
        _topPC.currentPage = 0;
        speed = 0;
        
    }else {
        _topPC.currentPage = speed;
        [_topScrollView setContentOffset:CGPointMake(_topPC.currentPage * kMainBoundsW, 0) animated:YES];
        
        }
   
    
    
    }



#pragma mark-----scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _topPC.currentPage = scrollView.contentOffset.x/kMainBoundsW;
    
    
}
#pragma mark-------pageControll的方法
- (void)changeTopScrollViewImage {
    
    
    _topScrollView.contentOffset = CGPointMake(_topPC.currentPage * kMainBoundsW, 0);
    
    
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
