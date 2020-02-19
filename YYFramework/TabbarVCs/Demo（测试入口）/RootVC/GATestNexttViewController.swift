//
//  File.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/12.
//  Copyright © 2020 houjianan. All rights reserved.
//

class GATestNexttViewController: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        base_showNavigationView(title: "Demo", isShow: true)
        base_initTableView()
    }
    
    override func base_initTableView() {
        super.base_initTableView()
        tableView.yy_register(nibName: GATestViewCell.identifier)
    }
    
    func initData() {
        dataSource = ["0、presentVC样式",
                      "1、水印（catextlayer）",
                      "2、访问通讯录",
                      "3、震动",
                      "4、城市地区选择",
                      "5、埋点统计",
                      "6、多个按钮排列",
                      "7、编辑的弹框",
                      "8、图片展示",
                      "9、搜索框",
                      "10、城市选择",
                      "11、偏好排序",
                      "12、View添加Icon",
                      "13、视频录制、图片、视频选择",
                      "14、表格",
                      "15、筛选",
                      "16、登录/退出",
                      "17、时间选择",
                      "18、输入验证码",
                      "19、输入邮箱提醒",
                      "20、runtime",
                      "21、flutter入口",
                      "22、图表📈",
                      "23、JSON转Model Model转JSON"
        ]
    }
}

extension GATestNexttViewController {
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
            dataSource[0] as! String : PresentsViewController(nibName: "PresentsViewController", bundle: nil),
            dataSource[1] as! String : GAWatermarkViewController(nibName: "GAWatermarkViewController", bundle: nil),
            dataSource[2] as! String : GAAddressBookViewController(nibName: "GAAddressBookViewController", bundle: nil),
            dataSource[3] as! String : GAVibrationViewController(nibName: "GAVibrationViewController", bundle: nil),
            dataSource[4] as! String : GARootAreaPickerViewController(nibName: "GARootAreaPickerViewController", bundle: nil),
            dataSource[5] as! String : GAMaiDianViewController(nibName: "GAMaiDianViewController", bundle: nil),
            dataSource[6] as! String : GATagsViewViewController(nibName: "GATagsViewViewController", bundle: nil),
            dataSource[7] as! String : GAEditAlertViewController(nibName: "GAEditAlertViewController", bundle: nil),
            dataSource[8] as! String : GAImageViewsViewController(nibName: "GAImageViewsViewController", bundle: nil),
            dataSource[9] as! String : GASearchViewViewController(nibName: "GASearchViewViewController", bundle: nil),
            dataSource[10] as! String : GASelectedCityViewController(nibName: "GASelectedCityViewController", bundle: nil),
            dataSource[11] as! String : GAPreferenceOrderingViewController(nibName: "GAPreferenceOrderingViewController", bundle: nil),
            dataSource[12] as! String : GAAddIconViewController(nibName: "GAAddIconViewController", bundle: nil),
            dataSource[13] as! String : GAVideoRooterViewController(nibName: "GAVideoRooterViewController", bundle: nil),
            dataSource[14] as! String : GAFormViewController(),
            dataSource[15] as! String : GAScreeningViewController(),
            dataSource[16] as! String : GALoginViewController(nibName: "GALoginViewController", bundle: nil),
            dataSource[17] as! String : GASelectedDateViewController(nibName: "GASelectedDateViewController", bundle: nil),
            dataSource[18] as! String : GAVerificationCodeViewController(nibName: "GAVerificationCodeViewController", bundle: nil),
            dataSource[19] as! String : GATextFieldEmailAlertViewController(nibName: "GATextFieldEmailAlertViewController", bundle: nil),
            dataSource[20] as! String : GARuntimeViewController(nibName: "GARuntimeViewController", bundle: nil),
            dataSource[21] as! String : GAFlutterRooterViewController(nibName: "GAFlutterRooterViewController", bundle: nil),
            dataSource[22] as! String : GAChartsViewController(nibName: "GAChartsViewController", bundle: nil),
            dataSource[23] as! String : GACodableViewController(nibName: "GACodableViewController", bundle: nil)
            
        ]
        
        let name = dataSource[indexPath.row] as! String
        let vc = vcs[name]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
