//
//  BaseGenericResponse.swift
//  Notes App
//
//  Created by Mohamed Skaik on 3/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseGenericResponse<T: Mappable> : BaseResponse {
    var object : T?
    var list : [T]?

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        object <- map["object"]
        list <- map["list"]
    }

}
