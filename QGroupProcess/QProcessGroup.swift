//
//  QProcessGroup.swift
//  QProcessGroups
//
//  Created by qiang xu on 2018/3/15.
//  Copyright © 2018年 qiang xu. All rights reserved.
//

import Foundation

public typealias QOperationFinishBlock = (QProcessGroup, Bool, Any?, Error?) -> Void

public class QProcessGroup: NSObject {
    
    public var finishBlock:QOperationFinishBlock?
    
    public func add(operation:QProcess, dependOperations:[QProcess]? = nil) -> String {
        operation.group = self
        if let dependOperations = dependOperations {
            let namesInArray = dependOperations.map { return $0.name }
            self.depends[operation.name] = Set(namesInArray)
            self.dependsInOrder[operation.name] = namesInArray
        }
        
        operations[operation.name] = operation
        
        return operation.name
    }
    
    public func start() {
        triggerNext()
    }
    
    private lazy var depends = [String:Set<String>]()
    
    private lazy var dependsInOrder = [String:[String]]()
    
    private lazy var operations = [String:QProcess]()
    
    private lazy var results = [String:Any]()
    
    private var finished = Set<String>()
    
    private var failed:Bool = false
    
    private let semaphore = DispatchSemaphore(value: 1)

    func success(operation:QProcess, result:Any) {
        semaphore.wait()
        
        finished.insert(operation.name)
        
        results[operation.name] = result
        
        semaphore.signal()
        
        triggerNext()
    }
    
    func fail(operation:QProcess, error:Error) {
        finishBlock?(self, false, nil, error)
        
        failed = true
    }
    
    private func triggerNext() {
        if failed {
            return
        }
        
        if finished.count > 0, finished.count == operations.count {
            finishBlock?(self, true, results, nil)
            return
        }
        
        semaphore.wait()
        
        let leftOPs = operations.values.filter { !finished.contains($0.name) }
        
        for op in leftOPs {
            if let deps = depends[op.name], deps.count > 0, deps.subtracting(finished).count > 0 {
                // 存在依赖， 并且依赖未完成
            } else {
                let namesInOrder = dependsInOrder[op.name]
    
                let params = namesInOrder?.map { return self.results[$0] }
                op.start(params: params)
            }
        }
        
        semaphore.signal()
    }
}
