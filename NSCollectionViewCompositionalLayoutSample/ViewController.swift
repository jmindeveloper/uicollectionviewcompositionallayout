//
//  ViewController.swift
//  NSCollectionViewCompositionalLayoutSample
//
//  Created by J_Min on 2022/04/23.
//

import UIKit

class ViewController: UICollectionViewController {
    
    let colors: [UIColor] = [.red, .blue, .orange, .brown, .cyan, .systemIndigo]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = layout()
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }


}

// MARK: - CollectionView Layout
extension ViewController {
    func creatCollectionViewLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.32), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func creatCustomCollectionViewLayout() -> NSCollectionLayoutSection {
        // 상단 왼쪽
        let leadingSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(100))
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingSize)
        leadingItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)

        // 상단 오른쪽
        let trailingSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingSize)
        trailingItem.contentInsets = .init(top: 5, leading: 0, bottom: 0, trailing: 5)

        // 상단 오른쪽그룹
        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitem: trailingItem, count: 3)

        // 상단그룹
        let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))

        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [leadingItem, trailingGroup])

        // 하단 스몰, 빅
        let bottomSmallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let bottomBigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7))

        let bottomSmallitem = NSCollectionLayoutItem(layoutSize: bottomSmallItemSize)
        bottomSmallitem.contentInsets = .init(top: 5, leading: 0, bottom: 5, trailing: 0)
        let bottomBigItem = NSCollectionLayoutItem(layoutSize: bottomBigItemSize)

        // 하단 그룹
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let bottomGroup = NSCollectionLayoutGroup.vertical(layoutSize: bottomGroupSize, subitems: [bottomSmallitem, bottomBigItem])
        bottomGroup.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)

        // 전체 그룹
        let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .estimated(400))
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: containerGroupSize, subitems: [topGroup, bottomGroup])

        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
    
    
    func createListCollectionViewLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch section {
            case 0:
                return self.creatCollectionViewLayout()
            case 1:
                return self.creatCustomCollectionViewLayout()
            case 2:
                return self.createListCollectionViewLayout()
            default:
                return nil
            }
        }
    }
}

// MARK: - CollectionView DataSource, Delegate
extension ViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 12
        case 1:
            return 12
        case 2:
            return 12
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.contentView.backgroundColor = colors.randomElement()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

class CollectionViewCell: UICollectionViewCell {
    
}

