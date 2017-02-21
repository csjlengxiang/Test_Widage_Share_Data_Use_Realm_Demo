//
//  ViewController.m
//  testwidage
//
//  Created by sijiechen3 on 2017/2/21.
//  Copyright © 2017年 sijiechen3. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Realm.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                         firstObject    ] stringByAppendingString:@"person_chieve"];
    
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.SavingPlusData"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
    
    NSLog(@"%@", containerURL);
    
    Person * p = [[Person alloc] init];
    p.name = @"csj";
    p.age = 10;
    
    [NSKeyedArchiver archiveRootObject:p toFile:containerURL.path];

    Person * pp = [NSKeyedUnarchiver unarchiveObjectWithFile:containerURL.path];
    
    NSLog(@"%@", pp);
    
//    [self setupOldRealm];
    [self setupRealm];
    
    [p save];
}

- (void)setupOldRealm {
    RLMRealmConfiguration * config = [RLMRealmConfiguration defaultConfiguration];
    NSURL * oldPath = [[[config.fileURL URLByDeletingLastPathComponent]
                        URLByAppendingPathComponent:@"SavingPlus"]
                       URLByAppendingPathExtension:@"realm"];
    
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.SavingPlusData"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/"];
    NSURL * newPath = [[[containerURL URLByDeletingLastPathComponent]
                        URLByAppendingPathComponent:@"SavingPlus"]
                       URLByAppendingPathExtension:@"realm"];
    
    NSLog(@"old path %@", oldPath.path);
    NSLog(@"new path %@", newPath.path);
    
    config.fileURL = oldPath;
    config.schemaVersion = 1;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // do nothing
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

- (void)setupRealm {
    RLMRealmConfiguration * config = [RLMRealmConfiguration defaultConfiguration];
    NSURL * oldPath = [[[config.fileURL URLByDeletingLastPathComponent]
                           URLByAppendingPathComponent:@"SavingPlus"]
                          URLByAppendingPathExtension:@"realm"];
    
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.SavingPlusData"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/"];
    NSURL * newPath = [[[containerURL URLByDeletingLastPathComponent]
                        URLByAppendingPathComponent:@"SavingPlus"]
                       URLByAppendingPathExtension:@"realm"];
    
    NSLog(@"old path %@", oldPath.path);
    NSLog(@"new path %@", newPath.path);
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:oldPath.path]) {
        NSError * err;
        [[NSFileManager defaultManager] moveItemAtURL:oldPath toURL:newPath error:&err];
    }
    
    
    config.fileURL = newPath;
    
    config.schemaVersion = 1;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // do nothing
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

@end
