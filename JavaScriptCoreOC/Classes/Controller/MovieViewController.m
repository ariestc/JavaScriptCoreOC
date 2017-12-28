//
//  MovieViewController.m
//  JavaScriptCoreOC
//
//  Created by wangliang on 2017/12/28.
//  Copyright © 2017年 wangliang. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieViewData.h"
#import "MovieViewCell.h"

#define MovieViewCellID @"MovieViewCellID"

@interface MovieViewController ()<UICollectionViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong) NSArray *movies;

@end

@implementation MovieViewController

-(NSArray *)movies
{
    if (_movies == nil) {
        
        _movies=[[NSArray alloc] init];
    }
    return _movies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -- UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //调用此方法 触发textFieldDidEndEditing:方法调用
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    double number=[textField.text doubleValue];
    
    MovieViewData *mvData= [[MovieViewData alloc] init];

    [mvData loadMoviesWith:number moviesBlock:^(NSArray *movies) {

        self.movies=movies;

        [self.collectionView reloadData];
    }];
}


#pragma mark -- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movies.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   MovieViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:MovieViewCellID forIndexPath:indexPath];
    
    cell.movie=self.movies[indexPath.row];
    
    return cell;
}

-(void)dealloc{
    
    NSLog(@"MovieViewController 销毁 --- ");
}

@end
