//
//  TableAndChartController.swift
//  chart
//
//  Created by Nikolay Eckert on 18/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import UIKit
import Alamofire


class TableAndChartController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tablePoints: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var chartView: ChartView!
    
    let cellReuseIdentifier = "cell"
    
    private var _points: [CoordinateString] = []
    var points: [CoordinateString] {
        get { return _points }
        set { _points = newValue }
    }
    
    
    @IBAction func saveChartButton(_ sender: UIBarButtonItem) {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            self.chartView.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        let selector = #selector(image(_:didFinishSavingWithError:contextInfo:))
        UIImageWriteToSavedPhotosAlbum(image, self, selector, nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "X / Y"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) -> Void {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tablePoints.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        let index = indexPath.row
        cell.textLabel?.text = "\(points[index].x) / \(points[index].y)"
        cell.textLabel?.textAlignment = .center
        
        return cell
    }

    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    private func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private func scrollViewContentSizeChange() {
        if UIDevice.current.orientation.isLandscape {
            self.scrollView.contentSize = CGSize(width: 100, height: 1050)
        } else {
            self.scrollView.contentSize = CGSize(width: 100, height: 100)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.scrollViewContentSizeChange()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollViewContentSizeChange()
        
        self.tablePoints.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tablePoints.delegate = self
        self.tablePoints.dataSource = self
        
        ChartViewService.coordinates = self.points
    }
}
