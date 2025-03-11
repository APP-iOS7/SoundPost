import Foundation

class CommentButtonViewModel: ContentViewModel {
    @Published var buttonClick = 1
    
    override func QuickStartSet() {
        if isQuickStartButtonOn {
            self.isShowingNewPost = true
            if self.buttonClick > 0 && self.buttonClick < 3 {
                self.buttonClick += 1
            } else {
                self.buttonClick = 2
            }
        } else {
            self.isQuickStartButtonOn = true
            self.isShowingNewPost = true
            self.buttonClick += 1
        }
    }
}
