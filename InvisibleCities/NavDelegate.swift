//
//  NavDelegate.swift
//  InvisibleCities
//
//  Created by Leo Koppelkamm on 25/12/14.
//  Copyright (c) 2014 Leo. All rights reserved.
//

import Foundation

import UIKit

class NavDelegate: UINavigationController, UINavigationBarDelegate {
    override func shouldAutorotate() -> Bool {        
        if let viewController = self.visibleViewController as? ContentViewController {
            return viewController.shouldAutorotate()
        } else {
            return true
        }
    }
}