import XCTest
import UIKit
import MasMagicPills

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
        tableView.register(UITableViewCell.self)
        _ = tableView.dequeueReusableCell() as UITableViewCell
    }

    func test_register_cell_with_class_and_indexpath() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.register(UITableViewCell.self)
        _ = tableView.dequeueReusableCell(indexPath: indexPath) as UITableViewCell
    }

    func test_register_cell_with_nib_using_class() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.registerWithNib(UITableViewCell.self, bundle: Bundle(for: UITableViewExtensionsTests.self))
        _ = tableView.dequeueReusableCell(indexPath: indexPath) as UITableViewCell
    }

    func test_register_header_footer_view() {
        tableView.registerHeaderFooter(UITableViewHeaderFooterView.self)
        _ = tableView.dequeueReusableHeaderFooterView() as UITableViewHeaderFooterView
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
