//
//  ViewController.swift
//  WeatherApp
//
//  Created by 양준식 on 2022/04/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var textField: UITextField = {
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
        
    }


}



private extension ViewController {
    func setupSubView(){
        [ textField, getWeatherButton, cityNameLabel, weatherLabel, temperatureLabel, minMaxTempstackView].forEach{
            view.addSubview($0)
        }
        
        textField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30.0)
        }
        
        getWeatherButton.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(24.0)
            $0.centerX.equalTo(textField.snp.centerX)
           
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
}
