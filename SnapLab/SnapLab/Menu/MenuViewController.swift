import UIKit
import SnapKit
import AlamofireImage


class MenuViewController: UIViewController {
    
    let snapLabLabel = UILabel()
    let uploadPhotoFromTheLibraryButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        customizeUI()
        addSubview()
        makeConstrains()
        targetActions()
    }
    
    private func customizeUI() {
        
        view.backgroundColor = UIColor(rgb: 0x050A26)
        
        snapLabLabel.text = "SnapLab"
        snapLabLabel.font = UIFont(name: "Lobster-Regular", size: 60)
        snapLabLabel.textColor = UIColor.white
        

        uploadPhotoFromTheLibraryButton.setTitle("Загрузить фото из библиотеки", for: .normal)
        uploadPhotoFromTheLibraryButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        uploadPhotoFromTheLibraryButton.setTitleColor(UIColor(rgb: 0x050A26), for: .normal)
        uploadPhotoFromTheLibraryButton.backgroundColor = UIColor.white
        uploadPhotoFromTheLibraryButton.layer.cornerRadius = 10
        
        
    }
    private func addSubview() {
        let labels = [snapLabLabel]
        let buttons = [uploadPhotoFromTheLibraryButton]
        
        for label in labels {
            view.addSubview(label)
        }
        
        for button in buttons {
            view.addSubview(button)
        }
        
    }
    private func makeConstrains() {
        snapLabLabel.snp.makeConstraints { make in
            make.centerX.equalTo(uploadPhotoFromTheLibraryButton)
            make.top.equalToSuperview().inset(100)
        }
        uploadPhotoFromTheLibraryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
    }
    private func targetActions(){
        uploadPhotoFromTheLibraryButton.addTarget(self, action: #selector(editorShowButton), for: .touchUpInside)
    }
    @objc func editorShowButton() {
        let editorViewController = EditorViewController()
        navigationController?.pushViewController(editorViewController, animated: true)
    }

}


