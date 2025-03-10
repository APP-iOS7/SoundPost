import SwiftUI

struct CustomNavigationBar: View {
    private let title: String
    
    private let btnInits: [(title: String, action: () -> Void)]
    
    init (title: String, btnInits: [(title: String, action: () -> Void)] = []) {
        self.title = title
        self.btnInits = btnInits
    }
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text(title)
                    .font(.headline)
                Spacer()
            }
            HStack {
                Spacer()
                ForEach(btnInits, id: \.0) { btnInit in
                    Button(action: btnInit.action) {
                        if btnInit.title == btnInits.last?.title {
                            Text(btnInit.title)
                                .foregroundStyle(.black)
                                .padding(.trailing)
                        } else {
                            Text(btnInit.title)
                                .foregroundStyle(.black)
                        }
                        
                    }
                }
            }
        }
        .frame(height: 30)
    }
}
