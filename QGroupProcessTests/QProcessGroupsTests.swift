//
//  QProcessGroupsTests.swift
//  QProcessGroupsTests
//
//  Created by qiang xu on 2018/3/15.
//  Copyright © 2018年 qiang xu. All rights reserved.
//

import XCTest

class QProcessGroupsTests: XCTestCase {
    
    func fakeFailTest() {
        XCTFail("test faile")
    }
    
    
    func testNotRelatedTwoFirstFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: nil)
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertFalse(resultSuccess)
    }
    
    func testNotRelatedTwoSecondFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "Hello")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: nil)
        
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(resultSuccess)
    }
    
    func testNotRelatedTwoAllFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: nil)
        
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(resultSuccess)
    }
    
    func testTwoFirstFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op2])
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(resultSuccess)
    }
    
    func testTwoSecondFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "Hello")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(resultSuccess)
    }
    
    func testTwoAllFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(resultSuccess)
    }
    
    func testNotRelatedTwoSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "world")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: nil)
        
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(resultSuccess)
    }
    
    func testRelatedTwoSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "world")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(resultSuccess)
    }
    
    func testNotRelatedThreeSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "world")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let op3 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: nil)
        let _ = group.add(operation: op3, dependOperations: nil)
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(resultSuccess)
    }
    
    func testSerialThreeSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "world")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let op3 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        let _ = group.add(operation: op3, dependOperations: [op2])
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(resultSuccess)
    }
    
    func testBCRelayAFailed() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "world")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let op3 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                let error = NSError(domain: "test", code: -1, userInfo: nil)
                operation.failure(error: error)
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        let _ = group.add(operation: op3, dependOperations: [op1])
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertFalse(resultSuccess)
    }
    
    func testBCRelayASuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "world")
            }
        }
        let op2 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let op3 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                sleep(1)
                operation.success(result: "hello")
            }
        }
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        let _ = group.add(operation: op3, dependOperations: [op1])
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?)  in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(resultSuccess)
    }
}
