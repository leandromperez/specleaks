//
//  LeakingViewController.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 10/01/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import UIKit

class LeakingViewController: UIViewController {
    
    private var anyObject : AnyObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func cleanLeakedObjects(){
    
        self.anyObject = nil
    }
    
    func createLeak(){
        self.anyObject = self
    }
    
    func doSomething(){
        print("doing something")
    }
    
    func createLeakInBlock() -> () -> (){
        return {
            self.doSomething()
        }
    }
    
    func dontCreateLeakInBlock() -> () -> (){
        return { [weak self] in
            self?.doSomething()
        }
    }

}

