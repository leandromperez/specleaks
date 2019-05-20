//
//  Helpers.swift
//  SpecLeaks_Example
//
//  Created by Leandro Perez on 01/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

typealias ErrorHandler = (Error)->()
typealias Action = () -> ()
typealias Handler<T> = (T) -> ()
