//
//  RACObserveViewController.m
//  ReactNative
//
//  Created by admin on 16/9/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "RACObserveViewController.h"
#import "RACObserveCell.h"
#import "RACObserveModel.h"
@interface RACObserveViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSMutableArray *dataArr;
@end

@implementation RACObserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *titlesArr=@[@"时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖騑于上路，访风景于崇阿。临帝子之长洲，得天人之旧馆。层峦耸翠，上出重霄；飞阁流丹，下临无地。鹤汀凫渚，穷岛屿之萦回；桂殿兰宫，即冈峦之体势",@"披绣闼，俯雕甍，山原旷其盈视，川泽纡其骇瞩。闾阎扑地，钟鸣鼎食之家；舸舰迷津，青雀黄龙之舳。云销雨霁，彩彻区明。落霞与孤鹜齐飞，秋水共长天一色。渔舟唱晚，响穷彭蠡之滨，雁阵惊寒，声断衡阳之浦。",@"遥襟甫畅，逸兴遄飞。爽籁发而清风生，纤歌凝而白云遏。睢园绿竹，气凌彭泽之樽；邺水朱华，光照临川之笔。四美具，二难并。穷睇眄于中天，极娱游于暇日。天高地迥，觉宇宙之无穷；兴尽悲来，识盈虚之有数。望长安于日下，目吴会于云间。地势极而南溟深，天柱高而北辰远。关山难越，谁悲失路之人；萍水相逢，尽是他乡之客。怀帝阍而不见，奉宣室以何年？"];
    
    
    self.dataArr=[NSMutableArray array];
    
    for (NSInteger i=0; i<titlesArr.count; i++) {
        RACObserveModel *observeModel = [[RACObserveModel alloc] init];
        observeModel.title = titlesArr[i];
        [self.dataArr addObject:observeModel];
    }
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    tableview.tableFooterView = [UIView new];
    [self.view addSubview:tableview];
    tableview.rowHeight = UITableViewAutomaticDimension;  //iOS 8以后xib适应高度
    tableview.estimatedRowHeight = 300;
    tableview.dataSource = self;
    tableview.delegate = self;
    [tableview registerNib:[UINib nibWithNibName:@"RACObserveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RACObserveCell"];
}
#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RACObserveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RACObserveCell" forIndexPath:indexPath];
    cell.observeModel = self.dataArr[indexPath.row];
    return cell;
}

@end
