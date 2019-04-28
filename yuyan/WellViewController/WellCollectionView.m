//
//  WellCollectionView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "WellCollectionView.h"
#import "WellModel.h"
#import "Tools.h"
#import <UIImageView+WebCache.h>
#import "UIView+CornerRadiusLayer.h"


@interface WellCollectionCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *ticket;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *xintiao;

@end

@implementation WellCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSub];
        [self.contentView setLayerCornerRadius:0 borderWidth:1 borderColor:[UIColor colorWithHexString:@"#F7F7F7"]];
    }
    return self;
}

- (void)createSub{
    if (!_ticket) {
        _ticket = [UIImageView new];
        [self.contentView addSubview:_ticket];
        _ticket.whc_CenterX(0).whc_LeftSpace(12).whc_RightSpace(12).whc_Height(74 *ScaleHeight).whc_TopSpace(20);
    }
    if (!_name) {
        _name = [UILabel new];
        [self.contentView addSubview:_name];
        _name.whc_LeftSpace(12).whc_TopSpaceToView(13, _ticket);
        _name.textColor = [UIColor textColorWithType:0];
        _name.font = FontSize(15);
    }
    if (!_xintiao) {
        _xintiao = [UILabel new];
        [self.contentView addSubview:_xintiao];
        _xintiao.whc_TopSpaceToView(5, _name).whc_LeftSpace(12);
        _xintiao.textColor = [UIColor colorWithHexString:@"#999999"];
        _xintiao.font = FontSize(12);
    }
}
@end

@interface WellCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation WellCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[WellCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WellCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WellModel *model = self.arr[indexPath.row];
    cell.name.text = model.title;
    [cell.ticket sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    NSRange range = NSMakeRange(0,[model.creed_price length]);
    cell.xintiao.attributedText = [Tools text:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@雨燕币",model.creed_price]] fontSize:14 color:[UIColor colorWithHexString:@"#FF6000"] rang:range];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     WellModel *model = self.arr[indexPath.row];
    if (_wellDelegate && [_wellDelegate respondsToSelector:@selector(send:)]) {
        [_wellDelegate send:model.goods_id];
    }
}

@end
