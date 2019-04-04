//
//  JDCategoryRightCollectionCell.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryRightCollectionCell.h"
#import "UIView+Extension.h"
#import "ClassModel.h"
#import <UIImageView+WebCache.h>

@interface JDCategoryRightCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *goodImageView;
@property (nonatomic, retain) UILabel *goodNameLabel;
@end

@implementation JDCategoryRightCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width-25, self.width - 25)];
    self.goodImageView.centerX = self.width/2;
    [self.contentView addSubview:self.goodImageView];
    self.goodImageView.backgroundColor = [UIColor redColor];
    
    self.goodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodImageView.frame), self.width, 20)];
    self.goodNameLabel.textAlignment = NSTextAlignmentCenter;
    _goodNameLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _goodNameLabel.font = FontSize(9);
    [self.contentView addSubview:self.goodNameLabel];
}



@end

@interface JDCategoryRightHeaderView : UICollectionReusableView
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation JDCategoryRightHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, self.width-30, 97)];
//    [self addSubview:imageView];
//    imageView.image = [UIImage imageNamed:@"banner.jpg"];
//
    self.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  0, self.width, 40)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel = titleLabel;
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    [self addSubview:titleLabel];
    
}

@end

@interface JDCategoryRightCollectionCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) JDCategoryRightHeaderView *headerView;

@end

@implementation JDCategoryRightCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat width = ScreenWidth - 100;
    flowLayout.itemSize = CGSizeMake(width/3, width/3);
    flowLayout.headerReferenceSize = CGSizeMake(20, 40);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, ScreenHeight - NavigationHeight) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerClass:NSClassFromString(@"JDCategoryRightCell") forCellWithReuseIdentifier:@"JDCategoryRightCell"];
    [collectionView registerClass:NSClassFromString(@"JDCategoryRightHeaderView")  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JDCategoryRightHeaderView"];
    [self addSubview:collectionView];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JDCategoryRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDCategoryRightCell" forIndexPath:indexPath];
    childModel *model = self.arr[indexPath.row];
    cell.goodNameLabel.text = [NSString stringWithFormat:@"%@", model.title];
    cell.goodImageView.backgroundColor = [UIColor greenColor];
//    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        JDCategoryRightHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JDCategoryRightHeaderView" forIndexPath:indexPath];
        self.headerView = headerView;
        self.headerView.titleLabel.text = self.titleStr;
        return headerView;
    } else {
        return 0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    childModel *model = self.arr[indexPath.row];
    NSLog(@"%@",model.creed_id);
}


- (void)setSectionTitle:(NSString *)sectionTitle {
    self.titleStr = sectionTitle;
    [self.collectionView reloadData];
}

- (void)setCount:(NSInteger)count{
    _count = count;
    [self.collectionView reloadData];
}

@end
