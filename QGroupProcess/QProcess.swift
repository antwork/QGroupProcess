//
//  QOperation.swift
//  QProcessGroups
//
//  Created by qiang xu on 2018/3/15.
//  Copyright © 2018年 qiang xu. All rights reserved.
//

import Foundation

public class QProcess: NSObject {
    
    deinit {
        print(">>\(name) deinit")
    }
    
    weak var group:QProcessGroup?
    
    var name:String = UUID().uuidString
    
    // 自带参数
    public var originParams:Any?

    // 依赖携带参数
    public var dependParams:Any?
    
    // 开始任务
    @objc public final func start(params:Any?) {
        self.dependParams = params
        
        self.process()
    }
    
    // 处理任务：待子类继承
    @objc public func process() {
        
    }
    
    // 成功回调
    @objc public final func success(result:Any) {
        DispatchQueue.main.async {
            self.group?.success(operation: self, result: result)
        }
    }
    
    // 失败回调
    @objc public final func failure(error:Error) {
        DispatchQueue.main.async {
            self.group?.fail(operation: self, error: error)
        }
    }
}

public typealias QOperationBlock = (QProcess) -> Void

public class QBlockProcess: QProcess {
    
    private let block:QOperationBlock
    
    @objc public init(params:Any? = nil, block:@escaping QOperationBlock) {
        self.block = block
        super.init()
        
        self.originParams = params
    }
    
    override public func process() {
        block(self)
    }
}
