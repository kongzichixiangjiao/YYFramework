//
//  GACalenderScrollView.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderScrollView: UIView {
    private let _basisYear: Int = 2
    
    public var currentYear = GADate.currentYear()
    public var currentMonth = GADate.currentMonth()
    public var selectedDay = GADate.currentDay()
    
    private var _monthModels: [[GACalenderModel]] = []
    private var _weekModels: [[GACalenderModel]] = []
    private var _sectionModels: [[GACalenderModel]] = []
    
    private var _type: GACalenderViewType = .month
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: self.bounds)
        v.tag = 1002
        v.backgroundColor = UIColor.orange
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsHorizontalScrollIndicator = true
        v.showsVerticalScrollIndicator = true
        v.isPagingEnabled = true
        v.delegate = self
        return v
    }()
    
    lazy var scrollUpView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.lightGray
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: flow)
        v.tag = 1001
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.isPagingEnabled = true
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    lazy var weekHeaderView: GACalenderWeekHeaderView = {
        let v = GACalenderWeekHeaderView(frame: CGRect(x: 0, y: self.controlHeaderView.bounds.maxY + 10, width: self.bounds.width, height: GACalenderWeekHeaderView.height))
        v.backgroundColor = UIColor.purple
        return v
    }()
    
    lazy var controlHeaderView: GACalenderControlHeaderView = {
        let v = GACalenderControlHeaderView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: GACalenderControlHeaderView.height))
        v.backgroundColor = UIColor.orange
        v.delegate = self
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initData()
        _initView()
        
    }
    
    private func _initView() {
        self.addSubview(controlHeaderView)
        self.addSubview(weekHeaderView)
        self.addSubview(scrollView)
        
        let h = (kScreenWidth / 7) * (_type == .week ? 1 : 6)
        scrollView.frame = CGRect(x: 0, y: weekHeaderView.frame.origin.y + weekHeaderView.bounds.height, width: self.bounds.width, height: h)
        
        scrollUpView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: scrollView.height + 1)
        scrollView.contentSize = scrollUpView.size
        
        scrollView.addSubview(scrollUpView)
        
        collectionView.frame = scrollView.bounds
        collectionView.yy_register(nibName: GACalenderMonthCell.identifier)
        scrollUpView.addSubview(collectionView)
    }
    
    private func _initData() {
        if _type == .month {
            // INIT MONTH Models
            let date = GADate.dateStringToDate("\(GADate.currentDate.year)-\(GADate.currentDate.month)-01", fromateType: GADateFormatType.y_m_d)
            _initMonthModels(date: date)
        }
        
        if _type == .week {
            // INIT WEEK Models
            _initWeekModels(date: GADate.currentDate)
        }
    }
    
    private func _initMonthModels(date: Date) {
        var monthModels: [GACalenderModel] = []
        for year in (currentYear - _basisYear)..<(currentYear + _basisYear) {
            var days: [Int] = []
            
            for month in 1..<13 {
                days.append(GADate.getCountOfDaysInMonth(year: year, month: month))
                let model = GACalenderModel()
                model.year = year
                model.month = month
                model.days = Array<Int>.ga_init_IntArray(start: 1, end: GADate.getCountOfDaysInMonth(year: year, month: month)+1)
                
                let count = GADate.getCountOfDaysInMonth(year: year, month: month) + GADate.firstWeekDay(year: year, month: month)
                let h: CGFloat = CGFloat(count + 7 - count % 7) / 7 * (kScreenWidth / 7)
                
                model.monthHeight = h
                
                monthModels.append(model)
            }
        }
        
        var monthItems = [GACalenderModel]()
        for i in 0..<monthModels.count {
            monthItems.append(monthModels[i])
            if i != 0 && (i + 1) % 12 == 0 {
                _monthModels.append(monthItems)
                monthItems.removeAll()
            }
        }
        
        _scrollTo(year: currentYear, month: currentMonth, type: .left)
        
        controlHeaderView.middleText = "\(currentYear)-\(currentMonth)"
    }
    
    private func _initWeekModels(date: Date) {
        let currentWeekDay = GADate.getWeekDates(date)
        let currentBeforeWeekDay = GADate.getNextWeek(date, type: .before)
        let currentNextWeekDay = GADate.getNextWeek(date, type: .next)
        
        let weeks = [currentBeforeWeekDay, currentWeekDay, currentNextWeekDay]
        _weekModels.removeAll()
        for week in weeks {
            var models = [GACalenderModel]()
            for day in week {
                let model = GACalenderModel()
                model.year = day.year
                model.month = day.month
                model.day = day.day
                models.append(model)
            }
            _weekModels.append(models)
        }
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
    }
    
//    private func _initData() {
//        var models: [GACalenderModel] = []
//        for year in (currentYear - _basisYear)..<(currentYear + _basisYear) {
//            var days: [Int] = []
//
//            for month in 1..<13 {
//                days.append(GADate.getCountOfDaysInMonth(year: year, month: month))
//                let model = GACalenderModel()
//                model.year = year
//                model.month = month
//                model.days = Array<Int>.ga_init_IntArray(start: 1, end: GADate.getCountOfDaysInMonth(year: year, month: month)+1)
//
//                let count = GADate.getCountOfDaysInMonth(year: year, month: month) + GADate.firstWeekDay(year: year, month: month)
//                let h: CGFloat = CGFloat(count + 7 - count % 7) / 7 * (kScreenWidth / 7)
//
//                model.monthHeight = h
//
//                models.append(model)
//            }
//        }
//
//        var items = [GACalenderModel]()
//        for i in 0..<models.count {
//            items.append(models[i])
//            if i != 0 && (i + 1) % 12 == 0 {
//                _sectionModels.append(items)
//                items.removeAll()
//            }
//        }
//
//        _scrollTo(year: currentYear, month: currentMonth, type: .left)
//        controlHeaderView.ymLabel.text = "\(currentYear)-\(currentMonth)"
//    }
    
    private func _scrollTo(year: Int, month: Int, type: UICollectionView.ScrollPosition) {
        
    }
    
    private func _updateCalenderView(type: UICollectionView.ScrollPosition, isScroll: Bool = true) {
        if type == .left {
            currentMonth -= 1
        } else {
            currentMonth += 1
        }
        if currentMonth == 0 {
            currentYear = currentYear - 1
            currentMonth = 12
        } else if currentMonth == 13 {
            currentYear = currentYear + 1
            currentMonth = 1
        }
        
        if isScroll {
            _scrollTo(year: currentYear, month: currentMonth, type: type)
        }
        
        _setupControlerHeaderView(year: currentYear, month: currentMonth)
        
        _updateViewsFrame()
    }
    
    private func _setupControlerHeaderView(year: Int, month: Int) {
        controlHeaderView.middleText = "\(year)-\(month)"
    }
    
    private func _updateViewsFrame() {
        let count = GADate.getCountOfDaysInMonth(year: currentYear, month: currentMonth) + GADate.firstWeekDay(year: currentYear, month: currentMonth)
        let _: CGFloat = CGFloat(count + 7 - count % 7) / 7 * (kScreenWidth / 7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GACalenderScrollView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GACalenderMonthCell.identifier, for: indexPath) as! GACalenderMonthCell
        cell._type = _type
        let model = _type == .month ? _monthModels[indexPath.section] : _weekModels[indexPath.row]
        if _type == .week {
            cell.weekModels = model
        } else {
            cell.model = model[indexPath.row]
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _type == .week ? _weekModels.count : _monthModels[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _type == .week ? 1  : _monthModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if _type == .week {
            return CGSize(width: collectionView.width, height: kScreenWidth / 7)
        }
        let _ = _monthModels[indexPath.section][indexPath.row]
        //        return CGSize(width: collectionView.size.width, height: model.monthHeight)
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt", indexPath)
    }
}

extension GACalenderScrollView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        #if DEBUG
        //        print("month: ", (collectionView.visibleCells.first as! GACalenderMonthCell).model.month)
        //        print("year: ", (collectionView.visibleCells.first as! GACalenderMonthCell).model.year)
        #endif
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let _ = scrollView.contentOffset.y
    }
}

extension GACalenderScrollView: GACalenderControlHeaderViewDelegate {
    
    func calenderControlHeaderView_left() {
        _updateCalenderView(type: .left)
    }
    
    func calenderControlHeaderView_right() {
        _updateCalenderView(type: .right)
    }
    
    func calenderControlHeaderView_title() {
        
    }
}

extension GACalenderScrollView: GACalenderMonthCellDelegate {
    func calenderMonthCell(model: GACalenderModel, allRow: Int) {
        print(allRow)
    }
    
    func calenderMonthCellDidSelected(indexPath: IndexPath, day: Int) {
        
    }
    
}
