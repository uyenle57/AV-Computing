//position variables of tiles
float tx;  //x
float ty;  //y
float tz;  //z
int r = 50;  //size of tiles

class Floor {
  
  int[] numTiles = new int[30]; //number of tiles

  void display() {
    for (int i=0; i<numTiles.length; i++) {  //Create grid of tiles using double for loop
    for (int k=0; k<numTiles.length; k++) {
      noStroke();
      pushMatrix();
        tx = i*r;       //x position: draw tiles next to each other
        ty = 500*2;     //y position: bottom of screen
        tz = k*r-1000;  //z position: draw tiles in z direction
                        //-1000 push them further away from the screen

        translate(tx, ty, tz);
        rotateX(PI/2);  //rotate the tiles so that it lays flat on the ground
        
        //fill tiles according to player position, just like with the enemies.
        //green colour to represent grass
        fill(0,map(dist(position[0], position[1], position[2], tx, ty, tz), 0, 1000, 135, 0),0);
        
        box(r, r, 10);
      popMatrix();
      }
    }
  }
}

