//
//  ApiNote.swift
//  Notes App
//
//  Created by Mohamed Skaik on 3/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class ApiNote: BaseApiController {
    
    public func indexNotes(category_id: Int, requsetResponse: @escaping RequsetResponseArray<Note>){
        internetConnectionChecker { (status) in
            if status{
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())"]
                Alamofire.request(ApiSettings.NOTES.withId(id: category_id), method: .get, headers: headers).responseObject { (response: DataResponse<BaseGenericResponse<Note>>) in
                    
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
    
    public func create(title: String, details: String, category_id: Int, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let parameters: Parameters = ["title" : title, "details" : details, "category_id" : category_id]
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.NOTE_CREATE.url, method: .post, parameters: parameters, headers: headers).responseObject { (response: DataResponse<BaseResponse>) in
                    
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

    public func update(title: String, details: String, note_id: Int, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let parameters: Parameters = ["title" : title, "details" : details]
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.NOTE_UPDATE.withId(id: note_id), method: .put, parameters: parameters, headers: headers).responseObject { (response: DataResponse<BaseResponse>) in
                    
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

    public func delete(note_id: Int, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.NOTE_UPDATE.withId(id: note_id), method: .delete,headers: headers).responseObject { (response: DataResponse<BaseResponse>) in

                    requsetResponse(true, "")
                }
            }
        }
    }

    public func updateStatusNote(note_id: Int, requsetResponse: @escaping RequsetResponseMessage){
        internetConnectionChecker { (status) in
            if status{
                let headers: HTTPHeaders = ["Authorization":"Bearer \(UserData.getToken())", "lang" : L102Language.currentAppleLanguage()]
                Alamofire.request(ApiSettings.UPDATE_STATUS_NOTE.withId(id: note_id), method: .get,headers: headers).responseObject { (response: DataResponse<BaseResponse>) in

                    if let baseResponse = response.result.value{
                        if response.result.isSuccess{
                            if let status = baseResponse.status{
                                requsetResponse(status, "")
                                return
                            }
                        }
                    }
                }
                requsetResponse(false, "")
            }
        }
    }
    
}
