//
//  MainVC.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "MainVC.h"

#define TIMELIMITTGAG 500
@interface MainVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIScrollView *_topScrollView;
    UIPageControl *_topPC;
    UITableView *_goodsTableView;
    UICollectionView *_goodsCollectionView;
    UILabel *_scrollLabel;
    
    
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollVIew;
@property (nonatomic,strong)NSMutableArray *topImageArr;
@property (nonatomic,strong)NSMutableArray *timelimitArr;
@property (nonatomic,strong)NSMutableArray *goodsMessageArr;
@property (nonatomic,strong)NSMutableArray *collectionArr;
@property (nonatomic,strong)NSMutableArray *titleArr;
@property (nonatomic,strong)UIButton *selectedBtn;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
         
    [self createTopScrollView];
    [self createTimelimitView];
    [self createTableView];
    [self createCollectionView];
    
    _selectedBtn = nil;
    
   
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

- (NSMutableArray *)goodsMessageArr {
    if (!_goodsMessageArr) {
        
        _goodsMessageArr = [NSMutableArray array];
        
    }
    return _goodsMessageArr;
    
}
- (NSMutableArray *)collectionArr {
    
    if (!_collectionArr) {
        
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}

- (NSMutableArray *)titleArr {
    
    if (!_titleArr) {
        
        _titleArr =[NSMutableArray array];
    }
    return _titleArr;
}
                                 
#pragma mark------创建顶部的scrollView
- (void)createTopScrollView {
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.frame = CGRectMake(0, 0, kMainBoundsW, 300);
    [_bgScrollVIew addSubview:bgView];
    
    _bgScrollVIew.delegate = self;
    _bgScrollVIew.showsVerticalScrollIndicator = NO;
    
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
    
    //scrollView和pageControll的联动定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollViewAndPageControlll) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

  
    
}

#pragma mark-----创建限时抢购模块
- (void)createTimelimitView {
    
    
    [SQSRequest sendRequestForTimelimitInfo:^(NSArray *infoArr) {
        
        [self.timelimitArr addObjectsFromArray:infoArr];
        
        
        for (NSInteger i = 0; i < _timelimitArr.count; i++) {
            
            UIButton *timeLimitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            SQSTimelimitModel *modle = self.timelimitArr[i];
           
            [timeLimitButton sd_setBackgroundImageWithURL:[NSURL URLWithString:modle.img_index] forState:UIControlStateNormal];
            timeLimitButton.frame =CGRectMake(10 + (kMainBoundsW-30)/2 *i, 320, (kMainBoundsW-30)/2, 250);
            timeLimitButton.tag = TIMELIMITTGAG +i;
            
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


#pragma mark--------创建限购模块下的tableVi
- (void)createTableView {
    

    [SQSRequest sendRequestFroGoodsMessage:^(NSArray *messageArr) {
        
        [self.goodsMessageArr addObjectsFromArray:messageArr];
                       
        [_goodsTableView reloadData];
        
    }];
    
    
    
    
    UITableView *goodsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 580, kMainBoundsW, kMainBoundsH) style:UITableViewStyleGrouped];
    
    
    goodsTableView.dataSource = self;
    goodsTableView.delegate = self;
    goodsTableView.showsVerticalScrollIndicator = NO;
    goodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [goodsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [_bgScrollVIew addSubview:goodsTableView];
    
    _goodsTableView = goodsTableView;
    
   
    
}

#pragma mark-------创建最下面的CollectionView
- (void)createCollectionView {
    
    [SQSRequest sendRequestFroCollectionViewData:^(NSArray *dataArr) {
        
        [self.collectionArr addObjectsFromArray:dataArr];
        
        
        [_goodsCollectionView reloadData];
    }];
    
    [SQSRequest sendRequestFrocollectionViewHeaderTitile:^(NSArray *titleArr) {
        
        [self.titleArr addObjectsFromArray:titleArr];
        
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    UICollectionView *goodsCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_goodsTableView.frame) + 20, kMainBoundsW, kMainBoundsH) collectionViewLayout:layout];
    goodsCollectionView.dataSource = self;
    goodsCollectionView.delegate =self;
    goodsCollectionView.backgroundColor = [UIColor whiteColor];
    goodsCollectionView.showsVerticalScrollIndicator = NO;
    [goodsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"coll"];
    
    [goodsCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [_bgScrollVIew addSubview:goodsCollectionView];
    _goodsCollectionView = goodsCollectionView;
    
     _bgScrollVIew.contentSize = CGSizeMake(kMainBoundsW, CGRectGetMaxY(goodsCollectionView.frame));
    
    
}

#pragma mark------collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    
    return _collectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coll" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
    }
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kMainBoundsW - 10)/2, 250)];
    [cell.contentView addSubview:bgView];
    
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.frame = CGRectMake(0, 0, (kMainBoundsW - 10)/2, 180);
    SQSComponent *model = _collectionArr[indexPath.row];
    NSString *picUrl =[[model.picUrl componentsSeparatedByString:@"?"] firstObject];
    [pictureBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:picUrl] forState:UIControlStateNormal];
    [bgView addSubview:pictureBtn];
    
    UIImageView *countryPic = [[UIImageView alloc]initWithFrame: CGRectMake(10, CGRectGetMaxY(pictureBtn.frame), 30, 30)];
    
    [countryPic sd_setImageWithURL:[NSURL URLWithString:model.nationalFlag]];
    [bgView addSubview:countryPic];
    
    UILabel *countryName =[[UILabel alloc]initWithFrame:CGRectMake(45, CGRectGetMaxY(pictureBtn.frame), 60, 30)];
    countryName.text = model.country;
    countryName.textColor = [UIColor grayColor];
    [bgView addSubview:countryName];
    
    UILabel *goodsDescription = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(countryPic.frame) , pictureBtn.frame.size.width, 30)];
    goodsDescription.text = model.componentDescription;
    [bgView addSubview:goodsDescription];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(goodsDescription.frame), 80, 30)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    priceLabel.textColor = [UIColor redColor];
    [bgView addSubview:priceLabel];
    
    
    UILabel *origionPreceLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(goodsDescription.frame) + 5, 100, 20)];
    origionPreceLabel.text = [NSString stringWithFormat:@"￥%@",model.originPrice];
    origionPreceLabel.textColor = [UIColor grayColor];
    origionPreceLabel.font = [UIFont systemFontOfSize:10];
    [bgView addSubview:origionPreceLabel];
    
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((kMainBoundsW-15)/2, 300);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
    return UIEdgeInsetsMake(10, 0, 10, 0);
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    for (UIView *view1 in view.subviews) {
        
        [view1 removeFromSuperview];
    }
    
    
    for (NSInteger i =0; i < 4; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20 +(kMainBoundsW - 40)/4 * i, 10,80, 30);
        
        SQSItems *model = _titleArr[i];
        [btn setTitle:model.navName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(collectionViewTitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
    }
    
    UILabel *scrollLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, kMainBoundsW/4, 3)];
    scrollLabel.backgroundColor =[UIColor redColor];
    [view addSubview:scrollLabel];
    _scrollLabel = scrollLabel;
    
    
    return  view;
    
}

#pragma mark------collectionView的头的点击方法
- (void)collectionViewTitleClick:(UIButton *)sender {
    
    
    _selectedBtn.selected = NO;
    sender.selected = YES;
    
    
      
       _scrollLabel.center = CGPointMake(sender.center.x, 52);
    
    _selectedBtn = sender;
    
    
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    return CGSizeMake(kMainBoundsH, 60);
}




#pragma mark------tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    
    
    
    return _goodsMessageArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 100;
            break;
        case 1:
            return 300;
            break;
        case 2:
            return 180;
            break;
            
        default:
            return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 100;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame =CGRectMake(0, 0, kMainBoundsW, 0);
    
      RegionModel *model =_goodsMessageArr[section];
    
    
    [headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.region_name[0]] forState:UIControlStateNormal];
    
    return headerBtn;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 100)];
    [cell.contentView addSubview:bgView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    switch (indexPath.row) {
        case 0:
            
        {
            
            
            UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 100)];
            bgScrollView.showsHorizontalScrollIndicator = NO;
            [bgView addSubview:bgScrollView];
            
            RegionModel *model =_goodsMessageArr[indexPath.section];
            for (int i =0; i < model.region_brands.count; i++) {
                
                UIButton *brandsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                brandsBtn.frame = CGRectMake(10+(120+10)*i, 20, 120, 60);
                [brandsBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.region_brands[i]] forState:UIControlStateNormal];
                [bgScrollView addSubview:brandsBtn];
                
                
            }
            bgScrollView.contentSize = CGSizeMake(130*model.region_brands.count, 0);
            
            
            
            break;
        }
        case 1:
        {
            
            
            UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 300)];
            bgScrollView.pagingEnabled = YES;
            bgScrollView.showsHorizontalScrollIndicator = NO;
            [bgView addSubview:bgScrollView];
            
            RegionModel *model =_goodsMessageArr[indexPath.section];
           
            for (int i =0; i < model.region_pictures.count; i++) {
                
                UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                pictureBtn.frame = CGRectMake(kMainBoundsW * i, 0, kMainBoundsW, 300);
                [pictureBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.region_pictures[i]] forState:UIControlStateNormal];
                [bgScrollView addSubview:pictureBtn];
                
                
            }
            bgScrollView.contentSize = CGSizeMake(kMainBoundsW * model.region_brands.count, 0);
            
            
            break;
        }

        case 2:
        {
            
            
            UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 180)];
            bgScrollView.pagingEnabled = YES;
            bgScrollView.showsHorizontalScrollIndicator = NO;
            [bgView addSubview:bgScrollView];
            
            RegionModel *model =_goodsMessageArr[indexPath.section];
            
            for (int i =0; i < model.region_skus.count; i++) {
                
                UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                pictureBtn.frame = CGRectMake(10+(100 +10) * i, 0, 100, 100);
                GoodsMessageModel *goodsModle =model.region_skus[i];
                [pictureBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:goodsModle.picUrl] forState:UIControlStateNormal];
                [bgScrollView addSubview:pictureBtn];
                
                UILabel *origin_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 120, 30)];
                origin_priceLabel.text = [NSString stringWithFormat:@"现价:￥%@",goodsModle.price];
                origin_priceLabel.textColor = [UIColor redColor];
                [pictureBtn addSubview:origin_priceLabel];
                
                UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 135, 120, 30)];
                priceLabel.font = [UIFont systemFontOfSize:14];
                priceLabel.text = [NSString stringWithFormat:@"原价:￥%@",goodsModle.origin_price];
                priceLabel.textColor = [UIColor lightGrayColor];
                [pictureBtn addSubview:priceLabel];

                
                
                
            }
            bgScrollView.contentSize = CGSizeMake(150j * model.region_brands.count, 0);
            
            
            break;
        }

        default:
            break;
    }
    
    return cell;
    
}





#pragma mark-----解决tableView的滑动与底层scrollView的滑动冲突问题
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (scrollView == _bgScrollVIew) {
        
        
        UIButton *btn = [_bgScrollVIew viewWithTag:TIMELIMITTGAG ];
        
        if (_bgScrollVIew.contentOffset.y < CGRectGetHeight(btn.frame)) {
            
            _goodsTableView.userInteractionEnabled = NO;
            
        }else {
            
             _goodsTableView.userInteractionEnabled = YES;
            
        }
        
    }
    
    
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
    
    if (scrollView ==_topScrollView) {
        _topPC.currentPage = scrollView.contentOffset.x/kMainBoundsW;
    }
    
    
    
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
