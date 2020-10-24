// Chemotaxis 
// Andrea Robinowitz
// October 22, 2020


// Create the array of Dogs

Dog [] dogs;
// Create the array of Bones
Bone [] bones;
// create a Ball
Ball favoriteTennisBall;

// AUXILLARY FUNCTIONS

int returnRandomNumber(int max) {
 // this function returns a random integer,x, such that 0<= X <= max
 // the argument, max, must be an integer >= 0.
return ((int) (Math.random()*(max+1)));
}

float distanceBetweenTwoPoints (float x1, float y1, float x2, float y2)
{
return sqrt (sq(x2 - x1) + sq(y2 - y1));
}

// MAIN Functions

void setup()   
{     
  size(860,760);   
  frameRate(4);
  background(34,139,34);
  dogs = new Dog [10];  // Create dogs array of Dog objects
  for (int i = 0; i < dogs.length; i++) // initialize the dogs array
  {
    dogs [i] = new Dog (returnRandomNumber(800), returnRandomNumber(700));
  }
  bones = new Bone [30];  // Create the bones array of Bone objects
  for (int i = 0; i < bones.length; i++) // intialize the bones array
  {
    bones[i] = new Bone (returnRandomNumber(800), returnRandomNumber(700));
  }
  favoriteTennisBall = new Ball (mouseX, mouseY);
}

void draw()   
{   
   int bonesLeft;
   bonesLeft = countBones();
   background(34,139,34);
   if (bonesLeft > 0) {
     favoriteTennisBall.myX = mouseX;
     favoriteTennisBall.myY = mouseY;
     assignTargets ();
     for (int i = 0; i < dogs.length; i++)
     {
       dogs[i].show();
       favoriteTennisBall.show();
       dogs[i].move();

     }
     for (int i = 0; i < bones.length; i++)
     {
      bones[i].show();
     }
     }
    else
     { // if no uneaten bones, then start the simulation over
       setup();
     }
    text("See How Many Bones Each Bone Can Find! A Blue line, means the Dog has smelled a bone and is looking for it. Bones Left: "+bonesLeft,50,12);
}

// CLASS DEFINITIONS

class Ball
{
  int myX, myY, ballIsVisible;
  Ball(int x, int y)
  {
    myX = x;
    myY = y;
    ballIsVisible = 0;
  }
  void show()
  {
    if (ballIsVisible != 0) {
    fill(255,255,0);
    ellipse(myX,myY,15,15);
    fill(255,255,255);
    }
  }
}

class Dog   
{     
  int myX,myY,myColor,myXDirection, restingAndEating, tummySize;
  int targetX, targetY; // the object I'm trying to find
  int stepSize = 10; // how far the dog can move in one "move"
  int wag = 0;
  int totalBonesEaten;

  Dog(int x,int y)
  {
    myX=x;
    myY=y;
    restingAndEating = 0;
    tummySize = 16;
    myColor = 255;
    myXDirection = 0; // zero for moving left, one for moving right
    wag = 0;
    totalBonesEaten = 0;
  }

  void changeWag () {
    if (returnRandomNumber(10) < 8) {
      if (wag == 0) {
        wag = 1;
      }
      else
      {
        wag = 0;
      }
    }
  }

  void show()
  {
    noStroke();
    fill(255,255,255);
    if (myXDirection == 0) {
      // draw left facing dog
      ellipse(myX,myY,20,20);
      fill(54);
      ellipse(myX-3,myY-2,3,3); // left eye
      ellipse(myX+3,myY-2,3,3); // right eye
      ellipse(myX,myY+2,3,3);
      fill(255,192,203);
      ellipse(myX,myY+7,4,5);
      fill(255,255,255);
      ellipse(myX+20,myY+10,40,tummySize); // dog tummy
      ellipse(myX+5,myY+17,5,20);
      ellipse(myX+10,myY+17,5,20);
      ellipse(myX+30,myY+17,5,20);
      ellipse(myX+35,myY+17,5,20);
      stroke(255,255,255);
      strokeWeight(4);
      if (wag == 0) {
        line((float)(myX+35),(float)(myY+5),(float)(myX+40),(float)(myY-11));
      }
      else {
        line((float)(myX+35),(float)(myY+5),(float)(myX+43),(float)(myY-7));
      }
      text(totalBonesEaten,myX-2, myY-18);
      noStroke();
      fill(255,255,255);
      triangle((float) (myX-10), (float) (myY-5), (float) (myX-1), // ears
          (float) (myY-10), (float) (myX-8), (float) (myY-14));
      triangle((float) (myX-2), (float) (myY-9), (float) (myX+7),
          (float) (myY-7), (float) (myX+8), (float) (myY-14));
    }
    else
    {
      // draw right facing dog
      ellipse(myX,myY,20,20);
      fill(54);
      ellipse(myX+3,myY-2,3,3); // left eye
      ellipse(myX-3,myY-2,3,3); // eye
      ellipse(myX,myY+2,3,3);
      fill(255,192,203);
      ellipse(myX,myY+7,4,5);
      fill(255,255,255);
      ellipse(myX-20,myY+10,40,tummySize);
      ellipse(myX-5,myY+17,5,20);
      ellipse(myX-10,myY+17,5,20);
      ellipse(myX-30,myY+17,5,20);
      ellipse(myX-35,myY+17,5,20);
      stroke(255,255,255);
      strokeWeight(4);
      //line((float)(myX-35),(float)(myY+5),(float)(myX-40),(float)(myY-8));
      if (wag == 0) {
        line((float)(myX-35),(float)(myY+5),(float)(myX-40),(float)(myY-11));
      }
      else {
        line((float)(myX-35),(float)(myY+5),(float)(myX-43),(float)(myY-7));
      }
      text(totalBonesEaten,myX+2, myY-18);
      noStroke();
      fill(255,255,255);
      triangle((float) (myX+10), (float) (myY-5), (float) (myX+1),
          (float) (myY-10), (float) (myX+8), (float) (myY-14));
      triangle((float) (myX+2), (float) (myY-9), (float) (myX-7),
          (float) (myY-7), (float) (myX-8), (float) (myY-14));
    }

    if (restingAndEating == 14) {
      if (myXDirection == 0) {
          ellipse(myX-3,myY-2,5,5); // left eye
          ellipse(myX+3,myY-2,5,5); // right eye
      }
      else
      {
          ellipse(myX+3,myY-2,3,5); // left eye
          ellipse(myX-3,myY-2,3,5); // eye
      }
    }
     if (restingAndEating > 0) {
       changeWag();
       stroke(0,0,0);
       strokeWeight(1);
       if (restingAndEating >12) {
         ellipse(myX,myY+4,20,8);
       }
       else if (restingAndEating > 5) {
         ellipse(myX,myY+4,20,restingAndEating-4);
       }
       if (restingAndEating >4) {
         ellipse(myX+10,myY+2,5,5);
       }
       if (restingAndEating > 3) {
         ellipse(myX+10,myY+6,5,5);
       }
       if (restingAndEating > 2) {
         ellipse(myX-10,myY+2,5,5);
       }
       if (restingAndEating > 1) {
         ellipse(myX-10,myY+6,5,5);
       }
       if ((restingAndEating > 0) && (restingAndEating < 12) && ((restingAndEating % 2) == 0) && (tummySize < 29)) {
         tummySize++;
       }
     }
  }

  void changeTarget (int x, int y)
  {
    if ((x != targetX) && (y != targetY) && (restingAndEating == 0)) {
      // check if this is a NEW target
      targetX = x;
      targetY = y;
      strokeWeight(1);
      stroke(0,0,255);
      line((float) (myX+2), (float) (myY+2), (float) targetX, (float) targetY);
      stroke(255,255,255);
    }
  }


 void move ()
 {
    int xProbabilityCorrectDirection, yProbabilityCorrectDirection;
    int newX, newY;
    int probabilityTowardTargetX, probabilityTorwardTargetY;

 if (restingAndEating > 0) {
      restingAndEating --;
    }
    else
    {
      if (tummySize > 16) {
        tummySize--;
      }

    if (returnRandomNumber(10) < 5) {
      changeWag();
    }

    // distanceToTarget = distanceBetweenTwoPoints((float) myX, (float) myY, (float) targetX, (float) targetY); // used to calculate accuracy of sniffing

    xProbabilityCorrectDirection = returnRandomNumber(99);
    yProbabilityCorrectDirection = returnRandomNumber(99);

    probabilityTowardTargetX = 80;
    probabilityTorwardTargetY = 80;

    if (xProbabilityCorrectDirection < probabilityTowardTargetX)
        {
          // move towards the target, 80% change
          if (targetX > myX)
          {
            newX = myX+stepSize;
            myXDirection = 1;
          }
        else
        {
          newX = myX-stepSize;
          myXDirection = 0;
        }
      }
    else // move away from the target, 20% chance
      {
         if (targetX > myX)
         {
          newX = myX - stepSize;
          myXDirection = 0;
          }
        else
        {
          newX = myX + stepSize;
          myXDirection = 1;
        }
      }
   if (yProbabilityCorrectDirection < probabilityTorwardTargetY)
     {
      // move towards the target, 80% change
      if (targetY > myY) {
          newY = myY+stepSize;
        }
      else
        {
          newY = myY-stepSize;
        }
     }
    else // move away from the target, 20% chance
      {
         if (targetY > myY)
         {
          newY = myY - stepSize;
          }
        else {
          newY = myY + stepSize;
        }
      }

      if (newX < 0)  {
          myX = 10;
        }
        else {
          if (newX > 840) {
            myX = 840;
          }
          else {
             myX = newX;
          }
      }
      if (newY< 0) {
        myY = 10;
      }
      else {
          if (newY > 740) {
            myY = 740;
          }
         else {
           myY = newY;
         }
      }
    }
 }
}

 class Bone
{
  int myX, myY, eaten;

  Bone(int x, int y)
  {
    myX = x;
    myY = y;
    eaten = 0;
  }

 void show()
  {
    if (eaten == 0) {
      stroke(0,0,0);
      strokeWeight(1);
      ellipse(myX,myY,20,8);
      ellipse(myX+10,myY-2,5,5);
      ellipse(myX+10,myY+2,5,5);
      ellipse(myX-10,myY-2,5,5);
      ellipse(myX-10,myY+2,5,5);
    }
  }
}


// OTHER FUNCTIONS

int countBones ()
// Return how many uneaten bones are left

{
 int numberOfBones = 0;
 for (int i = 0; i<bones.length; i++) {
   if (bones[i].eaten == 0) {
     numberOfBones++;
   }
 }
return numberOfBones;
}


void assignTargets ()
// this function assigns each dog in the dogs array to the nearest bone in the bones array.

{
  int closestBone, newClosestBone;
  float closestBoneDistance, thisBoneDistance;

  for (int i = 0; i < dogs.length; i++) // loop through all of the dogs
    {
    closestBone = 999999; 
    closestBoneDistance =  999999;
    newClosestBone = 0;
    if (favoriteTennisBall.ballIsVisible == 0) {
    for (int j = 0; j < bones.length; j++) // cycle through all of the bones search for a closer bone
      {
      if (favoriteTennisBall.ballIsVisible == 0){
        thisBoneDistance = // calculate how far the current bone is from the dog.
          distanceBetweenTwoPoints (dogs[i].myX, dogs[i].myY, bones[j].myX, bones[j].myY);
        if ((bones[j].eaten == 0) && (thisBoneDistance < closestBoneDistance))  // if this bone is not already eaten & is closer than the (previous) cloest bone
          {
            closestBone = j;  // then we set this bone as the cloest bone and the distance
            closestBoneDistance = thisBoneDistance;  // from the bone to the current dog is the new closest distance.
            newClosestBone = 1;
          }
      }
      }
        if (closestBone == 999999) //there is no bone that is not eaten
        {
            dogs[i].targetX = 300;
            dogs[1].targetY = 300;
        }
      else
        {
          if (closestBoneDistance < 30)
          {
            bones[closestBone].eaten = 1; // the dog is very close to the bone, so the bone is eaten.
            dogs[i].restingAndEating = 20;
            dogs[i].totalBonesEaten++;
          }
          else
          {
    // after going through all of the bones, we set the target for the current dog to the location of the closest bone

            dogs[i].changeTarget(bones[closestBone].myX, bones[closestBone].myY);
          }
        }
      }
      else {
        dogs[i].changeTarget(mouseX, mouseY);
        }
      }
    }


// INPUT FUNCTIONS

void mouseReleased ()
{
 favoriteTennisBall.ballIsVisible = 0;
}


void mousePressed()
 {
     favoriteTennisBall.myX = mouseX;
     favoriteTennisBall.myY = mouseY;
     favoriteTennisBall.ballIsVisible = 1;
     favoriteTennisBall.show();
     //redraw();
 }   
