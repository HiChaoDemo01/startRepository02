//
//  QHJCusTableViewCell.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "QHJCusTableViewCell.h"

@interface QHJCusTableViewCell ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic)UIScrollView *picsScroll;
@property(strong,nonatomic)UIPageControl *pageControl;
@property(strong,nonatomic)UIImageView *userPic;
@property(strong,nonatomic)UILabel *nameLab,*timeLab,*contentLab,*tagLab;

@end

@implementation QHJCusTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}
-(void)createView
{
    _bgView=[[UIView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_bgView];
    UIImageView *userPic=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 34, 34)];
    userPic.layer.cornerRadius=17;
    userPic.layer.masksToBounds=YES;
    [userPic sd_setImageWithURL:[NSURL URLWithString:self.model.avatarModel.userAvatar]];
    [_bgView addSubview:userPic];
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 80, 20)];
    nameLab.text=self.model.userName;
    nameLab.font=[UIFont systemFontOfSize:12];
    [_bgView addSubview:nameLab];
    
    UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 15)];
    timeLab.textColor=[UIColor grayColor];
    timeLab.font=[UIFont systemFontOfSize:10];
    timeLab.text=self.model.datatime;
    [_bgView addSubview:timeLab];
    
    UIButton *attentionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn.center=CGPointMake(kMainBoundsW-10-35, userPic.center.y);
    attentionBtn.bounds=CGRectMake(0, 0, 70, 30);
    attentionBtn.backgroundColor=[UIColor redColor];
    [attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    attentionBtn.layer.cornerRadius=5;
    attentionBtn.layer.masksToBounds=YES;
    [_bgView addSubview:attentionBtn];
    
    UIScrollView *picsScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, attentionBtn.frame.origin.y+attentionBtn.size.height+10, kMainBoundsW, 400)];
    for (int i=0; i<self.model.pics.count; i++) {
        UIImageView *scrollImg=[UIImageView new];
        [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.model.pics[i]]];
        scrollImg.frame=CGRectMake(kMainBoundsW*i, 0, kMainBoundsW, 400);
        [picsScroll addSubview:scrollImg];
    }
    picsScroll.contentSize=CGSizeMake(kMainBoundsW*self.model.pics.count, 400);
    picsScroll.pagingEnabled=YES;
    picsScroll.delegate=self;
    [_bgView addSubview:picsScroll];
    _picsScroll=picsScroll;
    
    if (self.model.pics.count>1) {
        UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(picsScroll.frame.origin.x+picsScroll.size.width-50, picsScroll.frame.origin.y+picsScroll.frame.size.height-40, 50, 40)];
        pageControl.numberOfPages=self.model.pics.count;
        pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        [_bgView addSubview:pageControl];
        _pageControl=pageControl;
    }
    
    UILabel *contentLab=[UILabel new];
    contentLab.numberOfLines=0;
    contentLab.text=self.model.content;
    contentLab.font=[UIFont systemFontOfSize:15];
    CGSize size=[contentLab sizeThatFits:CGSizeMake(kMainBoundsW, 0)];
    if (size.height<=100) {
        contentLab.frame=CGRectMake(10, picsScroll.frame.origin.y+picsScroll.size.height+10, kMainBoundsW, size.height);
    }
    else
    {
        contentLab.frame=CGRectMake(10, picsScroll.frame.origin.y+picsScroll.size.height+10, kMainBoundsW, 100);
    }
    [_bgView addSubview:contentLab];
    
    UILabel *tagLabe=[[UILabel alloc]initWithFrame:CGRectMake(10, contentLab.frame.origin.y+contentLab.size.height+5, 30, 20)];
    tagLabe.text=@"标签";
    tagLabe.textColor=[UIColor grayColor];
    tagLabe.font=[UIFont systemFontOfSize:13];
    [_bgView addSubview:tagLabe];

}
-(void)setModel:(CommunityTableDataModel *)model
{
    _model=model;
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _bgView=[[UIView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_bgView];
    UIImageView *userPic=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 34, 34)];
    userPic.layer.cornerRadius=17;
    userPic.layer.masksToBounds=YES;
    [userPic sd_setImageWithURL:[NSURL URLWithString:self.model.avatarModel.userAvatar]];
    [_bgView addSubview:userPic];
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 80, 20)];
    nameLab.text=self.model.userName;
    nameLab.font=[UIFont systemFontOfSize:12];
    [_bgView addSubview:nameLab];
    
    UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 15)];
    timeLab.textColor=[UIColor grayColor];
    timeLab.font=[UIFont systemFontOfSize:10];
    timeLab.text=self.model.datatime;
    [_bgView addSubview:timeLab];
    
    UIButton *attentionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn.center=CGPointMake(kMainBoundsW-10-35, userPic.center.y);
    attentionBtn.bounds=CGRectMake(0, 0, 70, 30);
    attentionBtn.backgroundColor=[UIColor redColor];
    [attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    attentionBtn.layer.cornerRadius=5;
    attentionBtn.layer.masksToBounds=YES;
    [_bgView addSubview:attentionBtn];
    
    UIScrollView *picsScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, attentionBtn.frame.origin.y+attentionBtn.size.height+10, kMainBoundsW, 400)];
    for (int i=0; i<self.model.pics.count; i++) {
        UIImageView *scrollImg=[UIImageView new];
        [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.model.pics[i]]];
        scrollImg.frame=CGRectMake(kMainBoundsW*i, 0, kMainBoundsW, 400);
        [picsScroll addSubview:scrollImg];
    }
    picsScroll.contentSize=CGSizeMake(kMainBoundsW*self.model.pics.count, 400);
    picsScroll.pagingEnabled=YES;
    picsScroll.delegate=self;
    [_bgView addSubview:picsScroll];
    _picsScroll=picsScroll;
    
    if (self.model.pics.count>1) {
        UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(picsScroll.frame.origin.x+picsScroll.size.width-50, picsScroll.frame.origin.y+picsScroll.frame.size.height-40, 50, 40)];
        pageControl.numberOfPages=self.model.pics.count;
        pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        [_bgView addSubview:pageControl];
        _pageControl=pageControl;
    }
    
    UILabel *contentLab=[UILabel new];
    contentLab.numberOfLines=0;
    contentLab.text=self.model.content;
    contentLab.font=[UIFont systemFontOfSize:15];
    CGSize size=[contentLab sizeThatFits:CGSizeMake(kMainBoundsW, 0)];
    if (size.height<=100) {
        contentLab.frame=CGRectMake(10, picsScroll.frame.origin.y+picsScroll.size.height+10, kMainBoundsW, size.height);
    }
    else
    {
    contentLab.frame=CGRectMake(10, picsScroll.frame.origin.y+picsScroll.size.height+10, kMainBoundsW, 100);
    }
    [_bgView addSubview:contentLab];
    
    UILabel *tagLabe=[[UILabel alloc]initWithFrame:CGRectMake(10, contentLab.frame.origin.y+contentLab.size.height+5, 30, 20)];
    tagLabe.text=@"标签";
    tagLabe.textColor=[UIColor grayColor];
    tagLabe.font=[UIFont systemFontOfSize:13];
    [_bgView addSubview:tagLabe];
    
}
#pragma mark--移除cell上的所有子视图，再创建新的子视图
-(void)removeView
{
    [_bgView removeFromSuperview];
    _bgView=nil;
    [self setNeedsLayout];
}
#pragma mark--scroll和pageControl的联动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage=scrollView.contentOffset.x/kMainBoundsW;
}
@end
