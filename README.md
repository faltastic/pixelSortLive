# pixelSortLive

 Pixel sorting on a collection of photo sets for live performances
 
![alt](https://raw.githubusercontent.com/faltastic/pixelSortLive/master/screenshots/main.jpg)

## What is this?

This sketch performs pixel sorting on a collection of photo sets. It was built to be used in live performances.
  
* It runs on [Processing](https://processing.org/) (2). 
* For the GUI, I use [controlP5](http://www.sojamo.de/libraries/controlP5/) which works ok on Processing 2 but not 3. 
* The sorting algorithim used is [this sketch](https://github.com/phillipdavidstearns/aYearInCode/blob/master/Processing%202.2.1/cellSort/cellSort.pde) written by Phillip Davis Stearns. 

## How to Use It?


Install the [controlP5 library](http://www.sojamo.de/libraries/controlP5/) and open the sketch in Processing 2.

To add your own photo sets, place them in the data folder and add them to photoSets at the top of the main sketch

```processing
String[] photoSets = {
 "cosmos", "desert"  //  , "more", "albums", "here"
};
```

Each photo set may contain **jpg** photos of any size but they must be named *poly0.jpg*, *poly1.jpg*, *poly2.jpg*, and so on.

That's it!

## Controls

![alt](https://raw.githubusercontent.com/faltastic/pixelSortLive/master/screenshots/gui.jpg)

Let's go through what the control window let's you do:

* Play = starts and stops the pixel sorting 
* Reload = restart the sorting on the current image


* Back/Next Image = goes back or forwards one image 
* No Flip = toggle flipping image in the photoset (default: on)


* Random Mode/Matrix = set a new random mode or matrix on the next image
* Sort speed = speed up the sorting effect by skipping 1-5 pixels 


* Sort Flip = flip the sorting thersholds 
* Wrap = toggle wrapping pixels on image edges on/off (default: on)


* Mode = choose between 6 sorting algorithims 
* Sort Matrix = the direction in which the sorting is to be done
* CLR = zeroes the current matrix


* Range = lower and upper brightness thersholds of which pixels to be sorted


* Frate = speed control, it really changes the sketch's framerate
* Flip Time = set how long it takes between image flips, the higher the value the slower the flip

* Overlay = set the hue and transparency of an overlay layer


* Shot = Take a screenshot of the display window and save it in TIFF format


* Albums = load another album

### Hidden Controls

You can control the size of the display window in the first line in the setup() function

```processing
 size(1080, 720);
```


## Thanks

To [Kareem Osman](https://vimeo.com/kafkube) for the help testing this code in the wild.

## License

MIT 2018

Basically, you can do whatever you want as long as you include the original copyright and license notice in any copy of the software/source. 

If you use this code in a live show or to make a video, I would love to hear from you. Email me at youssef.faltas@gmail.com 


