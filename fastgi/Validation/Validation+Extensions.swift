//
//  Validation+Extensions.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

import ValidatedPropertyKit

extension Validation where Value == String {
    static func required(errorMessage: String = "Is Empty") -> Validation {
        return .init { value in
            value.isEmpty  ? .failure(.init(message: errorMessage)) : .success(())
        }
    }
}
