/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct User : Mappable {
	var first_name : String?
	var last_name : String?
	var email : String?
	var mobile : String?
	var student_api_uuid : String?
	var status : String?
	var updated_at : String?
	var created_at : String?
	var id : Int?
	var token : String?
	var categories_count : Int?
	var notes_count : Int?
	//var student : Student?
    
	init?(map: Map) {

	}

    init(first_name: String, last_name: String, email: String, mobile: String) {
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.mobile = mobile
    }
    
    init(first_name: String, last_name: String, email: String, mobile: String, token: String, categories_count: Int, notes_count: Int) {
        self.init(first_name: first_name, last_name: last_name, email: email, mobile: mobile)
        self.token = token
        self.categories_count = categories_count
        self.notes_count = notes_count
        
    }
    
	mutating func mapping(map: Map) {

		first_name <- map["first_name"]
		last_name <- map["last_name"]
		email <- map["email"]
		mobile <- map["mobile"]
		student_api_uuid <- map["student_api_uuid"]
		status <- map["status"]
		updated_at <- map["updated_at"]
		created_at <- map["created_at"]
		id <- map["id"]
		token <- map["token"]
		categories_count <- map["categories_count"]
		notes_count <- map["notes_count"]
		//student <- map["student"]
	}

}
