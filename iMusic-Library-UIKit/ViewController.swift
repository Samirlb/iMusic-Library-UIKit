import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentSongImage: UIImageView!
    @IBOutlet weak var currentSongArtist: UILabel!
    @IBOutlet weak var currentSongTitle: UILabel!
    @IBOutlet weak var currentActionButton: UIButton!
    
    private let tableDelegate = LibraryTableDelegate()
    private lazy var albums: Albums = Albums()
    private var currentAlbum: Album = Album()
    private var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableDelegates()
        self.registerCells()
        self.loadCovers()
    }
    
    private func setUpTableDelegates() {
        self.tableView.dataSource = self.tableDelegate
        self.tableView.delegate = self.tableDelegate
        self.tableDelegate.setUpController(self)
    }
    
    private func registerCells() {
        let cover = UINib(nibName: "CoverViewCell", bundle: nil)
        let coverInfo = UINib(nibName: "DetailsTableCell", bundle: nil)
        self.tableView.register(cover, forCellReuseIdentifier: "CoverViewCell")
        self.tableView.register(coverInfo, forCellReuseIdentifier: "DetailsTableCell")
    }
    
    private func loadCovers() {
        self.tableDelegate.setUpAlbums(self.albums)
    }
    
    func getCurrentAlbum() -> Album {
        return self.currentAlbum
    }
    
    func setCurrentAlbum(album: Album) {
        self.currentAlbum = album
        self.tableView.reloadData()
    }
    
    func setCurrentSong() {
        let currentAlbum = self.getCurrentAlbum()
        self.currentSongImage.image = UIImage(named: currentAlbum.imageName)
        self.currentSongArtist.text = currentAlbum.artist
        self.currentSongTitle.text = currentAlbum.name
        self.setCurrentActionButtonImage(pause: false)
        self.initializePlayer()
    }
    
    func setCurrentActionButtonImage(pause: Bool) {
        let pauseImage = UIImage(named: "pause")
        let playImage = UIImage(named: "play")
        self.currentActionButton.setImage(pause ? pauseImage : playImage, for: .normal)
    }
    
    @IBAction func currentActionButton(_ sender: UIButton) {
        guard let player = self.player else {
            self.initializePlayer()
            return
        }
        self.togglePlayer(player: player)
    }
    
    private func initializePlayer() {
        let currentAlbum = self.getCurrentAlbum()
        if currentAlbum.name.isEmpty {
            return
        }
        
        let soundFileURL = self.getCurrentSong(album: currentAlbum)
        do {
            self.setCurrentActionButtonImage(pause: player?.isPlaying ?? false)
            self.player?.stop()
            self.player = try AVAudioPlayer(contentsOf: soundFileURL)
            self.player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getCurrentSong(album: Album) -> URL {
        let song = album.song.rawValue
        guard let soundFileURL = Bundle.main.url(forResource: song, withExtension: "flac") else {
            return URL(fileURLWithPath: "")
        }
        return soundFileURL
    }
    
    private func togglePlayer(player: AVAudioPlayer) {
        self.setCurrentActionButtonImage(pause: player.isPlaying)
        if player.isPlaying {
            player.pause()
            return
        }
        player.play()
    }
}

