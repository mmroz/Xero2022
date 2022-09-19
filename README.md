Things I did:
1. Changed the Invoice and InvoiceItem to structs instead of classes to make use of immutability. There are some trade-offs related to marking functions as mutable since structs are by value however the readability of var vs let outweigh the costs and this can be managed through careful use of a data source
2. Added a UUID to the invoice that can be used as an identifier in the case that no invoice number has been assigned. This allows us to keep track of the invoice without a server.
2. Implemented the missing functions and added tests
3. Added a UITableView and UITableViewDiffableDataSouce to present the invoices
4. Added a data source to fetch the invoices (this would be where we remotely fetch the data)
5. Added a SwiftUI cell to present the invoice with the related ViewModel

TODO:
1. Correctly handle localization to show 1 item vs 2 items
