## Synopsis

This is an example to show how to do a simple search to an OLX service.
The project is based on SwiftyJSON, AlamofireImage and Alamofire libraries.

The application looks something like this:

###Empty field validation:
![Empty field gif](https://raw.githubusercontent.com/loucimj/SearchOLX/master/gifs/empty_field.gif)


###Search results screen:
![Search gif](https://raw.githubusercontent.com/loucimj/SearchOLX/master/gifs/search.gif)

## Architecture

The application is intended to use Protocols to implement most of the logic needed for it.

Protocol **NetworkRequester** implements the functions that can be reused on any service to provide **Request** building and configuration, as also response validation, to cover possible problems from the backend, as responses that are not JSON, possible HTTP errors and responses that are not OK from the server.

As an example you can check the **Service** class that implements and uses that Protocol.

Other Protocols are used to implement business logic, such as **SearchLogic** that encapsulates the tasks to instantiate the Service and process its responses, making it easier to for the ViewControllers (as **ListingTableViewController**) to override the Protocol default implementations to handle data arrival and error handling.

## Installation

Download the repository from github and make sure you install the pod libraries using `pod install`

## License

All code here is under [MIT license](https://opensource.org/licenses/MIT)
