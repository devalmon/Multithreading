//
//  SceneDelegate.m
//  Multithreading
//
//  Created by Alexey Baryshnikov on 22.05.2020.
//  Copyright © 2020 Alexey Baryshnikov. All rights reserved.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *) scene];
    ViewController *rootViewController = ViewController.new;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    
//    [self performSelectorInBackground:@selector(testThread) withObject:nil];
//    for (int i = 0; i < 10; i++) {
//        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread) object:nil];
//        thread.name = [NSString stringWithFormat:@"thread #%d", i + 1];
//        [thread start];
//    }
    
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"x"];
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"0"];
    thread1.name = @"thread 1";
    thread2.name = @"thread 2";
    [thread1 start];
    [thread2 start];
    
    
    self.array = [NSMutableArray array];
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:1];
     
    /*
    self.array = [NSMutableArray array];
    
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    __weak id weakSelf = self;
    
    dispatch_async(queue, ^{
        [weakSelf addStringToArray:@"x"];
    });
    dispatch_async(queue, ^{
        [weakSelf addStringToArray:@"0"];
    });
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3];
     */
}

- (void)testThread {
    @autoreleasepool {
        double startTime = CACurrentMediaTime();
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        
            for (int i = 0; i < 20; i++) {
        }
        NSLog(@"%@ finished in %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);

    }
}

- (void)addStringToArray: (NSString *) string {
    @autoreleasepool {
        
        double startTime = CACurrentMediaTime();
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        
//        @synchronized (self) {
            NSLog(@"%@ calcus started", [[NSThread currentThread] name]);

            for (int i = 0; i < 2000; i++) {
                [self.array addObject:string];
            }
            
            NSLog(@"%@ calcus ended", [[NSThread currentThread] name]);

//        }
        
        NSLog(@"%@ finished in %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);

    }
}

- (void)printArray {
    NSLog(@"%@", self.array);
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
