//
//  RealmPerson.h
//  testwidage
//
//  Created by sijiechen3 on 2017/2/21.
//  Copyright © 2017年 sijiechen3. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmPerson : RLMObject

@property NSString * name;
@property int age;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RealmPerson>
RLM_ARRAY_TYPE(RealmPerson)
