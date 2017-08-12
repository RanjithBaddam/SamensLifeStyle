//
//  AddressDetailsModel.m
//  samens
//
//  Created by All time Support on 10/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AddressDetailsModel.h"

@implementation AddressDetailsModel
-(void)getAddressModelWithDictionary:(NSDictionary *)dict{
    self.add_type = [dict valueForKey:@"add_type"];
    self.city = [dict valueForKey:@"city"];
    self.full_address = [dict valueForKey:@"full_address"];
    self.id = [dict valueForKey:@"id"];
    self.landmark = [dict valueForKey:@"landmark"];
    self.mobile = [dict valueForKey:@"mobile"];
    self.mobile_sec = [dict valueForKey:@"mobile_sec"];
    self.name = [dict valueForKey:@"name"];
    self.pincode = [dict valueForKey:@"pincode"];
    self.state = [dict valueForKey:@"state"];

}

@end
