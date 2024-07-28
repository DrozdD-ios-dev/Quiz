import Foundation

struct Questions: Codable {
    let questions: [Group]
}

struct Group: Codable {
    let group: [Question]
}

struct Question: Codable {
    let title: String
    let number: String
    let answers: [Answer]
}

struct Answer: Codable {
    let letter: String
    let correct: Bool
}
