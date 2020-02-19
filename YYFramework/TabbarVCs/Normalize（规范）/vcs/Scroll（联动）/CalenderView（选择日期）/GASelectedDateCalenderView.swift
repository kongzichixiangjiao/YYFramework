//
//  GASelectedDateCalenderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GASelectedDateCalenderViewDelegate: class {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat)
}

class GASelectedDateCalenderView: UIView {
    
    //MARK:
    enum ScrollDirection: Int {
        case left = 1, right = 2, normal = 99
    }
    
    weak var delegate: GASelectedDateCalenderViewDelegate?
    
    private let _basisYear: Int = 0
    var initFinishedYears = [Int]()
    
    var startDate: String = ""
    var endDate: String = ""
    private var startOffsetX: CGFloat = 0 // 左滑 右滑
    private var scrollDirection: ScrollDirection = .normal
    
    public var currentYear = GADate.currentYear()
    public var currentMonth = GADate.currentMonth()
    public var selectedDay = GADate.currentDay()
    
    private var _monthModels: [[GACalenderModel]] = []
    private var _weekModels: [[GACalenderModel]] = []
    
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
        v.isPagingEnabled = true
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    lazy var weekHeaderView: GACalenderWeekHeaderView = {
        let v = GACalenderWeekHeaderView(frame: CGRect(x: 0, y: self.controlHeaderView.bounds.maxY + 10, width: self.bounds.width, height: GACalenderWeekHeaderView.height))
        return v
    }()
    
    lazy var controlHeaderView: GACalenderControlHeaderView = {
        let v = GACalenderControlHeaderView(frame:  CGRect(x: 0, y: 0, width: self.bounds.width, height: GACalenderControlHeaderView.height))
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initView()
        _initData()
        
        //        _initPanGesture()
    }
    
    // MARK: 初始化view
    private func _initView() {
        collectionView.yy_register(nibName: GACalenderMonthCell.identifier)
        self.addSubview(controlHeaderView)
        self.addSubview(weekHeaderView)
        self.addSubview(collectionView)
        
        _updateViewsFrame()
    }
    
    // MARK: 手势
    private func _initPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(_collectionViewPanAction(sender:)))
        pan.delegate = self
        
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
                } else {
                    print("左滑动")
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
    
    // MARK: 数据初始化
    private func _initData() {
        _initMonthModels(year: currentYear, isInit: true)
    }
    
    // MARK: 月份数据初始化
    func _initMonthModels(year: Int, isInit: Bool = true) {
        // 当前年份数据是不是已经加载了
        for y in initFinishedYears {
            if y == year {
                return
            }
        }
        
        if scrollDirection == .left {
            initFinishedYears.append(year)
        } else {
            initFinishedYears.insert(year, at: 0)
        }
        
        var monthModels: [GACalenderModel] = []
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
        
        var monthItems = [GACalenderModel]()
        for i in 0..<monthModels.count {
            monthItems.append(monthModels[i])
            if i != 0 && (i + 1) % 12 == 0 {
                if scrollDirection == .left {
                    _monthModels.append(monthItems)
                } else {
                    _monthModels.insert(monthItems, at: 0)
                }
                monthItems.removeAll()
            }
        }
        
        if isInit {
            _scrollTo(year: year, month: currentMonth, type: .left)
            controlHeaderView.middleText = "\(year)-\(currentMonth)"
        } else {
            if scrollDirection == .left {
                
            } else {
                _scrollTo(year: currentYear, month: 1, type: .left)
                controlHeaderView.middleText = "\(currentYear)-\(1)"
            }
        }
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
    
    // MARK: 滚动到某年某月
    private func _scrollTo(year: Int, month: Int, day: Int = -1, type: UICollectionView.ScrollPosition) {
        collectionView.reloadData()
        guard let index = initFinishedYears.firstIndex(of: year) else {
            return
        }
        let indexPath = IndexPath(item: month - 1, section: index)
        collectionView.scrollToItem(at: indexPath, at: type, animated: false)
    }
    
    // MARK: 点击上一月 下一月
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
    
    // MARK: 点击上一周 下一周
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
    
    // MARK: 头部年月
    private func _setupControlerHeaderView(year: Int, month: Int) {
        controlHeaderView.middleText = "\(year)-\(month)"
    }
    
    // MARK: 更新Frame
    private func _updateViewsFrame() {
        
        var h: CGFloat = 0
        let count = GADate.getCountOfDaysInMonth(year: currentYear, month: currentMonth) + GADate.firstWeekDay(year: currentYear, month: currentMonth)
        h = CGFloat(count + 7 - count % 7) / 7 * (kScreenWidth / 7)
        
        self.frame = CGRect(x: 0, y: self.y, width: self.width, height: h + GACalenderWeekHeaderView.height + GACalenderControlHeaderView.height)
        
        controlHeaderView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: GACalenderControlHeaderView.height)
        weekHeaderView.frame = CGRect(x: 0, y: self.controlHeaderView.bounds.maxY, width: self.bounds.width, height: GACalenderWeekHeaderView.height)
        collectionView.frame = CGRect(x: 0, y: weekHeaderView.maxY, width: collectionView.width, height: h)
        collectionView.reloadData()
        
        delegate?.selectedDateCalenderView_updateViewsFrame(h: self.frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UICollectionViewDelegate
extension GASelectedDateCalenderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GACalenderMonthCell.identifier, for: indexPath) as! GACalenderMonthCell
        let model = _monthModels[indexPath.section]
        cell.model = model[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _monthModels[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _monthModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _ = _monthModels[indexPath.section][indexPath.row]
        return collectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt", indexPath)
    }
}

// MARK: ScrollViewDelegate
extension GASelectedDateCalenderView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetX: CGFloat = scrollView.contentOffset.x
        if currentOffsetX > startOffsetX { // 左滑
            scrollDirection = .left
        } else {
            scrollDirection = .right
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentCell = (collectionView.visibleCells.first as! GACalenderMonthCell)
        
        var year = currentCell.model.year
        let month = currentCell.model.month
        let _ = currentCell.model.day
        currentCell.reloadData(model: currentCell.model)
        
        _setupControlerHeaderView(year: year, month: month)
        
        currentYear = year
        currentMonth = month
        
        _updateViewsFrame()
        
        if scrollDirection == .left && currentMonth == 12 {
            year += 1
        }
        
        if scrollDirection == .right && currentMonth == 1 {
            year -= 1
        }
        
        _initMonthModels(year: year, isInit: false)
    }
}

// MARK: GACalenderControlHeaderViewDelegate
extension GASelectedDateCalenderView: GACalenderControlHeaderViewDelegate {
    
    func calenderControlHeaderView_left() {
        _updateCalenderView(type: .left)
    }
    
    func calenderControlHeaderView_right() {
        _updateCalenderView(type: .right)
    }
    
    func calenderControlHeaderView_title() {
        
    }
}

// MARK: GACalenderMonthCellDelegate
extension GASelectedDateCalenderView: GACalenderMonthCellDelegate {
    func calenderMonthCell(model: GACalenderModel, allRow: Int) {
        
    }
    
    func calenderMonthCellDidSelected(indexPath: IndexPath, day: Int) {
        let currentCell = (collectionView.visibleCells.first as! GACalenderMonthCell)
        let model: GACalenderModel = currentCell.model
        
        let year = model.year
        let month = model.month
        let sDay = day
        let dateString = "\(year)-\(month)-\(day)"
        print(dateString)
        
        startDate = dateString
        endDate = dateString
        
        selectedDay = sDay
        
        currentYear = model.year
        currentMonth = model.month
    }
    
}

// MARK: UIGestureRecognizerDelegate
extension GASelectedDateCalenderView: UIGestureRecognizerDelegate {
    
}


