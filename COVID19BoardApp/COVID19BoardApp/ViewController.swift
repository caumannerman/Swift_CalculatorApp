//
//  ViewController.swift
//  COVID19BoardApp
//
//  Created by 양준식 on 2022/04/22.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    private lazy var domesticTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "국내 누적 확진자"
        label.textAlignment = .center
        label.backgroundColor = .blue
        
        return label
    }()
    private lazy var newDomesticTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "국내 신규 확진자"
        label.textAlignment = .center
        label.backgroundColor = .green
        
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [domesticTitleLabel, newDomesticTitleLabel])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var domesticInfectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "2512"
        label.backgroundColor = .red
        
        return label
    }()
    
   
    
    private lazy var newDomesticInfectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "90"
        label.backgroundColor = .yellow
        
        return label
    }()
    
    private lazy var pieChartView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverView(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.configureStackView(koreaCovidOverview: result.korea)
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
            
        })
        // Do any additional setup after loading the view.
        setupSubView()
       
    }


}

extension ViewController{
    func setupSubView(){
        [titleStackView, domesticInfectionLabel, newDomesticInfectionLabel, pieChartView].forEach{
            view.addSubview($0)
        }
        
        titleStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.leading.trailing.equalToSuperview().inset(12.0)
        }
        
        domesticInfectionLabel.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(12.0)
            $0.centerX.equalTo(domesticTitleLabel.snp.centerX)
        }
        
        newDomesticInfectionLabel.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(12.0)
            $0.centerX.equalTo(newDomesticTitleLabel.snp.centerX)
        }
        
        pieChartView.snp.makeConstraints{
            $0.top.equalTo(newDomesticInfectionLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(12.0)
        }
    }
}

extension ViewController{
    func makeCovidOverviewList(
        cityCovidOverview: CityCovidOverview
    ) -> [CovidOverview]{
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju
        ]
    }
    func configureChartView(covidOverviewList: [CovidOverview]){
        let entries = covidOverviewList.compactMap{ [weak self] overview -> PieChartDataEntry? in
            guard let self = self else {return nil}
            return PieChartDataEntry(value: self.removeFormatString(string: overview.newCase),
                                     label: overview.countryName,
                                     data: overview)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        self.pieChartView.data = PieChartData(dataSet: dataSet)
    }
    
    func removeFormatString(string: String) -> Double{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    
    func configureStackView(koreaCovidOverview: CovidOverview){
        self.domesticInfectionLabel.text = "\(koreaCovidOverview.totalCase)"
        self.newDomesticInfectionLabel.text = "\(koreaCovidOverview.newCase)"
    }
    func fetchCovidOverView(
        completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void
    ){
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "j1pmnZzOx4FcDgyQlYiq2WMGSVsL38Ka6"
        ]
        
        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    do{
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCovidOverview.self, from: data)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                    
                case let .failure(error):
                    completionHandler(.failure(error))
                }
                
            })
        
    }
}
