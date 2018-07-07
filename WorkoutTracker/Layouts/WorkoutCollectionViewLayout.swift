//
//  WorkoutCollectionViewLayout.swift
//  WorkoutTracker
//
//  Created by Nicholas Romano on 7/7/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit
protocol  WorkoutCollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat

}

class WorkoutCollectionViewLayout: UICollectionViewLayout {
    var delegate: WorkoutCollectionViewLayoutDelegate!
    var numberOfColumns = 1
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width : CGFloat {
        get {
            
            let rect = collectionView!.bounds
            return rect.width
        }
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: width, height: contentHeight)
        }
    }
    
    override func prepare() {
        if cache.isEmpty {
            
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath as NSIndexPath)
                
                let frame = CGRect(x:  xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect){
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    
}
