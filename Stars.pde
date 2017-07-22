
//Creates shiny stars in the sky

int[] particles = new int [50];  //array of 50 particles

Star [] stars = new Star[particles.length];  //Array of Stars class with length 80


class Star {
 
  float x, y, z;  //positions of particles
  PVector location;
  
  Star(float x_, float y_, float z_) {
    x = x_;  //setting position vaiables equal to variables in the constructor
    y = y_;  //so that we can declare it in setup()
    z = z_;
    
    location = new PVector(x,y,z);
  }
  
  void display() {
    fill(255);  
    pushMatrix();
      translate(x, y, z);  //position of stars is declared in setup()
      ellipse(0,0, random(3), random(3));  //draw ellipses with random sizes from 0 to 3
      //point(0,0);
    popMatrix();

  }
}
