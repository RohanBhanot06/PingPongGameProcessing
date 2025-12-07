/* 
 Name: Rohan Bhanot 
 Date: Monday, June 13, 2022
 File Name: PingPong
 Purpose: Creating a ping pong game with two players that goes up to 11 points.
 ICS2O1
 */

/* Variable Table
 bx - x coordinate of the ball
 by - y coordinate of the ball
 p1x - x coordinate of the paddle 1
 p1y - y coordinate of the paddle 1
 p2x - x coordinate of the paddle 2
 p2y - y coordinate of the paddle 2
 vx - x velocity vector of the ball
 vy - y velocity vector of the ball
 r - radius
 font - font used
 stage - stages
 stage 0 - menu screen
 stage 1 - help screen
 stage 2 - play screen
 stage 3 - lost screen
 stage 4 - reset screen
 turquoise - color - RGB color turquoise
 pink - color - RGB color pink
 black - color - RGB color black
 white - color - RGB color white
 points - points tracker for right rectangle
 points1 - points tracker for left rectangle
 */

// Variable Declaration

//ping pong ball
float bx = 350; //x coordinate of the ball
float by = 250; //y coordinate of the ball
//paddle 1
float p1x = 0; //x coordinate of the paddle 1
float p1y = 200; //y coordinate of the paddle 1
//paddle 2
float p2x = 674.5; //x coordinate of the paddle 2
float p2y = 200; //y coordinate of the paddle 2
//velocity vectors
float vx = 4.5; //x velocity vector of the ball
float vy = 4.5; //y velocity vector of the ball
//radius
int r = 10; //ball radius
//colors
color turquoise = color(64, 224, 208); //turquoise color
color pink = color(255, 0, 187); //pink color
color black = color(0); //black color
color white = color(255); //white color
//images
PImage logo; //logo for ping pong game
PImage line; //line to seperate sides
PImage play; //the button for play text
PImage help; //the button for help text
PImage back; //the button for back
PImage mainMenu; //the button for main menu text
PImage gameOver; //the text that appears when you lose the game
PImage instructions; //the text that tells you how to play the game
//points
int points=0; //points tracker for right rectangle
int points1=0; //points tracker for left rectangle
//font
PFont font; //font used for text
//stages
int stage = 0; //stage declaration

// Setup Before the Loop

void setup() {
  size(700, 500);
  logo = loadImage("logo.jpeg");
  line = loadImage("line.png");
  play = loadImage ("play.png");
  help = loadImage ("help.png");
  back = loadImage ("back.png");
  instructions = loadImage ("instructions.jpeg");
  mainMenu = loadImage ("mainMenu.png");
  gameOver = loadImage ("gameOver.png");
  font = createFont("font.ttf", 32);
  print("Stage0=MainScreen, Stage1=HelpScreen, Stage2=PlayScreen, Stage3=LoseScreen, Stage4=ResetforMainScreen"); 
  frameRate(60);
}

// Infinite Loop

void draw() {
  /* 
   stage 0: Menu Screen
   stage 1: Help Screen
   stage 2: Play Screen
   stage 3: Lost Screen
   stage 4: Reset Screen
   */
  //main menu stage
  if (stage == 0) {
    background(black);
    image(logo, 90, -60, 500, 400);
    image(help, 290, 290, 120, 100);
    image(play, 290, 370, 120, 100);
    fill(0);
    //help button
    if ((mousePressed == true) && (mouseX >=290 && mouseX <=410 && mouseY >=290 && mouseY <=390)) {//changes stage to help screen stage
      stage = 1;
    } //closing for help button
    //play button
    if ((mousePressed == true) && (mouseX >=290 && mouseX <=410 && mouseY >=370 && mouseY <=470)) {//changes stage to play screen stage
      stage = 2;
    } //closing for play button
  } // closing for stage 0

  //instructions stage
  if (stage == 1) {
    image(instructions, 0, 0, 700, 500);
    image(back, 290, 25, 120, 100);
    if ((mousePressed == true) && (mouseX > 290 && mouseX < 410 && mouseY > 25 && mouseY < 125)) {//changes stage to main menu screen stage
      stage = 0;
    }
  } //closing for stage 1

  //takes the player to the main menu, resets score, resets obstacles x and y values, as well as paddle coordinates.
  if (stage == 4) {
    bx = 350;
    by = 250;
    p1x = 0;
    p1y = 200;
    p2x = 674.5;
    p2y = 200;
    stage = 0;
    points = 0;
    points1 = 0;
  } //closing for stage 4

  //play stage
  if (stage == 2) {
    background(black);
    image(line, 322.5, -60, 60, 615);
    fill(turquoise);
    ellipse(bx, by, 30, 30);
    fill(white);
    textFont(font, 24);
    textSize(40);
    text(points, 505, 40);
    text(points1, 155, 40);

    //when you move the ball
    bx=bx+vx;//vx is velocity for x
    by=by+vy;//vy is velocity for y

    //bouncing from top:
    if (by<r+10) { 
      vy=-vy;
    }
    //bouncing from bottom:
    if (by>490-r) { 
      vy=-vy;
    }
    //bouncing from the left side:
    if (bx<r+10) {
      vx=-vx;
    }
    //bouncing from the right side:
    if (bx>690-r) {
      vx=-vx;
    }

    fill(pink);
    rect(p1x, p1y, 25, 100);
    rect(p2x, p2y, 25, 100);

    //collision between ball & left rectangle
    if (bx > p1x && bx < p1x+37.5 && by > p1y && by < p1y+100) {
      vx=-vx;
      vy=+vy;
    }
    //collision between ball & right rectangle
    if (bx > p2x-10 && bx < p2x+25 && by > p2y && by < p2y+100) {
      vx=-vx;
      vy=+vy;
    }

    if (bx<20) {
      points=points+1;
    }
    if (bx>680) {
      points1=points1+1;
    }

    //restrictions
    if (p1y<=0) {
      p1y=p1y+10;
    }
    if (p1y>=400) {
      p1y=p1y-10;
    }
    if (p2y<=0) {
      p2y=p2y+10;
    }
    if (p2y>=400) {
      p2y=p2y-10;
    }

    //game over stage
    if (points==11) {
      stage = 3;
    }

    if (points1==11) {
      stage = 3;
    }
  }//closing for stage 2
  if (stage == 3) {
    background(black);
    image(logo, 140, 230, 400, 300);
    image(gameOver, 232.5, 25, 230, 120);
    image(mainMenu, 232.5, 150, 230, 120);
    fill(0);
    if ((mousePressed == true) && (mouseX >=-232.5 && mouseX <=462.5 && mouseY >=150 && mouseY <=270)) {//changes stage to main menu screen stage
      stage = 4;
    }
  }//closing for stage 3
}//end of draw

void keyPressed() {
  //keyboard commands for movement
  if (key == 'w') {
    p1y=p1y-25;
  }
  if (key == 's') {
    p1y=p1y+25;
  }
  if (key == CODED && (keyCode == UP)) {
    p2y=p2y-25;
  }
  if (key == CODED && (keyCode == DOWN)) {
    p2y=p2y+25;
  }
}//end keyPressed
