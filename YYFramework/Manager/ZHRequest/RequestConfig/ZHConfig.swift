//
//  ZHConfig.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/31.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

/**
 *  是否提交到苹果爸爸怀里
 *  kIsSubmitApplePapa = true 一定是生产环境，如果需要提交TestFlight其它需要手动配置
 *  kIsSubmitApplePapa = false 手动配置需要的环境
 **/
let kIsSubmitApplePapa: Bool = false

let kDevelopEnvironment_Url: ZHBaseUrlType = .test
let kDevelopEnvironment_H5_Url: ZHH5BaseUrlType = .other

enum ZHBaseUrlType: String {
    case product     = "product"
    case zhunProduct = ""
    case test        = "http://px-cfpapp.zhengheht.com/cfpapp"
    case other       = "https://api.netease.im"
}

enum ZHH5BaseUrlType: String {
    case product     = "product"
    case zhunProduct = ""
    case test        = "http://px-cfpapp.zhengheht.com"
    case other       = "other" 
}






// #warning
// TODO:
// FIXME:

/*
 脚本 run script warning
 TAGS="TODO:|FIXME:"
 echo "searching ${SRCROOT} for ${TAGS}"
 find "${SRCROOT}" \( -name "*.swift" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/"

 */

/**
 *  多个target，判断是release还是debug
 **/



/*
#if RELEASE
print("RELEASE")
#else
print("no RELEASE")
#endif
*/



/**
 *  一个target中，判断是release还是debug
 **/
/*
 #if DEBUG
 print("1")
 #else
 print("2")
 #endif
 */
