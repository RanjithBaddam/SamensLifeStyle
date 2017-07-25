//
//  CustomStepper.m
//  samens
//
//  Created by All time Support on 20/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "CustomStepper.h"

@implementation CustomStepper

- (void)setValue:(double)value
{
    BOOL isPlus  = self.value < value;
    BOOL isMinus = self.value > value;
    
    if (self.wraps) { // Handing wrapped values is tricky
        if (self.value > self.maximumValue - self.stepValue) {
            isPlus  = value < self.minimumValue + self.stepValue;
            isMinus = isMinus && !isPlus;
        } else if (self.value < self.minimumValue + self.stepValue) {
            isMinus = value > self.maximumValue - self.stepValue;
            isPlus  = isPlus && !isMinus;
        }
    }
    
    if (isPlus)
        self.plusMinusState = JLTStepperPlus;
    else if (isMinus)
        self.plusMinusState = JLTStepperMinus;
    
    [super setValue:value];
}

@end
