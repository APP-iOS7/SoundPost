import FirebaseStorage
import UIKit
import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    // 최상위 참조
    private let storageRef = Storage.storage().reference()
    
    // 이미지 폴더 참조
    private let imageRef: StorageReference
    
    // 오디오 폴더 참조
    private let audioRef: StorageReference
    
    init() {
        self.imageRef = storageRef.child("image")
        self.audioRef = storageRef.child("audio")
    }
    
    
    func uploadAudio(audioURL: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let fileExtension = audioURL.pathExtension.lowercased()
        let validExtensions = ["mp3", "wav", "m4a", "aac"] // ✅ 지원하는 오디오 확장자
        
        // 🔹 지원하는 파일 형식인지 확인
        guard validExtensions.contains(fileExtension) else {
            completion(.failure(NSError(domain: "InvalidAudioFormat", code: -2, userInfo: [NSLocalizedDescriptionKey: "지원하지 않는 오디오 형식입니다."])))
            return
        }
        
        let audioRef = self.audioRef.child("\(UUID().uuidString).\(fileExtension)") // ✅ 오디오 파일 저장 경로 지정
        
        // 🔹 Firebase Storage에 오디오 파일 업로드
        audioRef.putFile(from: audioURL, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 🔹 업로드 후 다운로드 URL 반환
            audioRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    print("✅ 오디오 업로드 성공! 다운로드 URL: \(url.absoluteString)")
                    completion(.success(url.absoluteString))
                }
            }
        }
    }
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print ("imageData is nil")
            completion(.failure(NSError(domain: "ImageConversion", code: -1, userInfo: nil)))
            return
        }
        let imageRef = self.imageRef.child("\(UUID()).jpeg")
        
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL() {url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                } else if let url = url{
                    print("✅ 업로드 성공! 다운로드 URL: \(url.absoluteString)")
                    completion(.success(url.absoluteString))
                }
            }
        }
    }
}
