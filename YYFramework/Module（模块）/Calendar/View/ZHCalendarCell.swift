//
//  ZHCalendarCell.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/24.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ZHCalendarCell: UITableViewCell {
    
    @IBOutlet weak var cView: UIView!
    
    @IBOutlet weak var cViewTop: NSLayoutConstraint!
    
    
    var testCalendar = Calendar.current
    let formatter = DateFormatter()
    var monthSize: MonthSize? = nil
    var numberOfRows: Int = 7 {
        didSet {
            print("scrollDidEndDecelerating")
            //            if numberOfRows == 7 {
            //                numberOfRows = 1
            //            } else {
            //                numberOfRows = 7
            //            }
            
            switch numberOfRows {
            case 7:
                calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300)
            case 1:
                calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)
            default:
                calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300)
            }
            
            calendarView.reloadData()
            // 滚动到当前月
            calendarView.scrollToDate(Date())
            
        }
    }
    
    var scrollY: CGFloat! {
        didSet {
//            self.calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300 - scrollY)
            cViewTop.constant = -scrollY
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.white
        
        cView.addSubview(calendarView)
        
        calendarView.yy_register(nibName: TestRangeSelectionViewControllerCell.identifier)
        calendarView.yy_registerSection(nibName: ZHMonthHeaderView.identifier)
        calendarView.register(UINib(nibName: ZHMonthHeaderView.identifier, bundle: Bundle.main),
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: ZHMonthHeaderView.identifier)
        calendarView.reloadData()
        
        self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
        // 滚动到当前月
        calendarView.scrollToDate(Date())
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    lazy var calendarView: JTAppleCalendarView = {
        let v = JTAppleCalendarView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 300))
        v.calendarDelegate = self
        v.calendarDataSource = self
        v.backgroundColor = UIColor.orange
        v.allowsMultipleSelection = true // 允许选择多个日期
        v.isRangeSelectionUsed = true // 允许进行日期区域选择
        v.scrollDirection = .horizontal
        v.cellSize = UIScreen.main.bounds.width / 7
        v.minimumLineSpacing = 5
        v.minimumInteritemSpacing = 5
        v.scrollingMode = .stopAtEachCalendarFrame
        /*
         /// stopAtEachCalendarFrame - non-continuous scrolling that will stop at each frame
         case stopAtEachCalendarFrame
         /// stopAtEachSection - non-continuous scrolling that will stop at each section
         case stopAtEachSection
         /// stopAtEach - non-continuous scrolling that will stop at each custom interval
         case stopAtEach(customInterval: CGFloat)
         /// nonStopToSection - continuous scrolling that will stop at a section
         case nonStopToSection(withResistance: CGFloat)
         /// nonStopToCell - continuous scrolling that will stop at a cell
         case nonStopToCell(withResistance: CGFloat)
         /// nonStopTo - continuous scrolling that will stop at acustom interval
         case nonStopTo(customInterval: CGFloat, withResistance: CGFloat)
         /// none - continuous scrolling that will eventually stop at a point
         case none
         */
        return v
    }()
    
    
    func handleConfiguration(cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? TestRangeSelectionViewControllerCell else { return }
        handleCellColor(cell: cell, cellState: cellState)
        handleCellSelection(cell: cell, cellState: cellState)
    }
    
    func handleCellColor(cell: TestRangeSelectionViewControllerCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.label.textColor = .black
        } else {
            cell.label.textColor = .orange
        }
    }
    
    func handleCellSelection(cell: TestRangeSelectionViewControllerCell, cellState: CellState) {
        if calendarView.allowsMultipleSelection {
            switch cellState.selectedPosition() {
            case .full: cell.selectedView.backgroundColor = .green
            case .left: cell.selectedView.backgroundColor = .yellow
            case .right: cell.selectedView.backgroundColor = .red
            case .middle: cell.selectedView.backgroundColor = .blue
            case .none: cell.selectedView.backgroundColor = nil
            }
        } else {
            if cellState.isSelected {
                cell.selectedView.backgroundColor = UIColor.red
            } else {
                cell.selectedView.backgroundColor = UIColor.white
            }
        }
    }
    // 年月
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = testCalendar.dateComponents([.month], from: startDate).month!
        _ = DateFormatter().shortMonthSymbols[(month-1) % 12]
        // 0 indexed array
        _ = testCalendar.component(.year, from: startDate)
        //        monthLabel.text = monthName + " " + String(year)
    }
}


extension ZHCalendarCell: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    // 单元格即将显示
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        if indexPath.row == 10 {
        }
        handleConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: TestRangeSelectionViewControllerCell.identifier, for: indexPath) as! TestRangeSelectionViewControllerCell
        if date.isToday {
            cell.label.text = "今天"
            cell.selectedView.backgroundColor = .black
        } else {
            cell.label.text = cellState.text
        }
        
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = testCalendar.timeZone
        formatter.locale = testCalendar.locale
        
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2019 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numberOfRows,
                                                 calendar: testCalendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfRow,
                                                 firstDayOfWeek: .sunday,
                                                 hasStrictBoundaries: true)
        return parameters
    }
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return monthSize
    }
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let date = range.start
        //            let month = testCalendar.component(.month, from: date)
        let v = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: ZHMonthHeaderView.identifier, for: indexPath) as! ZHMonthHeaderView
        v.mTitleLabel.text = formatter.string(from: date)
        return v
    }
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
//        print("scrollDidEndDecelerating")
//        if numberOfRows == 7 {
//            numberOfRows = 1
//        } else {
//            numberOfRows = 7
//        }
//        
//        switch numberOfRows {
//        case 7:
//            calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300)
//        case 1:
//            calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)
//        default:
//            calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300)
//        }
//        
//        calendarView.reloadData()
//        // 滚动到当前月
//        calendarView.scrollToDate(Date())
        
    }
    
    func up(num: Int) {
        numberOfRows = num
        switch numberOfRows {
        case 7:
            calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300)
        case 1:
            calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)
        default:
            calendarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300)
        }
        
        calendarView.reloadData()
        // 滚动到当前月
        calendarView.scrollToDate(Date())
    }
}

