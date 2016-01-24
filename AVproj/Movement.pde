
// Movement controls of the player 
// All controls go here

void movement() {
 if(keyPressed == true)
    {
     if(key == 'w') 
     {
      bobA += walkspeed; //go forward
     }
     else if(key == 's')
     {
      bobA -= walkspeed; //go backward
     }
     else
     {
      bobA = bobA/slowspeed; //else if no key is pressed for this axis, slow down in this direction only.
     }
     if(key == 'a')
     {
      bobB += walkspeed; //move left
     }
     else if(key == 'd')
     {
      bobB -= walkspeed; //move right
     }
     else
     {
      bobB = bobB/slowspeed;
     }
    }
   else ////if no key is pressed, slow down in all directions
    {
     bobA =bobA/slowspeed;
     bobB =bobB/slowspeed;
     bobC =bobC/slowspeed;
    }
    
    ////limiting  speed to maximum
   if(bobA > maxspeed)
    bobA = maxspeed;
   else if(bobA < -maxspeed)
    bobA = - maxspeed;
   if(bobB > maxspeed)
    bobB = maxspeed;
   else if(bobB < -maxspeed)
    bobB = -maxspeed;
   if(bobC > maxspeed)
    bobC = maxspeed;
   else if(bobC < -maxspeed)
    bobC = -maxspeed;
 
 //moving the camera accordingly
 camera1.dolly(-bobA);
 camera1.truck(-bobB);
 camera1.boom(-bobC);
 
 camera1.feed();  //display

 position = camera1.position();  //get x,y and z positions of player (this is just how ocd works and gets its coordinates)
}
