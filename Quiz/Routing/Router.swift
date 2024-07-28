import SwiftUI

final class Router: ObservableObject {
    
    static let shared = Router()
    @Published var path = [Route]()
    
    func showMapScreen() {
        path.append(.map)
    }
    
    func showPlayScreen() {
        path.append(.play)
    }
    
    func showFinishGameScreen() {
        path.append(.finishGame)
    }
    
    func showCalendarScreen() {
        path.append(.calendar)
    }
    
    func showPresentScreen() {
        path.append(.present)
    }
    
    func showOnboardingScreen() {
        path.append(.onboarding)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func goBackToRoot() {
        path.removeAll()
    }
    
}
