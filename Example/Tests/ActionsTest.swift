//
//  Actions.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 03/02/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Nimble
import Quick

@testable import SpecLeaks

class LeakWhenActionCalled {

    var something: AnyObject?

    func dontLeak() {
        print("don't leak")
    }

    func leak() {
        self.something = self
    }

    func returnLeakingBlock() -> Action {
        return {
            self.dontLeak()
            print ("I leak because i'm not using weak " )
        }
    }

    func returnNotLeakingBlock() -> Action {
        return {[weak self] in
            self?.dontLeak()
            print ("I don't leak because i'm using weak " )
        }
    }
}

class LeakWhenActionCalledSpec: QuickSpec {

    override func spec() {

        describe("an ObjectThatLeaksWhenActionCalled") {

            let test = LeakTest {
                return LeakWhenActionCalled()
            }

            describe("init") {
                it("must not leak") {
                    expect(test).toNot(leak())
                }
            }

            describe("leak with no action") {
                it("must not leak") {
                    let leakingAction: Handler<LeakWhenActionCalled> = {_ in }
                    expect(test).toNot(leakWhen(leakingAction))
                }
            }

            describe("leak") {
                it("must leak") {
                    let leakingAction: Handler<LeakWhenActionCalled> = {leaker in leaker.leak()}
                    expect(test).to(leakWhen(leakingAction))
                }
            }

            describe("dontLeak") {
                it("must not leak") {
                    let notLeakingAction: Handler<LeakWhenActionCalled> = {leaker in leaker.dontLeak()}
                    expect(test).toNot(leakWhen(notLeakingAction))
                }
            }

            describe("returnLeakingBlock") {
                it("must leak") {
                    let leak: (LeakWhenActionCalled)-> Any  = {leaker in return leaker.returnLeakingBlock()}

                    expect(test).to(leakWhen(leak))
                }
            }

            describe("returnNotLeakingBlock") {
                it("must not leak") {
                    let leak: (LeakWhenActionCalled)-> Any  = {leaker in return leaker.returnNotLeakingBlock()}

                    expect(test).toNot(leakWhen(leak))
                }
            }
        }
    }
}
