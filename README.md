# UICollectionView-XYTemplateLayoutCell
A custom templateLayoutCell for UICollectionView
## Overview
Template auto layout cell for **automatically** UICollectionViewCell height calculating.
![Demo Overview](https://github.com/fifyrio/UICollectionView-XYTemplateLayoutCell/blob/master/Sceenshots/screenshots.gif)
## Basic usage

If you have a **self-satisfied** cell, then all you have to do is: 

``` objc
#import "UICollectionView+XYTemplateLayoutCell.h"

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView xy_getCellSizeForIdentifier:@"your identifier" width:width cacheByIndexPath:indexPath config:^(XYFeedCell * cell) {
        cell.model = self.data[indexPath.item];
    }];
}
```
