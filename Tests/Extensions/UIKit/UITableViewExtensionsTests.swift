import XCTest
import UIKit
import MagicPills

class UITableViewExtensionsTests: XCTestCase {

    let tableView = UITableView()
    let emptyTableView = UITableView()

    override func setUp() {
        super.setUp()
        tableView.dataSource = self
        emptyTableView.dataSource = self
        tableView.reloadData()
    }

    func test_register_cell_with_class() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.register(UITableViewCell.self)
        let cell: UITableViewCell? = tableView.dequeueReusableCell(indexPath)
        XCTAssertNotNil(cell)
    }

    func test_register_cell_with_nib_using_class() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.registerWithNib(UITableViewCell.self, bundle: Bundle(for: UITableViewExtensionsTests.self))
        let cell: UITableViewCell? = tableView.dequeueReusableCell(indexPath)
        XCTAssertNotNil(cell)
    }
}

extension UITableViewExtensionsTests: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == self.emptyTableView ? 0 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.emptyTableView {
            return 0
        } else {
            return section == 0 ? 5 : 8
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
