//
//  MiyaerScrollView.h
//  MiyaScrollView
//
//  Created by miya on 16/7/13.
//  Copyright © 2016年 miya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    pageControlPositionTypeLeft = 0,
    pageControlPositionTypeMiddle,
    pageControlPositionTypeRight
}pageControlPositionType;


@interface MiyaerScrollView : UIView
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *imageURLArray;
/**
 *是否需要pageControl,default is YES
 */
@property (nonatomic, assign) BOOL needPageControl;
/**
 *  是否循环轮播,default is NO
 */
@property (nonatomic, assign) BOOL infiniteLoop;

/**占位图片名字*/
@property (nonatomic, copy) NSString *placeHolderImageName;

@property (nonatomic, assign) pageControlPositionType pageControlPositionType;
/**
 *  是否真正轮播
 *
 *  @return 返回YES，正在自动轮播
 */
-(BOOL)isAutoCarouseling;
/**
 *  开始轮播，默认是启动的
 */
-(void)startAutoCarousel;
/**
 *  停止自动轮播
 */
-(void)stopAutoCarousel;



@end
