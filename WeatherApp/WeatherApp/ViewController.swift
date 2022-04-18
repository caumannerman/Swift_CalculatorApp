//
//  ViewController.swift
//  WeatherApp
//
//  Created by 양준식 on 2022/04/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var cityNameTextField: UITextField = {
       let textField = UITextField()
        textField.font = .systemFont(ofSize: 20.0, weight: .regular)
        
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemMint.cgColor
        
        
        return textField
    }()
    
    private lazy var getWeatherButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("날씨 가져오기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
        
        
        return button
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .medium)
        label.backgroundColor = .blue
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        
        return label
    }()

    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40.0, weight: .bold)
        
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .regular)
        
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .regular)
        
        return label
    }()
    
    private lazy var minMaxTempstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maxTempLabel, minTempLabel])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20.0
        return stackView
    }()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup(){
        setupSubView()
        cityNameLabel.text = "서울"
        weatherLabel.text = "맑음"
        temperatureLabel.text = "23^C"
        maxTempLabel.text = "최고: 30C"
        minTempLabel.text = "최저: 20C"
        
        getWeatherButton.addTarget(self, action: #selector(tapGetWeatherButton), for: .touchUpInside)
        
    }

    func getWeather( cityName: String){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=7eac24c87cf28d42dd38d4c25778708a") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){ [weak self] data, response, error in
            guard error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  let weatherInformation = try? JSONDecoder().decode(WeatherInformation.self, from: data) else { return }
            debugPrint(weatherInformation)
        }.resume()
        
    }
    //날씨 가져오기 버튼 클릭시 
    @objc func tapGetWeatherButton(){
        if let cityName = self.cityNameTextField.text {
            self.getWeather(cityName: cityName)
            //키보드 내리기
            self.view.endEditing(true)
        }
    }

}



extension ViewController {
    private func setupSubView(){
        [ cityNameTextField, getWeatherButton, cityNameLabel, weatherLabel, temperatureLabel, minMaxTempstackView].forEach{
            view.addSubview($0)
        }
        
        cityNameTextField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30.0)
        }
        
        getWeatherButton.snp.makeConstraints{
            $0.top.equalTo(cityNameTextField.snp.bottom).offset(24.0)
            $0.centerX.equalTo(cityNameTextField.snp.centerX)
           
        }
        
        cityNameLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(getWeatherButton.snp.bottom).offset(60.0)
        }
        
        weatherLabel.snp.makeConstraints{
            $0.centerX.equalTo(cityNameLabel.snp.centerX)
            $0.top.equalTo(cityNameLabel.snp.bottom).offset(8.0)
        }
        
        temperatureLabel.snp.makeConstraints{
            $0.centerX.equalTo(cityNameLabel.snp.centerX)
            $0.top.equalTo(weatherLabel.snp.bottom).offset(16.0)
        }
        
        minMaxTempstackView.snp.makeConstraints{
            $0.centerX.equalTo(cityNameLabel.snp.centerX)
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(6.0)
        }
    }
    //빈화면 touch시, 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
