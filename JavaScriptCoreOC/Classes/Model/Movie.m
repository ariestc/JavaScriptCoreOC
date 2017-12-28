//
//  Movie.m
//  JavaScriptCoreOC
//
//  Created by wangliang on 2017/12/28.
//  Copyright © 2017年 wangliang. All rights reserved.
//

#import "Movie.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MovieJSExports <JSExport>


@end

@interface Movie() <MovieJSExports>

@end

@implementation Movie

-(instancetype)initMovieWithDict:(NSDictionary *)dict
{
    self=[super init];

    if (self) {

        _title=dict[@"title"];
        _price=dict[@"price"];
        _imageUrl=dict[@"imageUrl"];
    }

    return self;
}

+(instancetype)movieWithDict:(NSDictionary *)dict
{
    return [[self alloc] initMovieWithDict:dict];
}

//-(instancetype)initMovieWithTitle:(NSString *)title price:(NSString *)price imageUrl:(NSString *)imageUrl
//{
//    self=[super init];
//
//    if (self) {
//
//        _title=title;
//        _price=price;
//        _imageUrl=imageUrl;
//    }
//    return self;
//}
//
//+(instancetype)movieWithTitle:(NSString *)title price:(NSString *)price imageUrl:(NSString *)imageUrl
//{
//    return [[self alloc] initMovieWithTitle:title price:price imageUrl:imageUrl];
//}

@end
