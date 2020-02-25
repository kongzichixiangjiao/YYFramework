# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

inhibit_all_warnings! # 消除警告

flutter_application_path = '/Users/houjianan/Documents/GitHub/iOS/flutter_yyframework/'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

source 'https://github.com/CocoaPods/Specs.git' # 解决错误：[!] CDN: trunk Repo update failed - 20 error(s):

target 'YYFramework' do
  
  use_frameworks!
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Kingfisher'
  pod 'AFNetworking', '~> 3.0'
  pod 'JTAppleCalendar', '7.1.6'
  pod 'SwiftDate'
  pod 'HandyJSON'
  pod 'SnapKit'
  pod 'SwiftyRSA'
  pod 'MJRefresh'
  #CoreData
  pod 'MagicalRecord'
  
  # RxSwift系列
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'ReactiveCocoa', '9.0.0'
  
  # 绑定
  pod 'Bond'
  
  pod 'GAAlertPresentation'
  
  pod 'CTMediator'
  # pod 'LayoutKit', '7.0.3'
  pod 'TransitionableTab'
  
  # 刷新
  pod 'ESPullToRefresh'
  
  # UI调试工具
  #pod 'LookinServer', :configurations => ['Debug']
  
  # 统计
  #pod 'BaiduMobStatCodeless' # 百度统计无埋点SDK
  #pod 'GrowingAutoTrackKit' # 统计
  
  #pod 'BaiduMapKit' # 百度地图SDK
  #pod 'BMKLocationKit' # 百度定位
  
  # 播放器
  #pod 'BMPlayer', '~> 1.2.0' # 播放器
  # pod 'WMPlayer' # 播放器
   #pod 'SuperPlayer' # 腾讯播放器
   # 腾讯云直播
#   pod 'TXLiteAVSDK_Professional', :podspec => 'http://pod-1252463788.cosgz.myqcloud.com/liteavsdkspec/TXLiteAVSDK_Professional.podspec'
  # 七牛云 模拟器和真机
  pod "PLPlayerKit", :podspec => 'https://raw.githubusercontent.com/pili-engineering/PLPlayerKit/master/PLPlayerKit-Universal.podspec'
  pod "Player", "~> 0.13.2"
  # 阿里播放器
  #pod 'AliPlayerSDK_iOS'
  
  # 直播
  #pod 'LFLiveKit'
  # 七牛直播
  # PLCameraStreamingKit 是 Pili 直播 SDK 的 iOS 推流端，是带有采集模块老版本 SDK。如果是新用户接入，建议使用 PLMediaStreamingKit。该版本支持 RTMP 推流，h.264 和 AAC 编码，硬编软编支持。具有丰富的数据和状态回调，方便用户根据自己的业务定制化开发。具有直播场景下的重要功能，如：美颜、背景音乐、水印等功能。
  # PLCameraStreamingKit 已与 PLStreamingKit 合并为 PLMediaStreamingKit, 此 repo 将停止更新，请老用户迁移到 PLMediaStreamingKit
  # pod 'PLCameraStreamingKit'
  #  pod "PLMediaStreamingKit" # 视频/音频采集和编码配置
  #  pod 'PLShortVideoKit' # 七牛短视频 专业版
  # 七牛短视频 基础版
  # 模拟器不能运行 暂时注释
#  pod 'PLShortVideoKit', :podspec => 'https://raw.githubusercontent.com/pili-engineering/PLShortVideoKit/master/PLShortVideoKit-Basic.podspec'
  #pod 'VZInspector' # debug工具
  
  # Hero动画
  # pod 'Hero' # https://github.com/HeroTransitions/Hero
  # pod "CollectionKit", '2.3.0'
  # 渐变色
  # pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  
  # 下载/上传
  #pod 'Tiercel' # 原生 后台 任务管理 断点续传 线程安全 下载类
  #pod 'DaisyNet' # 下载类
  
  # 单元测试
  pod 'OCMock'
  
  pod 'SSZipArchive', '2.1.4' # zip解压
  pod 'SwiftTheme', '0.4.3' # 换肤
  
  #类似懒加载小工具
  pod 'Then', '2.4.0'
  
  pod 'CryptoSwift', '0.15.0'
  
  # 友盟系列
  # 友盟基础库
  #pod 'UMCCommon'
  #pod 'UMCSecurityPlugins'
  # 友盟日志库
  #pod 'UMCCommonLog'
  
  # 友盟统计库
  #pod 'UMCAnalytics'
  
  # 友盟推送
  # pod 'UMCPush'
  
  # 友盟分享库
  # U-Share SDK UI模块（分享面板，建议添加）
  # pod 'UMCShare/UI'
  # 集成微信(精简版0.2M)
  # pod 'UMCShare/Social/ReducedWeChat'
  # 集成微信(完整版14.4M)
  # pod 'UMCShare/Social/WeChat'
  # ... ...
  # 集成邮件
  # pod 'UMCShare/Social/Email'
  # 集成短信
  # pod 'UMCShare/Social/SMS'
  
  
  pod 'WechatOpenSDK' # 微信sdk
  
  #pod 'BuglyHotfix' #bugly热更新 https://bugly.qq.com/docs/user-guide/instruction-manual-ios-hotfix/?v=20200114181137

  install_all_flutter_pods(flutter_application_path)
  
end
