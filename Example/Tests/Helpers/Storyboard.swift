//
//  Storyboard.swift
//  Go24
//
//  Created by Leandro Perez on 9/22/17.
//  Copyright © 2017 Your Trainer Inc. All rights reserved.
//

import Foundation

protocol Storyboard {
    func initialViewController<T: OSViewController> () -> T
    var name: String {get}
    var bundle: Bundle {get}
}

extension Storyboard {
    var storyboard: OSStoryboard {
        return makeStoryboard(named: self.name, bundle: self.bundle)
    }

    func initialViewController<T: OSViewController> () -> T {
        let vc: T = instantiateInitialController(storyboard: self.storyboard)

        return vc
    }
}

enum Storyboards: String, Storyboard {

    case LeakingViewController

    var name: String {
        return self.rawValue
    }

    var bundle: Bundle {
        return Bundle.main
    }
}
