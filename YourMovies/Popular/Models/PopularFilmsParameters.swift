//
//  PopularFilmsParameters.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 05.07.2021.
//

import Foundation
import NetworkFramework

struct PopularFilmsParameters: RequestParametersProtocol {
    static var caseType: CaseTypes { .snakeCase }
    

    let apiKey: String
    let language: String
}
