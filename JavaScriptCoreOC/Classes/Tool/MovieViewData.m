//
//  MovieViewData.m
//  JavaScriptCoreOC
//
//  Created by wangliang on 2017/12/28.
//  Copyright © 2017年 wangliang. All rights reserved.
//

#import "MovieViewData.h"
#import <AFNetworking.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "Movie.h"

#define MovieURL @"https://itunes.apple.com/us/rss/topmovies/limit=50/json"

@interface MovieViewData()

@end

@implementation MovieViewData

//懒加载JSContext
-(JSContext *)context{
    
    if (_context == nil) {
        
        _context = [[JSContext alloc] init];
        
      NSString *commonJSPath=[[NSBundle mainBundle] pathForResource:@"common" ofType:@"js"];
      NSString *additionsJSPath=[[NSBundle mainBundle] pathForResource:@"additions" ofType:@"js"];
    
        
      NSString *commomStr=[NSString stringWithContentsOfFile:commonJSPath encoding:NSUTF8StringEncoding error:nil];
    
      NSString *additionsStr=[NSString stringWithContentsOfFile:additionsJSPath encoding:NSUTF8StringEncoding error:nil];
        
        //将OC中的Movie类对象和JavaScript中的Movie对象桥接在一起
        [_context setObject:[Movie self] forKeyedSubscript:@"Movie"];
        
        //执行js代码
        [_context evaluateScript:commomStr];
        [_context evaluateScript:additionsStr];
    }
    
    return _context;
}

-(void)loadMoviesWith:(double)limit  moviesBlock:(void(^)(NSArray *movies))moviesBlock
{
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *dataTask=[mgr GET:MovieURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
     NSString *jsonString=[self switchObjectToJSON:responseObject];
      
      //解析JSON数据并传出Movie模型数组
      moviesBlock([self parseResponseObject:jsonString limit:limit]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"MovieViewData Load Error %@",error);
    }];
    
    [dataTask resume];
    
}

//解析JSON数据
-(NSArray *)parseResponseObject:(NSString *)response limit:(double)limit{
    
    //1
   JSValue *parseFunction=[self.context objectForKeyedSubscript:@"parseJson"];
   NSArray *parsed=[[parseFunction callWithArguments:@[response]] toArray];
    
    //2
   JSValue *filterFunction=[self.context objectForKeyedSubscript:@"filterByLimit"];
   NSArray *filtered=[filterFunction callWithArguments:@[parsed,@(limit)]].toArray;
    
    //3
    return [self switchDictionaryArrayToModelArrayWith:filtered];
}

//字典数组转模型数组
-(NSMutableArray *)switchDictionaryArrayToModelArrayWith:(NSArray *)array
{
    
    NSMutableArray *arrayM=[NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        
        Movie *movie=[Movie movieWithDict:dic];
        
        [arrayM addObject:movie];
    }
    
    return arrayM;
}

//字典转json格式字符串：
- (NSString*)switchObjectToJSON:(id)objc
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objc options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(void)dealloc{
    
    NSLog(@"MovieViewData 销毁 ---");
}

@end
