//
//  AppStorage.swift
//  CollegeStars
//
//  Created by Mac on 19/11/20.
//

import Foundation
struct AppStorage {
    static var userID: String? {
        get {
            return UserDefaults.standard.string(forKey: "userID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userID")
        }
    }
    static var referalCode: String? {
        get {
            return UserDefaults.standard.string(forKey: "referalCode")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userreferalCodeID")
        }
    }
    static var firstUser: String? {
        get {
            return UserDefaults.standard.string(forKey: "firstUser")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "firstUser")
        }
    }
    static var userToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "User_Token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "User_Token")
        }
    }
    static var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "refreshToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "refreshToken")
        }
    }
    static var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: "username")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "username")
        }
    }
    static var userIntro: String? {
        get {
            return UserDefaults.standard.string(forKey: "User_Intro")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "User_Intro")
        }
    }
    static var userEmail: String? {
        get {
            return UserDefaults.standard.string(forKey: "email")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "email")
        }
    }
    static var userMobile: String? {
        get {
            return UserDefaults.standard.string(forKey: "userMobile")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userMobile")
        }
    }
    static var fcmToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "fcmToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fcmToken")
        }
    }
    static var languageID: String? {
        get {
            return UserDefaults.standard.string(forKey: "language")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "language")
        }
    }
    static var locationNameStr: String? {
        get {
            return UserDefaults.standard.string(forKey: "location")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "location")
        }
    }
    static var contestIDStr: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "contest_ID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "contest_ID")
        }
    }
    static var CategoriesList: [CategoryData]? {
        get {
            guard let userContentKey = AppData.makeUniqueKey(prefix: "Categories") else {
                return nil
            }

            guard let data = UserDefaults.standard.data(forKey: userContentKey) else {
                return nil
            }

            guard let content = try? JSONDecoder().decode([CategoryData].self, from: data) else {
                return nil
            }

            return content
        }
        set {
            if let content = try? JSONEncoder().encode(newValue), let userContentKey = AppData.makeUniqueKey(prefix: "Categories") {
                UserDefaults.standard.set(content, forKey: userContentKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    static var BannerListData: [BannerData]? {
        get {
            guard let userContentKey = AppData.makeUniqueKey(prefix: "Banners") else {
                return nil
            }

            guard let data = UserDefaults.standard.data(forKey: userContentKey) else {
                return nil
            }

            guard let content = try? JSONDecoder().decode([BannerData].self, from: data) else {
                return nil
            }

            return content
        }
        set {
            if let content = try? JSONEncoder().encode(newValue), let userContentKey = AppData.makeUniqueKey(prefix: "Banners") {
                UserDefaults.standard.set(content, forKey: userContentKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    static var TopRatedItems: [TopRatedItemsData]? {
        get {
            guard let userContentKey = AppData.makeUniqueKey(prefix: "TopItems") else {
                return nil
            }

            guard let data = UserDefaults.standard.data(forKey: userContentKey) else {
                return nil
            }

            guard let content = try? JSONDecoder().decode([TopRatedItemsData].self, from: data) else {
                return nil
            }

            return content
        }
        set {
            if let content = try? JSONEncoder().encode(newValue), let userContentKey = AppData.makeUniqueKey(prefix: "TopItems") {
                UserDefaults.standard.set(content, forKey: userContentKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    static var monthlyPackItemList: [MonthlyPackData]? {
        get {
            guard let userContentKey = AppData.makeUniqueKey(prefix: "MonthlypackItems") else {
                return nil
            }

            guard let data = UserDefaults.standard.data(forKey: userContentKey) else {
                return nil
            }

            guard let content = try? JSONDecoder().decode([MonthlyPackData].self, from: data) else {
                return nil
            }

            return content
        }
        set {
            if let content = try? JSONEncoder().encode(newValue), let userContentKey = AppData.makeUniqueKey(prefix: "MonthlypackItems") {
                UserDefaults.standard.set(content, forKey: userContentKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    static func makeUniqueKey(prefix: String) -> String? {
        guard let currentUser = AppStorage.userToken else {
            return nil
        }

        return "\(prefix)@\(currentUser)"
    }

    
}
