import SwiftUI
import PhotosUI

class QuickStartButtonViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published private var audio: Data = Data()
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    //유저 정보를 받아와야함
    var uploader: User = User(email: " ", nickname: " ", password: " ", isAlarmOn: false, signupDate: Date.now)
    
    final func NewPostUpload() {
//        let newPost: Post = Post(id: Date.now.formatted() , uploadDate: Date.now, audio: audio, image: image, uploader: uploader)
//        uploader.posts.append(newPost)
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiimage = UIImage(data: data) {
                    selectedImage = uiimage
                    return
                }
            }
        }
    }
    
}
