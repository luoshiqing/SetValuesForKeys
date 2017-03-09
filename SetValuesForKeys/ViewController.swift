//
//  ViewController.swift
//  SetValuesForKeys
//
//  Created by sqluo on 2017/1/20.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class ABC : NSObject{
    
    var id: String?
    var name: String?
    var age: String?
    var exo: String?

    //字典初始化
    init(dict: [String:String]){
        super.init()
        
        //给所有成员赋值
        self.getMembers(of: dict)
    }
}

extension NSObject {
    
    //MARK:获取类的成员属性，根据dict返回对应的dict
    /**
     - parameter dict:     需要设置的字典
     */
    public func getMembers(of dict: [String:Any]){
        
        var tmpDict = dict          //返回的字典
        var members = [String]()    //存放类所有成员
        var count: UInt32 = 0
        let ivars = class_copyIvarList(self.classForCoder, &count) //获取有多少个成员
        for i in 0..<Int(count) {
            let ivar = ivars![i]
            let name = ivar_getName(ivar)
            let strName = String(cString: name!)
            members.append(strName)
        }
        free(ivars)
        //排查是否含有该成员
        for (key,_) in tmpDict {
            if !members.contains(key) {
                print("**不包含该key**:\(key)")
                tmpDict.removeValue(forKey: key)
            }
        }
        //给所有成员赋值
        self.setValuesForKeys(tmpDict)
    }
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict = ["id":"5555","array":"4","sb":"dx","haha":"3"]
        
        let abc = ABC(dict: dict)
        
        print(abc.age ?? "age = nil")
        print(abc.name ?? "name = nil")
        print(abc.id ?? "id = nil")
    }

}

