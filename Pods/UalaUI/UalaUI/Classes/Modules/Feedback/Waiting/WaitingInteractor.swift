import Foundation

public class WaitingInteractor {
    weak public var presenter: WaitingPresenterProtocol?
    public var waitingRequest: WaitingRequestProtocol?
    
    public init() {}
}

extension WaitingInteractor: WaitingInteractorProtocol {
    
    public func makeRequest() {
        Task {
            do {
                guard let feedbackModel = try await waitingRequest?.transferWaitingAsyncRequest() else {
                    return
                }
                await self.presenter?.handleFeedback(feedbackModel: feedbackModel)
            } catch let error {
                await self.presenter?.handleFeedbackError(error: error)
            }
        }
    }
    
    public func cancelRequest() {
        waitingRequest?.requestTask?.cancel()
    }
}
