/*
 Welcome to the Xero technical excercise!
 ---------------------------------------------------------------------------------
 The test consists of a small invoice application that has a number of issues.
 
 Your job is to fix them and make sure you can perform the functions in each method below and display the list of invoices from getInvoices() inside a UITableView.
 
 Note your first job is to get the solution compiling!
 
 Rules
 ---------------------------------------------------------------------------------
 * The entire solution must be written in Swift (UIKit or SwiftUI)
 * You can modify any of the code in this solution, split out classes, add projects etc
 * You can modify Invoice and InvoiceLine, rename and add methods, change property types (hint)
 * Feel free to use any libraries or frameworks you like
 * Feel free to write tests (hint)
 * Show off your skills!
 
 Good luck :)
 
 When you have finished the solution please zip it up and email it back to the recruiter or developer who sent it to you
 */

import UIKit
import SwiftUI
import Combine

class InvoicesListViewController: UIViewController {
    
    enum TableSections {
        case all
    }
    
    private let dateFormatter: DateFormatter
    private let currencyFormatter: NumberFormatter
    private let viewModel: InvoicesListViewModel
    private var cancellables: Set<AnyCancellable> = Set()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        return table
    }()
    private lazy var tableViewDataSource: UITableViewDiffableDataSource<TableSections, InvoiceRowViewModel> = {
        let dataSource = UITableViewDiffableDataSource<TableSections, InvoiceRowViewModel>(tableView: tableView, cellProvider: { [ weak self] (_, _, invoice) in
            guard let self = self else { return UITableViewCell() }
            let cell = UITableViewCell()
            cell.contentConfiguration = UIHostingConfiguration {
                InvoiceCell(invoice: invoice, dateFormatter: self.dateFormatter, currencyFormatter: self.currencyFormatter)
            }
            return cell
        })
        return dataSource
    }()
    
    // MARK: - Init
    
    init(viewModel: InvoicesListViewModel, dateFormatter: DateFormatter, currencyFormatter: NumberFormatter) {
        self.dateFormatter = dateFormatter
        self.currencyFormatter = currencyFormatter
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createInvoiceWithOneItem()
        createInvoiceWithMultipleItemsAndQuantities()
        removeItem()
        mergeInvoices()
        cloneInvoice()
        orderLineItems()
        previewLineItems()
        removeExtraItems()
        Self.InvoiceToString()
        
        viewModel.$dataSource.sink { [weak self] items in
            self?.update(items: items)
        }.store(in: &cancellables)
        
        setupTableView()
        reloadTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableViewData()
    }
    
    ///Initialises the tableview
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    ///Populates the cells with the invoices returned from GetInvoices
    private func reloadTableViewData() {
        viewModel.load()
    }
    
    private func update(items: [InvoiceRowViewModel]) {
        let snapshot = InvoiceRowBuilder.sections(items: items)
        tableViewDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UITableViewDelegate

extension InvoicesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Stuff that was already here

private extension InvoicesListViewController {
        private func createInvoiceWithOneItem() {
            var invoice = Invoice()
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                               description: "Pizza",
                                               quantity: 1,
                                               cost: 9.99))
        }
    
        private  func createInvoiceWithMultipleItemsAndQuantities() {
            var invoice = Invoice()
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                               description: "Banana",
                                               quantity: 4,
                                               cost: 10.21))
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                               description: "Orange",
                                               quantity: 1,
                                               cost: 5.21))
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 3,
                                               description: "Pizza",
                                               quantity: 5,
                                               cost: 5.21))
    
            print(invoice.total)
        }
    
        private func removeItem() {
            var invoice = Invoice()
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                               description: "Orange",
                                               quantity: 1,
                                               cost: 5.22))
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                               description: "Banana",
                                               quantity: 4,
                                               cost: 10.33))
    
            invoice.removeInvoiceLine(with: 1)
            print(invoice.total)
        }
    
        private func mergeInvoices() {
            var invoice1 = Invoice()
    
            invoice1.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                                description: "Banana",
                                                quantity: 4,
                                                cost: 10.33))
    
            var invoice2 = Invoice()
    
            invoice2.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                                description: "Orange",
                                                quantity: 1,
                                                cost: 5.22))
    
            invoice2.addInvoiceLine(InvoiceLine(invoiceLineId: 3,
                                                description: "Blueberries",
                                                quantity: 3,
                                                cost: 6.27))
    
            invoice1.mergeInvoices(sourceInvoice: invoice2)
            print(invoice1.total)
    
        }
    
        private func cloneInvoice() {
            var invoice = Invoice()
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                               description: "Apple",
                                               quantity: 1,
                                               cost: 6.99)
            )
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                               description: "Blueberries",
                                               quantity: 3,
                                               cost: 6.27))
    
            let clonedInvoice = invoice.clone()
            print(clonedInvoice.total)
        }
    
        private static func InvoiceToString() {
            var invoice = Invoice()
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                               description: "Apple",
                                               quantity: 1,
                                               cost: 6.99))
    
            print(invoice.toString(dateFormatter: Formatters.dateFormatter()))
        }
    
        func orderLineItems() {
            var invoice = Invoice()
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 3,
                                               description: "Banana",
                                               quantity: 4,
                                               cost: 10.21))
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                               description: "Orange",
                                               quantity: 1,
                                               cost: 5.21))
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                               description: "Pizza",
                                               quantity: 5,
                                               cost: 5.21))

    
            let newInvoice = Invoice(invoiceNumber: invoice.invoiceNumber, invoiceDate: invoice.invoiceDate, lineItems: invoice.oderLineItems)
            print(newInvoice.toString(dateFormatter: Formatters.dateFormatter()))
        }
    
        private func previewLineItems() {
            var invoice = Invoice()
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                               description: "Banana",
                                               quantity: 4,
                                               cost: 10.21))
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                               description: "Orange",
                                               quantity: 1,
                                               cost: 5.21))
    
            invoice.addInvoiceLine(InvoiceLine(invoiceLineId: 3,
                                               description: "Pizza",
                                               quantity: 5,
                                               cost: 5.21))
    
            let items = invoice.previewLineItems(1)
            print(items)
        }
    
        private func removeExtraItems() {
            var invoice1 = Invoice()
    
            invoice1.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                                description: "Banana",
                                                quantity: 4,
                                                cost: 10.33))
    
            invoice1.addInvoiceLine(InvoiceLine(invoiceLineId: 3,
                                                description: "Blueberries",
                                                quantity: 3,
                                                cost: 6.27))
    
            var invoice2 = Invoice()
    
            invoice2.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                                description: "Orange",
                                                quantity: 1,
                                                cost: 5.22))
    
            invoice2.addInvoiceLine(InvoiceLine(invoiceLineId: 3,
                                                description: "Blueberries",
                                                quantity: 3,
                                                cost: 6.27))
    
            invoice2.removeItems(from: invoice1)
            print(invoice2.total)
        }
    
        private func getInvoices() -> [Invoice] {
                var invoice1 = Invoice()
    
                invoice1.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                                    description: "Banana",
                                                    quantity: 4,
                                                    cost: 10.33))
    
            var invoice2 = Invoice()
    
                invoice2.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                                    description: "Orange",
                                                    quantity: 1,
                                                    cost: 5.22))
    
                invoice2.addInvoiceLine(InvoiceLine(invoiceLineId: 2,
                                                    description: "Blueberries",
                                                    quantity: 3,
                                                    cost: 6.27))
    
            var invoice3 = Invoice()
    
                invoice3.addInvoiceLine(InvoiceLine(invoiceLineId: 1,
                                                    description: "Pizza",
                                                    quantity: 1,
                                                    cost: 9.99))
    
            return [invoice1, invoice2, invoice3]
        }
}
