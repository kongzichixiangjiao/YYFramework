//
//  GATagFlowLayout.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/28.
//  Copyright © 2018年 houjianan. All rights reserved.
//

/*
func stringSize(s: String) -> CGSize {
    if s.count == 0 {
        return CGSize.zero
    }
    let font = UIFont.systemFont(ofSize: 14)
    let width = UIScreen.main.bounds.size.width - self.layout.flowEdgeInset.left - self.layout.flowEdgeInset.right
    let contentSize = (s as NSString).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
    // 32是label距离左右的间距和 // 20距离上下和
    let size = CGSize(width: min(contentSize.width + 32, width + 2), height: max(28, contentSize.height + 25))
    return size
}
*/
/*
lazy var layout: GATagFlowLayout = {
    let l = GATagFlowLayout()
    l.flowEdgeInset = UIEdgeInsets(top: 20, left: 30, bottom: 15, right: 40)
    l.columSpace = 10
    l.delegate = self
    return l
}()
*/
import UIKit

protocol GATagFlowLayoutDelegate: class {
    func tag(layout: GATagFlowLayout, indexPath: IndexPath) -> CGSize
}

class GATagFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: GATagFlowLayoutDelegate?
    
    var columSpace: CGFloat = 0
    var rowSpaces: [CGFloat] = [0] // 第一组
    
    var sectionHeight: CGFloat = 0
    var sectionTopSpace: CGFloat = 0
    var flowEdgeInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    var attrsArray: [UICollectionViewLayoutAttributes] = []
    var sectionAttrsArray: [UICollectionViewLayoutAttributes] = []
    
    private var lastItemRect: CGRect!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData() {
        attrsArray.removeAll()
        self.lastItemRect = CGRect(x: flowEdgeInset.left, y: flowEdgeInset.top, width: 0, height: 0)
    }
    
    override func prepare() {
        super.prepare()
        
        initData()
        
        let sectionCount = collectionView!.numberOfSections
        
        for j in 0..<sectionCount {
            let attribute = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: j))
            attrsArray.append(attribute!)
            
            for i in 0..<collectionView!.numberOfItems(inSection: j) {
                let attribute = layoutAttributesForItem(at: IndexPath(item: i, section: j))
                attrsArray.append(attribute!)
            }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        var orx: CGFloat = 0
        var ory: CGFloat = 0
        
        var isRowDs: CGFloat = 0
        var isColumnDs: CGFloat = 0
        
        if lastItemRect.maxX != flowEdgeInset.left {
            isColumnDs = columSpace
        }
        
        if lastItemRect.maxY != flowEdgeInset.top {
            isRowDs = rowSpaces[indexPath.section]
        }
        
        let size = delegate?.tag(layout: self, indexPath: indexPath)
        let maxDistance = self.collectionView!.frame.size.width - self.lastItemRect.maxX - isColumnDs  - self.flowEdgeInset.right
        if size!.width > maxDistance {
            orx = self.flowEdgeInset.left
            ory = self.lastItemRect.origin.y + self.lastItemRect.size.height + isRowDs
        } else {
            orx = self.lastItemRect.origin.x + self.lastItemRect.size.width + isColumnDs
            ory = self.lastItemRect.origin.y
        }
        
        attribute.frame = CGRect(x: orx, y: ory, width: size!.width, height: size!.height)
        lastItemRect = attribute.frame
        
        return attribute
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        let x: CGFloat = 0
        let y: CGFloat = lastItemRect.maxY + (indexPath.section != 0 ? sectionTopSpace : 0)
        let w: CGFloat = collectionView!.width
        let h: CGFloat = sectionHeight
        attribute.frame = CGRect(x: x, y: y, width: w, height: h)
        lastItemRect = attribute.frame
        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        let maxContentHeight = lastItemRect.origin.y + lastItemRect.size.height + flowEdgeInset.bottom
        return CGSize(width: 0, height: maxContentHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

