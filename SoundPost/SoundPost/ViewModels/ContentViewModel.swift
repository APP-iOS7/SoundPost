import Foundation
import SwiftUICore

final class ContentViewModel: ObservableObject {

  @Published private var tabSelection: Tab = .home

  var tabHandler: Binding<Tab> {
    Binding(
      get: { self.tabSelection },
      set: { newTab in
        self.tabSelection = newTab
      }
    )
  }

  enum Tab: Hashable {
    case home
    case quickStart
    case myProfile
  }
}
