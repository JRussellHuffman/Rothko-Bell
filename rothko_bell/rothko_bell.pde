String[] quantumCorpusLoad;
String[] finalQuantumArray;
color black = color(0);
color white = color(255);
int startingX;
int startingY;
int scale = 20;
int rows = 40;
int columns = 50;
boolean drawOnBottom;
int padding = 50;

void setup() {
  size(1100,1100);
  background(white);
  loadPixels();
  strokeWeight(5);
  stroke(black);
  parseCorpus();
  drawLines();
  
  //export image
  //save("pixel_art.png");
  //println("exported!");

}

void parseCorpus() {
  quantumCorpusLoad = loadStrings("corpus.txt");
  finalQuantumArray = quantumCorpusLoad[0].replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\\s", "").split(",");
}


//Draw lines based on the corpus. The 0th qubit (left digit in this case, which is backwards from how qiskit reads them)
//determines the position, being either the top canvas or the bottom canvas.
//the 1st qubit (right digit) determines if its a hortizontal or vertical line.

void drawLines() {
  for (int i = 0; i < finalQuantumArray.length; i ++) {
    
    //store 0 and 1 as characters
    int binary0='0';
    char b0 = (char)binary0; 
    int binary1='1';
    char b1 = (char)binary1; 
   
    // get the first qubit character
    char qb0 = finalQuantumArray[i].charAt(1);
    // get the second qubit character
    char qb1 = finalQuantumArray[i].charAt(2);
    
    
    //decide which canvas to draw the line on
    if (qb0 == b0) {
      drawOnBottom = false;
    } else {
      drawOnBottom = true;
    }
    
    //draw either a hortizontal or vertical line
    if (qb1 == b0) {
      drawHortizontalLine(i, drawOnBottom);
    } else {
      drawVerticalLine(i, drawOnBottom);
    }
  }
}



void drawHortizontalLine(int i, boolean drawBottom) {
  
  double ycoordinate = Math.floor(i/(columns));
  double xcoordinate = i - (ycoordinate*columns);
  
  startingX = (int) xcoordinate * scale + (scale/(10/2)) + padding; //start 10 percent in
  startingY = (int) ycoordinate * scale + (scale/2); //start 50% in
  
  startingY += scale/4 * 10 + padding; //adding a gap from the top
  
  if (drawBottom) {
    startingY += rows * scale / 2; //start halfway down
    startingY += scale/2 * 10; //adding a gap between the two
  }
  
  line(startingX,startingY, startingX + scale - (scale/(5/2)), startingY); //make the length 20 percent short, which is 10 percent of each side
}



void drawVerticalLine(int i, boolean drawBottom) {
  double ycoordinate = Math.floor(i/(columns));
  double xcoordinate = i - (ycoordinate*columns);
  
  startingX = (int) xcoordinate * scale + (scale/2) + padding; //make the length 20 percent short, which is 10 percent of each side
  startingY = (int) ycoordinate * scale + (scale/(10/2)); //start 50% in
  
  startingY += scale/4 * 10 + padding; //adding a gap adding a gap from the top
  
  if (drawBottom) {
    startingY += rows * scale / 2; //start halfway down
    startingY += scale/2 * 10; //adding a gap between the two 
  }
  
  line(startingX,startingY, startingX, startingY + scale - (scale/(5/2)));//make the length 20 percent short, which is 10 percent of each side
}
