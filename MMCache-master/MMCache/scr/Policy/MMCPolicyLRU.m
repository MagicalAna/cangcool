//
//  MMCPolicyLRU.m
//  MMCache
//
//  Created by leon on 06/07/2018.
//  Copyright © 2018 leon. All rights reserved.
//

#import "MMCPolicyLRU.h"
#import "MMCContainer.h"
#import "MMCStorageProtocol.h"


@implementation MMCPolicyLRU


- (BOOL)saveObject:(MMCContainer *)object toStorage:(id<MMCStorageProtocol>)storage maxCapacity:(NSInteger)maxCapacity {
    if (maxCapacity > 0 && [storage count] >= maxCapacity) {
        MMCContainer *container = [storage leastRecentAccessed];
        if (container.id) {
            if ([storage removeObjectForId:container.id]) {
                NSLog(@"<LRU> FULL [%@ accessed at %@] was removed", container.object, container.accessTime);
            }
        }
    }
    return [storage saveObject:object];
}


@end
