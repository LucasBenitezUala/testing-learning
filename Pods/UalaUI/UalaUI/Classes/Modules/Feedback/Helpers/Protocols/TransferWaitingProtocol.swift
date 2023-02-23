import PromiseKit
import UalaCore

public protocol WaitingRequestProtocol {
    var requestTask: Task<FeedbackModel, Error>! { get set }
    func transferWaitingAsyncRequest() async throws -> FeedbackModel
}
