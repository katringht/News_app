//
//  Result_enum.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 16.10.2021.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Error(String)
}
