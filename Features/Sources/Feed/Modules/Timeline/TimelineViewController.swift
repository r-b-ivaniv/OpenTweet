//
//  TimelineViewController.swift
//
//
//  Created by Roman Ivaniv on 2024-01-26.
//

import UIKit
import Combine
import CoreModule
import InterfaceComponents

final class TimelineViewController: UICollectionViewController, ViewController {
    private var lastSelectedIndexPath: IndexPath?

    var lastSelectedCell: UICollectionViewCell? {
        guard let lastSelectedIndexPath,
              let cell = collectionView.cellForItem(at: lastSelectedIndexPath)
        else {
            return nil
        }

        return cell
    }
    
    internal var viewModel: TimelineViewModel

    private var cancellables = Set<AnyCancellable>()
    private let cellTemplate = TweetCell()
    
    private lazy var dataSource: DataSource = {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(withType: TweetCell.self, for: indexPath)
            cell.configure(tweet: model)
            return cell
        }
    }()
    
    // MARK: - Init
    
    init(viewModel: TimelineViewModel) {
        self.viewModel = viewModel
            
        super.init(
            collectionViewLayout: UICollectionViewFlowLayout {
                $0.scrollDirection = .vertical
                $0.minimumLineSpacing = Constants.lineSpacing

            }
        )
        collectionView.alwaysBounceVertical = true
        
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setup()
        
        // TODO: localization, no time :(
        title = "Timeline"
        collectionView.register(TweetCell.self)
    }
    
    // MARK: - Private
    
    private func addObservers() {
        // TODO: add animation for state change. No time :(
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    // TODO: localization. no time :(
                    self?.collectionView.setMessage("Loading...")
                case .loaded(let timeline):
                    self?.collectionView.clearMessage()
                    self?.applySnapshot(for: timeline)
                case .error(let error):
                    self?.collectionView.setMessage(error)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Private
        
    private func applySnapshot(for timeline: [TweetModel]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.timeline])
        snapshot.appendItems(timeline, toSection: .timeline)
        
        dataSource.apply(snapshot)
    }
}

extension TimelineViewController {
    // MARK: - DiffableDataSource
    enum Section {
        case timeline
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TweetModel>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, TweetModel>
}

extension TimelineViewController {
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TweetCell else {
            return
        }
        cell.onSelectionDone = { [weak self] in guard let self else { return }
            let tweet = dataSource.snapshot().itemIdentifiers[indexPath.item]
            viewModel.didSelect(tweet: tweet)
        }
    }
}

extension TimelineViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let tweet = dataSource.itemIdentifier(for: indexPath) else {
            return .zero
        }
        cellTemplate.configure(tweet: tweet)
        return cellTemplate.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
}

private extension TimelineViewController {
    // MARK: - Constants
    enum Constants {
        static let lineSpacing: CGFloat = 8
    }
}
