//
//  AlbumViewController.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 24/07/22.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class AlbumViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let refreshControl = UIRefreshControl()
    
    private var albumViewModel : AlbumViewModel!
    private var albumPhotoViewModel: AlbumPhotoViewModel!
    private let bag = DisposeBag()
    private var realmAlbumDataViewModel : RealmAlbumDataViewModel!
    private var realmUserSessionViewModel : RealmUserSessionViewModel!
    
    var albums = [Album]()
    var albumPhotos = [AlbumPhoto]()
    var sections = [Section]()
    var sectionRealmData = [SectionRealm]()
    var sessionCount: Int?
    var sessionDate: Date?
    var sessionExist: Bool?
    
    let dataSource = Observable.just([AlbumPhoto].self)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        
        self.setUpLayout()
        self.collectionViewRefreshControl()
        self.loadCollectionViewData()
    }
    
    func setUpLayout() {
        
        let compositionalLayout: UICollectionViewCompositionalLayout = {
                
            let width = (UIScreen.main.bounds.width) - 10
            let height = (UIScreen.main.bounds.width / 3) - 10
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let columns = 3
            let groupHeight = NSCollectionLayoutDimension.absolute(height)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous

            // after section delcaration…
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .estimated(50))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            section.boundarySupplementaryItems = [headerItem]
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }()
        
        self.collectionView.collectionViewLayout = compositionalLayout
    }
    
    func collectionViewRefreshControl() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh data")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        //Setup pull to refresh
        if #available(iOS 10.0, *) {
            self.collectionView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
            self.collectionView.addSubview(refreshControl)
        }
    }
    
    func loadCollectionViewData() {
        
        self.realmUserSessionViewModel =  RealmUserSessionViewModel()
        self.sessionCount = self.realmUserSessionViewModel.sessionCount
        self.sessionDate = self.realmUserSessionViewModel.sessionDate
        self.sessionExist = self.realmUserSessionViewModel.sessionExist
        
        if self.sessionExist! {
            
            let calendar = Calendar.current
            let savedComponents = calendar.dateComponents([.year, .month, .day], from: self.sessionDate!)
            let savedDate = calendar.date(from: savedComponents)
            
            let components = calendar.dateComponents([.year, .month, .day], from: Date())
            let currentDate = calendar.date(from: components)
            
            let elapsed = Calendar.current.dateComponents([.day], from: savedDate!, to: currentDate!).day ?? 0
            
            /*print("sessionDate After Update: \(self.sessionDate!)")
            print("sessionCount After Update: \(self.sessionCount!)")
            print("elapsed After Update: \(elapsed)")*/

            if elapsed == 0 { // in current date
            
                if self.sessionCount! >= 1 {
                    
                    print("Pulling from local storage")
                    bindCollectionView(source: "local")
                } else {
                    
                    print("Calling API in same Day")
                    if Reachability.isConnectedToNetwork(){
                        bindCollectionView(source: "remote")
                        self.getAlbumTitle()
                    }else{
                        print("Internet Connection not Available!")
                    }
                }
            } else {
                
                print("Calling API First time in the Other Day")
                if Reachability.isConnectedToNetwork(){
                    bindCollectionView(source: "remote")
                    self.getAlbumTitle()
                }else{
                    print("Internet Connection not Available!")
                }
            }
        } else {
            
            print("Calling API First time.")
            if Reachability.isConnectedToNetwork(){
                bindCollectionView(source: "remote")
                self.getAlbumTitle()
            }else{
                print("Internet Connection not Available!")
            }
        }
    }
    
    func bindCollectionView(source: String) {
        
        if source == "local" {
            
            self.realmAlbumDataViewModel =  RealmAlbumDataViewModel()
            let dataSource = realmAlbumDataViewModel.collectionViewDataSource()
            
            self.realmAlbumDataViewModel.sectionObservable.bind(to: collectionView.rx.items(dataSource: dataSource))
                            .disposed(by: bag)
            self.realmAlbumDataViewModel.getRealmAlbumData()
        } else {
            self.albumPhotoViewModel =  AlbumPhotoViewModel()
            let dataSource = albumPhotoViewModel.collectionViewDataSource()
            
            self.albumPhotoViewModel.sectionObservable.bind(to: collectionView.rx.items(dataSource: dataSource))
                            .disposed(by: bag)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        SectionCount.shareInstance.sectionCount = 1
        self.getAlbumTitle()
    }
    
    func getAlbumTitle() {
        
        self.albumViewModel =  AlbumViewModel()
        self.albumViewModel.bindAlbumViewModelToController = {
            
            self.albums = self.albumViewModel.albums
            
            if self.albums.count > 0 {
                
                self.getAlbumPhotos()
            }
        }
    }
    
    func getAlbumPhotos() {
        
        var arraySectionRealm = [SectionRealm]()
        self.sections = [Section]()
        self.albumPhotoViewModel = AlbumPhotoViewModel()
        self.albumPhotoViewModel.getAlbumPhotos(albums: self.albums)
        
        self.albumPhotoViewModel.bindAlbumPhotoViewModelToController = {
            
            self.albumPhotos = self.albumPhotoViewModel.albumPhotos
            self.sections = self.albumPhotoViewModel.sections
            
            dump(self.albumPhotos)
            
            if self.albums.count == SectionCount.shareInstance.sectionCount {
                
                if self.refreshControl.isRefreshing {
                    
                    self.refreshControl.endRefreshing()
                }
                
                // synchronize realm database
                if self.sections.count > 0 {
                    
                    for section in self.sections {
                        
                        let albumTitle = section.albumTitle
                        let photos = section.items
                        
                        var albumPhotoArray = [AlbumPhotoRealm]()
                        for photo in photos {
                            
                            let albumPhoto = AlbumPhotoRealm.create(withAlbumId: photo.albumId, withId: photo.id, withTitle: photo.title, withUrl: photo.url, withThumbnailUrl: photo.thumbnailUrl)
                            albumPhotoArray.append(albumPhoto)
                        }
                        
                        let sectionRealm = SectionRealm.create(withAlbumTitle: albumTitle, withAlbumPhotos: albumPhotoArray)
                        
                        arraySectionRealm.append(sectionRealm)
                    }
                    
                    self.realmAlbumDataViewModel =  RealmAlbumDataViewModel()
                    self.realmAlbumDataViewModel.saveRealmAlbumData(with: arraySectionRealm)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
