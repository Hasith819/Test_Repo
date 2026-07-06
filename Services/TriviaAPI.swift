//
//  TriviaAPI.swift
//  ios-project
//
//  Created by student6 on 2026-07-02.
//

import Foundation

struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}

struct TriviaAPI {
    func fetchQuestions() async throws -> [TriviaQuestion] {
        let url = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(TriviaResponse.self, from: data)
        return result.results
    }
}

extension String {
    var htmlDecoded: String {
        self
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&#039", with: "'")
    }
}