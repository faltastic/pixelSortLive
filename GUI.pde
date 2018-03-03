
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
    y+=10;
    
    cp5.addToggle("PLAY")
      .plugTo(parent, "play")
        .setPosition(20, y).setSize( (w-60)/2, 20);
    
    cp5.addBang("reload")
      .setLabel("REload").setPosition((w-60)/2 + 40, y).setSize(( w-60)/2, 20);
    
    
    y+=40;
    
    cp5.addBang("backImage")
      .setLabel("back")
        .setPosition(20, y)
          .setSize(w/4, 20);
          
     cp5.addBang("nextImage")
      .setLabel("next image")
        .setPosition(40+w/4, y)
          .setSize(3*w/4-60 , 20);
          
    y+=40;

    cp5.addToggle("PauseFlip")
      .plugTo(parent, "pauseFlip")
        .setLabel("No Flip")
           .setPosition(20, y).setSize(40, 20); 
    
    cp5.addToggle("randomMode")
      .plugTo(parent, "randomMode")
        .setLabel("rnd mode")
           .setPosition(80, y).setSize(40, 20); 
    
    cp5.addToggle("randomMatrix")
      .plugTo(parent, "randomMatrix")
        .setLabel("rnd matrix")
           .setPosition(140, y).setSize(40, 20); 
           
    y+=45;      
    cp5.addSlider("Sort Speed")
    .plugTo(parent, "sortSpeed")
     .setPosition(20,y)
     .setSize(w/2,15)
     .setRange(1,5)
     .setValue(1)
     .setNumberOfTickMarks(5)
     ;        

    y+=35;
    
    cp5.addToggle("Wrap")
      .plugTo(parent, "wrap")
        .setState(true)
          .setPosition(w/2, y).setSize(w/3, 20);
    cp5.addToggle("Sort Flip")
      .plugTo(parent, "logic")
        .setPosition(20, y).setSize(w/3, 20)
          .setMode(ControlP5.SWITCH);  
          
   
    
    y+=50;
    text("Mode", 20, y);
    y+=10;
    cp5.addRadioButton("changeMode")
    //.plugTo(parent, "mode")
      .setPosition(20, y).setSize(30, 20)
        .setColorLabel(color(255))
          .setItemsPerRow(3)
            .setSpacingColumn(20)

              .addItem("A", 0).addItem("B", 1).addItem("C", 2)
                .addItem("D", 3).addItem("E", 4).addItem("F", 5)
                  .activate(2)
                    ;
    y+=70;
    
    text("Sort Matrix", 20, y);
    
    y-=15;
    cp5.addBang("clearMatrix")
        .setCaptionLabel("CLR")
           .setPosition(w-60, y).setSize(10, 10); 
    y+=25;
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
    y+=80;
    
    cp5.addRange("range")
      .setBroadcast(false) 
        .setPosition(20, y)
          .setSize(w-60, 20)
            .setHandleSize(10)
              .setRange(0, 255)
                .setRangeValues(20, 150)
                  .setBroadcast(true)
                    ;
     
    y+=30;
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
   
      y+=50;
      Group g1 = cp5.addGroup("g1")
      .setLabel("overlay")
        .setPosition(20, y)
          .setSize(w-40, 30)
            .setBackgroundColor(color(100))
              ;
       cp5.addSlider("hue")
      .plugTo(parent, "overlayHue")
        .setRange(0, 255)
          .setValue(0)
            .setPosition(0, 10)
              .setSize(60, 10)
              .setGroup(g1)
                ;  
      cp5.addSlider("alpha")
      .plugTo(parent, "overlayAlpha")
        .setRange(0, 255)
          .setValue(255)
            .setPosition(80, 10)
              .setSize(50, 10)
              .setGroup(g1)
                ;  

  
  y+=50;
   cp5.addBang("shot")
      .setLabel("shot")
        .setPosition(20, y)
        .setSize(w-40, 20);
       
    y+=50;
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
  
  public void clearMatrix() { 
    setRules();
  }
  
  public void reload() { 
    loadSource();
  }
  
  public void nextImage() {
    nImg = (nImg+1)%totalImg;
    loadSource(); 
  }
  
  public void backImage() {
    nImg = (nImg-1)%totalImg;
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
  
  public void shot(){
    printFrame=true;
    println("shot");
  }


  public void draw() {
    // NOTHING //
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

