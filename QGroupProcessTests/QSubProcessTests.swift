//
//  QProcessGroupsTests.swift
//  QProcessGroupsTests
//
//  Created by qiang xu on 2018/3/15.
//  Copyright © 2018年 qiang xu. All rights reserved.
//

import XCTest

class QSuccessSubProcess: QProcess {
    override func process() {
        DispatchQueue.global().async {
            sleep(1)
            self.success(result: "1")
        }
    }
}

class QFailSubProcess: QProcess {
    override func process() {
        DispatchQueue.global().async {
            sleep(1)
            let error = NSError(domain: "test", code: -1, userInfo: nil)
            self.failure(error: error)
        }
    }
}

class QSubProcessTests: XCTestCase {
    
    func testSubProcessNotRelatedTwoFirstFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QFailSubProcess()
        let op2 = QSuccessSubProcess()
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
    
    func testSubProcessNotRelatedTwoSecondFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QFailSubProcess()
        
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
    
    func testSubProcessNotRelatedTwoAllFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QFailSubProcess()
        let op2 = QFailSubProcess()
        
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

    func testSubProcessTwoFirstFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QFailSubProcess()
        let op2 = QSuccessSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op2])
        
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertFalse(resultSuccess)
    }

    func testSubProcessTwoSecondFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QFailSubProcess()
        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])

        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertFalse(resultSuccess)
    }

    func testSubProcessTwoAllFail() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QFailSubProcess()
        let op2 = QFailSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op2])
        

        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertFalse(resultSuccess)
    }

    func testSubProcessNotRelatedTwoSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QSuccessSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: nil)


        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(resultSuccess)
    }

    func testSubProcessRelatedTwoSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QSuccessSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])

        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(resultSuccess)
    }

    func testSubProcessNotRelatedThreeSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QSuccessSubProcess()
        let op3 = QSuccessSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: nil)
        let _ = group.add(operation: op3, dependOperations: nil)

        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(resultSuccess)
    }

    func testSubProcessSerialThreeSuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QSuccessSubProcess()
        let op3 = QSuccessSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        let _ = group.add(operation: op3, dependOperations: [op2])

        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
    
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(resultSuccess)
    }

    func testSubProcessBCRelayAFailed() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QSuccessSubProcess()
        let op3 = QFailSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        let _ = group.add(operation: op3, dependOperations: [op1])

        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertFalse(resultSuccess)
    }

    func testSubProcessBCRelayASuccess() {
        weak var exp = expectation(description: "\(#function)")
        var resultSuccess = false
        let group = QProcessGroup()
        let op1 = QSuccessSubProcess()
        let op2 = QSuccessSubProcess()
        let op3 = QSuccessSubProcess()

        let _ = group.add(operation: op1, dependOperations: nil)
        let _ = group.add(operation: op2, dependOperations: [op1])
        let _ = group.add(operation: op3, dependOperations: [op1])

        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            resultSuccess = success
            exp?.fulfill(); exp = nil
        }
        group.start()
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(resultSuccess)
    }
}
