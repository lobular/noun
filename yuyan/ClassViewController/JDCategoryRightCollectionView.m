//
//  JDCategoryRightCollectionView.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryRightCollectionView.h"
#import "JDCategoryRightCollectionCell.h"
#import "ClassModel.h"

@interface JDCategoryRightCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource,rightDelegate>

@end


@implementation JDCategoryRightCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[JDCategoryRightCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JDCategoryRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ClassModel *model = self.fatherArr[indexPath.row];
    cell.delegate = self;
    cell.sectionTitle = [NSString stringWithFormat:@"%@", model.title];
    NSArray *arr = self.childArr[indexPath.row];
    cell.count = arr.count;
    cell.arr = arr;
    return cell;
}

- (void)sendWhich:(childModel *)model{
    _value(model);
}


@end
