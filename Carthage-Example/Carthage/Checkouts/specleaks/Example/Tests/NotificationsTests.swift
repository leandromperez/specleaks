//
//  ObjectListeningAppNotificationSpec.swift
//  UnitTestLeaks
//
//  Created by Leandro Perez on 03/02/2018.
//  Copyright © 2018 Leandro Perez. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxSwift
import RxCocoa

@testable import SpecLeaks

//MARK: - Not Leaking
class NotLeakingWithAppNotification{
    private var disposeBag = DisposeBag()
    
    var s : Int = 5
    
    func doSomething(){
        s = Int(arc4random())
    }
    
    init() {
        NotificationCenter.default.rx
            .notification(Notification.Name.init("Some notification"))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self](_) in
                self.doSomething()
            })
            .disposed(by: self.disposeBag)
    }
}

//MARK: - Leaking
class LeakingWithAppNotification{
    private var disposeBag = DisposeBag()
    
    var s : Int = 5
    
    func doSomething(){
        s = Int(arc4random())
    }
    
    init() {
        NotificationCenter.default.rx
            .notification(Notification.Name.init("Some notification"))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_) in //NOTICE that [unowned self] was taken out, creating a leak
                self.doSomething()
            })
            .disposed(by: self.disposeBag)
    }
}

class NotificationsTests: QuickSpec {
    
    override func spec() {
        describe("an NotLeakingWithAppNotification") {
           
            it("must not leak"){
                let listeningAppNotification = LeakTest{
                    return NotLeakingWithAppNotification()
                }
                
                expect(listeningAppNotification).toNot(leak())
            }
        }
        
        describe("a LeakWithAppNotification") {
            
            it("must leak"){
                let leaker = LeakTest{
                    return LeakingWithAppNotification()
                }
                
                expect(leaker).to(leak())
            }
        }
    }
}
