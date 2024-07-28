import SwiftUI

@main
struct QuizApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}

struct AppView: View {
    @StateObject var router = Router.shared
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            MainScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .play:
                        PlayScreen()
                    case .map:
                        MapScreen()
                    case .finishGame:
                        FinishGameScreen()
                    case .calendar:
                        CalendarScreen()
                    case .present:
                        PresentScreen()
                    case .onboarding:
                        OnboardingScreen()
                    }
                }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    AppView()
}
