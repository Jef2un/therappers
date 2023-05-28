//
//  TabBarViewController.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/22.
//

import UIKit
import AVFoundation


class SharedState {
    static let instance = SharedState()

    var isMusicPlaying: Bool = false {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("musicPlayingChanged"), object: nil)
        }
    }
    
    private init() { }
}

class TabBarViewController: UITabBarController {
    var audioPlayer: AVAudioPlayer?
    var playSong: Music?
    var playOrNot: Bool = false

    let songVC = SongViewController()
//    let profileVC = ProfileViewController()
    let activitiesVC = ActivitiesViewController()
    let profileVC = LoggedInViewController()
    
    let songImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "therappers")
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    
    let musicController: UIView = {
        var controller = UIView()
        controller.backgroundColor = .lightGray
        return controller
    }()
    
    let playBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        btn.tintColor = .systemPink
        return btn
    }()
    
    let songName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [songName,artistName])
        sv.axis = .vertical
        sv.spacing = 5
        return sv
    }()
    
    func set(){
        songName.text = playSong?.songName
        artistName.text = playSong?.artist
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(musicController)
        controllerAddSubview()
        controllerConstraint()
        
        
        addItem()
        playBtn.addTarget(self, action: #selector(playMusicBtn), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMusicPlayingChanged), name: NSNotification.Name("musicPlayingChanged"), object: nil)

    }
    
    @objc func handleMusicPlayingChanged() {
        musicController.isHidden = false
        set()
        playSound(music: playSong?.songName ?? "wow")
    }
    
    @objc func playMusicBtn(){
        if playOrNot{
            audioPlayer?.pause()
            playOrNot = false
        }else{
            audioPlayer?.play()
            playOrNot = true
        }
    }
    
    func controllerAddSubview(){
        musicController.addSubview(songImage)
        musicController.addSubview(playBtn)
        musicController.addSubview(labelStackView)
        controllerWidgetConstraint()
        musicController.isHidden = true
    }
    
    func controllerWidgetConstraint(){
        songImage.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songImage.centerYAnchor.constraint(equalTo: musicController.centerYAnchor),
            playBtn.centerYAnchor.constraint(equalTo: musicController.centerYAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: musicController.centerYAnchor),
            songImage.leadingAnchor.constraint(equalTo: musicController.leadingAnchor,constant: 10),
            playBtn.trailingAnchor.constraint(equalTo: musicController.trailingAnchor,constant: -10),
            labelStackView.leadingAnchor.constraint(equalTo: songImage.trailingAnchor,constant: 10),
            songImage.heightAnchor.constraint(equalTo: musicController.heightAnchor, multiplier: 0.8),
            songImage.widthAnchor.constraint(equalTo: songImage.heightAnchor, multiplier: 1)
        ])
    }
    
    func controllerConstraint(){
        musicController.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicController.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            musicController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            musicController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            musicController.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5)
        
        ])
    }

    func addItem(){
        tabBar.tintColor = .systemPink

        let songNavVC = UINavigationController(rootViewController: songVC)
        songVC.tabBarItem = UITabBarItem(title: "歌曲", image: UIImage(systemName: "flame.fill"), tag: 0)
        
//        let profileNavVC = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem = UITabBarItem(title: "我的", image: UIImage(systemName: "person.fill"), tag: 1)

        let activitiesNavVC = UINavigationController(rootViewController: activitiesVC)
        activitiesVC.tabBarItem = UITabBarItem(title: "活動", image: UIImage(systemName: "music.mic.circle.fill"), tag: 2)
        
        viewControllers = [songNavVC, activitiesNavVC, profileVC]
    }
}

//MARK: - Play Music Button
extension TabBarViewController{
    
    func playSound(music:String) {
        if let path = Bundle.main.path(forResource: "music/\(music)", ofType:"mp3") {
            let url = URL(fileURLWithPath: path)

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
                playOrNot = true
            } catch {
                // 音樂播放失敗
                print("音樂播放失敗")
            }
        } else {
            // 沒有找到音樂檔案
            print("沒有找到音樂檔案")
            print(music)
        }
    }
}
