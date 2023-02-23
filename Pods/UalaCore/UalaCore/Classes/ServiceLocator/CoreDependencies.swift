import Foundation

protocol CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { get }
}

extension Mexico: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUMXHelper() }
}

extension MexicoABC: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUMXHelper() }
}

extension Argentina: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUARHelper() }
}

extension Colombia: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUDefaultHelper() }
}

extension ArgentinaBank: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUDefaultHelper() }
}
