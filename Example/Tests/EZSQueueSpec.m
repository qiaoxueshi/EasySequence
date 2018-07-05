//
//  EZSQueueSpec.m
//  iOSTest
//
//  Created by nero on 2018/5/2.
//  Copyright (c) 2018 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

QuickSpecBegin(EZSQueueSpec)

describe(@"EZSQueue test", ^{
    context(@"base test", ^{
        it(@"can initazlie a empty queue", ^{
            EZSQueue *queue = [EZSQueue new];
            expect(queue.isEmpty).to(beTrue());
            expect(queue.front).to(beNil());
            expect(queue.count).to(equal(0));
        });
        
        it(@"can enque object to queue", ^{
           EZSQueue<NSString *> *queue = [EZSQueue new];
            [queue enqueue:@"1"];
            expect(queue.isEmpty).to(beFalse());
            expect(queue.count).to(equal(1));
            expect(queue.front).to(equal(@"1"));
            [queue enqueue:@"2"];
            expect(queue.count).to(equal(2));
            expect(queue.front).to(equal(@"1"));
        });
        
        it(@"can deque from queue", ^{
            EZSQueue<NSString *> *queue = [EZSQueue new];
            [queue enqueue:@"1"];
            [queue enqueue:@"2"];
            
            expect(queue.front).to(equal(@"1"));
            expect(queue.count).to(equal(2));
            NSString *object = [queue dequeue];
            expect(object).to(equal(@"1"));
            expect(queue.front).to(equal(@"2"));
            expect(queue.count).to(equal(1));
        });
        
        it(@"can check a queue contains the special object", ^{
            EZSQueue<NSString *> *queue = [EZSQueue new];
            [queue enqueue:@"1"];
            [queue enqueue:@"B"];
            [queue enqueue:@"三"];
            expect([queue contains:@"2"]).to(beFalse());
            expect([queue contains:@"B"]).to(beTrue());
        });
    });
    
    context(@"copying test", ^{
        it(@"can make a cloned object from origin object", ^{
            EZSQueue<NSString *> *queue = [EZSQueue new];
            [queue enqueue:@"1"];
            [queue enqueue:@"2"];
            EZSQueue<NSString *> *anotherQueue = [queue copy];
            expect(queue).notTo(beIdenticalTo(anotherQueue));
            expect(queue).to(equal(anotherQueue));
            
            [anotherQueue enqueue:@"3"];
            expect(anotherQueue).notTo(equal(queue));
        });
    });
    
    context(@"transfer from sequence test", ^{
        it(@"can transform a seuquence to a queue", ^{
            EZSequence *s = EZS_Sequence(@[@1, @2, @3]);
            EZSQueue *queue = [s as:[EZSQueue class]];
            expect(queue.front).to(equal(@1));
            [queue dequeue];
            expect(queue.front).to(equal(@2));
            [queue dequeue];
            expect(queue.front).to(equal(@3));
            [queue dequeue];
            expect(queue.isEmpty).to(beTrue());
        });
    });
});

QuickSpecEnd
