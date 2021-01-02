//
//  ApiSettings.swift
//  Notes App
//
//  Created by Mohamed Skaik on 1/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation

enum ApiSettings: String {
    
    case API_UUID = "46c53c5d-b1c4-4f3e-a6bf-424a3d76bf56"
    case BASE_URL = "http://notes.mr-tech.tech/api/"
    
    case USER_REGISTER = "user/register"
    case LOGIN = "user/login"
    case LOGOUT = "user/logout"
    case USER_UPDATE = "user/update"
    
    case CATEGORIES = "categories"
    case CATEGORY_UPDATE = "categories/{id}"
    
    case NOTE_CREATE = "notes"
    case NOTES = "categories/{id}/notes"
    case NOTE_UPDATE = "notes/{id}"
    case UPDATE_STATUS_NOTE = "notes/{id}/status"
    
    var url : String {
        switch self {
        case .BASE_URL:
            return ApiSettings.BASE_URL.rawValue
        case .API_UUID:
        return ApiSettings.API_UUID.rawValue
        default:
            return "\(ApiSettings.BASE_URL.rawValue)\(self.rawValue)"
        }
    }
    
    func withId(id: Int) -> String{
        switch self {
        case .CATEGORY_UPDATE, .NOTES, .NOTE_UPDATE, .UPDATE_STATUS_NOTE:
            return "\(ApiSettings.BASE_URL.rawValue)\(self.rawValue.replacingOccurrences(of: "{id}", with: "\(id)"))"
        default:
            return ""
        }
    }
}
