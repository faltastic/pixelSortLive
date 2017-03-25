# pixelSortLive

 Pixel sorting on a collection of photo sets for live performances
 
(https://raw.githubusercontent.com/faltastic/pixelSortLive/master/screenshots/main.jpg)

 ### What is this?
This sketch performs pixel sorting on a collection of photo sets. It was built to be used in live performances.
  
* It runs on [Processing](https://processing.org/). 
* For the GUI, I use [controlP5](http://www.sojamo.de/libraries/controlP5/) which works ok on Processing 2 but not 3. 
* The sorting algorithim used is [this sketch](https://github.com/phillipdavidstearns/aYearInCode/blob/master/Processing%202.2.1/cellSort/cellSort.pde) written by Phillip Davis Stearns. 

## How to Use It?

To add your own photo sets, place them in the data folder and add their names to the photoSets string array at the top of the main sketch

```processing
String[] photoSets = {
 "cosmos", "desert"  //  , "more", "albums", "here"
};
```

Each photo set may contain **jpg** photos of any size but they must be named *poly0.jpg*, *poly1.jpg*, *poly2.jpg*, and so on.

That's it!

## Controls


## License

MIT

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

