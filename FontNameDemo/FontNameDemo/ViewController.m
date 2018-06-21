//
//  ViewController.m
//  FontNameDemo
//
//  Created by tronsis_ios on 16/8/11.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import "ViewController.h"
#import "JKRFontFamily.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<JKRFontFamily *> *fontFamilies;

@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    
    /**
     自定义字体步骤：
     1，首先下载字体库，然后把自己库托到项目里
     2，在 info.plist 中添加 Fonts provided by application － AaQingCong.ttf
     3，TARGETS－Build Phases－Copy Bundle Resources 添加字体库文件
     4，cell.textLabel.font = [UIFont fontWithName:@"XXX" size:18];
     */
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _fontFamilies = [NSMutableArray array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.frame = self.view.bounds;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100.f;
    [self loadData];
}

- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSString *familyName in [UIFont familyNames]) {
            JKRFontFamily *family = [[JKRFontFamily alloc] init];
            family.familyName = familyName;
            family.fontNames = [UIFont fontNamesForFamilyName:familyName];
            [_fontFamilies addObject:family];
        }
        [_fontFamilies sortUsingComparator:^NSComparisonResult(JKRFontFamily *  _Nonnull obj1, JKRFontFamily *  _Nonnull obj2) {
            return [obj1.familyName compare:obj2.familyName];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fontFamilies.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fontFamilies[section].fontNames.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.fontFamilies[section].familyName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:self.fontFamilies[indexPath.section].fontNames[indexPath.row] size:18];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"字体展示/FontShow/12.345 - %@", self.fontFamilies[indexPath.section].fontNames[indexPath.row]];
    return cell;
}

@end
