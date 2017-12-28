//
//  MovieViewData.h
//  JavaScriptCoreOC
//
//  Created by wangliang on 2017/12/28.
//  Copyright © 2017年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSContext;

@interface MovieViewData : NSObject

@property(nonatomic,strong) JSContext *context;

-(void)loadMoviesWith:(double)limit moviesBlock:(void (^)(NSArray *movies))moviesBlock;

@end
