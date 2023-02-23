import UIKit

public class ExpenseDetailCell: TransactionTableViewCell {

    public override func fillInfo(with decorator: TransactionCellDecoratorProtocol) {
        titleCell.text = decorator.getTitle()
        subtitleLabel.attributedText = decorator.getDescription()
        dateLabel.text = decorator.getDate()
        amountCell.attributedText = decorator.getAmount()
    }
}
