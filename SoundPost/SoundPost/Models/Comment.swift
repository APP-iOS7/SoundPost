import Foundation

struct Comment {
    let uploadDate: Date
    let audio: Data
    let uploader: String
    let targetPost: Post
    let id: String
}
