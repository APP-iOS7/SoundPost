import Foundation
import SwiftUICore

final class ContentViewModel: ObservableObject {

  @Published private var tabSelection: Tab = .home

  var tabHandler: Tab {
      get { self.tabSelection }
      set(newTab) {
        self.tabSelection = newTab
      }
    
  }

  enum Tab: Hashable {
    case home
    case quickStart
    case myProfile
  }
}
