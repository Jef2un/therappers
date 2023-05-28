//
//  LoggedInViewController.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/25.
//

import UIKit

class LoggedInViewController: UIViewController {
    
    
    var weatherManager = WeatherManager()
    
    var cells:[Cells] = []
    
    var weather:WeatherModel?
    
    private let weatherImage = UIImageView()
    
    private let temp:UILabel = {
        var text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.textColor = .black
        text.numberOfLines = 0
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    private let tableView: UITableView = {
        var table = UITableView()
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()

    
    private let titleText: UILabel = {
        var title = UILabel()
        title.text = "我的"
        title.font = .boldSystemFont(ofSize: 34)
        return title
    }()
    
    private let settingBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "gearshape.circle.fill"), for: .normal)
        return btn
    }()
    
    private let subTitleText: UILabel = {
        var title = UILabel()
        title.text = "音樂庫"
        title.font = .boldSystemFont(ofSize: 24)
        return title
    }()
    
    private let musicLibBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("+ 新建歌單", for: .normal)
        btn.setTitleColor(.systemPink, for: .normal) // Set the title color to white

        return btn
    }()
    
    private let songList:UIView = {
        var view = UIView()
        var label = UILabel()
        var image = UIImageView()
        label.text = "我的歌單"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        image.image = UIImage(named: "therappers")
        image.layer.cornerRadius = 10
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 10
        view.addSubview(label)
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 4/5),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor,constant: 5)
        ])

        return view
    }()
    
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubView()
        self.navigationController?.hidesBarsOnTap = true
            
        
        setDelegate()
        titleConstraint()
        subTitleConstraint()
        songListConstraint()
        weatherConstraint()
        
        cells = fetchData()
        
        weatherManager.performRequest { [weak self] weather in
            DispatchQueue.main.async {
                self?.weather = weather
                
                self?.weatherImage.image = UIImage(systemName: self?.weather?.conditionName ?? "cloud")
                self?.temp.text = self?.weather?.tempString
            }
        }

        
    }
    
    private func addSubView(){
        view.addSubview(tableView)
        view.addSubview(titleText)
        view.addSubview(settingBtn)
        view.addSubview(subTitleText)
        view.addSubview(musicLibBtn)
        view.addSubview(songList)
        view.addSubview(weatherImage)
        view.addSubview(temp)
    }
    
    @objc func test(){
        print("It work")
    }
    
    func setDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }

    func titleConstraint(){
        titleText.translatesAutoresizingMaskIntoConstraints = false
        settingBtn.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            settingBtn.centerYAnchor.constraint(equalTo: titleText.centerYAnchor),
            settingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12),
            tableView.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
    }
    
    func weatherConstraint(){
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        temp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImage.centerYAnchor.constraint(equalTo: titleText.centerYAnchor),
            temp.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor),
            weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temp.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor)
        
        ])
    }
    
    func subTitleConstraint(){
        subTitleText.translatesAutoresizingMaskIntoConstraints = false
        musicLibBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleText.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            subTitleText.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
            musicLibBtn.centerYAnchor.constraint(equalTo: subTitleText.centerYAnchor),
            musicLibBtn.trailingAnchor.constraint(equalTo: settingBtn.trailingAnchor)
        
        ])
    }
    
    func songListConstraint(){
        songList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songList.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            songList.leadingAnchor.constraint(equalTo: subTitleText.leadingAnchor),
            songList.trailingAnchor.constraint(equalTo: settingBtn.trailingAnchor),
            songList.topAnchor.constraint(equalTo: subTitleText.bottomAnchor,constant: 10)
        
        
        ])
    }
    
}


extension LoggedInViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier,for: indexPath) as! ProfileTableViewCell
        let cellBtn = cells[indexPath.row]
        cell.set(cell: cellBtn)
        return cell
    }
}

extension LoggedInViewController{
    private func fetchData() -> [Cells]{
        let cellBtn1 = Cells(image: UIImage(systemName: "person.and.background.dotted")!, label: "想去的活動")
        let cellBtn2 = Cells(image: UIImage(systemName: "clock.badge")!, label: "播放紀錄")
        let cellBtn3 = Cells(image: UIImage(systemName: "music.mic")!, label: "追蹤中的音樂人")
        return [cellBtn1,cellBtn2,cellBtn3]
    }
}


