//
//  ViewEx.swift
//  Hero
//
//  Created by sadman samee on 5/22/17.
//  Copyright © 2017 sadman samee. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func roundedCorner(radius: CGFloat) {
        layer.cornerRadius = radius

        clipsToBounds = true
    }

//    func roundedCornerColor(radius: CGFloat,color: UIColor = UIColor(cgColor:Theme.current.borderColor.cgColor)){
//        self.layer.cornerRadius = radius
//        self.layer.borderColor = color.cgColor
//        self.clipsToBounds = true
//    }
//
//
//
//    func addBorderWithColor(borderWidth: CGFloat = K.Geometry.boarderWidth, color: UIColor = UIColor(cgColor:Theme.current.borderColor.cgColor)) {
//        self.layer.borderWidth = borderWidth
//        self.layer.borderColor = color.cgColor
//    }

    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }

    func makeCircular() {
        layer.cornerRadius = min(frame.size.height, frame.size.width) / 2.0
        clipsToBounds = true
    }
}

extension UIView {
    /*
     func addBorder(edges: UIRectEdge, colour: UIColor = UIColor(cgColor:Theme.current.borderColor.cgColor), thickness: CGFloat = K.Geometry.boarderWidth) -> [UIView] {

     var borders = [UIView]()

     func border() -> UIView {
     let border = UIView(frame: CGRect.zero)
     border.backgroundColor = colour
     border.translatesAutoresizingMaskIntoConstraints = false
     return border
     }

     if edges.contains(.top) || edges.contains(.all) {
     let top = border()
     addSubview(top)
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
     options: [],
     metrics: ["thickness": thickness],
     views: ["top": top]))
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
     options: [],
     metrics: nil,
     views: ["top": top]))
     borders.append(top)
     }

     if edges.contains(.left) || edges.contains(.all) {
     let left = border()
     addSubview(left)
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
     options: [],
     metrics: ["thickness": thickness],
     views: ["left": left]))
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
     options: [],
     metrics: nil,
     views: ["left": left]))
     borders.append(left)
     }

     if edges.contains(.right) || edges.contains(.all) {
     let right = border()
     addSubview(right)
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
     options: [],
     metrics: ["thickness": thickness],
     views: ["right": right]))
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
     options: [],
     metrics: nil,
     views: ["right": right]))
     borders.append(right)
     }

     if edges.contains(.bottom) || edges.contains(.all) {
     let bottom = border()
     addSubview(bottom)
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
     options: [],
     metrics: ["thickness": thickness],
     views: ["bottom": bottom]))
     addConstraints(
     NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
     options: [],
     metrics: nil,
     views: ["bottom": bottom]))

     borders.append(bottom)
     }

     return borders
     }
     */
}

// extension CALayer {
//     @IBInspectable public var borderUIColor: UIColor {
//        set {
//            self.borderColor = newValue.cgColor
//        }
//
//        get {
//            return UIColor(cgColor: self.borderColor!)
//        }
//    }
// }

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }

        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }

        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable public var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }

        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }

        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable public var zPosition: CGFloat {
        get {
            return layer.zPosition
        }

        set {
            layer.zPosition = newValue
        }
    }

    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }

    public func addCircularShabow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: CGFloat(5.0), height: CGFloat(5.0))
        layer.shadowOpacity = 0.6
        // let shadowPath = UIBezierPath(rect: self.bounds)
        // self.layer.shadowPath = shadowPath.cgPath
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: min(frame.size.height, frame.size.width) / 2).cgPath

//        view.layer.shadowRadius = 4
    }

    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: w, height: w), cornerRadius: w / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        layer.addSublayer(shapeLayer)
    }

    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: w, height: w), cornerRadius: w / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        layer.addSublayer(shapeLayer)
    }

    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        layer.add(animation, forKey: nil)
    }
}

internal extension UIView {
    internal func slowSnapshotView() -> UIView {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let imageView = UIImageView(image: image)
        imageView.frame = bounds
        let snapshotView = UIView(frame: bounds)
        snapshotView.addSubview(imageView)
        return snapshotView
    }
}

extension UIView {
    public func addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }

    public func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in subviews {
            let aView = someView
            let newWidth = aView.x + aView.w
            let newHeight = aView.y + aView.h
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    public func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.w
                let newHeight = aView.y + aView.h
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    public func resizeToFitWidth() {
        let currentHeight = h
        sizeToFit()
        h = currentHeight
    }

    public func resizeToFitHeight() {
        let currentWidth = w
        sizeToFit()
        w = currentWidth
    }

    public var x: CGFloat {
        get {
            return frame.origin.x
        } set(value) {
            frame = CGRect(x: value, y: y, width: w, height: h)
        }
    }

    public var y: CGFloat {
        get {
            return frame.origin.y
        } set(value) {
            frame = CGRect(x: x, y: value, width: w, height: h)
        }
    }

    public var w: CGFloat {
        get {
            return frame.size.width
        } set(value) {
            frame = CGRect(x: x, y: y, width: value, height: h)
        }
    }

    public var h: CGFloat {
        get {
            return frame.size.height
        } set(value) {
            frame = CGRect(x: x, y: y, width: w, height: value)
        }
    }

    public var left: CGFloat {
        get {
            return x
        } set(value) {
            x = value
        }
    }

    public var right: CGFloat {
        get {
            return x + w
        } set(value) {
            x = value - w
        }
    }

    public var top: CGFloat {
        get {
            return y
        } set(value) {
            y = value
        }
    }

    public var bottom: CGFloat {
        get {
            return y + h
        } set(value) {
            y = value - h
        }
    }

    public var origin: CGPoint {
        get {
            return frame.origin
        } set(value) {
            frame = CGRect(origin: value, size: frame.size)
        }
    }

    public var centerX: CGFloat {
        get {
            return center.x
        } set(value) {
            center.x = value
        }
    }

    public var centerY: CGFloat {
        get {
            return center.y
        } set(value) {
            center.y = value
        }
    }

    public var size: CGSize {
        get {
            return frame.size
        } set(value) {
            frame = CGRect(origin: frame.origin, size: value)
        }
    }

    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return left - offset
    }

    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return right + offset
    }

    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return top - offset
    }

    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return bottom + offset
    }

    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return w - offset
    }

    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("Error: The view \(self) doesn't have a superview")
            return
        }

        x = parentView.w / 2 - w / 2
    }

    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("Error: The view \(self) doesn't have a superview")
            return
        }

        y = parentView.h / 2 - h / 2
    }

    public func centerInSuperView() {
        centerXInSuperView()
        centerYInSuperView()
    }
}

// MARK: Render Extensions

extension UIView {
    public func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

extension UIView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    public func roundView() {
        layer.cornerRadius = min(frame.size.height, frame.size.width) / 2
    }
}

extension UIView {
    public func shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0)),
            NSValue(caTransform3D: CATransform3DMakeTranslation(5, 0, 0))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7 / 100

        layer.add(anim, forKey: nil)
    }
}

extension UIView {
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]

        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            (degrees: Double) -> Double in
            let radians: Double = (M_PI * degrees) / 180.0
            return radians
        }

        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        layer.add(shakeGroup, forKey: "shakeIt")
    }
}

extension UIView {
    func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
}

extension UITableView {
    func isLastCell(indexPath: IndexPath) -> Bool {
        let totalSections = numberOfSections
        let totalRowForSection = numberOfRows(inSection: indexPath.section)
        if (indexPath.section == totalSections - 1)
            && (indexPath.row == totalRowForSection - 1) {
            return true
        }
        return false
    }

    func isLastCellForSection(indexPath: IndexPath) -> Bool {
        let totalRowForSection = numberOfRows(inSection: indexPath.section)
        if indexPath.row == totalRowForSection - 1 {
            return true
        }
        return false
    }
}

extension CALayer {
    // cell.Label.layer.addBorder(UIRectEdge.Top, color: UIColor.greenColor(), thickness: 0.5)
    /*
     func addBorder(edge: UIRectEdge, color: UIColor = UIColor(cgColor:Theme.current.borderColor.cgColor), thickness: CGFloat = K.Geometry.boarderWidth) {

     let border = CALayer()

     switch edge {
     case UIRectEdge.top:

     border.frame = CGRect(x:0, y:0,width: self.frame.height, height: thickness)
     break
     case UIRectEdge.bottom:
     border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
     break
     case UIRectEdge.left:
     border.frame = CGRect(x:0, y:0, width:thickness, height:self.frame.height)
     break
     case UIRectEdge.right:
     border.frame = CGRect(x:self.frame.width - thickness, y: 0, width:thickness, height:self.frame.height)
     break
     default:
     break
     }

     border.backgroundColor = color.cgColor;

     self.addSublayer(border)
     }
     */
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
