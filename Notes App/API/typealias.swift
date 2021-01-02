//
//  typealis.swift
//  Notes App
//
//  Created by Mohamed Skaik on 1/11/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import Foundation

typealias RequsetResponseMessage = (_ status: Bool, _ message: String) -> Void
typealias RequsetResponseArray<T> = (_ status: Bool, _ list: [T] ) -> Void
typealias InternetConnectionChecker = (_ status: Bool) -> Void
