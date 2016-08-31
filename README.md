# UICollectionView-XYTemplateLayoutCell
A custom templateLayoutCell for UICollectionView
## 题记
在揣摩了**forkingdog**的FDTemplateLayoutCell后，突然发现UICollectionView没有一套计算cell高度的方法，所以依葫芦画瓢画出了这个
## 简介
Template auto layout cell for **automatically** UICollectionViewCell height calculating.
![Demo Overview](https://github.com/fifyrio/UICollectionView-XYTemplateLayoutCell/blob/master/Screenshots/screenshots.gif)
## 如何使用

####Use in UICollectionViewCell: 
* fixed width

``` objc
#import "UICollectionView+XYTemplateLayoutCell.h"

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:@"your identifier" width:width config:^(id cell) {
        /*设置cell的数据*/
    }];
}
```

* fixed height
``` objc
#import "UICollectionView+XYTemplateLayoutCell.h"
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:@"your identifier" height:height config:^(id cell) {
        /*设置cell的数据*/
    }];
}
```
* dynamic size
``` objc
#import "UICollectionView+XYTemplateLayoutCell.h"
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:@"your identifier" config:^(id cell) {
        /*设置cell的数据*/
    }];
}
```

#### Use in UICollectionReusableView: 
* fixed width

``` objc
#import "UICollectionView+XYTemplateReusableView.h"
//这里以Header为例
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [collectionView xy_getReusableViewSizeForIdentifier:@"your identifier" width:width config:^(id reusableView) {
        /*设置header的数据*/
    }];
}
```
* fixed height

``` objc
#import "UICollectionView+XYTemplateReusableView.h"
//这里以Header为例
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [collectionView xy_getReusableViewSizeForIdentifier:@"your identifier" height:height config:^(id reusableView) {
        /*设置header的数据*/
    }];
}
```
* dynamic size

``` objc
#import "UICollectionView+XYTemplateReusableView.h"
//这里以Header为例
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [collectionView xy_getReusableViewSizeForIdentifier:@"your identifier" config:^(id reusableView) {
        /*设置header的数据*/
    }];
}
```
#### 缓存cell的size的API


``` objc
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:@"your identifier" width:ScreenW cacheByIndexPath:indexPath config:^(id cell) {
        //config
    }];
}
```
#### 缓存Header/Footer的size的API
``` objc
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [collectionView xy_getReusableViewSizeForIdentifier:@"your identifier" width:width cacheBySection:section config:^(id reusableView) {
        //config
    }];
}
```
## Release Versions
* v1.1
add dynamic size

* v1.0
support to caculate size for UICollectionView Cell