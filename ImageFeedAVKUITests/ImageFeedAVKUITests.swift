import XCTest

final class ImageFeed_UITests: XCTestCase {
    
//    Перед началом теста необходимо заполнить данные:
    private let login = "avk.16@yandex.ru"
    private let password = "vubje4-cygtYg-xijzet"
    private let userName = "Andy Kruch"
    private let nickname = "@andy_kruch"
    
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 10))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        loginTextField.tap()
        loginTextField.typeText(login)
        
        sleep(5)
        webView.swipeUp()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        passwordTextField.tap()
        passwordTextField.typeText(password)
        webView.swipeUp()
        
        webView.buttons["Login"].tap()
        
        sleep(5)
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        
        print(app.debugDescription)
    }
    
    func testFeed() throws {
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        cellToLike.buttons["likeButton"].tap()
        sleep(2)
        cellToLike.buttons["likeButton"].tap()
        sleep(2)
        cellToLike.tap()
        sleep(10)
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["backButton"]
        navBackButtonWhiteButton.tap()
    }
    
    func testProfile() throws {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts["\(userName)"].exists)
        XCTAssertTrue(app.staticTexts["\(nickname)"].exists)
        
        app.buttons["logoutButton"].tap()
        
        app.alerts["Пока, пока!"].scrollViews.otherElements.buttons["Да"].tap()
        sleep(2)
        
        let authButton = app.buttons["Authenticate"]
        XCTAssertTrue(authButton.waitForExistence(timeout: 5))
    }}
