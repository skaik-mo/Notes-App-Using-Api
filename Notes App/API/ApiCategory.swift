//
//  ApiCategory.swift
//  Notes App
//
//  Created by Mohamed Skaik on 3/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class ApiCategory: BaseApiController {
    
    public func indexCategories(requsetResponse: @escaping RequsetResponseArray<Category>){
        internetConnectionChecker { (status) in
            if status{
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())"]
                Alamofire.request(ApiSettings.CATEGORIES.url, method: .get, headers: headers).responseObject { (response: DataResponse<BaseGenericResponse<Category>>) in
                    
                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let list = baseResponse.list{
                                requsetResponse(true, list)
                                return
                            }
                        }
                        requsetResponse(false, [])
                    }
                }
            }
        }
    }
    
    public func create(title: String, details: String, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let parameters: Parameters = ["title" : title, "details" : details]
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.CATEGORIES.url, method: .post, parameters: parameters, headers: headers).responseObject { (response: DataResponse<BaseResponse>) in
                    
                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let status = baseResponse.status , let message = baseResponse.message{
                                requsetResponse(status, message)
                                return
                            }
                        }
                        requsetResponse(false, baseResponse.message ?? "")
                    }
                }
            }
        }
    }

    public func update(id: Int, title: String, details: String, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let parameters: Parameters = ["title" : title, "details" : details]
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.CATEGORY_UPDATE.withId(id: id), method: .put, parameters: parameters, headers: headers).responseObject { (response: DataResponse<BaseResponse>) in
                    
                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let status = baseResponse.status , let message = baseResponse.message{
                                requsetResponse(status, message)
                                return
                            }
                        }
                        requsetResponse(false, baseResponse.message ?? "")
                    }
                }
            }
        }
    }

    public func delete(id: Int, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.CATEGORY_UPDATE.withId(id: id), method: .delete, headers: headers).responseObject { (response: DataResponse<BaseResponse>) in

                    requsetResponse(true, "")
                }
            }
        }
    }
    
}
