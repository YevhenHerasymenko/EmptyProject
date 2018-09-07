#!/usr/bin/env xcrun swift

import Foundation

enum StringerError: Error {
    case noFileSpecified
    case fileNotFound(filepath: String)
    case parsingFailed
}

func getArgument() -> String {
    guard CommandLine.arguments.count >= 2 else {
        return "Localizable.strings"
    }
    return CommandLine.arguments[1]
}

func contentFromFile(_ filename: String) throws -> NSString {
    let filepath = "\(FileManager.default.currentDirectoryPath)/en.lproj/\(filename)"
    
    guard FileManager.default.fileExists(atPath: filepath) else {
        throw StringerError.fileNotFound(filepath: filepath)
    }
    return try NSString(contentsOfFile: filepath, encoding: String.Encoding.unicode.rawValue)
}

func parse(_ query: NSString) throws -> String {
    let regex = try NSRegularExpression(pattern: "\"(.+?)\"\\s*=\\s*\"(.+?)\"\\s*;", options: .caseInsensitive)
    let matches = regex.matches(in: (query as String),
                                options: .withTransparentBounds,
                                range: NSRange(location: 0, length: query.length))
    let results = matches
        .map { match -> [String] in
            var strings = [String]()
            for index in 0..<(match.numberOfRanges) {
                let range = match.range(at: index)
                strings.append(query.substring(with: range) as String)
            }
            return strings
        }
        .filter { $0.count >= 3 }
      .reduce("") { (initial, strings) -> String in
        let firstSplitArray: [String] = strings[1]
          .split(separator: ".").map(String.init)
        let secondSplitArray = firstSplitArray
          .map { $0.split(separator: "_").map(String.init) }
          .reduce([String]()) { result, strings in
            return result + strings
        }

        let key: String = secondSplitArray
          .enumerated()
          .map { index, key in
            guard index != 0 else {
              guard Int(key) != nil else {
                return key
              }
              return "error\(key)"
            }
            return key.prefix(1).uppercased() + key.dropFirst()
          }.joined()
          .replacingOccurrences(of: "%", with: "")
          .replacingOccurrences(of: "&", with: "")
        return initial + "\t\tcase \(key) = \"\(strings[1])\"\n"
  }
    
    let begin = "import Foundation\n\nenum Localizable: String {\n"
    let end = "}"
    
    return begin + results + end
}

func main() -> Int {
    do {
        let filename = getArgument()
        let content = try contentFromFile(filename)
        let result = try parse(content)
        print(result)
        return 1
    } catch StringerError.noFileSpecified {
        print("Error: file is not specified")
        return 0
    } catch StringerError.fileNotFound(let filepath) {
        print("Error: file \(filepath) is not existed")
        return 0
    } catch StringerError.parsingFailed {
        print("Error: parsing file failed")
        return 0
    } catch {
        print("Error 😭, \(error)")
        return 0
    }
}

main()
