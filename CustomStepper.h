//
//  CustomStepper.h
//  samens
//
//  Created by All time Support on 20/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum JLTStepperPlusMinusState_ {
    JLTStepperMinus = -1,
    JLTStepperPlus  = 1,
    JLTStepperUnset = 0
} JLTStepperPlusMinusState;

@interface CustomStepper : UIStepper

@property (nonatomic) JLTStepperPlusMinusState plusMinusState;

@end
