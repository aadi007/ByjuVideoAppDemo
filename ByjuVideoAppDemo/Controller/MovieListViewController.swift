//
//  MovieListViewController.swift
//  ByjuVideoAppDemo
//
//  Created by Aadesh Maheshwari on 30/11/15.
//  Copyright © 2015 @@DI007. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData

class MovieListViewController: UITableViewController {

    private let videoDataCellIdentifier = "VideoDataCellIdentifier"
    var movies = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if the local storage has the data present in the DB to be shown 
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Video")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            movies = results as! [NSManagedObject]
            if movies.count == 0 {
                print("fetch the contents from the list and store it")
                fetchVideoData()
            } else {
                self.title = "\(movies.count) movies"
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func fetchVideoData() {
        Alamofire.request(Router.UtilRouteManager(UtilRouter.GetMoviewData())).responseJSON { ( response) in
            if response.result.isSuccess {
                let jsonObj = JSON(response.result.value!)
                if let resultArray = jsonObj["results"].array {
                    for subjson:JSON in resultArray {
                        let video = VideoModel(json: subjson)
                        self.saveVideoData(video)
                    }
                }
                print("movies data \(self.movies)")
                if self.movies.count > 0 {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
            }
            else {
                print("Error \(response.response?.statusCode) message \(response.response?.debugDescription) ")
            }
        }
    }
    
    func saveVideoData(videoData: VideoModel) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Video",
            inManagedObjectContext:managedContext)
        
        let video = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        if let name = videoData.trackName {
            video.setValue(name, forKey: "name")
        }
        if let longDescription = videoData.longDescription {
            video.setValue(longDescription, forKey: "long_description")
        }
        if let URL = videoData.thumbnailURL {
            video.setValue(URL, forKey: "thumbnail_url")
        }
        
        do {
            try managedContext.save()
            movies.append(video)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let video = movies[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(videoDataCellIdentifier, forIndexPath: indexPath) as! MovieDataViewCell
        if let name = video.valueForKey("name") as? String {
            cell.titleLabel.text = name
        }
        if let descrip = video.valueForKey("long_description") as? String {
            cell.descriptionLabel.text = descrip
        }
        if let thumbnailURL = video.valueForKey("thumbnail_url") as? String {
            cell.thumbnailImageView.sd_setImageWithURL(NSURL(string: thumbnailURL)!)
        }
        return cell
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 43 + labelHeightForRowAtIndexPath(indexPath)
    }
    
    func labelHeightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        let video = movies[indexPath.row]

        let calculationTitleView = UILabel()
        calculationTitleView.numberOfLines = 0
        let labelAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(16), NSForegroundColorAttributeName : UIColor.blackColor()]
        calculationTitleView.attributedText = NSAttributedString(string: video.valueForKey("name") as! String, attributes: labelAttributes)
        let labelViewWidth:CGFloat = CGRectGetWidth(self.view.frame) - 70
        let titlesize:CGSize = calculationTitleView.sizeThatFits(CGSizeMake(labelViewWidth, 900))
        print("titlesize \(titlesize.height)")
        
        let calculationView = UILabel()
        calculationView.numberOfLines = 0
        let attributes = [NSFontAttributeName : UIFont.systemFontOfSize(12), NSForegroundColorAttributeName : UIColor.blackColor()]
        calculationView.attributedText = NSAttributedString(string: video.valueForKey("long_description") as! String, attributes: attributes)
        let textViewWidth:CGFloat = CGRectGetWidth(self.view.frame) - 127.5
        let size:CGSize = calculationView.sizeThatFits(CGSizeMake(textViewWidth, 900))
        return size.height + titlesize.height
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
