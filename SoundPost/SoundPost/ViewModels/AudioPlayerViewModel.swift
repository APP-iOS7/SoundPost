import Foundation
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    private var player: AVPlayer?
    private var timeObserver: Any?
    
    @Published var isPlaying = false
    @Published var isLoading = true
    @Published var loadError = false
    @Published var currentTime = 0.0
    @Published var duration = 0.0
    
    init(url: URL) {
        setupPlayer(with: url)
    }
    
    deinit {
        removeTimeObserver()
    }
    
    private func setupPlayer(with url: URL) {
        isLoading = true
        loadError = false
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        // 로딩 상태 관찰
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        // 아이템 로드 완료 상태 관찰
        let statusObserver = playerItem.observe(\.status) { [weak self] item, _ in
            DispatchQueue.main.async {
                switch item.status {
                case .readyToPlay:
                    self?.isLoading = false
                    self?.duration = item.duration.seconds
                    self?.setupTimeObserver()
                case .failed:
                    self?.isLoading = false
                    self?.loadError = true
                default:
                    break
                }
            }
        }
        
        // 메모리 관리를 위해 관찰자 저장
        objc_setAssociatedObject(self, "statusObserver", statusObserver, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func playerItemDidReachEnd() {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
            self?.currentTime = 0
            self?.player?.seek(to: .zero)
        }
    }
    
    private func setupTimeObserver() {
        // 0.1초마다 현재 재생 시간 업데이트
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }
    }
    
    private func removeTimeObserver() {
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
            self.timeObserver = nil
        }
    }
    
    func playOrPause() {
        if isPlaying {
            player?.pause()
        } else {
            if currentTime >= duration {
                player?.seek(to: .zero)
            }
            player?.play()
        }
        isPlaying.toggle()
    }
    
    func seek(to time: Double) {
        let targetTime = CMTime(seconds: time, preferredTimescale: 600)
        player?.seek(to: targetTime) { [weak self] completed in
            if completed {
                self?.currentTime = time
            }
        }
    }
}
