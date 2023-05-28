
import Foundation
import UIKit

class SongViewController: UIViewController {
    
    var musics:[Music] = []
    var albums:[CollectionTableViewCellViewModle] = []
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicTableViewCell")
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "CollectionTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "歌曲"
        
        view.addSubview(tableView)
        
        setDelegate()
        musics = fetchMusicData()
        albums = fetchAlbumData()
    }
    
    //MARK: - Constrain TableView
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func setDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SongViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            tabBarVC.playSong = musics[indexPath.row-1]
        }
        SharedState.instance.isMusicPlaying = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = musics.count + 1
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let viewModle = albums[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.reuseidentifier, for: indexPath) as? CollectionTableViewCell
            else{
                fatalError()
            }
            cell.delegate = self
            cell.config(with: viewModle)
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell",for: indexPath) as! MusicTableViewCell
            let music = musics[indexPath.row - 1]
            cell.set(music: music)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return view.frame.size.width/2
        }else{
            return view.frame.size.width/5
        }
    }
}

// MARK: - Dummy Data
extension SongViewController{
    func fetchMusicData() -> [Music]{
        let song1 = Music(songName: "Lovemyself",artist: "GummyB", album: "Be The Champ")
        let song2 = Music(songName: "掃把星",artist: "阿夫", album: "Be The Champ")
        let song3 = Music(songName: "敦化南路",artist: "GummyB", album: "Block To Block")
        let song4 = Music(songName: "風光少年兄",artist: "阿跨面", album: "Block To Block")
        let song5 = Music(songName: "石橋",artist: "GummyB", album: "Semi Final")
        let song6 = Music(songName: "陷眠",artist: "阿跨面", album: "Semi Final")
        let song7 = Music(songName: "安泰swaq",artist: "小卡比", album: "Diss Back")
        let song8 = Music(songName: "嗆到無麻吉",artist: "比杰", album: "Diss Back")
        let song9 = Music(songName: "卯死",artist: "阿法", album: "Theme Game")
        let song10 = Music(songName: "Luv me hate me",artist: "E1and", album: "Theme Game")
        let song11 = Music(songName: "二選一",artist: "REX & Quanzo", album: "Roll Call")
        let song12 = Music(songName: "無名英雄",artist: "馬克 & 阿跨面", album: "Roll Call")
        return [song1,song2,song3,song4,song5,song6,song7,song8,song9,song10,song11,song12]
    }
    
    func fetchAlbumData() -> [CollectionTableViewCellViewModle]{
        let viewModles: [CollectionTableViewCellViewModle] = [
            CollectionTableViewCellViewModle(
                viewModles: [
                    TileCollectionViewCellViewModel(name: "Be The Champ", image: UIImage(named: "be the champ")),
                    TileCollectionViewCellViewModel(name: "Semi Final", image: UIImage(named: "semi finals")),
                    TileCollectionViewCellViewModel(name: "Diss Back", image: UIImage(named: "diss back")),
                    TileCollectionViewCellViewModel(name: "Roll Call", image: UIImage(named: "roll call")),
                    TileCollectionViewCellViewModel(name: "Theme Game", image: UIImage(named: "theme game")),
                    TileCollectionViewCellViewModel(name: "Block To Block", image: UIImage(named: "block to block"))
                ]
            )
        ]
        return viewModles
    }
}

//MARK: - Press Carousel
extension SongViewController:CollectionTableViewCellDelegate{
    func collectionTableViewCellDidTapItem(with viewModel: TileCollectionViewCellViewModel) {
        let ADVC = AlbumDetailViewController()
        ADVC.viewModel = viewModel
        for i in musics{
            if i.album == viewModel.name{
                ADVC.songList.append(i)
            }
        }
        self.navigationController?.pushViewController(ADVC, animated: true)
    }
}



