//
//  Settings.swift
//  ColorSwitch
//
//  Created by Hemanth Raja on 26/08/18.
//  Copyright © 2018 Hemanth Raja. All rights reserved.
//

import SpriteKit

enum PhysicsCategories{
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1
}

enum zpositions{
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
