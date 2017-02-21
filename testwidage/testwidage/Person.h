//
//  Person.h
//  testwidage
//
//  Created by sijiechen3 on 2017/2/21.
//  Copyright © 2017年 sijiechen3. All rights reserved.
//

#import <Mantle.h>

@interface Person : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString * name;
@property (assign, nonatomic) NSUInteger age;

- (void)save;

@end
