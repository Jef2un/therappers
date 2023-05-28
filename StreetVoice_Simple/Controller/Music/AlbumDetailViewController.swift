import UIKit

class AlbumDetailViewController: UIViewController {
    
    var viewModel:TileCollectionViewCellViewModel?
    var songList: [Music] = []
    


    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel?.name
        setDelegate()
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        

        self.navigationItem.rightBarButtonItem = plusButton
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func setDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func plusButtonTapped() {
        let alertController = UIAlertController(title: "喜歡這張專輯嗎？", message: "確定要將\(viewModel?.name ?? "專輯")加入音樂庫嗎？", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK button was tapped. Adding album to music library...")

        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension AlbumDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            tabBarVC.playSong = songList[indexPath.row]
        }
        SharedState.instance.isMusicPlaying = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell",for: indexPath) as! MusicTableViewCell
        let music = songList[indexPath.row]
        cell.set(music: music)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width/5
    }
}
