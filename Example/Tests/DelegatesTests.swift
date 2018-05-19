//
//  DelegatesTests.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 03/02/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Nimble
import Quick
import SpecLeaks

// MARK: - Leaking
protocol ServerDelegate: AnyObject {}

class LeakingServer {
    var delegate: ServerDelegate?
}

class LeakingClient: ServerDelegate {
    var server: LeakingServer

    init(server: LeakingServer) {
        self.server = server
        server.delegate = self
    }
}

// MARK: - Not Leaking
class NotLeakingServer {
    weak var delegate: ServerDelegate?
}

class NotLeakingClient: ServerDelegate {
    var server: NotLeakingServer

    init(server: NotLeakingServer) {
        self.server = server
        server.delegate = self
    }
}

class SomeObject {
    func doSomething() {

    }
}

class SomeOjectTests: QuickSpec {
    override func spec() {
        describe("a SomeObject") {
            describe("init") {
                it("must not leak") {

                    let someObject = LeakTest {
                        return SomeObject()
                    }

                    let doSomethingIsCalled: (SomeObject) -> Void  = {obj in obj.doSomething()}

                    expect(someObject).toNot(leakWhen(doSomethingIsCalled))
                }
            }
        }
    }
}

class DelegatesTests: QuickSpec {

    override func spec() {
        describe("a NotLeakingClient") {

            it("must not leak") {

                let test = LeakTest {
                    return NotLeakingClient(server: NotLeakingServer())
                }

                expect(test).toNot(leak())
            }
        }

        describe("a LeakingClient") {

            it("must leak") {

                let test = LeakTest {
                    return LeakingClient(server: LeakingServer())
                }

                expect(test).to(leak())
            }

            it("must not leak") {

                let test = LeakTest {
                    return LeakingClient(server: LeakingServer())
                }

                expect(test).toNot(leak()) //This test is intended to fail, since the object leaks
            }
        }
    }
}
