import Foundation

public class JSONTestHelper {
    public enum ValidationError: Error {
        case modelNotEqual
    }

    public func parseAndUnparse<M: Codable & Equatable>(_ type: M.Type, from json: String, onSuccess: ((M) -> Void)? = nil) -> Error? {
        do {
            let model = try JSONDecoder().decode(M.self, from: json.dataUTF8)
            let modelJSON = try JSONEncoder().encode(model).stringUTF8!
            let decoded = try JSONDecoder().decode(M.self, from: modelJSON.dataUTF8)
            let success = model == decoded
            if success {
                onSuccess?(model)
                return nil
            }
            return ValidationError.modelNotEqual
        } catch let error as NSError {
            return error
        }
    }

    public func unparseAndParse<M: Codable & Equatable>(_ model: M) -> Error? {
        do {
            let modelJSON = try JSONEncoder().encode(model).stringUTF8!
            let decoded = try JSONDecoder().decode(M.self, from: modelJSON.dataUTF8)

            if model != decoded {
                return ValidationError.modelNotEqual
            }
            return nil
        } catch let error as NSError {
            return error
        }
    }
}
