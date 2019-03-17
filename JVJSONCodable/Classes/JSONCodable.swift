public struct JSONDecodable {
    
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    
    public static func decode<T: Decodable>(data: [String : Any], type: T.Type) -> T {
        let jsonData = try! JSONSerialization.data(withJSONObject: data)
        
        return try! decoder.decode(type, from: jsonData)
    }
    
    public static func encode<T: Encodable>(from: T) -> [String: Any] {
        let data = try! encoder.encode(from)
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        return json as! [String : Any]
    }
}

public extension Decodable {
    static func decodeFrom(data: [String: Any]) -> Self {
        return JSONDecodable.decode(data: data, type: Self.self)
    }
}

public extension Encodable {
    func encode() -> [String: Any] {
        return JSONDecodable.encode(from: self)
    }
}
