import Foundation

struct User: Codable {
    var points: Int
    var level: Int
    var currentDay: Date
    var presentDay: Int
    var openedPresentDay: Bool
    var hasOpenedAppBefore: Bool
    var currentGroupIndex: Int
    var openedPresent: Bool
}

extension User {
    static let mock = User(
        points: 0,
        level: 1,
        currentDay: Date.now,
        presentDay: 1,
        openedPresentDay: false,
        hasOpenedAppBefore: false,
        currentGroupIndex: 0,
        openedPresent: false
    )
}
