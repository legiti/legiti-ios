import Foundation

public enum TrackerException: Error {
    case requiredConfig(code: Int, message: String)
    case internalError(message: String)
}
