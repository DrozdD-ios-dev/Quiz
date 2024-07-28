import SwiftUI
import Combine

final class ViewModel: ObservableObject {
    
    @Published var currentProgress: Double = 0
    @Published var questionProgress: Double = 0
    @Published var currentQuestionID = 0
    @Published var user = CacheService.loadCache(key: "user") ?? User.mock
    @Published var groupQuestions: [Question] = []
    @Published var buttonState: ButtonState = .normal
    @Published var buttonStates: [ButtonState] = [.normal, .normal, .normal]
    @Published var addingPoints = 0
    @Published var starsState: StarsState = .noStar
    @Published var isButtonDisabled = false
    
    var currentQuestion: Question {
        return groupQuestions[currentQuestionID]
    }
    
    private let router = Router.shared
    private let constProgressBar = 240
    private var subscribers = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {
        $user
            .sink { user in
                CacheService.saveCache(model: user, key: "user")
            }
            .store(in: &subscribers)
        
        $addingPoints
            .sink { [weak self] points in
                guard let self else { return }
                switch points {
                case 0...10:
                    starsState = .noStar
                case 20...30:
                    starsState = .oneStar
                case 40...50:
                    starsState = .twoStar
                case 60:
                    starsState = .threeStar
                default:
                    break
                }
            }
            .store(in: &subscribers)
        
        checkCurrentDay()
        checkFirstOpenApp()
    }
    
    // MARK: - OnboardingScreen logic
    
    private func checkFirstOpenApp() {
        if !user.hasOpenedAppBefore {
            user.hasOpenedAppBefore = true
            showOnboardingScreen()
        }
    }
    
    // MARK: - MainScreen logic
    
    func setupSettings() {
        updateProgressView()
        updateQuestionsGroup()
    }
    
    private func updateProgressView() {
        if user.points > constProgressBar {
            user.level += user.points / constProgressBar
            if user.level % 2 == 0 {
                user.openedPresent = false
            }
            let points = user.points - constProgressBar
            user.points = points
        }
        currentProgress = Double(user.points) / Double(constProgressBar)
    }
    
    private func updateQuestionsGroup() {
        if user.currentGroupIndex < 10 {
        } else {
            user.currentGroupIndex = 0
        }
        loadQuestions()
    }
    
    // MARK: - PlayScreen logic
    
    private func loadQuestions() {
        do {
            groupQuestions = try DataService.decodeJsonData().questions[user.currentGroupIndex].group
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func answerButtonTapped(index: Int) async {
        let isCorrect = currentQuestion.answers[index].correct
        buttonStates[index] = isCorrect ? .right : .wrong
        addingPoints += isCorrect ? 10 : 0
        
        isButtonDisabled = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        isButtonDisabled = false
        
        resetButtonState()
        if currentQuestionID + 1 > groupQuestions.count - 1 {
            showFinishGameScreen()
        } else {
            currentQuestionID += 1
            questionProgress = Double(currentQuestionID) / Double(groupQuestions.count)
        }
        
    }
    
    private func resetButtonState() {
        buttonStates = [.normal, .normal, .normal]
    }
    
    func resetProgress() {
        user.points += addingPoints
        addingPoints = 0
        user.currentGroupIndex += 1
        questionProgress = 0
        currentQuestionID = 0
    }
    
    // MARK: - FinishGame logic
    
    func makeAttributedString(points: Int) -> AttributedString {
        var attributedString = AttributedString("You Earned \(points) pts")
        if let range = attributedString.range(of: "You Earned") {
            attributedString[range].font = .customFont(.poppins400, 18)
        }
        if let range = attributedString.range(of: "\(points) pts") {
            attributedString[range].font = .customFont(.poppins700, 20)
        }
        return attributedString
    }
    
    // MARK: - MapScreen logic
    
    func updatePresent() {
        if user.level % 2 == 0, !user.openedPresent {
            user.points += 20
            user.openedPresent = true
            showPresentScreen()
        }
    }
    
    // MARK: - CalendarScreen logic
    
    func checkCurrentDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let currentDay = dateFormatter.string(from: Date.now)
        guard let resultCurrentDay = Int(currentDay) else { return }
        let savedDay = dateFormatter.string(from: user.currentDay)
        guard let resultSavedDay = Int(savedDay) else { return }
        
        if resultCurrentDay - resultSavedDay == 1 {
            user.presentDay += 1
            user.openedPresentDay = false
        } else if resultCurrentDay > resultSavedDay {
            user.presentDay = 1
            user.openedPresentDay = false
        } else if resultCurrentDay == resultSavedDay {
            return
        }
        user.currentDay = Date.now
        showCalendarScreen()
    }
    
    func updatePresentDay() {
        if !user.openedPresentDay {
            user.points += user.presentDay * 10
            user.openedPresentDay = true
            updateProgressView()
        }
    }
    
    // MARK: - Routing
    
    private func showOnboardingScreen() {
        router.showOnboardingScreen()
    }
    
    private func showFinishGameScreen() {
        router.showFinishGameScreen()
    }
    
    private func showPresentScreen() {
        router.showPresentScreen()
    }
    
    func showCalendarScreen() {
        router.showCalendarScreen()
    }
    
    func showPlayScreen() {
        self.router.showPlayScreen()
    }
    
    func showMapScreen() {
        router.showMapScreen()
    }
    
    func goBack() {
        router.goBack()
    }
    
    func goBackToRoot() {
        router.goBackToRoot()
    }
}
