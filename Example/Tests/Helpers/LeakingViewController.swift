//
//  LeakingViewController.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 10/01/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import RxSwift

class LeakingViewController: OSViewController {

    private var anyObject: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func cleanLeakedObjects() {

        self.anyObject = nil
    }

    func createLeak() {
        self.anyObject = self
    }

    func doSomething() {
        print("doing something")
    }

    func createLeakInBlock() -> () -> Void {
        return {
            self.doSomething()
        }
    }

    func dontCreateLeakInBlock() -> () -> Void {
        return { [weak self] in
            self?.doSomething()
        }
    }

    func createLeakInFlatMap() -> Observable<String> {
        return Observable.just("hello")
            .flatMap { (_) -> Observable<String> in
                self.doSomething()
                return .just("goodbye and leak")
        }
    }

    func dontCreateLeakInFlatMap() -> Observable<String> {
        return Observable.just("hello")
            .flatMap { [unowned self] (_) -> Observable<String> in
                self.doSomething()
                return .just("goodbye")
        }
    }
}
