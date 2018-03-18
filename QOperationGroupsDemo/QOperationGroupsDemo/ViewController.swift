//
//  ViewController.swift
//  QOperationGroupsDemo
//
//  Created by qiang xu on 2018/3/18.
//  Copyright © 2018年 qiang xu. All rights reserved.
//

import UIKit
import QGroupProcess

class ViewController: UIViewController {

    let group = QProcessGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let op1 = QBlockProcess.init { (operation) in
            DispatchQueue.global().async {
                print("op1 begin:\(Thread.current)")
                sleep(3)
                operation.success(result: "world")
                print("op1 end")
            }
        }
        
        let op2 = QBlockProcess.init(params: "Hello") { (operation) in
            DispatchQueue.global().async {
                
                guard let params = operation.dependParams as? [String], let world = params.first else {
                    let error = NSError(domain: "", code: -1, userInfo: nil)
                    operation.failure(error: error)
                    return
                }
                
                print("op2 begin:\(Thread.current)")
                sleep(3)
                operation.success(result: "\(operation.originParams ?? "") \(world)")
                print("op2 end")
            }
        }
        
        let name1 = group.add(operation: op1, dependOperations: nil)
        let name2 = group.add(operation: op2, dependOperations: [op1])
        
        print("name1:\(name1) name2:\(name2)")
        
        group.finishBlock = { (group1:QProcessGroup, success:Bool, result:Any?, error:Error?) in
            guard success, let result = result as? [String:String] else {
                print(error ?? "Unknown Error")
                return
            }
            
            print(result)
        }
        group.start()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

