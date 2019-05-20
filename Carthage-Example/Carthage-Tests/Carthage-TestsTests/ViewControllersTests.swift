//
//  LeakingViewControllerSpec.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 10/01/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Quick
import Nimble
import SpecLeaks

class ViewControllersTests: QuickSpec {
    
    override func spec() {
        describe("UIViewController"){
            let test = LeakTest{
                return UIViewController()
            }

            describe("init") {
                it("must not leak"){
                    expect(test).toNot(leak())
                }
            }
        }

        describe("LeakingViewController") {
            let test = LeakTest{
                let storyboard = UIStoryboard.init(name: "LeakingViewController", bundle: Bundle(for: LeakingViewController.self))
                return storyboard.instantiateInitialViewController() as! LeakingViewController
            }
            
            describe("init") {
                it("must not leak"){
                    expect(test).toNot(leak())
                }
            }
            
            describe("doSomething") {
                it("must not leak"){
                    let action : (LeakingViewController) -> () = { vc in

                        vc.cleanLeakedObjects()
                        vc.doSomething()
                    }

                    expect(test).toNot(leakWhen(action))
                }
            }
            
            describe("createLeak") {
                it("must leak"){
                    let action : (LeakingViewController) -> () = { vc in

                        vc.cleanLeakedObjects()
                        vc.createLeak()
                    }

                    expect(test).to(leakWhen(action))
                }
            }

            describe("createLeakInBlock") {
                it("must leak"){
                    let action : (LeakingViewController) -> Any = { vc in

                        vc.cleanLeakedObjects()
                        return vc.createLeakInBlock()
                    }

                    expect(test).to(leakWhen(action))
                }

                it("must leak"){
                    let action : (LeakingViewController) -> Any = { vc in

                        vc.cleanLeakedObjects()
                        return vc.createLeakInBlock()
                    }

                    expect(test).to(leakWhen(action))
                }
            }
            describe("dontCreateLeakInBlock") {
                it("must not leak"){
                    let action : (LeakingViewController) -> Any = { vc in
                        
                        vc.cleanLeakedObjects()
                        return vc.dontCreateLeakInBlock()
                    }
                    
                    expect(test).toNot(leakWhen(action))
                }
            }
        }
    }
}



