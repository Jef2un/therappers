import UIKit



class MusicTableViewCell: UITableViewCell {
    static let identifier = "MusicTableViewCell"
    
    let musicImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        // 超出 musicImageView 边界的内容将被裁剪掉
        return imageView
    }()
    
    let musicSongName: UILabel = {
        var title = UILabel()
        title.numberOfLines = 0
        // 文本行数设置为 0 将根据內容自动换行，以适应其内容的长度
        title.adjustsFontSizeToFitWidth = true
        // 自动调整字体大小属性，文本内容超出了可用空间的宽度，文本的字体大小将自动缩小以适应可用空间
        return title
    }()
    
    let musicArtist: UILabel = {
        var title = UILabel()
        title.numberOfLines = 0
        // 文本行数设置为 0 将根据內容自动换行，以适应其内容的长度
        title.adjustsFontSizeToFitWidth = true
        // 自动调整字体大小属性，文本内容超出了可用空间的宽度，文本的字体大小将自动缩小以适应可用空间
        return title
    }()
    
//    let functionBtn: UIButton = {
//        var button = UIButton()
//        button.setImage(UIImage(named: "more"), for: .normal)
//        return button
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(musicImageView)
        addSubview(musicSongName)
        addSubview(musicArtist)
//        addSubview(functionBtn)
    
        configureFonts()
        setImageConstrain()
        setLableConstrain()
//        setBtnConstrain()
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    func configureFonts() {
        // 設置字体样式
        musicSongName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        musicArtist.font = UIFont.systemFont(ofSize: 14)
        musicArtist.textColor = UIColor.gray
    }
    
    func set(music: Music){
        musicImageView.image = UIImage(named: "therappers")
        musicSongName.text = music.songName
        musicArtist.text = music.artist
    }
    
//    func setBtnConstrain(){
//        functionBtn.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            functionBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            functionBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
//            functionBtn.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/3),
//            functionBtn.widthAnchor.constraint(equalTo: functionBtn.heightAnchor)
//        ])
        
//        functionBtn.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

//    }
    
    func setImageConstrain(){
        musicImageView.translatesAutoresizingMaskIntoConstraints = false
        // 向左對齊且y軸要一起置中對齊
        NSLayoutConstraint.activate([
            musicImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            musicImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            musicImageView.heightAnchor.constraint(equalToConstant: 70),
            musicImageView.widthAnchor.constraint(equalTo: musicImageView.heightAnchor)
        ])
    }
    
    func setLableConstrain(){
        musicSongName.translatesAutoresizingMaskIntoConstraints = false
        musicArtist.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicSongName.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -10),
            musicSongName.leadingAnchor.constraint(equalTo: musicImageView.trailingAnchor, constant: 20),
            musicSongName.heightAnchor.constraint(equalToConstant: 40),
            musicSongName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        
            musicArtist.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 10),
            musicArtist.leadingAnchor.constraint(equalTo: musicImageView.trailingAnchor, constant: 20),
            musicArtist.heightAnchor.constraint(equalToConstant: 40),
            musicArtist.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)

        ])


    }

}
