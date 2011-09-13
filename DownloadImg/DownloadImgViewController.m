
#import "DownloadImgViewController.h"

@interface DownloadImgViewController()
@property (nonatomic, retain) NSMutableData *recvData;
@property (nonatomic, retain) UIImageView *imgView;
@end

@implementation DownloadImgViewController
@synthesize imgView;
@synthesize recvData;

- (void)dealloc {
    [imgView release];
    
    if (recvData != nil) {
        [recvData release];
    }
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *sURL = @"https://lh3.googleusercontent.com/-aqQqmBTDerQ/Tm9jsxkIExI/AAAAAAAABo0/nYb8aZeHa7w/s800/background%2525402x.png";
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:sURL]
                                                  cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData 
                                              timeoutInterval:5.0f];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request 
                                                                  delegate:self];
    [connection start];
    [request release];
    
    //create imageView only when valid connection status
    if (connection) {
        self.imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(10,10,200,300);
        [self.view addSubview:imgView];
        
        self.recvData = [NSMutableData data];
    } else {
        //output error
        NSLog(@"Bad Connection!");
    }
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// TODO
    
    // Append the new data to recvData.
    [recvData appendData:data];
    NSLog(@"Appending... %d", [recvData length]);
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// TODO
    
    [recvData setLength:0];
    NSLog(@"Succeeded! didReceiveResponse: %d", [recvData length]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// TODO
	
    // recvData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[recvData length]);
    
    //create image from data and set it to ImageView
    UIImage *image = [[UIImage alloc] initWithData:recvData];
    [imgView setImage:image];
    [image release];

    // release the connection, and the data object
    [connection release];
    [recvData release];
    recvData = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// TODO
    
	
    // release the connection, and the data object
    [connection release];
    [recvData release];
    recvData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);	

}


@end
