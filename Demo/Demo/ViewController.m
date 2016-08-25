//
//  ViewController.m
//  Demo
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "ViewController.h"
#import "XYFeedCell.h"
#import "XYHeaderView.h"
#import "XYFeedModel.h"
#import "UICollectionView+XYTemplateLayoutCell.h"
#import "UICollectionView+XYTemplateReusableView.h"

#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width
static NSString * const kXYFeedCell = @"XYFeedCell";
static NSString * const kXYHeaderView = @"XYHeaderView";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (retain, nonatomic) NSArray *data;
@property (nonatomic, copy) NSString *headerTitle;
@end

@implementation ViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"Demo";
    [self setUpViews];
    self.headerTitle = @"少林方丈为失足妇女开光 网易淫才吟诗盖高楼";
    [self loadDataThen:^(NSMutableArray *data) {
        self.data = data.mutableCopy;
        [self.collectionView reloadData];
    }];
}
#pragma mark - Initialize
- (void)setUpViews{
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYFeedCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kXYFeedCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kXYHeaderView];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYFeedCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kXYFeedCell forIndexPath:indexPath];
    cell.model = self.data[indexPath.item];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    XYHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kXYHeaderView forIndexPath:indexPath];
    headerView.titleLabel.text = [NSString stringWithFormat:@"\"%@\"的评论", self.headerTitle];
    return headerView;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:kXYFeedCell width:ScreenW cacheByIndexPath:indexPath config:^(XYFeedCell * cell) {
        cell.model = self.data[indexPath.item];
    }];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [collectionView xy_getReusableViewSizeForIdentifier:kXYHeaderView width:ScreenW cacheBySection:section config:^(XYHeaderView *reusableView) {
        reusableView.titleLabel.text = [NSString stringWithFormat:@"\"%@\"的评论", self.headerTitle];
    }];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 10, 0);
}
#pragma mark - Actions
- (void)loadDataThen:(void(^)(NSMutableArray *data))then{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        NSMutableArray *models = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [models addObject:[[XYFeedModel alloc] initWithDictionary:obj]];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (then) {
                then(models);
            }
        });
        
    });
}
#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
