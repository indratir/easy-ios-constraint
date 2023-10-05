//
//  UILayoutPriority+Extensions.swift
//  
//
//  Created by Indra Tirta Nugraha on 05/10/23.
//

import Foundation
import UIKit

public extension UILayoutPriority {
    static var almostRequired: UILayoutPriority {
        .init(rawValue: 999.0)
    }
}
