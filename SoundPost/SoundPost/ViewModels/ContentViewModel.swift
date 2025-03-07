import Foundation
import SwiftUICore

final class ContentViewModel: ObservableObject {
    
    @Published private var tabSelection: Tab = .home
    @Published private var preTab: Tab = .home
    @Published var QuickStartButtonClick: Int = 0
    
    @Published var tabHandler: Tab = .home {
        didSet(oldTab) {
            if self.tabHandler != .quickStart && self.QuickStartButtonClick == 0 {
                self.preTab = self.tabSelection
            }
            if self.QuickStartButtonClick == 4 {
                self.tabHandler = self.preTab
            }
        }
        willSet(newTab) {
            if newTab == .quickStart {
                if self.QuickStartButtonClick >= 0 && self.QuickStartButtonClick < 4 {
                    self.QuickStartButtonClick += 1
                } else {
                    self.QuickStartButtonClick = 0
                }
            } else {
                self.QuickStartButtonClick = 0
            }
            self.tabSelection = newTab
        }
        
    }
    
    enum Tab: Hashable {
        case home
        case quickStart
        case myProfile
    }
}
