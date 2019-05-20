//
//  Storyboard.swift
//  Go24
//
//  Created by Leandro Perez on 9/22/17.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboard {
    func initialViewController<T : UIViewController> ()-> T
    var name : String {get}
    var bundle : Bundle {get}
}

extension Storyboard {
    var storyboard : UIStoryboard{
        return UIStoryboard.init(name: self.name, bundle: self.bundle)
    }
    
    func initialViewController<T : UIViewController> ()-> T {
        let vc : T = self.storyboard.instantiateInitialViewController() as! T
        
        return vc
    }
}


enum Storyboards : String, Storyboard{
    
    case LeakingViewController
    
    var name : String {
        return self.rawValue
    }
    
    var bundle : Bundle{
        return Bundle.main
    }
}
