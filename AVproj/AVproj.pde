
/* AV Computing Coursework 2
   THE FOREST DODGING GAME
   By Akira Fiorentino and Uyen Le

   Make sure you have OCD installed:
   (Sketch > Import Library > Add Library > Search 'OCD' and install)

(*)Note: 
   please rerun the sketch several times as sometimes it may not start properly.
   increase volume to hear background music
*/           


// ----------------------------------- CODE BEGINS --------------------------------------//

//Import libraries 
import ddf.minim.spi.*;  //Minim
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import damkjer.ocd.*;   //OCD

//Declare library variable names
Minim minim;
AudioPlayer music;
Constant a;
Camera camera1;

boolean bla = false; //a temporary boolean which is used only once
//at the beginning of the sketch in void mouseMoved().

//Speed of player
float walkspeed = 0.2; //walking speed
float slowspeed = 1.01; //slow-down speed
float maxspeed = 8; // maximum speed

float timer = 0;  //this timer is used to create the enemies in new positions every now and then.

int score = 0;    //this other timer is used for the players score.
float amp;  //amplitude of brown noise.

float position[] = new float[3]; //position of the player, x y and z.

//accelerating values for speed on x-axis,y-axis and z-axis
float bobA=0;
float bobB=0;
float bobC=0;

//triggers falling
boolean fall = false;

//initial position of player
int x = 0;
int y = 940;
int z = 0;

// Classes
Floor tiles;
Enemy enemy;

boolean sketchFullScreen() {  //run program in full screen
  return true;
}

PFont title, texts, gOver;  //different fonts for different texts

//------------------------------------- VOID SETUP() ----------------------------------------//
void setup()
{
  size(displayWidth,displayHeight,P3D);  //size of program depends on computer screen
  //size(1000, 800, P3D);
  smooth();
  noCursor();

  //INITIALISE CLASSES
  tiles = new Floor();
  enemy = new Enemy();
  
  // Class of Star particles
  for (int i=0; i < particles.length; i++) {
    stars[i] = new Star( random(-600,600), -200, random(-950,-200) );
      //particles have randomise x and z positions everytime  the sketch runs
      //y position remains the same as they need to be high up in the sky
  }
  
  //INITIALISE LIBRARIES
  minim = new Minim(this);
  music = minim.loadFile("ThomasBergersen_Dreammaker.wav", 1024);  //load music with minim
  AudioOutput out = minim.getLineOut();  //AudioOutput is used to generate sound in real-time
                                         //and output it to the sound card
                                         //getLineOut(type) gets the AudioOutput link
                                         //this is used for Brown Noise
  
  camera1 = new Camera(this, x, y, z);  //OCD camera

  //Set up the Brown Noise effect using AudioOutput
  Noise n = new Noise(0.5, Noise.Tint.BROWN);  //Noise(amplitude, noiseType)
  a = new Constant(0);
  n.patch(out);   //patch() sends the output to AudioOutput
  a.patch(n.amplitude);//patch the amplitude so it is controllable easily.

  for (current=0; current<ox.length; current++) {  //creates the enemies with array length of 4
    makeEnemy();
  }

  title = loadFont("LucidaBlackletter-40.vlw");  //font for game title
  texts = loadFont("ArialMT-20.vlw");            //font for instruction texts
  gOver = loadFont("RepriseStampStd-40.vlw");    //font for game over screen

  music.setGain(-36);  //reduce the music volume so we can hear the noise effect
                       //setGain() is used to manipulate volume with Minim
  music.play();  //play music at start
}

//------------------------------------ VOID DRAW() -----------------------------------------//
void draw() {
  background(0);
  lights();  //sets default lights for the spotlight() function
  println(position[0],position[2]);
  fill(200);
  
  //sets up a light around the player
  spotLight(255, 255, 255, position[0], position[1]-300, position[2], 0, 1, 0, PI/2, 8); 

  timer++;

  //every 300 milliseconds, re-creates all the enemies 
  //in new positions with new directions, speeds, size
  if (timer%300 == 0) {
    for (current=0; current<ox.length; current++)
    {
      //check that the enemy is not currently in the player's sight.
      if (!((position[0]>ox[current]-(w[current]/2)-500)
        &&(position[0]<ox[current]+(w[current]/2)+500)
        &&(position[2]>oz[current]-(w[current]/2)-500)
        &&(position[2]<oz[current]+(w[current]/2)+500))) {
        makeEnemy();
      }
    }
  }

  // Falling Sensor
  //checks if the player is off the grid of tiles by using the tile size (r)
  if ((position[0]<-20)||(position[0]>r*30+20)
  ||(position[2]<-((r*30*2)/3)-20)
  ||(position[2]>((r*30)/3)+20)) 
  {
    fall = true;
  }

  if (fall == true)  //if the fall boolean is true...
    bobC -= 1.4;    //accelerate on the y-axis
  else
    score = millis()/1000;  //increases score

  // CALLING FUNCTIONS FROM TABS 

  displayIntro();
  movement();

  tiles.display();
  enemy.display();
  enemy.push();

  gameOver();  //draw game over screen from gameOver tab
  
}  //void draw ends


void mouseMoved()   //look around with the mouse
{
  if (bla == false) {
    camera1.look(radians(mouseX - pmouseX) / 2.0, PI/2); //this only happens once it rotates the player 
                                                         //so he is facing in the correct direction.
    bla = true;
  } else {
    camera1.look(radians(mouseX - pmouseX) / 2.0, 0);
  }
}

// ----------------------------------- CODE ENDS --------------------------------------//
