import Foundation
import UalaCore

public protocol CardState {
    var activeCard: Card? { get set }
    var inactiveCard: Card? { get set }
}
