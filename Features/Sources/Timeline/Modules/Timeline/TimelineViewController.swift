//
//  TimelineViewController.swift
//
//
//  Created by Roman Ivaniv on 2024-01-26.
//

import UIKit
import Combine
import PinLayout

final class TimelineViewController: UICollectionViewController {

    private var viewModel: TimelineViewModel
    private var cancellables = Set<AnyCancellable>()
    private let cellTemplate = TweetCell()
    
    init(viewModel: TimelineViewModel) {
        self.viewModel = viewModel
            
        super.init(
            collectionViewLayout: UICollectionViewFlowLayout {
                $0.scrollDirection = .vertical
                $0.minimumLineSpacing = 18
                $0.minimumInteritemSpacing = 0
                $0.sectionInsetReference = .fromSafeArea
            }
        )
        
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addObservers() {
        viewModel.$dataSource
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Timeline"
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseIdentifier)
    }
    
}

extension TimelineViewController {
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.reuseIdentifier, for: indexPath) as! TweetCell
        cell.configure(tweet: viewModel.dataSource[indexPath.item])
        
        cell.backgroundColor = .orange
        
        return cell
    }
}

extension TimelineViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        // manually calculate height
//        return CGSize(width: collectionView.bounds.width - 20, height: 200)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.configure(tweet: viewModel.dataSource[indexPath.item])
        return cellTemplate.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
}

extension UIImageView {
    func download(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

//extension UIImageView {
//    func download(url: URL) async throws {
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response.mimeType, mimeType.hasPrefix("image"),
//                let image = UIImage(data: data)
//            else {
//                // Handle error or return, depending on your requirements
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        } catch {
//            // Handle the error appropriately
//            print("Error downloading image: \(error)")
//        }
//    }
//}
