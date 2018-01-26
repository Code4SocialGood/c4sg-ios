//
//  AlignedImageView.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/24/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

public struct AlignedImageViewMask: OptionSet {
    
    // Public alignment options
    public static let left: AlignedImageViewMask        = AlignedImageViewMask(rawValue: 0)
    public static let right: AlignedImageViewMask       = AlignedImageViewMask(rawValue: 1)
    public static let top: AlignedImageViewMask         = AlignedImageViewMask(rawValue: 2)
    public static let bottom: AlignedImageViewMask      = AlignedImageViewMask(rawValue: 3)
    public static let center: AlignedImageViewMask      = AlignedImageViewMask(rawValue: 4)
    public static let topLeft: AlignedImageViewMask     = [top, left]
    public static let topRight: AlignedImageViewMask    = [top, right]
    public static let bottomLeft: AlignedImageViewMask  = [bottom, left]
    public static let bottomRight: AlignedImageViewMask = [bottom, right]
    
    // Public raw value
    public let rawValue: Int
    
    
    // MARK: - Initialize Methods
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
}


@IBDesignable
public class AlignedImageView: UIImageView {
    
    // IBInspectable properties
    @IBInspectable public var alignLeft: Bool {
        set {
            self.setIBInspectableProperty(shouldInsert: newValue, alignmentMask: .left)
        }
        get {
            return self.getIBInspectableProperty(.left)
        }
    }
    
    @IBInspectable public var alignRight: Bool {
        set {
            self.setIBInspectableProperty(shouldInsert: newValue, alignmentMask: .right)
        }
        get {
            return self.getIBInspectableProperty(.right)
        }
    }
    
    @IBInspectable public var alignTop: Bool {
        set {
            self.setIBInspectableProperty(shouldInsert: newValue, alignmentMask: .top)
        }
        get {
            return self.getIBInspectableProperty(.top)
        }
    }
    
    @IBInspectable public var alignBottom: Bool {
        set {
            self.setIBInspectableProperty(shouldInsert: newValue, alignmentMask: .bottom)
        }
        get {
            return getIBInspectableProperty(.bottom)
        }
    }
    
    // Public properties
    public override var image: UIImage? {
        set {
            self.imageView?.image = newValue
            setNeedsLayout()
        }
        get {
            return self.imageView?.image
        }
    }
    
    public var alignment: AlignedImageViewMask = .center {
        didSet {
            // Update layout for only AlignedImageViewMask changes
            if alignment != oldValue {
                updateLayout()
            }
        }
    }
    
    // Private properties
    private var contentSize: CGSize {
        var newContentSize = bounds.size
        
        // Return original size if no image
        guard let image = image else {
            return newContentSize
        }
        
        // Calculate the new scale of the image
        let scaleX = newContentSize.width / image.size.width
        let scaleY = newContentSize.height / image.size.height
        let scale = min(scaleX, scaleY)
        
        switch self.contentMode {
        case .scaleToFill:
            newContentSize = CGSize(width: image.size.width * scaleX, height: image.size.height * scaleY)
        case .scaleAspectFill:
            newContentSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        case .scaleAspectFit:
            newContentSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        default:
            // Return original size for all other content modes
            newContentSize = image.size
        }
        
        return newContentSize
    }
    private(set) var imageView: UIImageView?
    
    
    // MARK: - Initialize Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildImageView(with: nil)
    }
    
    public override init(image: UIImage?) {
        super.init(image: image)
        
        buildImageView(with: image)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buildImageView(with: nil)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        updateLayout()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Contents retains its value so clear the contents with superview change
        layer.contents = nil
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        
        // Contents retains its value so clear the contents with window change
        layer.contents = nil
    }
    
    
    // MARK: - Private Layout Methods
    
    private func buildImageView(with image: UIImage? = nil) {
        if let image = image {
            imageView = UIImageView(image: image)
        }
        else {
            // Default to original image
            imageView = UIImageView(image: super.image)
        }
        imageView?.frame = self.bounds
        imageView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView?.contentMode = self.contentMode
        self.addSubview(imageView!)
    }
    
    private func updateLayout() {
        let origin = CGPoint(x: (bounds.size.width - self.contentSize.width) / 2,
                             y: (bounds.size.height - self.contentSize.height) / 2)
        var frame = CGRect(origin: origin, size: self.contentSize)
        
        // Set X alignment for image frame
        if alignment.contains(.left) {
            frame.origin.x = 0.0
        }
        else if alignment.contains(.right) {
            frame.origin.x = bounds.maxX - frame.size.width
        }
        
        // Set Y alignment for image frame
        if alignment.contains(.top) {
            frame.origin.y = 0.0
        }
        else if alignment.contains(.bottom) {
            frame.origin.y = bounds.maxY - frame.size.height
        }
        
        // Set the new frame for the imageView
        self.imageView?.frame = frame.integral
        
        // Contents retains its value so clear the contents with layout change
        layer.contents = nil
    }
    
    
    // MARK: - Private IBInspectable Methods
    
    private func setIBInspectableProperty(shouldInsert: Bool, alignmentMask: AlignedImageViewMask) {
        if shouldInsert {
            self.alignment.insert(alignmentMask)
        }
        else {
            self.alignment.remove(alignmentMask)
        }
    }
    
    private func getIBInspectableProperty(_ alignmentMask: AlignedImageViewMask) -> Bool {
        return self.alignment.contains(alignmentMask)
    }
    
}
