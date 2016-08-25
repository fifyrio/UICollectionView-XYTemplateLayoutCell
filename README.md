# UICollectionView-XYTemplateLayoutCell
A custom templateLayoutCell for UICollectionView
## 题记
在揣摩了**forkingdog**的FDTemplateLayoutCell后，突然发现UICollectionView没有一套计算cell高度的方法，所以依葫芦画瓢画出了这个
## 简介
Template auto layout cell for **automatically** UICollectionViewCell height calculating.
![Demo Overview](https://github.com/fifyrio/UICollectionView-XYTemplateLayoutCell/blob/master/Screenshots/screenshots.gif)
## 如何使用

####如果你的CollectionViewCell需要自适应高度,在宽度已经确定的情况下: 

``` objc
#import "UICollectionView+XYTemplateLayoutCell.h"

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:@"your identifier" width:width config:^(id cell) {
        /*设置cell的数据*/
    }];
}
```

注：如果是高度确定需要自适应宽度，则用
``` objc
- (CGSize)xy_getCellSizeForIdentifier:(NSString *)identifier height:(CGFloat)height config:(void (^)(id cell))config;
```

#### 如果你的CollectionView的Header需要自适应高度，在宽度已经确定的情况下: 
``` objc
#import "UICollectionView+XYTemplateReusableView.h"
//这里以Header为例
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [collectionView xy_getReusableViewSizeForIdentifier:@"your identifier" width:width config:^(id reusableView) {
        /*设置header的数据*/
    }];
}
```

## 缓存cell的size的API


``` objc
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:@"your identifier" width:ScreenW cacheByIndexPath:indexPath config:^(id cell) {
        //config
    }];
}
```
## 缓存Header/Footer的size的API
``` objc
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [collectionView xy_getReusableViewSizeForIdentifier:@"your identifier" width:width cacheBySection:section config:^(id reusableView) {
        //config
    }];
}
```