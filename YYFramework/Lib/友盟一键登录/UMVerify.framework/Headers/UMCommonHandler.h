//
//  UMCommonHandler.h
//  UMVerify
//
//  Created by wangkai on 2019/10/12.
//  Copyright © 2019 wangkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UMCustomModel.h"

@interface UMCommonHandler : NSObject

/**
*  获取当前SDK版本号
*  @return  字符串，sdk版本号
*/
+ (NSString *_Nonnull)getVersion;

/**
 *  初始化SDK调用参数，app生命周期内调用一次
 *  @param  info app对应的秘钥
 *  @param  complete 结果同步回调，成功时resultDic=@{resultCode:600000, msg:...}，其他情况时"resultCode"值请参考PNSReturnCode
 */
+ (void)setVerifySDKInfo:(NSString * _Nonnull)info complete:(void(^_Nullable)(NSDictionary * _Nonnull resultDic))complete;

/**
 *  检查及准备调用环境，resultDic返回PNSCodeSuccess才能调用下面的功能接口，在初次或切换蜂窝网络之后需要重新调用，一般在一次登录认证流程开始前调一次即可
 *  @param  complete 异步结果回调，成功时resultDic=@{resultCode:600000, msg:...}，其他情况时"resultCode"值请参考PNSReturnCode，只有成功回调才能保障后续接口调用
 */
+ (void)checkEnvAvailableWithComplete:(void (^_Nullable)(NSDictionary * _Nullable resultDic))complete;

/**
 *  获取本机号码校验Token
 *  @param  timeout 接口超时时间，单位s，默认为3.0s
 *  @param  complete 结果异步回调，成功时resultDic=@{resultCode:600000, token:..., msg:...}，其他情况时"resultCode"值请参考PNSReturnCode
 */
+ (void)getVerifyTokenWithTimeout:(NSTimeInterval)timeout complete:(void (^_Nullable)(NSDictionary * _Nonnull resultDic))complete;

/**
 *  加速一键登录授权页弹起，防止调用 getLoginTokenWithTimeout:controller:model:complete: 等待弹起授权页时间过长
 *  @param  timeout 接口超时时间，单位s，默认为3.0s
 *  @param  complete 结果异步回调，成功时resultDic=@{resultCode:600000, msg:...}，其他情况时"resultCode"值请参考PNSReturnCode
 */
+ (void)accelerateLoginPageWithTimeout:(NSTimeInterval)timeout complete:(void (^_Nullable)(NSDictionary * _Nonnull resultDic))complete;

/**
 *  获取一键登录Token，调用该接口首先会弹起授权页，点击授权页的登录按钮获取Token
 *  @warning 注意的是，如果前面没有调用 accelerateLoginPageWithTimeout:complete: 接口，该接口内部会自动先帮我们调用，成功后才会弹起授权页，所以有一个明显的等待过程
 *  @param  timeout 接口超时时间，单位s，默认为3.0s
 *  @param  controller 唤起自定义授权页的容器，内部会对其进行验证，检查是否符合条件
 *  @param  model 自定义授权页面选项，可为nil，采用默认的授权页面，具体请参考UMCustomModel.h文件
 *  @param  complete 结果异步回调，"resultDic"里面的"resultCode"值请参考PNSReturnCode，如下：
 *
 *          授权页控件点击事件：700000（点击授权页返回按钮）、700001（点击切换其他登录方式）、
 *          700002（点击登录按钮事件，根据返回字典里面的 "isChecked"字段来区分check box是否被选中，只有被选中的时候内部才会去获取Token）、700003（点击check box事件）、700004（点击协议富文本文字）
            接口回调其他事件：600001（授权页唤起成功）、600002（授权页唤起失败）、600000（成功获取Token）、600011（获取Token失败）、
 *          600015（获取Token超时）、600013（运营商维护升级，该功能不可用）、600014（运营商维护升级，该功能已达最大调用次数）.....
 */
+ (void)getLoginTokenWithTimeout:(NSTimeInterval)timeout controller:(UIViewController *_Nonnull)controller model:(UMCustomModel *_Nullable)model complete:(void (^_Nullable)(NSDictionary * _Nonnull resultDic))complete;

/**
 *  手动隐藏一键登录获取登录Token之后的等待动画，默认为自动隐藏，当设置 UMCustomModel 实例 autoHideLoginLoading = NO 时, 可调用该方法手动隐藏
 */
+ (void)hideLoginLoading;

/**
 *  注销授权页，建议用此方法，对于移动卡授权页的消失会清空一些数据
 *  @param flag 是否添加动画
 *  @param complete 成功返回
 */
+ (void)cancelLoginVCAnimated:(BOOL)flag complete:(void (^_Nullable)(void))complete;

/**
 *  设置日志上传开关
 *  @param  enable 开关设置BOOL值，默认为YES
 */
+ (void)setUploadEnable:(BOOL)enable;

@end
