import Foundation



struct AppData {
    static var baseUrlWithJsonApi: String {
        get {
            return "\(webServer)/api/v2"
        }
    }

    static var baseUrlWithXmlApi: String {
        get {
            return "\(webServer)/api"
        }
    }

    static var webServer: String {
        get {
            return APIParameters.baseURL
        }
    }

    static var webDomain: String {
        get {
            return AppData.webServer.replacingOccurrences(of: "http://", with: "").replacingOccurrences(of: "https://", with: "")
        }
    }
    static func makeUniqueKey(prefix: String) -> String? {
        guard let currentUser = AppStorage.userID else {
            return nil
        }

        return "\(prefix)@\(currentUser + " @AlphaStoryWorldUser")"
    }
//    static func isUserLogged() -> Bool {
//        return AppStorage.currentUser != nil
//    }
//
//    static func makeUniqueKey(prefix: String) -> String? {
//        guard let currentUser = AppStorage.currentUser else {
//            return nil
//        }
//
//        return "\(prefix)@\(currentUser.userIdentifier)"
//    }

    static var appVersion: String {
        get {
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "-"
            let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] ?? "-"
            return "Version \(version) (\(buildNumber))"
        }
    }

   // static var locationServers: [ServerModel]?
}
