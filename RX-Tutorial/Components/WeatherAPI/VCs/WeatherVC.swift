//
//  WeatherVC.swift
//  RX-Tutorial
//
//  Created by David Adel on 08/04/2021.
//

import UIKit
import RxCocoa
import RxSwift

class WeatherVC: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Good Weather"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        cityTextField
            .rx
            .controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map {
            self.cityTextField.text
        }.subscribe(onNext: { city in
            if let city = city {
                if city.isEmpty {
                    self.displayWeather(weather: nil)
                } else {
                    self.fetchWeather(by: city)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    private func displayWeather(weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℉ "
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.temperatureLabel.text = "🙈"
            self.humidityLabel.text = "🚫"
        }
    }
    
    func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else {
            return
        }
        
        let resouce = Resource<WeatherResult>(url: url)
        
        /*
        URLRequest.load(resource: resouce)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.empty)
            .subscribe(onNext: { result in
            let weather = result?.main
            self.displayWeather(weather: weather)
        }).disposed(by: disposeBag)
        
        let search = URLRequest.load(resource: resouce)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.empty)

        search.map { "\($0!.main.temp) ℉"}
            .bind(to: self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)

        search.map {"\($0!.main.humidity) 💦"}
            .bind(to: self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
         */
        
        /*
        let search = URLRequest.load(resource: resouce)
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\($0!.main.temp) ℉"}
            .drive(self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map {"\($0!.main.humidity) 💦"}
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
         */
        
        let search = URLRequest.load(resource: resouce)
            .observeOn(MainScheduler.instance)
            .retry(3)
            .catchError { error in
                print(error.localizedDescription)
                return Observable.just(WeatherResult.empty)
            }.asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\($0!.main.temp) ℉"}
            .drive(self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map {"\($0!.main.humidity) 💦"}
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
    }

}
