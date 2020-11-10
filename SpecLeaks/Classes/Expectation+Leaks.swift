//
//  Expectation+Leaks.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 03/02/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Foundation
import Nimble

public typealias LeakTestConstructor = () -> AnyObject

extension Expectation where T==LeakTestConstructor {

    public func toNotLeak(timeout: DispatchTimeInterval = AsyncDefaults.timeout, pollInterval: DispatchTimeInterval = AsyncDefaults.pollInterval, description: String? = nil, shouldFail: Bool = false) {
        do {
            guard let constructor = try expression.evaluate() else {
                fail()
                return
            }
            AnalyzeLeak().execute(constructor: constructor, shouldLeak: shouldFail)
        } catch {
            fail()
        }
    }

    public func toLeak() {
        self.toNotLeak(timeout: AsyncDefaults.timeout, pollInterval: AsyncDefaults.pollInterval, description: nil, shouldFail: true)
    }

    public func toNotLeakWhen<P>( shouldFail: Bool = false, _ action: (P)->Void) where P: AnyObject {
        do {
            guard let constructor = try expression.evaluate() else {
                fail()
                return
            }
            let castedConstructor : () -> P = { constructor() as! P }

            AnalyzeLeakAction().execute(constructor: castedConstructor, action: action, shouldLeak: shouldFail)
        } catch {
            fail()
        }
    }

    public func toLeakWhen<P>(shouldFail: Bool = false, _ action: (P)->Void) where P: AnyObject {
        self.toNotLeakWhen(shouldFail: true, action)
    }

    public func toNotLeakWhen<P>( shouldFail: Bool = false, _ action: (P)->Any) where P: AnyObject {
        do {
            guard let constructor = try expression.evaluate() else {
                fail()
                return
            }
            let castedConstructor : () -> P = { constructor() as! P }

            AnalyzeLeakAction().execute(constructor: castedConstructor, action: action, shouldLeak: shouldFail)
        } catch {
            fail()
        }
    }

    public func toLeakWhen<P>(shouldFail: Bool = false, _ action: (P)->Any) where P: AnyObject {
        self.toNotLeakWhen(shouldFail: true, action)
    }

}
