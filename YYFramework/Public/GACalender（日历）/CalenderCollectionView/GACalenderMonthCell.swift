//
//  GACalenderMonthCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/17.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GACalenderMonthCellDelegate: class {
    func calenderMonthCellDidSelected(indexPath: IndexPath, day: Int)
    func calenderMonthCell(model: GACalenderModel, allRow: Int)
}

class GACalenderMonthCell: UICollectionViewCell {
    
    static let height: CGFloat = kScreenWidth / 7
    
    weak var delegate: GACalenderMonthCellDelegate?
    
    public var currentSelectedRow: Int = 0
    public var _type: GACalenderViewType = .month
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weekModels: [GACalenderModel]! {
        didSet {
            collectionView.reloadData()
        }
    }
        
    var model: GACalenderModel! {
        didSet {
            if GADate.currentMonth() == model.month && GADate.currentYear() == model.year {
                currentSelectedRow = GADate.firstWeekDay(year: model.year, month: model.month) + GADate.currentDay() - 1
            } else {
                currentSelectedRow = GADate.firstWeekDay(year: model.year, month: model.month)
            }
            collectionView.reloadData()
            
            let count = model.days.count + GADate.firstWeekDay(year: model.year, month: model.month)
            let rowCount =  count + 7 - count % 7
            delegate?.calenderMonthCell(model: model, allRow: rowCount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.yy_register(nibName: GACalenderItemCell.identifier)
        collectionView.yy_register(nibName: GACalenderItemSpaceCell.identifier)
    }
    
    private func _getNewMonth(year: Int, month: Int, type: UICollectionView.ScrollPosition) -> [Int] {
        var newMonth = month
        var newYear = year
        if type == .left {
            newMonth -= 1
        } else {
            newMonth += 1
        }
        if newMonth == 0 {
            newMonth = 12
            newYear -= 1
        } else if newMonth == 13 {
            newMonth = 1
            newYear += 1
        }
        return [newYear, newMonth]
    }
    
    public func reloadData(model: GACalenderModel) {
        self.model = model;
        collectionView.reloadData()
    }
    
}

extension GACalenderMonthCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if _type == .week {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GACalenderItemCell.identifier, for: indexPath) as! GACalenderItemCell
            if currentSelectedRow == indexPath.row {
                cell.contentView.backgroundColor = UIColor.orange
            } else {
                cell.contentView.backgroundColor = UIColor.brown
            }
            let m = weekModels[indexPath.row]
            cell.year.text = "\(m.year)"
            cell.month.text = "\(m.month)"
            cell.day.text = "\(m.day)"
            return cell
        }
        if indexPath.row < GADate.firstWeekDay(year: model.year, month: model.month) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GACalenderItemSpaceCell.identifier, for: indexPath) as! GACalenderItemSpaceCell
            let MY = _getNewMonth(year: model.year, month: model.month, type: UICollectionView.ScrollPosition.left)
            let newY = MY.first!
            let newM = MY.last!
            let leftMonth = GADate.getCountOfDaysInMonth(year: newY, month: newM)
            cell.year.text = "\(newY)"
            cell.month.text = "\(newM)"
            cell.day.text = "\(abs(leftMonth - GADate.firstWeekDay(year: model.year, month: model.month) + indexPath.row + 1))"
            return cell
        }
        if indexPath.row >= model.days.count + GADate.firstWeekDay(year: model.year, month: model.month) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GACalenderItemSpaceCell.identifier, for: indexPath) as! GACalenderItemSpaceCell
            let MY = _getNewMonth(year: model.year, month: model.month, type: UICollectionView.ScrollPosition.right)
            let newY = MY.first!
            let newM = MY.last!
//            let rightMonth = GADate.getCountOfDaysInMonth(year: newY, month: newM)
            cell.year.text = "\(newY)"
            cell.month.text = "\(newM)"
            cell.day.text = "\(indexPath.row - model.days.count - GADate.firstWeekDay(year: model.year, month: model.month) + 1)"
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GACalenderItemCell.identifier, for: indexPath) as! GACalenderItemCell
        if currentSelectedRow == indexPath.row {
            cell.contentView.backgroundColor = UIColor.orange
        } else {
            cell.contentView.backgroundColor = UIColor.brown
        }
        if GADate.currentDay() + GADate.firstWeekDay(year: model.year, month: model.month) - 1 == indexPath.row && GADate.currentMonth() == model.month && GADate.currentYear() == model.year {
            cell.contentView.backgroundColor = UIColor.black
        }
        cell.year.text = "\(model.year)"
        cell.month.text = "\(model.month)"
        cell.day.text = "\(model.days[indexPath.row - GADate.firstWeekDay(year: model.year, month: model.month)])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if _type == .week {
            return 7
        }
        if let m = model {
            let count = m.days.count + GADate.firstWeekDay(year: model.year, month: model.month)
            return count + 7 - count % 7
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth / 7, height: kScreenWidth / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedRow = indexPath.row
        if _type == .week {
            collectionView.reloadData()
            let weekModel = weekModels[indexPath.row]
            delegate?.calenderMonthCellDidSelected(indexPath: indexPath, day: weekModel.day)
            return 
        }
        
        let index = indexPath.row - GADate.firstWeekDay(year: model.year, month: model.month)
        if index >= 0 {
            if index > model.days.count - 1 {
                return
            }
            let day = model.days[index]
            delegate?.calenderMonthCellDidSelected(indexPath: indexPath, day: day)
            collectionView.reloadData()
        }
    }
}

class GACalenderMonthCellFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}


