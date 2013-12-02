//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Johnny Zhao on 12/1/13.
//  Copyright (c) 2013 Johnny Zhao. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharLable;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharLable;

@end

@implementation TextStatsViewController


- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charsWithAttributes:(NSString *)attributeName
{
    NSMutableAttributedString *chars = [[NSMutableAttributedString alloc]init];
    
    NSUInteger index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value){
            [chars appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }
        else{
            index ++;
        }
    }
    return chars;
}

- (void)updateUI
{

    self.colorfulCharLable.text = [NSString stringWithFormat:@"%lu colorful chars", [[self charsWithAttributes:NSForegroundColorAttributeName] length]];
    
    self.outlinedCharLable.text = [NSString stringWithFormat:@"%lu outlined chars", [[self charsWithAttributes:NSStrokeColorAttributeName] length]];
    
}
@end
