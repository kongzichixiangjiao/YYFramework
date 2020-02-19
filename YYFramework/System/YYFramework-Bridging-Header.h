//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <CommonCrypto/CommonCrypto.h>
#import <objc/message.h>
#import "GAEmoji.h"
#import "NSString+NSString.h"
//#import "BaiduMobStat.h" // 百度统计
//#import "Growing.h" // 统计
//#import "SuperPlayer.h"
#import <PLPlayerKit/PLPlayerKit.h>
//#import <AipOcrSdk/AipOcrSdk.h>
#import <OCMock/OCMock.h>

// 友盟统计
//#import <UMCommon/UMCommon.h>
//#import <UMCommonLog/UMCommonLogHeaders.h>
//#import <UMAnalytics/MobClick.h>

//#import "VZInspector/VZInspector.h" // debug调试工具


//***百度人脸识别***//
//#import <IDLFaceSDK/IDLFaceSDK.h> // 人脸识别
// 如果在后台选择自动配置授权信息，下面的三个LICENSE相关的参数已经配置好了
// 只需配置FACE_API_KEY和FACE_SECRET_KEY两个参数即可

// 人脸license文件名
#define FACE_LICENSE_NAME    @"idl-license"
// 人脸license后缀
#define FACE_LICENSE_SUFFIX  @"face-ios"

// （您申请的应用名称(appname)+「-face-ios」后缀，如申请的应用名称(appname)为test123，则此处填写test123-face-ios）
// 在后台 -> 产品服务 -> 人脸识别 -> 客户端SDK管理查看，如果没有的话就新建一个
#define FACE_LICENSE_ID        @"2019-jinfu-test-face-ios"
//#import "VideoCaptureDevice.h"
//#import "DetectionViewController.h"
//***百度人脸识别--结束***//

// 企业微信 登录分享
#import "WWKApi.h"
#import "WWKApiObject.h"

// 百度地图
//#import <BaiduMapAPI_Base/BMKBaseComponent.h> //引入base相关所有的头文件
//#import <BaiduMapAPI_Map/BMKMapComponent.h> //引入地图功能所有的头文件
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>   //引入检索功能所有的头文件
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>   //引入云检索功能所有的头文件
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h> //引入计算工具所有的头文件
//#import < BaiduMapAPI_Map/BMKMapView.h> //只引入所需的单个头文件

// 百度定位
//#import <BMKLocationkit/BMKLocationComponent.h>

// 直播框架
//#import <LFLiveKit/LFLiveKit.h>
// 七牛云视频音频采集
//#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

// 微信
#import "WXApi.h"

// bugly热更新
//#import <BuglyHotfix/Bugly.h>
//#import "JPEngine.h"

// 腾讯直播
//#import "TXLiteAVSDK_Professional/TXLiteAVSDK.h"


// 阿里播放器
//阿里云播放器
//#import <AliyunPlayer/AliPlayer.h>
//#import <sys/utsname.h>
