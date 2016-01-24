void displayIntro() {

  //Variables for Timer
  float m = millis();
  int timedelay = 5000; //just adds a small delay of 5 seconds, after that the text slowly starts fading away.

  pushStyle();
  pushMatrix();
    if (true)
    {
      if(m < timedelay)  //if millis is less than 5 seconds
      {
        fill(255);  //fill texts with white
      }
      else  //if over 5 secondsß
      {
        fill(255,255-(m/100));  //texts slowly fade
      }    
      translate(0, 940, 0);  //these codes place texts in front of player
      rotateY(-PI/2);
      
      if(m < 35000) //after 35 seconds text disappears completely
      {
        textFont(texts);  //game story & instructions
        textSize(16);
        text("You are stuck in a dark, mysterious forest where there are" +"\n"+
             "monsters coming to kill you." +"\n"+
             "Stay alive using WASD to dodge as many monsters as you can." +"\n"+
             "Move mouse to look around." +"\n"+
             "Be careful not to fall. Good luck!",-30, -40, -400);
        
        textFont(title);
        textSize(55);
        if(m < timedelay)  //repeat the same time process for game title
          fill(255,0,0);
        else
          fill(255,0,0,255-(m/100));
        text("The Forest Dodging Game", -30, -150, -400);   //game title
      }
    }
    //Display Mist particles!
    for (int i=0; i < particles.length; i++) {  //Double for loop so stars are in a grid-like structure
    for (int j=0; j < particles.length; j++) {
       stars[i].display();
    }
    }
  popMatrix();
  popStyle();
}
