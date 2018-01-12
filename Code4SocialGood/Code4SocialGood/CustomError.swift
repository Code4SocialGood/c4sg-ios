//
//  CustomError.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/12/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

protocol CustomErrorProtocol: LocalizedError {
    var code: Int { get }
    var title: String? { get }
}

struct CustomError: CustomErrorProtocol {
    
    public var code: Int
    public var errorDescription: String? {
        return _description
    }
    public var failureReason: String? {
        return _description
    }
    public var title: String?
    
    private var _description: String
    
    init(code: Int, title: String?, description: String) {
        self.code = code
        self.title = title ?? "Error"
        self._description = description
    }
    
}
