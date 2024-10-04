//
//  WeatherListViewModelTests.swift
//  WeatherAppTests
//
//  Created by Jaime Tejeiro on 4/10/24.
//

import XCTest
@testable import WeatherApp



class WeatherListViewModelTests: XCTestCase {
    var viewModel: WeatherListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = WeatherListViewModel(weatherSearchLogic: WeatherSearchLogic(WeatherMock()) )
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Test para verificar que se recuperan los datos correctamente
    func testFechWeatherSearchDataSuccess() async throws {
        // Crear un modelo de prueba

        // Ejecutar la función a probar
        try await viewModel.fechWeatherSearchData(text: "Detroit")

        // Verificar que los estados se actualizan correctamente
        XCTAssertEqual(viewModel.getTempString(), "16 Cº")
        XCTAssertEqual(viewModel.getTempMinString(), "10 Cº")
        XCTAssertEqual(viewModel.getTempMaxString(), "22 Cº")
    }





}
