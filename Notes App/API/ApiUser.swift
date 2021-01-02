//
//  ApiUser.swift
//  Notes App
//
//  Created by Mohamed Skaik on 1/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class ApiUser: BaseApiController{
    
    public func createUser(user: User, password: String, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let parameters: Parameters = ["first_name" : user.first_name!, "last_name" : user.last_name!, "email" : user.email!, "mobile" : user.mobile!, "password" : password, "api_uuid" : ApiSettings.API_UUID.url]
                let headers: HTTPHeaders = ["lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.USER_REGISTER.url, method: .post, parameters: parameters, headers: headers).responseObject { (response: DataResponse<BaseGenericResponse<User>>) in
                    
                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let user = baseResponse.object{
                                UserData.setData(user: user)
                                requsetResponse(true, baseResponse.message ?? "")
                                return
                            }
                        }
                        requsetResponse(false, baseResponse.message ?? "")
                    }
                }
            }
        
        }
    }
    
    public func login( email: String, password: String, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let headers: HTTPHeaders = ["lang" : L102Language.currentAppleLanguage()]
                let parameters: Parameters = ["email" : email, "password" : password]
                Alamofire.request(ApiSettings.LOGIN.url, method: .post, parameters: parameters,headers: headers).responseObject { (response: DataResponse<BaseGenericResponse<User>>) in

                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let user = baseResponse.object{
                                UserData.setData(user: user)
                                requsetResponse(true, baseResponse.message ?? "")
                                return
                            }
                        }
                        requsetResponse(false, baseResponse.message ?? "")
                    }
                }
            }else {
                print("sdcsdcsc")
            }
        }
    }
    
    public func logout(requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.LOGOUT.url, method: .get, headers: headers).responseObject { (response: DataResponse<BaseResponse>) in

                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let message = baseResponse.message{
                                UserData.clearUserDefault()
                                requsetResponse(false, message)
                                return
                            }
                        }
                    }
                    requsetResponse(true, "")
                }
            }
        }
    }
    
    public func updateUser(user: User, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let parameters: Parameters = ["first_name" : user.first_name!, "last_name" : user.last_name!, "email" : user.email!, "mobile" : user.mobile!]
                let headers: HTTPHeaders = ["Authorization" : "Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.USER_UPDATE.url, method: .put, parameters: parameters, headers: headers).responseObject { (response: DataResponse<BaseGenericResponse<User>>) in
                    
                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let user = baseResponse.object{
                                UserData.setData(user: user)
                                requsetResponse(true, baseResponse.message ?? "")
                                return
                            }
                        }
                        requsetResponse(false, baseResponse.message ?? "")
                    }
                }
            }
        }
    }
    
}
