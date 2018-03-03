
// using Phillip Davis Stearns' cell sort sketch at

// https://github.com/phillipdavidstearns/aYearInCode/blob/master/Processing%202.2.1/cellSort/cellSort.pde


int[] swapPixels(int[] _pixelArray, int _index1, int _index2) {
  int buffer = _pixelArray[_index1];
  _pixelArray[_index1] = _pixelArray[_index2];
  _pixelArray[_index2] = buffer;
  return _pixelArray;
}

PImage cellSort(PImage _image) {
  _image.loadPixels();
  int swap_x = 0;
  int swap_y = 0;
  int neighbor_x = 0;
  int neighbor_y = 0;

  for (int y = 0; y < _image.height; y++) {
    for (int x = 0; x < _image.width; x++) {
      
      
      swap_x = x;
      swap_y = y;
      for (int ny = 0; ny < 3; ny++ ) {
        for (int nx = 0; nx < 3; nx++) {
          if (rules[ny][nx] /*&& (nx != 1 && ny != 1)*/) {
            
            if (!wrap) {
              neighbor_x = x + sortSpeed*(nx-1);
              neighbor_y = y + sortSpeed*(ny-1);
            } else {
              neighbor_x = (_image.width + x + sortSpeed*(nx-1)) % _image.width;
              neighbor_y = (_image.height + y + sortSpeed*(ny-1)) % _image.height;
            }
            if (coordinateInBounds(_image, neighbor_x, neighbor_y)) {
              if (evalPixels(_image, neighbor_x, neighbor_y, swap_x, swap_y, logic)) {
                switch(mode) {
                case 0:
                  if (_image.pixels[y*_image.width+x] < color(lower) && _image.pixels[y*_image.width+x] > color(higher)) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 1:
                  if (_image.pixels[neighbor_y*_image.width+neighbor_x] < color(lower) && _image.pixels[neighbor_y*_image.width+neighbor_x] > color(higher)) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 2:
                  if (_image.pixels[swap_y*_image.width+swap_x] < color(lower) && _image.pixels[swap_y*_image.width+swap_x] > color(higher)) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 3:
                  if (!(_image.pixels[y*_image.width+x] < color(lower) && _image.pixels[y*_image.width+x] > color(higher))) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 4:
                  if (!(_image.pixels[neighbor_y*_image.width+neighbor_x] < color(lower) && _image.pixels[neighbor_y*_image.width+neighbor_x] > color(higher))) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 5:
                  if (!(_image.pixels[swap_y*_image.width+swap_x] < color(lower) && _image.pixels[swap_y*_image.width+swap_x] > color(higher))) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                }
              }
            }
          }
        }
      }
    
      if (!(swap_x == x && swap_y == y)) {
        _image.pixels = swapPixels(_image.pixels, y*_image.width+x, swap_y*_image.width+swap_x);
      }
    }
  }
  _image.updatePixels();
  return _image;
}

boolean evalPixels(PImage _image, int x1, int y1, int x2, int y2, int logic) {
  boolean output = false;

  switch(logic) {
  case 0:
    output = _image.pixels[y1*_image.width+x1] < _image.pixels[y2*_image.width+x2];
    break;
  case 1:
    output =  _image.pixels[y1*_image.width+x1] > _image.pixels[y2*_image.width+x2];
    break;
  }
  return output;
}

boolean coordinateInBounds(PImage _image, int x, int y) {
  return x >= 0 && x < _image.width && y >= 0 && y < _image.height;
}


boolean pixelWithinWindow(PImage _image, int x, int y, int lower, int higher) {
  return _image.pixels[y*_image.width+x] < color(lower) && _image.pixels[y*_image.width+x] > color(higher);
}


PImage cellSortFix2(PImage _image) {
  int swap_x = 0;
  int swap_y = 0;
  int neighbor_x = 0;
  int neighbor_y = 0;

  //for (int x = _image.width; x > 0; x=x-1) {
  // for (int y = _image.height; ; y > 0 ; y=y-1) {
  for (int y = 0; y < _image.height; y++) {
    for (int x = 0; x < _image.width; x++) {


      swap_x = x;
      swap_y = y;
      for (int ny = 0; ny < 3; ny++ ) {
        for (int nx = 0; nx < 3; nx++) {
          if (rules[ny][nx] && !(nx == 1 && ny == 1)) {
            //            if (!wrap) {
            //              neighbor_x = x + (nx-1);
            //              neighbor_y = y + (ny-1);
            //            } else {
            neighbor_x = (_image.width + x  + (nx-1)) % _image.width;
            neighbor_y = (_image.height + y + (ny-1)) % _image.height;
            //   }
            if (coordinateInBounds(_image, neighbor_x, neighbor_y)) {
              if (evalPixels(_image, neighbor_x, neighbor_y, swap_x, swap_y, logic)) {
                switch(mode) {
                case 0:
                  if (_image.pixels[y*_image.width+x] < color(lower) && _image.pixels[y*_image.width+x] > color(higher)) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 1:
                  if (_image.pixels[neighbor_y*_image.width+neighbor_x] < color(lower) && _image.pixels[neighbor_y*_image.width+neighbor_x] > color(higher)) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 2:
                  if (_image.pixels[swap_y*_image.width+swap_x] < color(lower) && _image.pixels[swap_y*_image.width+swap_x] > color(higher)) {
                    // if (_image.pixels[swap_y*_image.width+swap_x] < color(lower) && _image.pixels[swap_y*_image.width+swap_x] > color(higher)) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 3:
                  if (!(_image.pixels[y*_image.width+x] < color(lower) && _image.pixels[y*_image.width+x] > color(higher))) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 4:
                  if (!(_image.pixels[neighbor_y*_image.width+neighbor_x] < color(lower) && _image.pixels[neighbor_y*_image.width+neighbor_x] > color(higher))) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                case 5:
                  if (!(_image.pixels[swap_y*_image.width+swap_x] < color(lower) && _image.pixels[swap_y*_image.width+swap_x] > color(higher))) {
                    swap_x = neighbor_x;
                    swap_y = neighbor_y;
                  }
                  break;
                }
              }
            }
          }
        }
      }
      if (!(swap_x == x && swap_y == y)) {
        _image.pixels = swapPixels(_image.pixels, y*_image.width+x, swap_y*_image.width+swap_x);
        //   _image.pixels = swapPixels(_image.pixels, swap_y*_image.width+swap_x, y*_image.width+x);
      }
    }
  }
  return _image;
}

PImage cellSortMove(PImage _image) {
  
   _image.loadPixels();
  
  int swap_x = 0;
  int swap_y = 0;
  
  int neighbor_x = 0;
  int neighbor_y = 0;

  for (int y = 0; y < _image.height; y++) {
    for (int x = 0; x < _image.width; x++) {
      
      swap_x = x;
      swap_y = y;
          
      neighbor_x = x+1;   // % _image.width;
      neighbor_y = y;     // (_image.height + y ) % _image.height;
      
      if (coordinateInBounds(_image, neighbor_x, neighbor_y)) {
        
        swap_x = neighbor_x;
        swap_y = neighbor_y;
        
        if ( !(swap_x == x && swap_y == y) ) {  
          _image.pixels = swapPixels(_image.pixels, y*_image.width+x, swap_y*_image.width+swap_x);
        }
        
      }
      
    }
  }
_image.updatePixels();
return _image;

}
