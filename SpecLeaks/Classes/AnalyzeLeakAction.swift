//
//  AnalyzeLeakAction.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 03/02/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

struct AnalyzeLeakAction{
    func execute<T>(constructor:() -> T, action:(T)->() , shouldLeak:Bool = false) where T:AnyObject{
        
        var mayBeLeaking : T?
        let leaksAnalyzer = LeaksAnalyzer()
        
        autoreleasepool{
            
            leaksAnalyzer.leakedObject = nil
            
            //Instantiate the object that will be analyzed
            mayBeLeaking = constructor()
            if let vc = mayBeLeaking as? UIViewController{
                _ = vc.view //TO call viewDidLoad on the vc
            }
            leaksAnalyzer.analize(mayBeLeaking!)
            
            //Run the action that will be analyzed
            action(mayBeLeaking!)
            
            
            //Set to nil. If the analyzer still has an instance, that's a leak
            mayBeLeaking = nil
        }
        
        if shouldLeak{
            expect(leaksAnalyzer.leakedObject).toEventuallyNot(beNil())
        }
        else{
            expect(leaksAnalyzer.leakedObject).toEventually(beNil())
        }
    }
    
    
    func execute<T>(constructor:() -> T, action:(T)->Any , shouldLeak:Bool = false) where T:AnyObject{
        
        var mayBeLeaking : T?
        let leaksAnalyzer = LeaksAnalyzer()
        
        var resultThatMightCauseLeak : Any? = nil

        autoreleasepool{
            
            leaksAnalyzer.leakedObject = nil
            
            //Instantiate the object that will be analyzed
            mayBeLeaking = constructor()
            if let vc = mayBeLeaking as? UIViewController{
                _ = vc.view //TO call viewDidLoad on the vc
            }
            leaksAnalyzer.analize(mayBeLeaking!)
            
            //Run the action that will be analyzed

            resultThatMightCauseLeak = action(mayBeLeaking!)
        
            //Set to nil. If the analyzer still has an instance, that's a leak
            mayBeLeaking = nil
        }
        
        if shouldLeak{
            expect(leaksAnalyzer.leakedObject).toEventuallyNot(beNil())
        }
        else{
            expect(resultThatMightCauseLeak).toNot(beNil())
            expect(leaksAnalyzer.leakedObject).toEventually(beNil())
        }
    }
}
