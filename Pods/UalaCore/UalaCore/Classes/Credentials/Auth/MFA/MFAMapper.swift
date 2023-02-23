
// swiftlint:disable identifier_name
struct OOBMapper: MappeableType {
    struct Result: Decodable {
        var oob_code: String
    }

    func map<T>(_ data: Data) -> T? {
        return decode(data)?.oob_code as? T
    }
}

struct CrendentialMapper: Mappeable {

    func map<T>(_ data: Data) -> T? {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        return CredentialBuilder.create(json) as? T
    }
}

struct RegisterMapper: MappeableType {
    struct Result: Decodable {
        let statusCode: Int
    }
    
    func map<T>(_ data: Data) -> T? {
        return (decode(data)?.statusCode ?? 0) as? T
    }
}
