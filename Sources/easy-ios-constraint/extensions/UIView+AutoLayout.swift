//
//  File.swift
//  
//
//  Created by Indra Tirta Nugraha on 05/10/23.
//

import Foundation
import UIKit

public extension UIView {
    // MARK: - Enums
    enum Side {
        case top
        case bottom
        case leading
        case trailing
    }
    
    enum Dimension {
        case height
        case width
    }
    
    enum Center {
        case vertical
        case horizontal
    }
    
    // MARK: - Anchors
    @discardableResult
    func fillSuperviewWidth(distance: CGFloat = 0.0, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        return alignWithSuperview(sides: [.leading, .trailing], distance: distance, priority: priority)
    }
    
    @discardableResult
    func fillSuperviewHeight(distance: CGFloat = 0.0, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        return alignWithSuperview(sides: [.top, .bottom], distance: distance, priority: priority)
    }
    
    @discardableResult
    func fillSuperview(distance: CGFloat = 0.0, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        return alignWithSuperview(sides: [.leading, .trailing, .top, .bottom], distance: distance, priority: priority)
    }
    
    @discardableResult
    func alignWithSuperview(
        sides: [Side],
        distance: CGFloat = 0.0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutConstraint.Relation = .equal
    ) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        if let superview = self.superview {
            for side in sides {
                constraints.append(align(side, withSide: side, of: superview, distance: distance, priority: priority, relation: relation))
            }
        }
        
        return constraints
    }
    
    @discardableResult
    func alignWithSuperview(
        _ side: Side,
        distance: CGFloat = 0.0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutConstraint.Relation = .equal
    ) -> NSLayoutConstraint {
        if let constraint = alignWithSuperview(sides: [side], distance: distance, priority: priority, relation: relation).first {
            return constraint
        }
        
        return .init()
    }
    
    @discardableResult
    func fillSafeArea(distance: CGFloat = 0.0, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        return alignWithSafeArea(sides: [.leading, .trailing, .top, .bottom], distance: distance, priority: priority)
    }
    
    @discardableResult
    func alignWithSafeArea(
        sides: [Side],
        distance: CGFloat = 0.0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutConstraint.Relation = .equal
    ) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        if let safeArea = self.superview?.safeAreaLayoutGuide {
            for side in sides {
                constraints.append(
                    align(
                        side,
                        withSide: side,
                        target: safeArea,
                        distance: distance,
                        priority: priority,
                        relation: relation
                    )
                )
            }
        }
        
        return constraints
    }
    
    @discardableResult
    func alignWithSafeArea(
        _ side: Side,
        distance: CGFloat = 0.0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutConstraint.Relation = .equal
    ) -> NSLayoutConstraint {
        if let constraint = alignWithSafeArea(sides: [side], distance: distance, priority: priority, relation: relation).first {
            return constraint
        }
        
        return .init()
    }
    
    @discardableResult
    func align(
        _ side: Side,
        withSide otherSide: Side,
        of view: UIView,
        distance: CGFloat = 0.0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutConstraint.Relation = .equal
    ) -> NSLayoutConstraint {
        return align(
            side,
            withSide: otherSide,
            target: view,
            distance: distance,
            priority: priority,
            relation: relation
        )
    }
    
    private func align(
        _ side: Side,
        withSide otherSide: Side,
        target: Any,
        distance: CGFloat = 0.0,
        priority: UILayoutPriority = .required,
        relation: NSLayoutConstraint.Relation = .equal
    ) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var convertedDistance = distance
        if side == otherSide && (side == .trailing || side == .bottom) {
            convertedDistance = -distance
        }
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: layoutAttribute(for: side),
            relatedBy: relation,
            toItem: target,
            attribute: layoutAttribute(for: otherSide),
            multiplier: 1.0,
            constant: convertedDistance
        )
        
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Dimension
    @discardableResult
    func pinHeight(_ constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return pinDimension(.height, of: nil, constant: constant, priority: priority)
    }
    
    @discardableResult
    func pinWidth(_ constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return pinDimension(.width, of: nil, constant: constant, priority: priority)
    }
    
    @discardableResult
    func pinHeight(to view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return pinDimension(.height, of: view, priority: priority)
    }
    
    @discardableResult
    func pinWidth(to view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return pinDimension(.width, of: view, priority: priority)
    }
    
    @discardableResult
    func pinSize(_ constant: CGFloat, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        return [pinHeight(constant, priority: priority), pinWidth(constant, priority: priority)]
    }
    
    @discardableResult
    func aspectRatio(
        for dimension: UIView.Dimension,
        ratio: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let firstDimension: NSLayoutConstraint.Attribute
        let secondDimension: NSLayoutConstraint.Attribute
        
        switch dimension {
        case .height:
            firstDimension = .width
            secondDimension = .height
        case .width:
            firstDimension = .height
            secondDimension = .width
        }
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: firstDimension,
            relatedBy: .equal,
            toItem: self,
            attribute: secondDimension,
            multiplier: ratio,
            constant: 0.0
        )
        
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Center
    @discardableResult
    func pinCenterHorizontally(priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        if let superview = self.superview {
            return pinCenterHorizontally(to: superview, priority: priority)
        }
        return .init()
    }
    
    @discardableResult
    func pinCenterVertically(priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        if let superview = self.superview {
            return pinCenterVertically(to: superview, priority: priority)
        }
        return .init()
    }
    
    @discardableResult
    func pinCenterHorizontally(to view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return pinCenter(.horizontal, of: view, priority: priority)
    }
    
    @discardableResult
    func pinCenterVertically(to view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return pinCenter(.vertical, of: view, priority: priority)
    }
    
    @discardableResult
    func pinCenter(priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(pinCenterVertically(priority: priority))
        constraints.append(pinCenterHorizontally(priority: priority))
        
        return constraints
    }
    
    private func pinDimension(
        _ dimension: Dimension,
        of target: UIView?,
        constant: CGFloat = 0.0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return pinEqual(layoutAttribute(for: dimension), of: target, constant: constant, priority: priority)
    }
    
    private func pinCenter(
        _ center: Center,
        of target: UIView,
        constant: CGFloat = 0.0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return pinEqual(layoutAttribute(for: center), of: target, constant: constant, priority: priority)
    }
    
    private func pinEqual(
        _ attribute: NSLayoutConstraint.Attribute,
        of target: UIView?,
        constant: CGFloat = 0.0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: target,
            attribute: attribute,
            multiplier: 1.0,
            constant: constant
        )
        
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    private func layoutAttribute(for side: Side) -> NSLayoutConstraint.Attribute {
        switch side {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
    
    private func layoutAttribute(for dimension: Dimension) -> NSLayoutConstraint.Attribute {
        switch dimension {
        case .height:
            return .height
        case .width:
            return .width
        }
    }
    
    private func layoutAttribute(for center: Center) -> NSLayoutConstraint.Attribute {
        switch center {
        case .vertical:
            return .centerY
        case .horizontal:
            return .centerX
        }
    }
}
