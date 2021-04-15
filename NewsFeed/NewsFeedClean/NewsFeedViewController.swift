//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Александр on 15.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCodeCellDelegate {
    
    

    

  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?

    private var feedViewModel = FeedViewModel.init(cells: [])
    
    @IBOutlet weak var table: UITableView!
     
    
    private var titleView = TitleView()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refrash), for: .valueChanged)
        
        return refreshControl
    }()
    
    
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setUpTopBars()
    setUpTable()
    
    view.backgroundColor = #colorLiteral(red: 0.2335635424, green: 0.4358375371, blue: 0.6482918859, alpha: 1)
    
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getUser)
  }
    
    
    private func setUpTable() {
        let topInsert: CGFloat = 8
        table.contentInset.top = topInsert 
    
        
        table.register( UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
        table.register(NewsFeedCodCell.self, forCellReuseIdentifier: NewsFeedCodCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.addSubview(refreshControl)
    }
    
    
    private func setUpTopBars() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
        
    }
    
    @objc private func refrash() {
      
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
        
    }
    
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
    
    switch viewModel {

    case .displayNewsFeed(feed: let feed ):
        self.feedViewModel = feed
        print("//")
        table.reloadData()
        refreshControl.endRefreshing()
        
    case .displayUser(userViewModel: let userViewModel):
        titleView.set(userViewModel: userViewModel)
    }

  }
    
    // MARK: NewsFeedCodeCellDelegate
    
    func revealPost(for cell: NewsFeedCodCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.revealPostId(postId: cellViewModel.postId))
       
    }
  
}

extension NewsFeedViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId , for: indexPath) as! NewsFeedCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodCell.reuseId, for: indexPath) as! NewsFeedCodCell

        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
   
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}
