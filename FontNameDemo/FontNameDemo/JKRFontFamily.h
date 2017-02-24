//
//  JKRFontFamily.h
//  FontNameDemo
//
//  Created by tronsis_ios on 16/8/11.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

// 自定义字体Family模型
@interface JKRFontFamily : NSObject

@property (nonatomic, copy) NSString *familyName;                 /// familyName
@property (nonatomic, strong) NSArray<NSString *> *fontNames;     /// 该family下所有字体的名字

@end
