//
//  Person.m
//  testwidage
//
//  Created by sijiechen3 on 2017/2/21.
//  Copyright © 2017年 sijiechen3. All rights reserved.
//

#import "Person.h"
#import "RealmPerson.h"

@implementation Person

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name": @"acheive_name",
             @"age":  @"acheive_age"
             };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@_%ld", self.name, self.age];
}

- (void)save {
    RealmPerson * rp = [[RealmPerson alloc] init];
    rp.name = [[NSDate date] description];
    rp.age = 12;
    RLMRealm * realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:rp];
    [realm commitWriteTransaction];
}

@end
