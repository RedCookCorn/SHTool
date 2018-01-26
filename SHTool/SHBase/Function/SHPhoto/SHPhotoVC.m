//
//  SHPhotoVC.m
//  SHTool
//
//  Created by senyuhao on 26/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHPhotoVC.h"
#import "SHBaseManager.h"
#import "SHPhotoCell.h"
#import "SHListAlbumCell.h"
#import "SHRightImageButton.h"
#import "SHBaseToast.h"

#import "UICollectionViewCell+SHExtension.h"
#import "UITableViewCell+SHExtension.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SHPhotoVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UICollectionView *mCollection;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) NSMutableArray *listAlbum;

@property (nonatomic, strong) UITableView *mTable;

@property (nonatomic, strong) NSMutableArray *mAllAssetCollection;
@property (nonatomic, assign) NSInteger selectCount;
@property (nonatomic, strong) NSMutableArray *selectIndexArr;

@property (nonatomic, assign) NSInteger selectAlbum;
@property (nonatomic, strong) SHRightImageButton *titleButton;

@end

@implementation SHPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mAllAssetCollection = [NSMutableArray new];
    _listArr = [NSMutableArray new];
    _listAlbum = [NSMutableArray new];
    _selectIndexArr = [NSMutableArray new];
    
    _selectCount = 0;
    
    [self setupViews];
    
    __weak typeof(self)tself = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [tself fetchAllAssetCollection];
                [tself enumerateAssetsInfoInAssetCollection];
                tself.selectAlbum = 0;
                [tself updateView:0];
            });
        }
    }];
}

// 界面设置
- (void)setupViews {
    _titleButton = [[SHRightImageButton alloc] initWithFrame:CGRectMake(0, 0, [SHBaseManager screenWidth]/2, 44)];
    [_titleButton setTitleColor:[SHBaseManager shareInstance].commonSHPhotoTitleColor forState:UIControlStateNormal];
    [_titleButton setImage:[SHBaseManager shareInstance].commonSHPhotoTitleImageDown forState:UIControlStateNormal];
    [_titleButton setImage:[SHBaseManager shareInstance].commonSHPhotoTitleImageUp forState:UIControlStateSelected];
    [_titleButton addTarget:self action:@selector(selectAlbum:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _titleButton;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.mCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [SHBaseManager screenWidth], [SHBaseManager screenHeight]) collectionViewLayout:layout];
    self.mCollection.dataSource = self;
    self.mCollection.delegate = self;
    self.mCollection.backgroundColor = [SHBaseManager shareInstance].commonSHPhotoBackgroudColor;
    [self.mCollection registerNib:[SHPhotoCell nib] forCellWithReuseIdentifier:[SHPhotoCell identifyForCell]];
    [self.view addSubview:self.mCollection];
    
    self.mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [SHBaseManager screenWidth], [SHBaseManager screenHeight]) style:UITableViewStyleGrouped];
    self.mTable.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    self.mTable.delegate = self;
    self.mTable.dataSource = self;
    self.mTable.bounces = NO;
    [self.mTable registerNib:[SHListAlbumCell nib] forCellReuseIdentifier:[SHListAlbumCell identifyForCell]];
    self.mTable.alpha = 0;
    [self.view addSubview:self.mTable];
}

// 点击TitleView操作
- (void)selectAlbum:(UIButton *)sender {
    //    sender.selected = !sender.selected;
    sender.selected = !sender.selected;
    [self animationBySelected:sender.selected];
}

- (void)animationBySelected:(BOOL)selected {
    if (selected) {
        self.mTable.alpha = 1;
    } else {
        self.mTable.alpha = 0.0;
    }
}

// 获取数据并显示
- (void)updateView:(NSInteger)index {
    if (_mAllAssetCollection.count > index) {
        SHBaseAlbum *base = self.listAlbum[index];
        [_titleButton setTitle:base.text forState:UIControlStateNormal];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self enumerateAssetsInAssetCollection:_mAllAssetCollection[index]];
        });
    }
}

#pragma mark - AllAlbum
- (void)fetchAllAssetCollection {
    // 获取自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        [_mAllAssetCollection addObject:assetCollection];
    }
    // 获取相册胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    if (cameraRoll != nil) {
        [_mAllAssetCollection addObject:cameraRoll];
    }
}

- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection {
    __block NSMutableArray *tempArr = [NSMutableArray new];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        CGFloat simpleWidth = ([SHBaseManager screenWidth] - 10)/4.0;
        CGSize size = CGSizeMake(simpleWidth*1.5, simpleWidth*1.5);
        // 从asset中获得图片
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [tempArr addObject:result];
        }];
    }
    
    __weak typeof(self)tself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tself.listArr removeAllObjects];
        [tself.listArr addObjectsFromArray:tempArr];
        [tself.mCollection reloadData];
    });
}

- (void)enumerateAssetsInfoInAssetCollection {
    for (PHAssetCollection *assetCollection in self.mAllAssetCollection) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.synchronous = YES;
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        SHBaseAlbum *base = [[SHBaseAlbum alloc] init];
        base.text = assetCollection.localizedTitle;
        base.imageCount = [assets count];
        if (assets.count > 0) {
            CGFloat simpleWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - 10)/4.0;
            CGSize size = CGSizeMake(simpleWidth*1.5, simpleWidth*1.5);
            // 从asset中获得图片
            [[PHCachingImageManager defaultManager] requestImageForAsset:assets[0] targetSize:size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                base.image = result;
            }];
        }
        [self.listAlbum addObject:base];
    }
    [self.mTable reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArr.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SHPhotoCell identifyForCell] forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell cameraCell];
    } else {
        [cell updateCell:self.listArr[indexPath.row - 1] selected:[self.selectIndexArr containsObject:indexPath]];
    }
    
    __weak SHPhotoCell *weakCell = cell;
    __weak typeof(self)tself = self;
    cell.selectBlock = ^(BOOL selected) {
        if (selected) {
            tself.selectCount++;
            if (tself.selectCount == tself.maxSelect+1) {
                tself.selectCount--;
                [SHBaseToast showToast:[NSString stringWithFormat:@"最多可选%d张图片",(int)tself.maxSelect] inView:tself.view];
                [weakCell cancelSelect];
            } else {
                [tself.selectIndexArr addObject:indexPath];
            }
        } else {
            tself.selectCount--;
            [tself.selectIndexArr removeObject:indexPath];
        }
    };
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat simpleWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - 10)/4.0;
    return CGSizeMake(simpleWidth, simpleWidth);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listAlbum.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHListAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:[SHListAlbumCell identifyForCell]];
    [cell updateCell:self.listAlbum[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _titleButton.selected = NO;
    [self animationBySelected:_titleButton.selected];
    if (self.selectAlbum != indexPath.row) {
        self.selectAlbum = indexPath.row;
        self.selectCount = 0;
        [self.selectIndexArr removeAllObjects];
        [self updateView:indexPath.row];
    }
}

@end
