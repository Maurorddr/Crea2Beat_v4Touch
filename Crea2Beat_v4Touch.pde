/**
 * Example of using a CountdownTimer with it's basic functions.
 */

import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;
import themidibus.*; //Import the library
import gifAnimation.*;

CountdownTimer timer;
String timerCallbackInfo = "";

Boton[][] bts = new Boton[16][8];

Gif loopingGif;

MidiBus myBus; // The MidiBus
int pos = 0;
float xunit;
float yunit;
float radii;
boolean touch = false;
PImage btImg;
PImage backgroundImg;
PImage play;
PImage stop;
PImage pause;
PImage clear;

PImage chan1;
PImage chan2;
PImage chan3;
PImage chan4;
PImage chan5;
PImage chan6;
PImage chan7;
PImage chan8;

Boton btPlay;
Boton btStop;
Boton btPause;
Boton btClear;

void setup() {
  size(displayWidth, displayHeight);
  xunit = width/24;
  yunit = height/24;
  radii = 0.3*xunit;
  // create and start a timer that has been configured to trigger onTickEvents every 100 ms and run for 5000 ms
  timer = CountdownTimerService.getNewCountdownTimer(this).configure(200, 5000000);
  //timer = CountdownTimerService.getNewCountdownTimer(this).configure(100, 5000).start();
  MidiBus.list();
  myBus = new MidiBus(this, -1, "Bus 1"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  loopingGif = new Gif(this, "lavalamp.gif");
  loopingGif.loop();
  btImg = loadImage("Hover_M.png");
  backgroundImg = loadImage("12.png");
  play = loadImage("play.png");
  stop = loadImage("stop.png");
  pause = loadImage("pause2.png");
  clear = loadImage("Plane.png");
  
  chan1 = loadImage("drum.png");
  chan2 = loadImage("drum.png");
  chan3 = loadImage("drum.png");
  chan4 = loadImage("drum.png");
  chan5 = loadImage("drum.png");
  chan6 = loadImage("drum.png");
  chan7 = loadImage("drum.png");
  chan8 = loadImage("drum.png");

  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 16; x++) {
      bts[x][y] = new Boton(new PVector((xunit*4)+(x*xunit), (yunit*14)+(y*yunit)), x, y);
    }
  }

  btPlay = new Boton(new PVector(10 * xunit, (0.1*yunit) + (22 * yunit)), 0, 0);
  btStop = new Boton(new PVector(11 * xunit + (0.65*xunit), (0.25*yunit) + 22 * yunit), 0, 0);
  btPause = new Boton(new PVector(12 * xunit + (xunit), (0.1*yunit) + 22 * yunit), 0, 0);
  btClear = new Boton(new PVector(20 * xunit + (xunit), (0.1*yunit) + 14 * yunit), 0, 0);
}

void draw() {
  image(backgroundImg, 0, 0, width, height);
  fill(255);
  textAlign(LEFT, TOP);

  // show the status of the timer
  text("timer.isRunning():" + timer.isRunning(), 15, 10);
  text("timer.isPaused():" + timer.isPaused(), 15, 25);
  text("tickInterval=" + timer.getTickInterval() + ", timerDuration=" + timer.getTimerDuration(), 15, 40);
  text("pos" + pos, 15, 55);
  text("touch" + touch, 15, 70);

  // show the info of event callbacks
  textAlign(CENTER, CENTER);
  text(timerCallbackInfo, width/2, height/2);

  image(loopingGif, xunit*11, yunit*3, loopingGif.width*2, loopingGif.height*2);
  
  image(chan1, 3*xunit, yunit*14, xunit, yunit);
  image(chan2, 3*xunit, yunit*15, xunit, yunit);
  image(chan3, 3*xunit, yunit*16, xunit, yunit);
  image(chan4, 3*xunit, yunit*17, xunit, yunit);
  image(chan5, 3*xunit, yunit*18, xunit, yunit);
  image(chan6, 3*xunit, yunit*19, xunit, yunit);
  image(chan7, 3*xunit, yunit*20, xunit, yunit);
  image(chan8, 3*xunit, yunit*21, xunit, yunit);

  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 16; x++) {
      //bts[x][y].update();
      Boton tmp = bts[x][y];
      if ( x == pos ) {
        noStroke();
        fill(255, 30, 230, 100);
        rect(bts[pos][y].location.x, bts[pos][y].location.y, xunit, yunit, radii);
      }
      tmp.draw();
    }
  }

  //--------
  handlePlay();
  //--------
  handleStop();
  //--------
  handlePause();
  //--------
  handleClear();
}

//------------------------------------------------------------------------------------
void handlePlay() {
  fill(255);
  rect(10 * xunit, (0.1*yunit) + 22 * yunit, xunit, yunit, 0.3*xunit);
  image(play, 10 * xunit, (0.2*yunit) + 22 * yunit, xunit, 0.8*yunit);
  if (btPlay.on) {
    println("Starting timer...");
    timer.start();
    btPlay.on = false;
  }
}

//------------------------------------------------------------------------------------
void handleStop() {
  fill(255);
  rect(11 * xunit+(0.5*xunit), (0.1*yunit) + 22 * yunit, xunit, yunit, 0.3*xunit);
  image(stop, 11 * xunit+(0.65*xunit), (0.25*yunit) + 22 * yunit, 0.7*xunit, 0.7*yunit);
  if (btStop.on) {
    println("Stopping timer...");
    timer.stop(CountdownTimer.StopBehavior.STOP_IMMEDIATELY);
    println("Resetting timer...");
    timer.reset(CountdownTimer.StopBehavior.STOP_IMMEDIATELY);
    btStop.on = false;
    pos = 0;
  }
}

//------------------------------------------------------------------------------------
void handlePause() {
  fill(255);
  rect(12 * xunit+(xunit), (0.1*yunit) + 22 * yunit, xunit, yunit, 0.3*xunit);
  image(pause, 12 * xunit+(xunit), (0.1*yunit) + 22 * yunit, xunit, yunit);
  if (btPause.on) {
    println("Stopping timer...");
    timer.stop(CountdownTimer.StopBehavior.STOP_IMMEDIATELY);
    btPause.on = false;
  }
}

//------------------------------------------------------------------------------------
void handleClear() {
  fill(255);
  rect(20 * xunit + (xunit), (0.1*yunit) + 14 * yunit, xunit, yunit, 0.3*xunit);
  image(clear, 20 * xunit + (xunit), (0.1*yunit) + 14 * yunit, xunit, yunit);
  if (btClear.on) {
    println("Stopping timer...");
    //timer.stop(CountdownTimer.StopBehavior.STOP_IMMEDIATELY);
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 16; x++) {
        bts[x][y].on = false;
      }
    }
    btClear.on = false;
  }
}
//------------------------------------------------------------------------------------
void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  timerCallbackInfo = "[tick] - timeLeft: " + timeLeftUntilFinish + "ms";
  pos++;
  pos %= 16;

  for (int y = 0; y < 8; y++) {
    if (bts[pos][y].on) {
      myBus.sendNoteOn(y, 60, 90); // Send a Midi noteOn
    }
  }
}

//------------------------------------------------------------------------------------
void onFinishEvent(CountdownTimer t) {
  timerCallbackInfo = "[finished]";
}

//------------------------------------------------------------------------------------
void keyPressed() {
  // user interface for operating the timer
  switch(key) {
  case 'a':
    println("Starting timer...");
    timer.start();
    break;
  case 's':
    println("Stopping timer...");
    timer.stop(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
    break;
  case 'r':
    println("Resetting timer...");
    timer.reset(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
    break;
  case 'q':
    println("getTimeLeftUntilNextEvent: " + timer.getTimeLeftUntilNextEvent());
    break;
  case 'w':
    println("getTimeLeftUntilFinish: " + timer.getTimeLeftUntilFinish());
    break;
  case 't':
    touch = !touch;
  }
}

//------------------------------------------------------------------------------------
void mouseClicked() {
  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 16; x++) {
      bts[x][y].select();
    }
  }
  btPlay.select();
  btStop.select();
  btPause.select();
  btClear.select();
}

//------------------------------------------------------------------------------------
void mouseMoved() {
  if (touch) {
    handleTouchEvents();
  }
}

//------------------------------------------------------------------------------------
void handleTouchEvents() {
  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 16; x++) {
      bts[x][y].select();
    }
  }
  btPlay.select();
  btStop.select();
  btPause.select();
  btClear.select();
}
