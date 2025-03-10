import SwiftUI
import PhotosUI

class QuickStartButtonViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published private var audio: Data = Data()
    @Published var imageSelection: PhotosPickerItem? = nil
    @Published var audioRecoder: AudioRecorder = AudioRecorder()
    var audioDownloadURL: String = ""
    var imageDownloadURL: String? = nil
    //유저 정보를 받아와야함
    var uploader: User?
    
    init(uploader: User?) {
        self.uploader = uploader
        print("YESS! \(String(describing: uploader?.nickname))")
    }
    
    final func NewPostUpload() async {
        let postId = UUID().uuidString
        let postUrl = await getUrl()

        // ✅ 업로드가 완료된 후 데이터 저장
        self.uploader?.posts.append(postId)
        let newPost = Post(id: postId, audioURL: postUrl.0, imageURL: postUrl.1, uploaderID: self.uploader!.id!, uploaderName: self.uploader!.nickname)

        print("오디오 URL: \(postUrl.0)")
        print("이미지 URL: \(postUrl.1 ?? "없음")")
        print("postId: \(postId)")

        FirebaseManager.shared.saveData(targetData: newPost)
    }
    func getUrl() async -> (String, String?) {
        do {
            // ✅ 오디오 업로드를 비동기적으로 실행하고 결과를 기다림
            let audioDownloadURL = try await StorageManager.shared.uploadAudioAsync(audioURL: audioRecoder.audioFilename!)

            var imageDownloadURL: String? = nil
            if let postImage = self.selectedImage {
                // ✅ 이미지 업로드도 비동기적으로 실행하고 결과를 기다림
                imageDownloadURL = try await StorageManager.shared.uploadImageAsync(image: postImage)
            }

            return (audioDownloadURL, imageDownloadURL)
        } catch {
            print("❌ 업로드 실패: \(error.localizedDescription)")
            return ("", nil) // 업로드 실패 시 기본값 반환
        }
    }
    
    //이미지 피커에 이미지 로드
    final func setImage (from selection: PhotosPickerItem?) {
        guard let selection else { return }
        selection.loadTransferable(type: Data.self) { result in
            switch result {
                //이미지 선택 성공 시
            case .success(let data) :
                if let data = data, let newImage = UIImage(data: data) {
                    if self.selectedImage?.pngData() != newImage.pngData() {
                        DispatchQueue.main.async {
                            self.selectedImage = newImage
                        }
                    }
                }
                // 이미지 선택 실패 시
            case .failure(let error):
                print(error)
            }
        }
    }
    final func startRecoring() {
        audioRecoder.startRecording()
    }
    final func stopRecoring() {
        audioRecoder.stopRecording()
    }
    final func restartRecording() {
        audioRecoder.deleteRecord()
        audioRecoder.startRecording()
    }
    final func playRecoed() {
        audioRecoder.playRecord()
    }
    func timeStamp() -> String {
        return audioRecoder.timer
    }
    
}
