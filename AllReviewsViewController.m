//
//  AllReviewsViewController.m
//  samens
//
//  Created by All time Support on 30/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AllReviewsViewController.h"
#import "AllReviewsTableViewCell.h"

@interface AllReviewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AllReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.allReviewsTableView.delegate = self;
    self.allReviewsTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _ReviewsMainArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)_ReviewsMainArray.count);
    return  1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AllReviewsTableViewCell *cell = [_allReviewsTableView dequeueReusableCellWithIdentifier:@"AllReviewsTableViewCell"];
    _ReviewModel = [_ReviewsMainArray objectAtIndex:indexPath.row];
    cell.starsLabel.text = _ReviewModel.rate;
    NSLog(@"%@",_ReviewModel.rate);
    cell.titleLabel.text = _ReviewModel.title;
    NSLog(@"%@",_ReviewModel.title);
    cell.DiscriptionLabel.text = _ReviewModel.review;
    NSLog(@"%@",_ReviewModel.review);
//    cell.customerNameLabel.text = _ReviewModel.name;
//    NSLog(@"%@",_ReviewModel.name);
    cell.dateLabel.text = _ReviewModel.date;
    NSLog(@"%@",_ReviewModel.date);
   
    
    return cell;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 414, 65)];
//    [headerView addSubview:_allReviewsTableView];
//    headerView.backgroundColor = [UIColor redColor];
//    return headerView;
//}

@end
