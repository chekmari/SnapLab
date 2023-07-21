//
//  EditorViewController.swift
//  SnapLab
//
//  Created by macbook on 13.05.2023.
//
import SnapKit
import Foundation
import UIKit

class EditorViewController: UIViewController {
    
    //MARK: - ОБЛАСТЬ ФОТОГРАФИИ
    let zeroView = UIView() // пустая серая область
    let zeroLabel = UILabel() // надпись о том что фото нет на zeroView
    let scrollView = UIScrollView() // scrollView для imageView
    var imageView = UIImageView() // view для отображения фото
    var originalImage: UIImage? // фото которое получается
    var filteredImage: UIImage? // фото которое первый раз отредактировалось и все следующий разы
    
    // MARK: - ОБЛАСТЬ РЕДАКТИРОВАНИЯ
    var editorOneView = UIView() // первая область
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium, scale: .large)
    var editorTwoView = UIView() // вторая область
    var scrollViewEditor = UIScrollView() // scrollView для editorOneView и editorTwoView
    
    // первая область
    let cropButton = UIButton() // кнопка обрезать
    let filtersButton = UIButton()
    let backChangeButton = UIButton()
    let forwardButton = UIButton()
    let infoButton = UIButton()  
    
    let downImageView = UIImageView()
    // вторая область
    var contrastValue: Float = 1.0
    var sharpnessValue: Float = 0.0
    var brightnessValue: Float = 0.0
    var saturationValue: Float = 1.0
    var noiseValue: Float = 0.5
//    // VIEWS:
//    let contrastView = UIView()
//    let sharpnessView = UIView()
//    let brightnessView = UIView()
//    let saturationView = UIView()
//    let noiseView = UIView()
//    // LABELS:
//    let contrastLabel = UILabel()
//    let sharpnessLabel = UILabel()
//    let brightnessLabel = UILabel()
//    let saturationLabel = UILabel()
//    let noiseLabel = UILabel()
//    // BUTTONS:
//    let contrastSlider = UIButton()
//    let sharpnessButton = UIButton()
//    let brightnessButton = UIButton()
//    let saturationButton = UIButton()
//    let noiseButton = UIButton()
    
    let imagePicker = UIImagePickerController()
    
    var sliders: [UISlider] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - НАБОР ФУНКЦИЙ
    private func setupUI() {
        PhotoRequestAlert()
        setupNavBar()
        customizeUI()
        setupScroll()
        setupImagePicker()
        addSubview()
        makeConstraints()
        targetActions()
    }
    // MARK: - ЗАПРОС НА РАЗРЕШЕНИЕ ИСПОЛЬЗОВАНИЯ ФОТОГРАФИЙ И ОТКРЫТИЕ ГАЛЕРИИ
    private func PhotoRequestAlert() {
        let alertController = UIAlertController(title: "Выбор режима", message: "Загрузить фото из библиотеки или из сети?", preferredStyle: .alert)
        let actionLibrary = UIAlertAction(title: "Из библиотеки", style: .default) { (action) in
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionURL = UIAlertAction(title: "Из сети", style: .default) { (action) in
            self.uploadSitePhoto()
        }
        alertController.addAction(actionLibrary)
        alertController.addAction(actionURL)
        present(alertController, animated: true)
    }
    // MARK: - НАСТРОЙКИ ЭЛЕМЕНТОВ ИНТЕРФЕЙСА
    private func customizeUI(){
        view.backgroundColor = UIColor(rgb: 0x050A26)

        zeroView.backgroundColor = .gray
        zeroView.layer.cornerRadius = 12
        
        zeroLabel.text = "Фото не выбрано.\n Вернитесь в МЕНЮ и попробуйте снова добавить фотографию из библиотеки!"
        zeroLabel.textAlignment = .center
        zeroLabel.font = UIFont.systemFont(ofSize: 9)
        zeroLabel.numberOfLines = 2
        zeroLabel.textColor = UIColor(rgb: 0x050A26)
        
        imageView.contentMode = .scaleToFill
        imageView.center = scrollView.center
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
    
        editorOneView.backgroundColor = .darkGray
        editorOneView.layer.cornerRadius = 12
        
        cropButton.setTitle("обрезать", for: .normal)
        cropButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cropButton.setTitleColor(.white, for: .normal)
        cropButton.backgroundColor = .gray
        cropButton.layer.cornerRadius = 8
        
        filtersButton.setTitle("фильтры", for: .normal)
        filtersButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        filtersButton.setTitleColor(.white, for: .normal)
        filtersButton.backgroundColor = .gray
        filtersButton.layer.cornerRadius = 8
        
        backChangeButton.setTitle("<", for: .normal)
        backChangeButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        backChangeButton.setTitleColor(.white, for: .normal)
        backChangeButton.backgroundColor = .gray
        backChangeButton.layer.cornerRadius = 8
        
        forwardButton.setTitle("вперед", for: .normal)
        forwardButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        forwardButton.setTitleColor(.white, for: .normal)
        forwardButton.backgroundColor = .gray
        forwardButton.layer.cornerRadius = 8
                
        infoButton.setTitle("как пользоваться?", for: .normal)
        infoButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        infoButton.setTitleColor(.white, for: .normal)
        infoButton.backgroundColor = .gray
        infoButton.layer.cornerRadius = 8
     
        downImageView.image = UIImage(systemName: "chevron.compact.down", withConfiguration: symbolConfig)
        downImageView.tintColor = .gray
        
        editorTwoView.backgroundColor = .darkGray
                
    }
    // MARK: - ДОБАВЛЕНИЕ VIEWS
    private func addSubview() {
        view.addSubview(zeroView)
        view.addSubview(editorOneView)
        
        zeroView.addSubview(zeroLabel)
        zeroView.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        
        editorOneView.addSubview(scrollViewEditor)
        
        let buttonsEditor = [cropButton, filtersButton, backChangeButton, forwardButton, infoButton]

        for button in buttonsEditor {
            scrollViewEditor.addSubview(button)
        }
        
        scrollViewEditor.addSubview(downImageView)
        scrollViewEditor.addSubview(editorTwoView)
        
        
        let contrastView = createViews()
        let sharpnessView = createViews()
        let brightnessView = createViews()
        let saturationView = createViews()
        let noiseView = createViews()
    }
    // MARK: - УСТАНОВКА CONSTRAINTS
    private func makeConstraints() {
        // Область фотографии
        zeroView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.height.equalTo(580)
            make.leading.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(6)
        }
        zeroLabel.snp.makeConstraints { make in
            make.centerX.equalTo(zeroView)
            make.centerY.equalTo(zeroView)
            make.leading.equalTo(zeroView).inset(6)
            make.trailing.equalTo(zeroView).inset(6)
        }
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        // Область редактирования
        editorOneView.snp.makeConstraints { make in
            make.top.equalTo(zeroView.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(6)
            make.bottom.equalToSuperview()
        }
        scrollViewEditor.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        filtersButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.width.equalToSuperview().inset(20)
        }
        cropButton.snp.makeConstraints { make in
            make.top.equalTo(filtersButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(52)
            make.width.equalToSuperview().dividedBy(4.0)
            
        }
        infoButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.equalTo(cropButton.snp.trailing).offset(20)
            make.top.equalTo(filtersButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        downImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoButton.snp.bottom).offset(12)
        }
        editorTwoView.snp.makeConstraints { make in
            make.top.equalTo(downImageView.snp.bottom).inset(12)
            make.height.equalTo(424) //412
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    // MARK: - УПРАВЛЕНИЕ КНОПКАМИ "ФИЛЬТРЫ И ИНФО"
    private func targetActions() {
        filtersButton.addTarget(self, action: #selector(filtresAlertAction), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
    }
    // MARK: - РЕАЛИЗАЦИЯ КНОПКИ "ФИЛЬТРЫ"
    @objc func filtresAlertAction() {
        let filtresAlert = UIAlertController(title: "Фильтры", message: "Выберите фильтр, который хотите установить на фотографию", preferredStyle: .actionSheet)
        
        // потом назвать по другому
        
        let filterOne = UIAlertAction(title: "Сепия", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applySepiaFilter)
        }
        
        let filterTwo = UIAlertAction(title: "Хром", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applyChromeFilter)
        }
        let filterThree = UIAlertAction(title: "Монохром", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applyMonoFilter)
        }
        let filterFour = UIAlertAction(title: "Нуар", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applyNoirFilter)
        }
        let filterFive = UIAlertAction(title: "Мгновение", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applyInstantFilter)
        }
        
        let filterSix = UIAlertAction(title: "Перенос эффекта", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applyTransferFilter)
        }
        
        let filterSeven = UIAlertAction(title: "Тональный", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applyTonalFilter)
        }
        
        let noneFilter = UIAlertAction(title: "Без фильтра", style: .default)
        { [self]
            UIAlertAction in
            applyFilter(filter: ImageFilterManager.applyNoFilter)
        }
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel)
        
        let actions = [filterOne,filterTwo,filterThree,filterFour,filterFive,filterSix,filterSeven,cancelAction,noneFilter]
        
        for action in actions {
            filtresAlert.addAction(action)
        }
        present(filtresAlert, animated: true)
    }
    // MARK: - РЕАЛИЗАЦИЯ КНОПКИ "КАК ПОЛЬЗОВАТЬСЯ?"
    @objc func infoAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController")
        
        present(infoVC, animated: true)
    }
    // MARK: -
    private func applyFilter(filter: (UIImage) -> UIImage?) {
        guard let image = originalImage else { return }
        if let filteredImage = filter(image) {
            self.filteredImage = filteredImage.fixOrientation()
            imageView.image = filteredImage
        }
    }
}



// MARK: - ДЛЯ ПЕРЕХОДА МЕЖДУ КОНТРОЛЛЕРАМИ
extension EditorViewController: UINavigationControllerDelegate {
    // MARK: - настройки NavigationBar
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "МЕНЮ", style: .done, target: self, action: #selector(backButtonTapped))
        let saveButton = UIBarButtonItem(title: "CОХРАНИТЬ", style: .done, target: self, action: #selector(saveAction))
        
        saveButton.tintColor = .darkGray
        backButton.tintColor = .systemGray
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = saveButton
    }
    // MARK: - РЕАЛИЗАЦИЯ КНОПКИ "НАЗАД"
    @objc func backButtonTapped() {
        let alertController = UIAlertController(title: "Внимание", message: "Вы уверены, что хотите вернуться на начальный экран? Все действия не будут сохранены.", preferredStyle: .alert)
           
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
           
        let backAction = UIAlertAction(title: "Вернуться", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(backAction)
        alertController.addAction(cancelAction)
           
        // Показываем алерт контроллер
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - РЕАЛИЗАЦИЯ КНОПКИ "СОХРАНИТЬ"
    @objc func saveAction() {
        guard let filteredImage = imageView.image else {
            // Если нет отфильтрованного изображения, выходим из метода
            return
        }
        // Сохраняем отфильтрованное изображение в фотоальбоме
        UIImageWriteToSavedPhotosAlbum(filteredImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            // Если произошла ошибка при сохранении изображения
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
            let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить изображение.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Оповещаем пользователя об успешном сохранении с помощью UIAlertController
            let alert = UIAlertController(title: "Успешно", message: "Изображение успешно сохранено в вашу галерею.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}



// MARK: - ДЛЯ СКРОЛЛИНГА
// TODO: - ДОДЕЛАТЬ НАСТРОЙКИ СКРОЛИНГА
extension EditorViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: - настройки скроллинга
    private func setupScroll() {
        scrollView.layer.cornerRadius = 12
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.darkText.cgColor
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true

        
        
        scrollViewEditor.zoomScale = 1.000001
        scrollViewEditor.minimumZoomScale = 1.0
        scrollViewEditor.maximumZoomScale = 1.000001
        scrollViewEditor.layer.borderWidth = 1
        scrollViewEditor.layer.borderColor = UIColor.darkText.cgColor
        scrollViewEditor.layer.cornerRadius = 12
        scrollViewEditor.contentSize = CGSize(width: 450, height: 450)
            //.init(width: 450, height: 450)
        scrollViewEditor.delegate = self
        scrollViewEditor.bounces = true
        scrollViewEditor.isScrollEnabled = true
        scrollViewEditor.bouncesZoom = false
        scrollViewEditor.alwaysBounceVertical = true
        scrollViewEditor.showsVerticalScrollIndicator = true
        scrollViewEditor.showsHorizontalScrollIndicator = false

    }
}



// MARK: - СОЗДАНИЕ СЛАЙДЕРОВ
extension EditorViewController {
    
    private func createSlider(minValue: Float, maxValue: Float, initialValue: Float) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        slider.value = initialValue
        slider.minimumTrackTintColor = UIColor(rgb: 0x050A26)
        slider.maximumTrackTintColor = UIColor(rgb: 0x050A26)
        slider.thumbTintColor = UIColor(rgb: 0x050A26)
        return slider
    }
    private func createViews() -> [UIView] {
        var views: [UIView] = []
        let textLabel = ["контрастность", "резкость", "яркость", "насыщенность", "шум"]
        
        for index in 0..<5 {
            let view = UIView()
            let label = UILabel()
            
            view.backgroundColor = .gray
            view.layer.cornerRadius = 12
            label.text = textLabel[index % textLabel.count]
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            
            editorTwoView.addSubview(view)
            view.addSubview(label)
            
            view.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8 + (72 * index))
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(64)
            }
            label.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().inset(4)
            }
            
            views.append(view)
            
            let slider: UISlider
            
            switch index {
            case 0: // Контрастность
                slider = createSlider(minValue: 0.0, maxValue: 2.0, initialValue: 1.0)
                slider.addTarget(self, action: #selector(contrastSliderValueChanged(_:)), for: .valueChanged)
            case 1: // Резкость
                slider = createSlider(minValue: -2.0, maxValue: 2.0, initialValue: 0.0)
                slider.addTarget(self, action: #selector(sharpnessSliderValueChanged(_:)), for: .valueChanged)
            case 2: // Яркость
                slider = createSlider(minValue: -1.0, maxValue: 1.0, initialValue: 0.0)
                slider.addTarget(self, action: #selector(brightnessSliderValueChanged(_:)), for: .valueChanged)
            case 3: // Насыщенность
                slider = createSlider(minValue: 0.0, maxValue: 2.0, initialValue: 1.0)
                slider.addTarget(self, action: #selector(saturationSliderValueChanged(_:)), for: .valueChanged)
            case 4: // Шум
                slider = createSlider(minValue: 0.0, maxValue: 1.0, initialValue: 0.5)
                slider.addTarget(self, action: #selector(noiseSliderValueChanged(_:)), for: .valueChanged)
                
            default:
                continue
            }
            view.addSubview(slider)
            slider.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().inset(20)
                make.trailing.equalToSuperview().inset(20)
            }
        }
        return views
    }
    
    @objc private func contrastSliderValueChanged(_ sender: UISlider) {
        contrastValue = sender.value
        applyFilters()
    }
    
    @objc private func sharpnessSliderValueChanged(_ sender: UISlider) {
        sharpnessValue = sender.value
        applyFilters()
    }
    
    @objc private func brightnessSliderValueChanged(_ sender: UISlider) {
        brightnessValue = sender.value
        applyFilters()
    }
    
    @objc private func saturationSliderValueChanged(_ sender: UISlider) {
        saturationValue = sender.value
        applyFilters()
    }
    
    @objc private func noiseSliderValueChanged(_ sender: UISlider) {
        noiseValue = sender.value
        applyFilters()
    }
    
    private func applyFilters() {
        guard let image = originalImage else { return }
        
        var filteredImage = image
        
        // Применяем каждый фильтр независимо от остальных
        if contrastValue != 1.0 {
            filteredImage = ImageFilterManager.applyContrastFilter(to: filteredImage, contrast: contrastValue) ?? filteredImage
        }
        
        if sharpnessValue != 0.0 {
            filteredImage = ImageFilterManager.applySharpnessFilter(to: filteredImage, sharpness: sharpnessValue) ?? filteredImage
        }
        
        if brightnessValue != 0.0 {
            filteredImage = ImageFilterManager.applyBrightnessFilter(to: filteredImage, brightness: brightnessValue) ?? filteredImage
        }
        
        if saturationValue != 1.0 {
            filteredImage = ImageFilterManager.applySaturationFilter(to: filteredImage, saturation: saturationValue) ?? filteredImage
        }
        
        if noiseValue != 0.5 {
            filteredImage = ImageFilterManager.applyNoiseFilter(to: filteredImage, noise: noiseValue) ?? filteredImage
        }
        
        // Отображаем отфильтрованное изображение
        imageView.image = filteredImage
    }
    
}

// MARK: - НАСТРОЙКИ IMAGE PICKER
extension EditorViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided with the following: \(info)")
        }
        
       
        
        // Получение пути к выбранному изображению
        if let imageURL = info[.imageURL] as? URL {
            // Создание CIImage из URL
            guard let originalCIImage = CoreImage.CIImage(contentsOf: imageURL) else {
                fatalError("Failed to create CIImage")
            }
                    
            // Создание UIImage из CIImage
            let uiImage = UIImage(ciImage: originalCIImage).fixOrientation()
            
            
            // Установка изображения в UIImageView
            originalImage = selectedImage.fixOrientation()
            
            let fixedImage = uiImage
            
            imageView.image = fixedImage
            
        }
    }

    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
}
// MARK: - НАСТРОЙКИ СЕТЕВОГО ЗАПРОСА
extension EditorViewController {
    
    func uploadSitePhoto() {
        // Получаем фото
        let photo = "https://piscum.photos/200/300"
        
        // Создание URL
        guard let photoURL = URL(string: photo) else {
            fatalError("Error")
        }
        
        // Инициализация сессию
        let session = URLSession(configuration: .default)
        
        // Создать запрос dataTask
        let task = session.dataTask(with: photoURL) { (data,response,error) in
            // Обработать полученные данные
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                // data = .jpeg
                self.imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    
}
