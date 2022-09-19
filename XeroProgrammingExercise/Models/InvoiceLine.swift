import Foundation

struct InvoiceLine {
    
    // MARK: - Private Properties
    
    private(set) var invoiceLineId: Int
    private var description: String
    private var quantity: Int
    private var cost: Decimal
    
    // MARK: - Public Properties
    
    var price: Decimal {
        Decimal(quantity) * cost
    }
    
    // MARK: - Init
    
    /// - Parameters:
    ///   - invoiceLineId: ID of the line item.
    ///   - description: Description of the line item.
    ///   - quantity: quantity of the line item.
    ///   - cost: cost of the line item.
    init(invoiceLineId: Int,
         description: String,
         quantity: Int,
         cost: Decimal) {
        self.invoiceLineId = invoiceLineId
        self.description = description
        self.quantity = quantity
        self.cost = cost
    }
}

// MARK: - Equatable

extension InvoiceLine: Equatable {}

// MARK: - Hashable

extension InvoiceLine: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(invoiceLineId)
    }
}

// MARK: - Comparable

extension InvoiceLine: Comparable {
    static func < (lhs: InvoiceLine, rhs: InvoiceLine) -> Bool {
        lhs.invoiceLineId < rhs.invoiceLineId
    }
}
