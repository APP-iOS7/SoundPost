import AVFoundation

class AudioRecorder: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioRecorder: AVAudioRecorder!
    //    @Published var isRecording = false
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var timer : String = "00:00"
    @Published var time: Double = 0
    
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var isPaused = false
    var audioFilename : URL?
    //녹음 설정 초기화
    override init() {
        super.init()
        let session = AVAudioSession.sharedInstance()
        do {
            //오디오 세션의 카테고리를 녹음과 재생으로 설정 , 오디오 세션을 활성화
            try session.setCategory(.playAndRecord, options: [.allowAirPlay,.allowBluetooth,.defaultToSpeaker])
            try session.setActive(true)
            //마이크 사용 권한 요청
            AVAudioApplication.requestRecordPermission { allowed in
                if !allowed {
                    print("Recording not allowed by the user" as! Error)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func isRecording() -> Bool {
        return audioRecorder.isRecording
    }
    func startRecording() {
        //녹음 설정
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        //녹음 파일 경로 설정
        let fileURL = getDocumentsDirectory().appendingPathComponent("SoundPost_\(UUID().uuidString).m4a")
        do {
            countSec = 0
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder.record(forDuration: 90)
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                self.timer = String(format: "%02d:%02d", self.countSec / 60, self.countSec % 60)
                if self.countSec >= 90 {
                    self.stopRecording()
                    self.countSec = 0// ✅ 90초 후 자동 종료
                }  else {
                    self.countSec += 1
                }
                
            })
        } catch {
            print("Failed to setup recorder: \(error.localizedDescription)")
        }
        self.audioFilename = fileURL
    }
    func stopRecording() {
        audioRecorder.stop()
        countSec = 0
        self.time = audioRecorder.currentTime
        try? AVAudioSession.sharedInstance().setActive(false)
    }
    func deleteRecord() {
        audioRecorder.deleteRecording()
    }
    func playRecord() {
        if let audioFilename = audioFilename {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                audioPlayer?.delegate = self
                audioPlayer?.play()
            } catch {
                print("Failed to play record: \(error.localizedDescription)")
            }
        }
    }
    func stopRecord() {
        audioPlayer?.play()
    }
}

