import Foundation
import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    let videosTable = UITableView(frame: .zero, style: .plain)
    
    struct Video {
        init(url: URL, name: String) {
            self.url = url
            self.name = name
        }
        let url: URL
        let name: String
    }
    
    var arrayOfVideos: [Video] = [
        Video(url: URL(string: "https://youtu.be/p2vOKrHzqcg")!, name: "iPhone 13"),
        Video(url: URL(string: "hhttps://youtu.be/SUyD2QXfGUg")!, name: "M1 Macs LTT"),
        Video(url: URL(string: "https://youtu.be/Uk1mDu3Ugn4")!, name: "M1 Macs MA"),
        Video(url: URL(string: "https://youtu.be/kDuU-5210gk")!, name: "Tech news 27.11"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videosTable.dataSource = self
        videosTable.delegate = self
        videosTable.translatesAutoresizingMaskIntoConstraints = false
        [videosTable].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            videosTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videosTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            videosTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            videosTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension VideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = arrayOfVideos[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfVideos.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Видео"
    }
}

extension VideoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = AVPlayer(url: arrayOfVideos[indexPath.row].url)
        let controller = AVPlayerViewController()
        controller.player = player
        print(controller)
        present(controller, animated: true) {
            player.play()
        }
    }
}
