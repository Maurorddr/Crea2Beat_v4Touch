class Boton {

  boolean on;
  int beat;
  int chan;
  PVector location; 
  float xunit = (width / 24.0);
  float yunit = (height / 24.0);
  float w = 0.8*xunit;
  float h = 0.8*yunit;
  float radii = (0.3*xunit);
  PImage btImg = null;

  Boton(PVector _loc, int _beat, int _chan) {
    location = _loc.copy();
    beat = _beat;
    chan = _chan;    
    on = false;
  }

  Boton(PVector _loc, int _beat, int _chan, PImage _btImg) {
    location = _loc.copy();
    beat = _beat;
    chan = _chan;
    on = false;
    btImg = _btImg;
  }

  void draw() {


    if (on) {

      if (btImg != null) {
        //tint(127, 85, 40, 175);
        image(btImg, location.x+(0.1*xunit), location.y+(0.1*yunit), w, h);
      } else {
        fill(127, 85, 40, 175);
        rect(location.x+(0.1*xunit), location.y+(0.1*yunit), w, h, radii);
      }
    } else {

      if (btImg != null) {
        //tint(85, 40, 127, 175);
        image(btImg, location.x+(0.1*xunit), location.y+(0.1*yunit), w, h);
      } else {
        fill(85, 40, 127, 175);
        rect(location.x+(0.1*xunit), location.y+(0.1*yunit), w, h, radii);
      }
    }
  }

  void select() {
    if ((mouseX-location.x) < w && (mouseX-location.x) > 0  && (mouseY-location.y) < h && (mouseY-location.y) > 0) {
      on = !on;
    }
  }
};
