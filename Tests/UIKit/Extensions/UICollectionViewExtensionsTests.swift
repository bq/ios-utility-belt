import XCTest
import UIKit
import MagicPills

private class HeaderCollectionReusableView: UICollectionReusableView {}

class UICollectionViewExtensionsTests: XCTestCase {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override func setUp() {
        super.setUp()

        collectionView.dataSource = self
        collectionView.reloadData()
    }

    func test_register_cell_with_class() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.register(UICollectionViewCell.self)
        let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(indexPath)
        XCTAssertNotNil(cell)
    }

    func test_register_cell_with_nib_using_class() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.registerWithNib(UICollectionViewCell.self, bundle: Bundle(for: UICollectionViewExtensionsTests.self))
        let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(indexPath)
        XCTAssertNotNil(cell)
    }

    func test_dequeue_reusable_supplementary_view() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.register(UICollectionViewCell.self)
        let _: UICollectionViewCell? = collectionView.dequeueReusableCell(indexPath)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withClass: HeaderCollectionReusableView.self)
        let headerVIew: HeaderCollectionReusableView? = collectionView.dequeueReusableSupplementaryView(kind: "UICollectionElementKindSectionHeader", indexPath: indexPath)
        XCTAssertNotNil(headerVIew)
    }
}

extension UICollectionViewExtensionsTests: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (collectionView == self.collectionView) ? 2 : 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == self.collectionView) ? (section == 0 ? 5 : 0) : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
