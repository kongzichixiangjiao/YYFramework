//
//  GABDMapViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/10/15.
//  Copyright © 2019 houjianan. All rights reserved.
//  百度地图 百度定位

import UIKit

class GABDMapViewController: GANavViewController {
    /*
    var _locationManager: BMKLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "百度地图", isShow: true)
//        _poiInit()
        _location()
    }
    
    private func _poiInit(latitude: CLLocationDegrees?, longitude: CLLocationDegrees?) {
        let search = BMKPoiSearch()
        search.delegate = self
        //初始化请求参数类BMKNearbySearchOption的实例
        let nearbyOption = BMKPOINearbySearchOption()
        //检索关键字，必选
        nearbyOption.keywords = ["小吃", "美食"]
        //检索中心点的经纬度，必选
        nearbyOption.location = CLLocationCoordinate2DMake(latitude ?? 0, longitude ?? 0)
        //检索半径，单位是米。
        nearbyOption.radius = 1000
        //检索分类，可选。
        nearbyOption.tags = ["小吃", "美食"]
        //是否严格限定召回结果在设置检索半径范围内。默认值为false。
        nearbyOption.isRadiusLimit = false
        //POI检索结果详细程度
        //nearbyOption.scope = BMK_POI_SCOPE_BASIC_INFORMATION;
        //检索过滤条件，scope字段为BMK_POI_SCOPE_DETAIL_INFORMATION时，filter字段才有效
        //nearbyOption.filter = filter;
        //分页页码，默认为0，0代表第一页，1代表第二页，以此类推
        nearbyOption.pageIndex = 0
        //单次召回POI数量，默认为10条记录，最大返回20条。
        nearbyOption.pageSize = 10
        
        let flag = search.poiSearchNear(by: nearbyOption)
        if(flag) {
            self.view.ga_showView("POI周边检索成功")
        } else {
            self.view.ga_showView("POI周边检索失败")
        }
    }
    
    private func _location() {
        
        let locationManager = BMKLocationManager()
        locationManager.delegate = self
        locationManager.coordinateType = BMKLocationCoordinateType.BMK09LL
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.locationTimeout = 10
        locationManager.reGeocodeTimeout = 10

        locationManager.requestLocation(withReGeocode: true, withNetworkState: true) { (location, state, error) in
//            print(location?.location?.coordinate.latitude)
//            print(location?.location?.coordinate.longitude)
            
            self._poiInit(latitude: (location?.location?.coordinate.latitude), longitude: location?.location?.coordinate.longitude)
            
//            print(state)
//            print(error)
        }
        
        
        
        //初始化实例
        _locationManager = BMKLocationManager()
        //设置delegate
        _locationManager.delegate = self
        //设置返回位置的坐标系类型
        _locationManager.coordinateType = BMKLocationCoordinateType.BMK09LL
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //设置应用位置类型
        _locationManager.activityType = .automotiveNavigation
        
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = false
        //设置是否允许后台定位
        //        _locationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10
        
        
        _locationManager.locatingWithReGeocode = true
        _locationManager.startUpdatingLocation()
        
        _locationManager.requestLocation(withReGeocode: true, withNetworkState: true) { (location, state, error) in
//            print(location)
//            print(state)
//            print(error)
        }
    }
 */
}
/*
extension GABDMapViewController: BMKPoiSearchDelegate {
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPOISearchResult!, errorCode: BMKSearchErrorCode) {
//        print(poiResult)
//        print(poiResult.poiInfoList)
//        for poi in poiResult.poiInfoList {
//            print(poi.city, poi.area, poi.address, poi.detailInfo.children)
//        }
    }
}

extension GABDMapViewController: BMKLocationManagerDelegate {
    func bmkLocationManager(_ manager: BMKLocationManager, doRequestAlwaysAuthorization locationManager: CLLocationManager) {
        print(manager)
    }
    
    func bmkLocationManager(_ manager: BMKLocationManager, didFailWithError error: Error?) {
//        print(error)
    }
    
    func bmkLocationManager(_ manager: BMKLocationManager, didUpdate state: BMKLocationNetworkState, orError error: Error?) {
        print(state)
    }
}
*/
