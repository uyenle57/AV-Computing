void gameOver() 
{
   if(position[1]>1500) { //checks if y position is past 1500
                          //meaning the player has fallen down and its time to display the score.
     
     pushStyle();
     pushMatrix();  
       translate(position[0],position[1]+50,position[2]);  //positions of game over scren
       rotateY(-PI/2);
       music.pause();    //music stops
       
       //draw game over screen
       fill(211, 0, 0);
       stroke(255);
       textFont(gOver);
       textSize(30);
       text("You are dead!" +"\n"+ "Your score is " + score, -10, -100, -250);
//       textSize(15);
//       text("Press 'R' to replay", -5, -5, -250);     
     popMatrix();
     popStyle();
    
   if (keyPressed)
   {
     if(key == 'r')  //Player press R to restart game
     { 
      setup();
      bla = false;
      timer = 0;
      score = 0;
      bobA=0;
      bobB=0;
      bobC=0;
      fall = false;
      x = 0;
      y = 940;
      z = 0;
     }
   }
 }
}
