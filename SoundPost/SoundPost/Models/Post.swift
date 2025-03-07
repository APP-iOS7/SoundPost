import SwiftUICore

struct Post {
    let id: String
    let uploadDate: Date
    let audio: Data
    var comments: [Comment] = []
    let image: Image?
    let uploader: User
    var likes: [User] = []
}
