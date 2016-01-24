int current;  //used to indicate the current enemy
              //basically a global 'i' variable used inside the for loop when calling the enemies.

float [] ox = new float[4];           //x position, also number of enemies to draw.
float [] oy = new float[ox.length];   //y position
float [] oz = new float[ox.length];   //z position
float [] oxi = new float[ox.length];  //initial x position
float [] ozi = new float[ox.length];  //initial z position
float [] oxs = new float[ox.length];  //speed on x-axis
float [] ozs = new float[ox.length];  //speed on z-axis

//fill color variables. the boxes get darker as they go far away.
float filler;
float pfiller; //previous fill color, used for checking which of the enemies has the highest fill
               //which is then used for the brown noise sound effect.
 
int [] w = new int[ox.length]; //size of the enemy (4)

class Enemy {
  
  void display() {
    for(int i=0; i<ox.length; i++) 
    {
     pushStyle();  //using this prevents stroke and fill colors to affect other objects
      pushMatrix();
      
       //moves the enemies around using the timer and the speed.
       ox[i] = oxi[i] - (oxs[i]*timer);
       oy[i] = 985 - (w[i])/2; //the y coordinate doesnt change, it just takes the size of the enemy and moves it so its perfectly on the ground
       oz[i] = ozi[i] - (ozs[i]*timer);
       
       //fill color is based on distance from the player.
       filler = map(dist(position[0],position[1],position[2],ox[i],oy[i],oz[i]),0,1000,140,0);
       //now we check if it is out of bounds.
       if(filler > 140)
         filler = 140;
       else if (filler < 0)
         filler = 0;
        
       //check if current fill color is larger than previous one.
       //if so, use the current enemy fill color to decide the volume of the noise effect.
       if((filler>pfiller) && (i>0))
       {
         amp = map(filler,0,140,0,0.01); //map amplitude to sensible values.
         a.setConstant(amp);
       }
       pfiller = filler; //set the pfiller variable to the current fill color, to be used in the next iteration of the for loop.
       fill(filler,0,0);
       
       translate(ox[i],oy[i],oz[i]);  //translate using predefined variables
      
       box(w[i]);
      
    popMatrix();
    popStyle();
   }
  }
  
  //checks if the current enemy is close enough to the player.
  //if so, push the player away.
  void push() {
   for(int i=0;i<ox.length;i++)
     {
     if((position[0]>ox[i]-(w[i]/2)-110)
        &&(position[0]<ox[i]+(w[i]/2)+110)
        &&(position[2]>oz[i]-(w[i]/2)-110)
        &&(position[2]<oz[i]+(w[i]/2)+110))
     {
       //z axis
       if(position[2]<oz[i])
         bobB = 9;
       else if(position[2]>oz[i])
         bobB = -9;
         
       //x axis
       if(position[0]>ox[i])
         bobA = 9;
       else if(position[0]<ox[i])
         bobA = -9;
   }
  }
 }
}  //class Enemy ends 


void makeEnemy() //this function is called every 0.3 seconds for all enemies that are not visible by the player.
//it will relocate them and give them a new speed, size, and direction.
{
  int counter = 0; //used to limit the while loop so it doesnt go on forever.
  //the following variables with a 't' are temporary, since we need to run various checks to see if they are alright when randomizing them.
  float toxi;
  float tozi;
  float toxs;
  float tozs;
  int tw = (int)random(200,600); //random sizes from 200 to 600
  timer = 0; //resets timer
  
  //here we just set these variables (the initial position of the enemy) to a value which we know isn't good: the position of the player
  //the box has to appear far away from the player, in the dark, so the player never sees the boxes appearing (or disappearing).
  //he just sees them coming and going.
  toxi = position[0];
  tozi = position[2];
  boolean alright = true;  //used to check if the randomized values are good or not
  
  while((position[0]>toxi-(tw/2)-1000)
        &&(position[0]<toxi+(tw/2)+1000)
        &&(position[2]>tozi-(tw/2)-1000)
        &&(position[2]<tozi+(tw/2)+1000))
  {
    toxi=random(-20-1000,r*30+20+1000);
    tozi=random(-((r*30*2)/3)-20-1000,((r*30)/3)+20+1000);
    counter++;
    if(counter == 10000) //if the while loop runs too many times, just give up and stop.
    {
      alright=false;
      break;
    }
  }
  
  //here we randomize the speed and make sure its fast enough
  if(alright==true) {
    toxs=1;
    tozs=1;
    counter=0;
    while(abs(toxs)+abs(tozs)<8) //since our randomized values could also give us small numbers close to zero
                                 //the while loop makes sure we get a large enough speed.
    {
      toxs=random(-14,14);
      tozs=random(-14,14);
      counter++;
      
      if(counter==10000) {
        alright=false;
        break;
      }
    }
    if (alright == true)
    {
      //if all the checks went alright, we set the actual values to the temporary ones.
      w[current] = tw;
      oxi[current] = toxi;
      ozi[current] = tozi;
      oxs[current] = toxs;
      ozs[current] = tozs;
    }
  }
}
