import SwiftUI
import PhotosUI

class QuickStartButtonViewModel: ObservableObject {
    @Published var image: Image? = nil
    @Published private var audio: Data = Data()
    @Published var selectedItems: [PhotosPickerItem] = []
    //유저 정보를 받아와야함
    var uploader: User = User(email: " ", nickname: " ", password: " ", isAlarmOn: false, signupDate: Date.now)
    
    final func NewPostUpload() {
        let newPost: Post = Post(id: Date.now.formatted() , uploadDate: Date.now, audio: audio, image: image, uploader: uploader)
        uploader.posts.append(newPost)
    }
    
    final func handleSelectedPhotos(from selectedItem: [PhotosPickerItem] ) {
        if !selectedItem.isEmpty {
            selectedItem[0].loadTransferable(type: Image.self) { result in
                DispatchQueue.main.async {
                    guard selectedItem == self.selectedItems else { return }
                    switch result {
                    case .success(let data?):
                        self.image = Image(data)
                    case .success(nil):
                        self.image = nil
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
