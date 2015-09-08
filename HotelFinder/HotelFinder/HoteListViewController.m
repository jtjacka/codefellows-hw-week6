//
//  HoteListViewController.m
//  
//
//  Created by Jeffrey Jacka on 9/7/15.
//
//

#import "HoteListViewController.h"
#import "Hotel.h"

@interface HoteListViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.tableView = [[UITableView alloc]init];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
  [self.tableView reloadData];
  
  //Is this proper syntax?
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
  
  [self.view addSubview:self.tableView];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  
  return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
