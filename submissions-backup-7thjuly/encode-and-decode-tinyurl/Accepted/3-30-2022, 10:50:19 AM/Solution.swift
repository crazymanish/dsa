// https://leetcode.com/problems/encode-and-decode-tinyurl

class Codec {
    var hashMap: [String: String] = [:]
    
    // Encodes a URL to a shortened URL.
    func encode(_ longUrl: String) -> String {
        let uuid = UUID().uuidString
        hashMap[uuid] = longUrl
        
        return uuid
    }
    
    // Decodes a shortened URL to its original URL.
    func decode(_ shortUrl: String) -> String {
        return hashMap[shortUrl] ?? "404"
    }
}

/**
 * Your Codec object will be instantiated and called as such:
 * let obj = Codec()
 * val s = obj.encode(longUrl)
 * let ans = obj.decode(s)
*/