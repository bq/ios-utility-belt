import XCTest
import UIKit
@testable import MagicPills

final private class HeaderCollectionReusableView: UICollectionReusableView {}
final private class TestCell: UICollectionViewCell {}

final class UICollectionViewExtensionsTests: XCTestCase {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let emptyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override func setUp() {
        super.setUp()

        collectionView.dataSource = self
        collectionView.reloadData()

        emptyCollectionView.dataSource = self
        emptyCollectionView.reloadData()
    }

    func testRegisterCellWithClass() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.register(TestCell.self)
        let cell: TestCell? = collectionView.dequeueReusableCell(indexPath)
        XCTAssertNotNil(cell)
    }

    func testRegisterCellWithNibUsingClass() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.registerWithNib(UICollectionViewCell.self, bundle: Bundle(for: UICollectionViewExtensionsTests.self))
        let cell: UICollectionViewCell? = collectionView.dequeueReusableCell(indexPath)
        XCTAssertNotNil(cell)
    }

    func testDequeueReusableSupplementaryView() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.register(TestCell.self)
        let _: TestCell? = collectionView.dequeueReusableCell(indexPath)
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
