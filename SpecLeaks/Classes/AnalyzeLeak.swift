//
//  AnalyzeLeak.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 03/02/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Foundation
#if os(iOS) || os(watchOS) || os(tvOS)
    import UIKit
#elseif os(OSX)
#endif
import Quick
import Nimble

struct AnalyzeLeak{
    func execute( constructor: LeakTestConstructor, shouldLeak: Bool = false ){
        
        var mayBeLeaking : AnyObject?
        let leaksAnalyzer = LeaksAnalyzer()
        
        autoreleasepool{
            leaksAnalyzer.leakedObject = nil
            
            mayBeLeaking = constructor()
            #if os(iOS) || os(watchOS) || os(tvOS)
                if let vc = mayBeLeaking as? UIViewController{
                    _ = vc.view //To call viewDidLoad on the vc
                }
            #elseif os(OSX)
                if let vc = mayBeLeaking as? NSViewController{
                    _ = vc.view //To call viewDidLoad on the vc
                }
            #endif
            
            leaksAnalyzer.analize(mayBeLeaking!)
            mayBeLeaking = nil
        }
        
        if shouldLeak{
            expect(leaksAnalyzer.leakedObject).toEventuallyNot(beNil())
        }
        else{
            expect(leaksAnalyzer.leakedObject).toEventually(beNil())
        }
    }
}

