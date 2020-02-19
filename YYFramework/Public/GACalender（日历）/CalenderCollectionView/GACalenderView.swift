//
//  GACalenderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/16.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

enum GACalenderViewType: Int {
    case week = 1, month = 2
}

class GACalenderView: UIView {
    private let _basisYear: Int = 100
    
    public var currentYear = GADate.currentYear()
    public var currentMonth = GADate.currentMonth()
    public var selectedDay = GADate.currentDay()
    
    private var _monthModels: [[GACalenderModel]] = []
    private var _weekModels: [[GACalenderModel]] = []
    
    private var _type: GACalenderViewType = .month
    
    private var startOffsetX: CGFloat = 0 // 左滑 右滑
    
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: flow)
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.isPagingEnabled = false
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    lazy var weekHeaderView: GACalenderWeekHeaderView = {
        let v = "GACalenderWeekHeaderView".xibLoadView() as! GACalenderWeekHeaderView
        v.backgroundColor = UIColor.purple
        v.frame = CGRect(x: 0, y: self.controlHeaderView.bounds.maxY + 10, width: self.bounds.width, height: GACalenderWeekHeaderView.height)
        return v
    }()
    
    lazy var controlHeaderView: GACalenderControlHeaderView = {
        let v = "GACalenderControlHeaderView".xibLoadView() as! GACalenderControlHeaderView
        v.backgroundColor = UIColor.orange
        v.delegate = self
        v.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: GACalenderControlHeaderView.height)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initView()
        _initData()
        
        _initPanGesture()
    }
    
    private func _initView() {
        self.addSubview(controlHeaderView)
        self.addSubview(weekHeaderView)
        self.addSubview(collectionView)
        
        let h = (kScreenWidth / 7) * (_type == .week ? 1 : 6)
        collectionView.frame = CGRect(x: 0, y: weekHeaderView.frame.origin.y + weekHeaderView.bounds.height, width: self.bounds.width, height: h)
        collectionView.yy_register(nibName: GACalenderMonthCell.identifier)
        
    }
    
    private func _initPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(_collectionViewPanAction(sender:)))
        pan.delegate = self
        
        //        collectionView.addGestureRecognizer(pan)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(_collectionViewSwipeAction(sender:)))
        swipe.direction = .down
        self.addGestureRecognizer(swipe)
        
        let swipe1 = UISwipeGestureRecognizer(target: self, action: #selector(_collectionViewSwipeAction(sender:)))
        swipe1.direction = .up
        self.addGestureRecognizer(swipe1)
        
    }
    
    @objc private func _collectionViewTapAction(sender: UITapGestureRecognizer) {
        print(sender)
    }
    
    @objc private func _collectionViewSwipeAction(sender: UISwipeGestureRecognizer) {
        print(sender.direction)
        if sender.direction == .down && _type == .week {
            _type = .month
            
            _scrollTo(year: currentYear, month: currentMonth, type: .left)
        }
        
        if sender.direction == .up && _type == .month {
            _type =  .week
            let date = GADate.dateStringToDate("\(currentYear)-\(currentMonth)-\(selectedDay)", fromateType: GADateFormatType.y_m_d)
            _initWeekModels(date: date)
        }
        _updateViewsFrame()
    }
    
    @objc private func _collectionViewPanAction(sender: UIPanGestureRecognizer) {
        let xV = sender.velocity(in: collectionView).x
        let _ = sender.velocity(in: collectionView).y
        let _ = sender.translation(in: collectionView).x
        let _ = sender.translation(in: collectionView).y
        
        switch sender.state {
        case .began:
            break
        case .ended:
            if abs(xV) > 500 {
                if xV > 0 {
                    print("右滑动")
                    if _type == .month {
                        _updateCalenderView(type: UICollectionView.ScrollPosition.left)
                    }
                    if _type == .week {
                        _updateCalenderWeekView(type: UICollectionView.ScrollPosition.left)
                    }
                } else {
                    print("左滑动")
                    if _type == .month {
                        _updateCalenderView(type: UICollectionView.ScrollPosition.right)
                    }
                    if _type == .week {
                        _updateCalenderWeekView(type: UICollectionView.ScrollPosition.right)
                    }
                }
            }
            
            break
        case .changed:
            break
        case .possible:
            break
        case .cancelled:
            break
        case .failed:
            break
        @unknown default: break
            
        }
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
    
    private func _scrollTo(year: Int, month: Int, day: Int = -1, type: UICollectionView.ScrollPosition) {
        if _type == .week {
            
        } else {
            collectionView.reloadData()
            let indexPath = IndexPath(item: month, section: year - GADate.currentYear() + _basisYear)
            collectionView.scrollToItem(at: indexPath, at: type, animated: true)
        }
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
    
    private func _updateCalenderWeekView(type: UICollectionView.ScrollPosition) {
        var date = GADate.dateStringToDate(String(_weekModels[1].first!.year) + "-" + String(_weekModels[1].first!.month) + "-" + String(_weekModels[1].first!.day), fromateType: GADateFormatType.y_m_d)
        
        if type == .left {
            date = GADate.getNextWeek(date, type: GADateNextWeekType.before).first!
        }
        
        if type == .right {
            date = GADate.getNextWeek(date, type: GADateNextWeekType.next).first!
        }
        
        _initWeekModels(date: date)
        _updateViewsFrame()
    }
    
    
    private func _setupControlerHeaderView(year: Int, month: Int) {
        controlHeaderView.middleText = "\(year)-\(month)"
    }
    
    private func _updateViewsFrame() {
        
        
        var h: CGFloat = 0
        if _type == .week {
            h = kScreenWidth / 7
        }
        
        if _type == .month {
            let count = GADate.getCountOfDaysInMonth(year: currentYear, month: currentMonth) + GADate.firstWeekDay(year: currentYear, month: currentMonth)
            h = CGFloat(count + 7 - count % 7) / 7 * (kScreenWidth / 7)
        }
        
        self.frame = CGRect(x: 0, y: self.y, width: self.width, height: h + GACalenderWeekHeaderView.height + GACalenderControlHeaderView.height)
        
        controlHeaderView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: GACalenderControlHeaderView.height)
        weekHeaderView.frame = CGRect(x: 0, y: self.controlHeaderView.bounds.maxY + 10, width: self.bounds.width, height: GACalenderWeekHeaderView.height)
        
        collectionView.frame = CGRect(x: 0, y: weekHeaderView.maxY, width: collectionView.width, height: h)
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: CollectionViewDelegate
extension GACalenderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetX: CGFloat = scrollView.contentOffset.x
        if currentOffsetX > startOffsetX { // 左滑
            print("左滑")
        } else {
            print("右滑")
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
}

extension GACalenderView {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentCell = (collectionView.visibleCells.first as! GACalenderMonthCell)
        
        if _type == .month {
            let year = currentCell.model.year
            let month = currentCell.model.month
            let _ = currentCell.model.day
            currentCell.reloadData(model: currentCell.model)
            
            _setupControlerHeaderView(year: year, month: month)
            
            currentYear = year
            currentMonth = month
        } else {
            let year = currentCell.weekModels.first!.year
            let month = currentCell.weekModels.first!.month
            let day = currentCell.weekModels.first!.day
            let date = GADate.dateStringToDate("\(year)-\(month)-\(day)", fromateType: GADateFormatType.y_m_d)
            _initWeekModels(date: date)
        }
        _updateViewsFrame()
    }
}

extension GACalenderView: GACalenderControlHeaderViewDelegate {
    
    func calenderControlHeaderView_left() {
        _updateCalenderView(type: .left)
    }
    
    func calenderControlHeaderView_right() {
        _updateCalenderView(type: .right)
    }
    
    func calenderControlHeaderView_title() {
        
    }
}

extension GACalenderView: GACalenderMonthCellDelegate {
    func calenderMonthCell(model: GACalenderModel, allRow: Int) {
        
    }
    
    func calenderMonthCellDidSelected(indexPath: IndexPath, day: Int) {
        let currentCell = (collectionView.visibleCells.first as! GACalenderMonthCell)
        var model: GACalenderModel!
        if _type == .week {
            model = currentCell.weekModels[indexPath.row]
        } else{
            model = currentCell.model
        }
        let year = model.year
        let month = model.month
        let sDay = _type == .week ? model.day : day
        print("\(year)-\(month)-\(day)")
        
        selectedDay = sDay
        
        currentYear = model.year
        currentMonth = model.month
    }
    
}

extension GACalenderView: UIGestureRecognizerDelegate {
    
}






