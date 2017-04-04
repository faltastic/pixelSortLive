
////////////////////////////
//   Conrol Window   ///////
////////////////////////////


ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  public void setup() {
    size(w, h);
    frameRate(25);
    fill(255);
    background(0);
    List l = java.util.Arrays.asList(photoSets);
    cp5 = new ControlP5(this);
    
    int y=0;
    y+=20;
    
    cp5.addToggle("PLAY")
      .plugTo(parent, "play")
        .setPosition(20, y).setSize(w/2 -25, 20);
    
    cp5.addBang("reload")
      .setLabel("REload").setPosition(w/2, y).setSize(w/2-25, 20);
    
    
    y+=50;

    cp5.addToggle("PauseFlip")
      .plugTo(parent, "pauseFlip")
        .setLabel("No Flip")
           .setPosition(20, y).setSize(40, 20); 
    cp5.addBang("nextImage")
      .setLabel("next image")
        .setPosition(w/2, y)
          .setSize(w/2-25, 20);
          
    
    
    y+=50;
    
    cp5.addToggle("Wrap")
      .plugTo(parent, "wrap")
        .setState(true)
          .setPosition(w/2, y).setSize(w/3, 20);
    cp5.addToggle("Sort Flip")
      .plugTo(parent, "logic")
        .setPosition(20, y).setSize(w/3, 20)
          .setMode(ControlP5.SWITCH);      
          
    
    
    y+=60;
    text("Mode", 20, y);
    y+=10;
    cp5.addRadioButton("changeMode")
      .setPosition(20, y).setSize(30, 20)
        .setColorLabel(color(255))
          .setItemsPerRow(3)
            .setSpacingColumn(30)

              .addItem("A", 0).addItem("B", 1).addItem("C", 2)
                .addItem("D", 3).addItem("E", 4).addItem("F", 5)
                  .activate(2)
                    ;
    y+=60;
    
    text("Sort Matrix", 20, y);
    y+=10;
    cp5.addCheckBox("sortMatrix")
      .setLabel("mode")
        .setPosition(20, y).setSize(40, 20)
          .setColorLabel(color(255))
            .setItemsPerRow(3)
              .setSpacingColumn(10)

                .addItem("1", 0).addItem("2", 0).addItem("3", 0)
                  .addItem("4", 0).addItem("5", 0).addItem("6", 0)
                    .addItem("7", 0).addItem("8", 0).addItem("9", 0)
                      ;
    y+=90;
    
    cp5.addRange("range")
      .setBroadcast(false) 
        .setPosition(20, y)
          .setSize(w-60, 20)
            .setHandleSize(10)
              .setRange(0, 255)
                .setRangeValues(20, 150)
                  .setBroadcast(true)
                    ;
    
    
    y+=50;
    cp5.addSlider("FRate")
      .plugTo(parent, "frameRate")
        .setRange(0.5, 40)
          .setValue(25)
            .setPosition(20, y)
              .setSize(w-60, 20)
                ;

    y+=30;
    cp5.addSlider("flipTime")
      .plugTo(parent, "flipSpeed")
        .setRange(2, 200)
          .setValue(30)
            .setPosition(20, y)
              .setSize(w/2, 20)
                ; 
    
    

   y+=60;
    Group g3 = cp5.addGroup("g3")
      .setLabel("Albums")
        .setPosition(20, y)
          .setSize(w-40, 100)
            .setBackgroundColor(color(50))
              ;


    cp5.addScrollableList("albumlist")
      .setPosition(10, 10)
        .setSize(130, 80)
          .setGroup(g3)

            .addItems(l)
              .setType(ScrollableList.DROPDOWN) 
                .setOpen(false);
  }


  public void albumlist(int n) {

    nSet =int(n);
    selectSet(nSet);
  }

  public void controlEvent(ControlEvent theEvent) {
    if (theEvent.isFrom("range")) {
      higher = ceil(theEvent.getController().getArrayValue(0));
      lower = ceil(theEvent.getController().getArrayValue(1));
    }
  }

  public void reload() { 
    loadSource();
  }
  public void nextImage() {
    nImg = (nImg+1)%totalImg;
    loadSource();
  }
  public void sortMatrix(float[] a) {
    rules[0][0] = boolean(floor(a[0])); 
    rules[0][1] = boolean(floor(a[1])); 
    rules[0][2] = boolean(floor(a[2]));
    rules[1][0] = boolean(floor(a[3])); 
    rules[1][1] = boolean(floor(a[4])); 
    rules[1][2] = boolean(floor(a[5]));
    rules[2][0] = boolean(floor(a[6])); 
    rules[2][1] = boolean(floor(a[7])); 
    rules[2][2] = boolean(floor(a[8]));
  }
  public void changeMode(int a) {
    mode = a;
  }
  public void draw() {

    // NOTHING //
  }


  public void keyPressed() {
    //println(keyCode);
    // keycode ref. at http://keycodes.atjayjo.com/

    // you can use the keyboard instead of the visual controls 
    // but the changes made won't reflect on the knobs and sliders 
    // in the control window

    switch(keyCode) {
    case 48:
      setRules();
      break;  
    case 49:
      rules[0][0] = !rules[0][0];
      break;
    case 50:
      rules[0][1] = !rules[0][1];
      break;
    case 51:
      rules[0][2] = !rules[0][2];
      break;
    case 52:
      rules[1][0] = !rules[1][0];
      break;
    case 53:
      rules[1][1] = !rules[1][1];
      break;
    case 54:
      rules[1][2] = !rules[1][2];
      break;
    case 55:
      rules[2][0] = !rules[2][0];
      break;
    case 56:
      rules[2][1] = !rules[2][1];
      break;
    case 57:
      rules[2][2] = !rules[2][2];
      break;

    case 82:
      loadSrcs(); 
      loadSource(); // r
      break;
    case 38: // up arrow
      higher++;
      println("low " +higher);
      break;
    case 40: // down arrow
      higher--;
      println("low " + higher);
      break;
    case 37: // up arrow
      lower--;
      println("high " +lower);
      break;
    case 39: // down arrow
      lower++;
      println("high " +lower);
      break;
    case 32: // space toggles animation
      play=!play;
      break;
    case 87: // w toggles edge wrap mode
      wrap=!wrap;
      break;
    case 65: // a toggles edge wrap mode
      mode=0;
      break;
    case 66: // b toggles edge wrap mode
      mode=1;
      break;
    case 67: // c toggles edge wrap mode
      mode=2;
      break;
    case 68: // d toggles edge wrap mode
      mode=3;
      break;
    case 69: // e toggles edge wrap mode
      mode=4;
      break;
    case 70: // f toggles edge wrap mode
      mode=5;
      break;

    case 91: // { slows down pixelsort
      if (frameRate>1) { 
        frameRate(frameRate -2); 
        println("fR = "+frameRate);
      }
      break;
    case 93: // } speeds up pixelsort
      if (frameRate<60) { 
        frameRate(frameRate +2);
        println("fR = "+frameRate);
      }
      break; 
    case 59: // ; slows down next image
      if (flipSpeed < 160) { 
        flipSpeed +=12; 
        println("Flip Speed = "+flipSpeed);
      }
      break;
    case 222: // ' speeds up next image 
      if (flipSpeed > 12) { 
        flipSpeed -=12; 
        println("Flip Speed = "+flipSpeed);
      }
      break;   
    case 78: // n loads next image
      nImg = (nImg+1)%totalImg;
      loadSource();
      break;
    case 76: // l pauses flip
      pauseFlip =!pauseFlip;
      break;
    case 77: // m loads next image set
      nSet = (nSet+1)%photoSets.length;
      selectSet(nSet);
      break;
    case 80:
      printFrame=!printFrame;
      printFNum=0;
      break;
    case 44:  // ,
      logic = 0;
      break;
    case 46: //.
      logic = 1;
      break;
    }
  }



  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }


  ControlP5 cp5;

  Object parent;
}

