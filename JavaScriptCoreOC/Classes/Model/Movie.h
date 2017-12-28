//
//  Movie.h
//  JavaScriptCoreOC
//
//  Created by wangliang on 2017/12/28.
//  Copyright © 2017年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *price;

@property(nonatomic,copy) NSString *imageUrl;

//精简写法
-(instancetype)initMovieWithDict:(NSDictionary *)dict;

+(instancetype)movieWithDict:(NSDictionary *)dict;

//繁琐写法
//-(instancetype)initMovieWithTitle:(NSString *)title price:(NSString *)price imageUrl:(NSString *)imageUrl;
//
//+(instancetype)movieWithTitle:(NSString *)title price:(NSString *)price imageUrl:(NSString *)imageUrl;

@end
