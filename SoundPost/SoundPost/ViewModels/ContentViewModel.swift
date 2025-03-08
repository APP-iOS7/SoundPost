import Foundation
import SwiftUICore

final class ContentViewModel: ObservableObject {
    
    @Published private var preTab: Tab = .home
    @Published var isQuickStartButtonOn: Bool = false
    @Published var QuickStartButtonClick: Int = 0
    @Published var isShowingNewPost: Bool = false
    
    @Published var tabHandler: Tab = .home
//    {
////        didSet(oldTab) {
////            if self.tabHandler != .quickStart && self.QuickStartButtonClick == 0 {
////                self.preTab = oldTab
////            }
////            if self.QuickStartButtonClick == 4 {
////                self.tabHandler = self.preTab
////            }
////        }
////        willSet(newTab) {
////            if newTab == .quickStart {
////                if self.QuickStartButtonClick >= 0 && self.QuickStartButtonClick < 4 {
////                    self.QuickStartButtonClick += 1
////                } else {
////                    self.QuickStartButtonClick = 0
////                }
////            } else {
////                self.QuickStartButtonClick = 0
////            }
////        }
//        get { self.preTab }
//        set {
//            if isQuickStartButtonOn {
//                
//            }
//        }
//        
//    }
    
    final func isNewPostShowing() -> Bool {
        return !isShowingNewPost
    }
    
    final func QuickStartButtonColor() -> Color {
        return isQuickStartButtonOn ? .black : .gray
    }
    final func TabColor(_ tab: Tab) -> Color {
        if isQuickStartButtonOn { return .gray }
        else { return tab == self.tabHandler ? .black : .gray }
    }
    final func TabSet(_ tab: Tab) {
        self.tabHandler = tab
        if isQuickStartButtonOn {
            isShowingNewPost = false
            isQuickStartButtonOn = false
            QuickStartButtonClick = 0
            
        }
    }
    final func QuickStartSet() {
        if isQuickStartButtonOn {
            self.isShowingNewPost = true
            if self.QuickStartButtonClick >= 0 && self.QuickStartButtonClick < 3 {
                self.QuickStartButtonClick += 1
            } else {
                self.isShowingNewPost = false
                self.QuickStartButtonClick = 0
                self.isQuickStartButtonOn = false
            }
        } else {
            self.isQuickStartButtonOn = true
            self.isShowingNewPost = true
            self.QuickStartButtonClick += 1
        }
    }
    enum Tab: Hashable {
        case home
//        case quickStart
        case myProfile
    }
}
