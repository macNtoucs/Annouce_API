//
//  Announce_API.h
//  Announce_API
//
//  Created by R MAC on 13/2/19.
//  Copyright (c) 2013年 R MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"
@interface Announce_API : NSObject


/*
 取得公佈欄資料
 參數：
     count : 要求的數量
     type : 類型{   學校公告, 校外訊息, 藝文活動  }
     day: 起始日期，格式為20130211
 
 EX : getAnnounceInfo_Count:@"3" andType:@"藝文活動" andStartDay:@20130211 ;
 */
+ (NSString *)getAnnounceInfo_Count:(NSInteger)count andType:(NSString *)type andPage:(NSInteger) page ;
@end
