import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    var player = Player()

    private lazy var songName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "stop"), for: .normal)
        button.addTarget(self, action: #selector(stop), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.right.2"), for: .normal)
        button.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var prevButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.left.2"), for: .normal)
        button.addTarget(self, action: #selector(prevSong), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func play() {
        player.play()
        songName.text = player.songs[player.currentSong].lastPathComponent
    }
    
    @objc func pause() {
        player.pause()
    }
    
    @objc func stop() {
            player.stop()
    }
    
    @objc func nextSong() {
        player.next()
        songName.text = player.songs[player.currentSong].lastPathComponent
    }
    
    @objc func prevSong() {
        player.prev()
        songName.text = player.songs[player.currentSong].lastPathComponent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        songName.text = player.songs[player.currentSong].lastPathComponent
        
        [songName,pauseButton,playButton,stopButton,nextButton,prevButton].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            songName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            songName.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 20),
            playButton.heightAnchor.constraint(equalToConstant: 20),
            stopButton.widthAnchor.constraint(equalToConstant: 20),
            stopButton.heightAnchor.constraint(equalToConstant: 20),
            pauseButton.widthAnchor.constraint(equalToConstant: 20),
            pauseButton.heightAnchor.constraint(equalToConstant: 20),
            playButton.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 50),
            stopButton.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 50),
            pauseButton.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 50),
            
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            stopButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            nextButton.centerXAnchor.constraint(equalTo: stopButton.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 16),
            
            prevButton.centerXAnchor.constraint(equalTo: pauseButton.centerXAnchor),
            prevButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 16)
        ])
        
        
        
    }
}

class Player {
    var player = AVAudioPlayer()
    
    var currentSong: Int = 0
    let songs: [URL] = [
        URL.init(fileURLWithPath: Bundle.main.path(forResource: "Queen", ofType: "mp3")!),
        URL.init(fileURLWithPath: Bundle.main.path(forResource: "Arctic Monkeys", ofType: "mp3")!),
        URL.init(fileURLWithPath: Bundle.main.path(forResource: "Linkin Park", ofType: "mp3")!),
        URL.init(fileURLWithPath: Bundle.main.path(forResource: "Our Last Night", ofType: "mp3")!),
        URL.init(fileURLWithPath: Bundle.main.path(forResource: "Panic! At The Disco", ofType: "mp3")!)
    ]
    
    init(){
        setup()
    }
    
    func play(){
        if (!player.isPlaying){
            player.play()
        }
    }
    
    func pause(){
        if (player.isPlaying) {
            player.stop()
        }
    }
    
    func stop(){
        if (player.isPlaying) {
            player.stop()
            player.currentTime = 0
        }
    }
    
    func next(){
        currentSong += 1
        let wasPlaying = player.isPlaying
        if (currentSong == songs.count) {
            currentSong = 0
        }
        do {player = try AVAudioPlayer.init(contentsOf: self.songs[currentSong])
        } catch {print(error)}
        if (wasPlaying) {
            player.play()
        }
    }
    
    func prev(){
        currentSong -= 1
        let wasPlaying = player.isPlaying
        if (currentSong == -1) {
            currentSong = songs.count - 1
        }
        do {player = try AVAudioPlayer.init(contentsOf: self.songs[currentSong])
        } catch {print(error)}
        if (wasPlaying) {
            player.play()
        }
    }
    
    func setup(){
        do {player = try AVAudioPlayer.init(contentsOf: self.songs[currentSong])
        } catch {print(error)}
    }
}

