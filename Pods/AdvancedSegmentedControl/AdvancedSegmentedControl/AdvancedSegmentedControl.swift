//
//  AdvancedSegmentedControl.swift
//  AdvancedSegmentedControl
//
//  Created by Dennis Müller on 01.10.18.
//  Copyright © 2018 Dennis Müller. All rights reserved.
//

import UIKit

/// A segmented control that allows for scrolling.
open class AdvancedSegmentedControl: UIControl, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    /// A segment of the segmented control.
    public struct Segment {
        
        /// The title that will be displayed.
        public let title: String
        
        /// The desired width of the segment.
        public var width: CGFloat
        
        init(title: String, width: CGFloat = 150) {
            assert(width > 0, "Segment width must be greater than zero")
            self.title = title
            self.width = width
        }
        
    }
    
    // MARK: - Properties
    // ========== PROPERTIES ==========
    private var collectionViewShownForTheFirstTime: Bool = true
    
    ///The distance between each of the segments.
    public var segmentSpacing: CGFloat = 4.0
    
    /// If this is set to true, the segments will be (proportionally to their widths) stretched to fit the view's width.
    /// Unlike `stretchSegmentsIfPossible`, this will *always* stretch the segments, even it they have to be made smaller.
    public var forceSegmentStretching: Bool = false
    
    /// If this is set to true, the segments will be proportionally distributed to fill the entire view's width,
    /// as long as their combined width (as set in AdvancedSegmentedControl.Segment) is lower than that.
    ///
    /// In other words, if the segments don't fill the view's width, their width will be proportionally increased.
    public var stretchSegmentsIfPossible: Bool = true
    
    public private(set) var segments: [Segment] = []
    
    /// The currently active (=selected) segment. The default value is -1, which represents no selection
    public var selectedSegmentIndex: Int = -1 {
        
        willSet {
            if newValue != selectedSegmentIndex {
                selectedSegmentIndexCell?.titleLabel.textColor = tintColor
            }
        }
        
        didSet {
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [.allowUserInteraction], animations: {
                self.highlightView.frame = self.selectedSegmentIndexCell?.frame ?? .zero
            }, completion: nil)
            
            collectionView.scrollToItem(at: IndexPath(item: selectedSegmentIndex, section: 0), at: .centeredHorizontally, animated: true)
            
            selectedSegmentIndexCell?.titleLabel.textColor = highlightView.backgroundColor?.readableTextColor
        }
    }
    
    private var selectedSegmentIndexCell: AdvancedSegmentedControl.Cell? {
        return collectionView.cellForItem(at: IndexPath(item: selectedSegmentIndex, section: 0)) as? AdvancedSegmentedControl.Cell
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.allowsMultipleSelection = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        addSubview(view)
        
        view.delegate = self
        view.dataSource = self
        view.register(cellWithClass: AdvancedSegmentedControl.Cell.self)
        
        return view
    }()
    
    private lazy var highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#eeeeee")
        
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        view.layer.zPosition = -1
        collectionView.insertSubview(view, at: 0)
        return view
    }()
    // ====================
    
    // MARK: - Initializers
    // ========== INITIALIZERS ==========
    convenience init(segments: [AdvancedSegmentedControl.Segment]) {
        self.init(frame: .zero)
        self.segments = segments
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        self.tintColor = UIColor(hexString: "#eeeeee")
        backgroundColor = UIColor(hexString: "#333333")
        _ = highlightView
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    // ====================
    
    // MARK: - Overrides
    // ========== OVERRIDES ==========
    
    // ====================
    
    
    // MARK: - Functions
    // ========== FUNCTIONS ==========
    
    /// Sets the highlight (=background) color of the selected segment.
    ///
    /// The default value is #eeeeee.
    ///
    /// - Parameter color: The background color
    public func setHighlightColor(_ color: UIColor) {
        highlightView.backgroundColor = color
    }
    
    /// Appends a given segment to the array of segments.
    ///
    /// - Parameter segment: The new segment you want to append
    public func addSegment(_ segment: AdvancedSegmentedControl.Segment) {
        segments.append(segment)
    }
    
    /// Creates a new segment fomr the given title and appends it to the array of segments.
    ///
    /// - Parameter segment: The title of the new segment you want to append
    public func addSegment(_ segmentTitle: String) {
        segments.append(Segment(title: segmentTitle))
    }
    
    /// Sets the array of segments and updates the view.
    ///
    /// - Parameter segments: The new segments
    public func setSegments(_ segments: [AdvancedSegmentedControl.Segment]) {
        self.segments = segments
        collectionView.reloadData()
        selectedSegmentIndex = 0
    }
    /// Sets the array of segments and updates the view.
    ///
    /// - Parameter segments: The new segment titles
    public func setSegments(_ segmentTitles: [String]) {
        segments = []
        for segmentTitle in segmentTitles {
            segments.append(Segment(title: segmentTitle))
        }
        collectionView.reloadData()
        selectedSegmentIndex = 0
    }
    
    /// Sets the width of all segments to a given value
    ///
    /// - Parameter width: the new width
    public func setSegmentsWidth(_ width: CGFloat) {
        for index in 0..<segments.count {
            segments[index].width = width
        }
    }
    
    /// Sets the width of a specific segment.
    ///
    /// - Parameters:
    ///   - index: The index of the segment whose width you want to adjust
    ///   - width: The new width
    public func setSegmentWidth(_ index: Int, width: CGFloat) {
        segments[index].width = width
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segments.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: AdvancedSegmentedControl.Cell.self, for: indexPath)
        
        cell.configure(withSegment: segments[indexPath.item], tintColor: tintColor)
        
        if selectedSegmentIndex == indexPath.item {
            cell.titleLabel.textColor = highlightView.backgroundColor?.readableTextColor
            highlightView.frame = cell.frame
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = segments[indexPath.item].width
        
        let itemCount = CGFloat(segments.count)
        let widthSum = segments.reduce(0.0, { $0 + $1.width })
        if forceSegmentStretching || (stretchSegmentsIfPossible && (widthSum + (itemCount - 1) * segmentSpacing) <= bounds.width) {
            let availableSpace = bounds.width - (itemCount - 1) * segmentSpacing - widthSum
            width = segments[indexPath.item].width +  (segments[indexPath.item].width / widthSum) * availableSpace
        }
        
        return CGSize(width: width, height: bounds.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSegmentIndex = indexPath.item
        sendActions(for: .valueChanged)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // calculate the contentOffset so that the preselected item is in the middle (if possible)
        if collectionViewShownForTheFirstTime && selectedSegmentIndex > 0 {
            collectionViewShownForTheFirstTime = false
            var offset: CGFloat = 0
            for index in 0..<selectedSegmentIndex {
                offset += segments[index].width
            }
            
            offset -= collectionView.bounds.width / 2 - segments[selectedSegmentIndex].width / 2 - segmentSpacing * CGFloat(selectedSegmentIndex)
            offset = max(0, min(collectionView.contentSize.width - collectionView.bounds.width, offset))
            
            collectionView.contentOffset.x = offset
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return segmentSpacing
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return segmentSpacing
    }
    // ====================
    
    
}
