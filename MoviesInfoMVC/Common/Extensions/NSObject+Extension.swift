//
//  NSObject+Extension.swift
//  MoviesInfoMVC
//
//  Created by Polina Petrenko on 03.01.2022.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
}
