//
//  InfoViewController.swift
//  SnapLab
//
//  Created by macbook on 25.05.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(rgb: 0x050A24)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .darkGray 
        backgroundView.layer.cornerRadius = 12
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
        
        let infoLabel = UILabel()
        infoLabel.text = "Функционал приложения"
        infoLabel.font = UIFont.systemFont(ofSize: 20)
        infoLabel.textColor = .white
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backgroundView).inset(20)
        }
        
        let textInfoLabel = UILabel()
        textInfoLabel.text = "КОН - контрастность\nРЕЗ - резкость\nЯРК - яркость\nНАС - насыщенность\nКРА - красочноть\nШУМ - шум"
        textInfoLabel.textColor = .white
        textInfoLabel.font = UIFont.systemFont(ofSize: 20)
        textInfoLabel.numberOfLines = 0
        textInfoLabel.textAlignment = .left
        
        view.addSubview(textInfoLabel)
        textInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(40)
        }
        
        let textInfoLabelTwo = UILabel()
        textInfoLabelTwo.textAlignment = .left
        textInfoLabelTwo.text = "Выберите режим и с помощью слайдера измените значение. Обрежьте фотографию или измените ориентацию нажав на кнопку ОБРЕЗАТЬ.\nВ разделе ФИЛЬТРЫ можно применить различные фильтры для вашей фотографиию.\nКнопка ВПЕРЕД и < служат для отмены изменений.\nПосле завершения редактирования нажмите на кнопку СОХР и сохраните отредактированную фотографию в галерею."
        textInfoLabelTwo.textColor = .white
        textInfoLabelTwo.font = UIFont.systemFont(ofSize: 18)
        textInfoLabelTwo.numberOfLines = 0
        view.addSubview(textInfoLabelTwo)
        textInfoLabelTwo.snp.makeConstraints { make in
            make.top.equalTo(textInfoLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        
        let bottomLabel = UILabel()
        bottomLabel.text = "Разработчик ПО: Попов Александр Алексеевич ТГУ 4 курс ПМИ"
        bottomLabel.textColor = .white
        bottomLabel.textAlignment = .center
        bottomLabel.font = UIFont.systemFont(ofSize: 10)
        view.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(20)
        }
    }
    

}
