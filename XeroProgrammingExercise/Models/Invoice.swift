import Foundation

struct Invoice {
    
    // MARK: - Private Properties
    
    private(set) var invoiceNumber: Int?
    private(set) var invoiceDate: Date?
    private(set) var lineItems: [InvoiceLine]
    
    // MARK: - Public Properties
    
    /// UUID for invoices that have not been retreived from the server
    let uuid: String
    
    /// GetTotal should return the sum of (Cost * Quantity) for each line item
    var total: Decimal {
        lineItems.map(\.price).reduce(0, +)
    }
    
    /// order the lineItems by Id
    var oderLineItems: [InvoiceLine] {
        lineItems.sorted()
    }
    
    // MARK: - Private
    
    init(
        uuid: String = UUID().uuidString,
        invoiceNumber: Int? = nil,
        invoiceDate: Date? = nil,
        lineItems: [InvoiceLine] = []) {
            self.uuid = uuid
            self.invoiceNumber = invoiceNumber
            self.invoiceDate = invoiceDate
            self.lineItems = lineItems
        }
    
    // MARK: - Public
    
    mutating func addInvoiceLine(_ line: InvoiceLine) {
        lineItems.append(line)
    }
    
    mutating func removeInvoiceLine(with invoiceLineId: Int) {
        lineItems.removeAll { $0.invoiceLineId == invoiceLineId }
    }
    
    /// Remove the line items in the current invoice that are also in the sourceInvoice
    mutating func removeItems(from sourceInvoice: Invoice) {
        let idsToRemove = Set(sourceInvoice.lineItems.map(\.invoiceLineId))
        lineItems.removeAll { idsToRemove.contains($0.invoiceLineId) }
    }
    
    /// MergeInvoices appends the items from the sourceInvoice to the current invoice
    ///  - Note: This will remove duplicate line items
    mutating func mergeInvoices(sourceInvoice: Invoice) {
        lineItems = (lineItems + sourceInvoice.lineItems).deduplicate()
    }
    
    /// returns the number of the line items specified in the variable `max`
    func previewLineItems(_ max: Int) -> [InvoiceLine] {
        guard lineItems.count > 0, max > 0 else { return [] }
        let upperBound = min(max, lineItems.count)
        return lineItems[0..<upperBound].map { $0 }
    }
    
    /// Creates a deep clone of the current invoice (all fields and properties)
    func clone() -> Invoice {
        Invoice(uuid: UUID().uuidString, invoiceNumber: invoiceNumber, invoiceDate: invoiceDate, lineItems: lineItems)
    }
    
    /// Outputs string constructed from the internal data
    func toString(dateFormatter: DateFormatter) -> String {
        let invoiceDateString: String = invoiceDate.map{ dateFormatter.string(from: $0) } ?? "nil"
        let invoiceNumberString: String = invoiceNumber.map{ "\($0)" } ?? "nil"
        return [
            "Invoice Number: \(invoiceNumberString)",
            "InvoiceDate: \(invoiceDateString)",
            "LineItemCount: \(lineItems.count)",
        ].joined(separator: ", ")
    }
}
