//
//  GeneralParameters.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import Foundation
import NetworkFramework

struct GeneralParameters: RequestParametersProtocol {
    static var caseType: CaseTypes { .snakeCase }

    let apiKey: String
    let language: String
}
