//
//  ViewController.m
//  AutoSlider
//
//  Created by Kshitij Ghule on 09/04/17.
//  Copyright © 2017 Crystal Hitech IT Solutions Pvt. Ltd. All rights reserved.
//


#import "ViewController.h"
#import "TAPageControl.h"


@interface ViewController () <UIScrollViewDelegate, TAPageControlDelegate>
{
    NSTimer *timer;
    NSInteger index;
}
@property (strong, nonatomic) TAPageControl *customPageControl2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *imagesData;

@end

@implementation ViewController
#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagesData = @[@"image1.jpg", @"image2.jpg", @"image3.jpg"];
    for(int i=0; i<self.imagesData.count;i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) * i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.scrollView.frame))];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:[self.imagesData objectAtIndex:i]];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.delegate = self;
    index=0;
    
    
    // Progammatically init a TAPageControl with a custom dot view.
    self.customPageControl2 = [[TAPageControl alloc] initWithFrame:CGRectMake(20,self.scrollView.frame.origin.y+self.scrollView.frame.size.height,self.scrollView.frame.size.width,40)];//CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) - 100, CGRectGetWidth(self.scrollView.frame), 40)
    // Example for touch bullet event
    self.customPageControl2.delegate      = self;
    self.customPageControl2.numberOfPages = self.imagesData.count;
    self.customPageControl2.dotSize       = CGSizeMake(20, 20);
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.imagesData.count, CGRectGetHeight(self.scrollView.frame));
    [self.view addSubview:self.customPageControl2];
    
}

-(void)viewDidAppear:(BOOL)animated{
    timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runImages) userInfo:nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
}

-(void)runImages{
    self.customPageControl2.currentPage=index;
    if (index==self.imagesData.count-1) {
        index=0;
    }else{
        index++;
    }
    [self TAPageControl:self.customPageControl2 didSelectPageAtIndex:index];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.customPageControl2.currentPage = pageIndex;
    index=pageIndex;
}
// Example of use of delegate for second scroll view to respond to bullet touch event
- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)currentIndex
{
    index=currentIndex;
    [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.view.frame) * currentIndex, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.scrollView.frame)) animated:YES];
}


@end
