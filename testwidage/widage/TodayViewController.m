//
//  TodayViewController.m
//  widage
//
//  Created by sijiechen3 on 2017/2/21.
//  Copyright © 2017年 sijiechen3. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <Masonry/Masonry.h>
#import "Person.h"
#import "Realm.h"
#import "RealmPerson.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.preferredContentSize = CGSizeMake(0, 150);

    self.view.backgroundColor = [UIColor redColor];
    
    
    UIButton * btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(openApp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                        firstObject    ] stringByAppendingString:@"person_chieve"];
    
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.SavingPlusData"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
    
    NSLog(@"%@", containerURL);
    
 
//    [NSKeyedArchiver archiveRootObject:p toFile:containerURL.path];
    
    Person * pp = [NSKeyedUnarchiver unarchiveObjectWithFile:containerURL.path];
    
    NSLog(@"%@", pp);
    
    [btn setTitle:pp.description forState:UIControlStateNormal];
    
    [self setupRealm];
    
    RLMResults * arr = [RealmPerson allObjects];
    for (RealmPerson * rp in arr) {
        NSLog(@"realm person - %@ %d", rp.name, rp.age);
    }
}

- (void)setupRealm {
    RLMRealmConfiguration * config = [RLMRealmConfiguration defaultConfiguration];
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.SavingPlusData"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/"];
    
    config.fileURL = [[[containerURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:@"SavingPlus"]
                      URLByAppendingPathExtension:@"realm"];
    
    NSLog(@"realm url: %@", config.fileURL);
    
    config.schemaVersion = 1;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // do nothing
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

- (void)openApp:(id)sender {
    
    [self.extensionContext openURL:[NSURL URLWithString:@"openSavingPlusApp://action="] completionHandler:^(BOOL success) {
        NSLog(@"open url result: %@", success ? @"yes": @"no");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
