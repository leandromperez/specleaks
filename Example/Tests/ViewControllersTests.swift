//
//  LeakingViewControllerSpec.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 10/01/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Nimble
import Quick

@testable import SpecLeaks

class ViewControllersTests: QuickSpec {
    
    override func spec() {
        describe("UI/NS ViewController"){
            let test = LeakTest {
                return getOSViewController()
            }

            describe("init") {
                it("must not leak"){
                    expect(test).toNot(leak())
                }
            }
        }

        describe("LeakingViewController") {
            let test = LeakTest{
                #if os(iOS) || os(watchOS) || os(tvOS)
                let storyboard = UIStoryboard.init(name: "LeakingViewController", bundle: Bundle(for: LeakingViewController.self))
                return storyboard.instantiateInitialViewController() as! LeakingViewController
                #elseif os(OSX)
                    let storyboard = NSStoryboard.init(name: NSStoryboard.Name("LeakingViewController"), bundle: Bundle(for: LeakingViewController.self))
                    return storyboard.instantiateInitialController() as! LeakingViewController
                #endif
                
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

                it("must NOT leak"){
                    let action : (LeakingViewController) -> Any = { vc in

                        vc.cleanLeakedObjects()
                        return vc.createLeakInBlock()
                    }

                    expect(test).toNot(leakWhen(action)) //This test is intended to fail, since the action leaks
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

            describe("createLeakInFlatMap") {
                it("must leak"){
                    let action : (LeakingViewController) -> Any = { vc in

                        vc.cleanLeakedObjects()
                        return vc.createLeakInFlatMap()
                    }

                    expect(test).to(leakWhen(action))
                }
            }
            
            describe("dontCreateLeakInFlatMap") {
                it("must not leak"){
                    let action : (LeakingViewController) -> Any = { vc in
                        
                        vc.cleanLeakedObjects()
                        return vc.dontCreateLeakInFlatMap()
                    }
                    
                    expect(test).toNot(leakWhen(action))
                }
            }
        }
    }
}



