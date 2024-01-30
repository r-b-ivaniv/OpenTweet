//
//  ThreadViewController.swift
//
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import UIKit
import CoreModule

final class ThreadViewController: UICollectionViewController, ViewController {
    internal var viewModel: ThreadViewModel
    private let cellTemplate = TweetCell()
    
    private lazy var dataSource: DataSource = {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(withType: TweetCell.self, for: indexPath)
            cell.configure(tweet: model)
            return cell
        }.configured {
            $0.supplementaryViewProvider = supplementaryViewProvider
        }
    }()
    
    // MARK: - Init
    
    init(viewModel: ThreadViewModel) {
        self.viewModel = viewModel
            
        super.init(
            collectionViewLayout: UICollectionViewFlowLayout {
                $0.scrollDirection = .vertical
                $0.minimumLineSpacing = Constants.lineSpacing
            }
        )
        
        collectionView.alwaysBounceVertical = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Thread"
        
        collectionView.register(TweetCell.self)
        collectionView.registerSupplementaryView(SectionHeaderView.self, king: UICollectionView.elementKindSectionHeader)
        
        applySnapshot(for: viewModel.tweet)
    }
    
    // MARK: - Private
        
    private func applySnapshot(for tweet: TweetModel) {
        // TODO: move snapshot logic to ViewModel + add unit tests, no time :(

        var snapshot = Snapshot()
        
        snapshot.appendSections([.single])
        snapshot.appendItems([tweet], toSection: .single)
        
        if let replyToTweet = tweet.tweetReplyTo {
            snapshot.appendSections([.replyTo])
            snapshot.appendItems([replyToTweet], toSection: .replyTo)
        } else if let replies = tweet.replies, !replies.isEmpty {
            snapshot.appendSections([.replies])
            snapshot.appendItems(replies, toSection: .replies)
        }
        
        dataSource.apply(snapshot)
    }
    
    private func supplementaryViewProvider(
        _ collectionView: UICollectionView,
        _ kind: String,
        _ indexPath: IndexPath
    ) -> UICollectionReusableView? {
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        switch section {
        case .replyTo, .replies:
            return collectionView.dequeueReusableSupplementaryView(
                withType: SectionHeaderView.self,
                king: kind,
                for: indexPath
            ).configured {
                $0.configure(header: section.header)
            }
        default:
            return nil
        }
    }
}

extension ThreadViewController {
    // MARK: - DiffableDataSource
    enum Section {
        case single
        case replyTo
        case replies
        
        var header: String? {
            switch self {
            case .replyTo:
                return "In reply to:"
            case .replies:
                return "Replies:"
            default:
                return nil
            }
        }
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TweetModel>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, TweetModel>
}

extension ThreadViewController {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = dataSource.snapshot().sectionIdentifiers[section]
        switch section { 
        case .replyTo, .replies:
            return CGSize(width: collectionView.frame.size.width, height: Constants.sectionHeaderSize)
        default:
            return .zero
        }
    }
}

extension ThreadViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let tweet = dataSource.itemIdentifier(for: indexPath) else {
            return .zero
        }
        cellTemplate.configure(tweet: tweet)
        return cellTemplate.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
}

private extension ThreadViewController {
    // MARK: - Constants
    enum Constants {
        static let lineSpacing: CGFloat = 12
        static let sectionHeaderSize: CGFloat = 36
    }
}
