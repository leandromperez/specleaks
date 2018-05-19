//
//  OSViewController.swift
//  SpecLeaks_Example
//
//  Created by Leandro Perez on 19/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

#if os(iOS) || os(watchOS) || os(tvOS)

import UIKit
public typealias OSViewController = UIViewController
public typealias OSStoryboard = UIStoryboard

#elseif os(macOS)

import Cocoa
public typealias OSViewController = NSViewController
public typealias OSStoryboard = NSStoryboard

#endif

func instantiateInitialController<T: OSViewController>(storyboard: OSStoryboard) -> T {
    #if os(iOS) || os(watchOS) || os(tvOS)

    return storyboard.instantiateInitialViewController() as! T

    #elseif os(macOS)

    return storyboard.instantiateInitialController() as! T

    #endif
}

func makeStoryboard(named: String, bundle: Bundle) -> OSStoryboard {

    #if os(iOS) || os(watchOS) || os(tvOS)

    return UIStoryboard.init(name: named, bundle: bundle)

    #elseif os(macOS)

    return NSStoryboard.init(name: NSStoryboard.Name(rawValue: named), bundle: bundle)

    #endif
}
