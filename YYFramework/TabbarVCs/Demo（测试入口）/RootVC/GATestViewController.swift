//
//  GATestViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/14.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit
import Alamofire
//import GAMineDetailsViewController
import CTMediator

class GATestViewController: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        base_showNavigationView(title: "Demo", isShow: true)
        base_initTableView()
        
        tableView.emptyDelegate = self
        tableView.ga_reloadData()
    }
    
    override func base_initTableView() {
        super.base_initTableView()
        tableView.yy_register(nibName: GATestViewCell.identifier)
    }
    
    func initData() {
        dataSource = ["0、collectionViewCell自适应高度",
                      "1、联动",
                      "2、消息滚动动画",
                      "3、webView js交互 签名",
                      "4、最近搜索，标签",
                      "5、mine details", "6、LayoutKit",
                      "7、html标签内容展示",  "8、身份证扫描验证",
                      "9、tabbarVC", "10、HERO动画", "11、视频播放", "12、YYPlayerSlider",
                      "13、testJson假数据操作", "14、一张图片签名",
                      "15、多张图片签名TableView",
                      "16、多张图片签名scrollView", "17、pdf文件签名",
                      "18、word文件签名", "19、视频压缩", "20、本地视频播放", "21、tabbarHeaderView(StackView)",
                      "22、webView预览",
                      "23、um统计",
                      "24、富文本点击事件Label", "25、联动", "26、人脸识别", "27、拼接图片", "28、tableView编辑", "29、百度地图-搜索",
                      "30、输入框开始编辑内容全选",
                      "31、直播LFLiveKit",
                      "32、七牛云-直播流",
                      "33、七牛云-短视频",
                      "34、录制完成-选择-视频播放",
                      "35、发送邮件",
                      "36、一键登录（友盟）"
                      
        ]
    }
}

extension GATestViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GATestViewCell.identifier, for: indexPath) as! GATestViewCell
        cell.l.text = dataSource[indexPath.row] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcs = [
            dataSource[0] as! String : GAEstimatedCollectionViewController(),
            dataSource[1] as! String : YYInterlockViewController(),
            dataSource[2] as! String : YYHomeViewController(),
            dataSource[3] as! String : GAWebViewViewController(),
            dataSource[4] as! String : GATagCollectionViewController(),
            dataSource[5] as! String : GALayoutKitViewController(),
            dataSource[6] as! String : GALayoutKitViewController(),
            dataSource[7] as! String : GAHtmlTagViewController(),
            dataSource[8] as! String : YYCardIOViewController(),
            dataSource[9] as! String : GATransitionableTabViewController(),
            dataSource[10] as! String : GAHeroAnimationViewController(),
            dataSource[11] as! String : YYPlayerViewController(nibName: "YYPlayerViewController", bundle: nil),
            dataSource[12] as! String : YYSliderViewController(nibName: "YYSliderViewController", bundle: nil),
            dataSource[13] as! String : GATestJsonViewController(nibName: "GATestJsonViewController", bundle: nil),
            dataSource[14] as! String : YYImageSignatureViewController(nibName: "YYImageSignatureViewController", bundle: nil),
            dataSource[15] as! String : YYImagesSignatureViewController(),
            dataSource[16] as! String : YYImagesSignatureScrollViewController(),
            dataSource[17] as! String : GAPDFSignatureViewController(),
            dataSource[18] as! String : GAWordFileSignatureViewController(),
            dataSource[19] as! String : PXVideoViewController(nibName: "PXVideoViewController", bundle: nil),
            dataSource[20] as! String : GALocalVideoPlayerViewController(nibName: "GALocalVideoPlayerViewController", bundle: nil),
            dataSource[21] as! String : GAStackViewViewController(nibName: "GAStackViewViewController", bundle: nil),
            dataSource[22] as! String : GAWebViewPreviewViewController(),
            dataSource[23] as! String : GAUMViewController(nibName: "GAUMViewController", bundle: nil),
            dataSource[24] as! String : GAEventLabelViewController(),
            dataSource[25] as! String : YYInterlockViewController(),
            dataSource[26] as! String : GABD_FaceRootViewController(nibName: "GABD_FaceRootViewController", bundle: nil),
            dataSource[27] as! String : TogetherImageViewController(),
            dataSource[28] as! String : GAEditTableViewController(),
            dataSource[29] as! String : GABDMapViewController(nibName: "GABDMapViewController", bundle: nil),
            dataSource[30] as! String : GATextFieldSelectedAllViewController(nibName: "GATextFieldSelectedAllViewController", bundle: nil),
            dataSource[31] as! String : LFLiveKitViewController(nibName: "LFLiveKitViewController", bundle: nil),
            dataSource[32] as! String : PLCameraStreamingKitViewController(nibName: "PLCameraStreamingKitViewController", bundle: nil),
            dataSource[33] as! String : PLShortVideoKitViewController(nibName: "PLShortVideoKitViewController", bundle: nil),
            dataSource[34] as! String : PLSelectedVideoListViewController(),
            dataSource[35] as! String : GASendEmailViewController(nibName: "GASendEmailViewController", bundle: nil),
            dataSource[36] as! String : GAUMLoginVeiwController()
            
            
        ]
        
        let name = dataSource[indexPath.row] as! String
        let vc = vcs[name]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension GATestViewController: UITableViewPlaceHolderDelegate {
    // 如果有其他样式图片可以重写此方法
    @objc func tableViewPlaceHolderView() -> UIView {
        let v = GAListPlaceholderView.ga_xibView()
        v.imgName = "list_noData"
        return v
    }
    
    func tableViewEnableScrollWhenPlaceHolderViewShowing() -> Bool {
        return false
    }
    
    func tableViewClickedPlaceHolderViewRefresh() {
        
    }
    
    func tableViewPlaceHolder_NoNetWork_View() -> UIView? {
        let v = GAListPlaceholderView.ga_xibView()
        v.imgName = "list_noWIFI"
        return v
    }
}
