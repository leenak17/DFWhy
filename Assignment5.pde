// Used for sound file
import processing.sound.*;
SoundFile soundfile;

//Used for all visualizations and text
import processing.sound.*;
PFont font;

//Used for Circle Resize
SoundFile sample;
Amplitude rms;
float smoothingFactor = 0.25;
float sum;
int counter = 0;
int reverseCounter = 38;

// Used for sound graph / bars
FFT fft;
int bands = 128;
float smoothingFactor2 = 0.01;
float[] sum2 = new float[bands];
int scale = 5;
float barWidth;

//Sound Wavelength
Waveform waveform;
int samples = 200;
float r = 150;
float g = 0;
float b = 0;

/** Audio data:
 SFSampleRate= 44100 Hz
 SFSamples= 6172416 samples
 SFDuration= 139.96408 seconds
 **/
 
public void setup() {
  size(4000, 2000);
  background(255);
  noCursor(); // removes cursor for best visuals
  
  //text font info
  font = createFont("Georgia Italic", 50);
  textFont(font);
  
  // plays and loops audio
  sample = new SoundFile(this, "Why.mp3");
  sample.loop();

  // connects visualizations to audio:
  // wavelengths
  waveform = new Waveform(this, samples);
  waveform.input(sample);
  
  // sound bars
  barWidth = width/float(bands);
  fft = new FFT(this, bands);
  fft.input(sample);
  
  //rms tracker (shape changes)
  rms = new Amplitude(this);
  rms.input(sample);
}
//used for switching visuals
int screen = 0;

void draw() {
  
// color palette array, lerpcolor to help flow
  color[] bgcolors = new color[39];
  bgcolors[0] = #000018;
  bgcolors[1] = lerpColor(bgcolors[0],bgcolors[2],.5);
  bgcolors[2] = #180000;
  bgcolors[3] = lerpColor(bgcolors[2],bgcolors[4],.5);
  bgcolors[4] = #181818;  
  bgcolors[5] = lerpColor(bgcolors[4],bgcolors[6],.5);
  bgcolors[6] = #183030;
  bgcolors[7] =lerpColor(bgcolors[6],bgcolors[8],.5);
  bgcolors[8] = #303048;
  bgcolors[9] = lerpColor(bgcolors[8],bgcolors[10],.5);
  bgcolors[10] = #304860;
  bgcolors[11] = lerpColor(bgcolors[10],bgcolors[12],.5);
  bgcolors[12] = #486060;
  bgcolors[13] = lerpColor(bgcolors[12],bgcolors[14],.5);
  bgcolors[14] = #603018;
  bgcolors[15] = lerpColor(bgcolors[14],bgcolors[16],.5);
  bgcolors[16] = #903030;
  bgcolors[17] = lerpColor(bgcolors[16],bgcolors[18],.5);
  bgcolors[18] = #904818;
  bgcolors[19] = lerpColor(bgcolors[18],bgcolors[20],.5);
  bgcolors[20] = #C04848;
  bgcolors[21] = lerpColor(bgcolors[20],bgcolors[22],.5);
  bgcolors[22] = #D83030;
  bgcolors[23] = lerpColor(bgcolors[22],bgcolors[24],.5);
  bgcolors[24] = #A84848;
  bgcolors[25] = lerpColor(bgcolors[24],bgcolors[26],.5);
  bgcolors[26] = #D89078;
  bgcolors[27] = lerpColor(bgcolors[26],bgcolors[28],.5);
  bgcolors[28] = #D86060;
  bgcolors[29] = lerpColor(bgcolors[28],bgcolors[30],.5);
  bgcolors[30] = #F0C0A8;
  bgcolors[31] = lerpColor(bgcolors[30],bgcolors[32],.5);
  bgcolors[32] = #D87878;
  bgcolors[33] = lerpColor(bgcolors[32],bgcolors[34],.5);
  bgcolors[34] = #A84848;
  bgcolors[35] = lerpColor(bgcolors[34],bgcolors[36],.5);
  bgcolors[36] = #F09078;
  bgcolors[37] = lerpColor(bgcolors[36],bgcolors[38],.5);
  bgcolors[38] = #F0A890;

//changes background colors
background(bgcolors[counter]);
counter = (counter + 1) % 38;
 
// switches between visualizations
  switch (screen) {
  case 0:
    wavelength();
    break;
  case 1:
    soundGraph();
    break;
  case 2:
    circleResize();
    break;
  }
  
 // description text
  drawType();
  fill(255,50);
}

// text function 
void drawType() {
  text("What Could Possibly Go Wrong?", RIGHT, 600);
  fill(255, 50);
  textAlign(BASELINE + 1000);
  text("Digital visualizations of 'Why?' by Dominic Fike", RIGHT, 700);
  fill(255, 50);
  textAlign(BASELINE + 1000);
  text("PRESS 0, 1, or 2 to change visuals", RIGHT, 800);
  fill(255, 50);
  textAlign(BASELINE + 1000);
}

// visualization switch controls
void keyPressed() {
  if ( key == '0' ) screen = 0;
  if ( key == '1' ) screen = 1;
  if ( key == '2' ) screen = 2;
}

// Visualization Functions 

// wavelength visualization
void wavelength() {
  // changes wavelength colors
  color[] bgcolors = new color[39];
  bgcolors[0] = #000018;
  bgcolors[1] = lerpColor(bgcolors[0],bgcolors[2],.5);
  bgcolors[2] = #180000;
  bgcolors[3] = lerpColor(bgcolors[2],bgcolors[4],.5);
  bgcolors[4] = #181818;  
  bgcolors[5] = lerpColor(bgcolors[4],bgcolors[6],.5);
  bgcolors[6] = #183030;
  bgcolors[7] =lerpColor(bgcolors[6],bgcolors[8],.5);
  bgcolors[8] = #303048;
  bgcolors[9] = lerpColor(bgcolors[8],bgcolors[10],.5);
  bgcolors[10] = #304860;
  bgcolors[11] = lerpColor(bgcolors[10],bgcolors[12],.5);
  bgcolors[12] = #486060;
  bgcolors[13] = lerpColor(bgcolors[12],bgcolors[14],.5);
  bgcolors[14] = #603018;
  bgcolors[15] = lerpColor(bgcolors[14],bgcolors[16],.5);
  bgcolors[16] = #903030;
  bgcolors[17] = lerpColor(bgcolors[16],bgcolors[18],.5);
  bgcolors[18] = #904818;
  bgcolors[19] = lerpColor(bgcolors[18],bgcolors[20],.5);
  bgcolors[20] = #C04848;
  bgcolors[21] = lerpColor(bgcolors[20],bgcolors[22],.5);
  bgcolors[22] = #D83030;
  bgcolors[23] = lerpColor(bgcolors[22],bgcolors[24],.5);
  bgcolors[24] = #A84848;
  bgcolors[25] = lerpColor(bgcolors[24],bgcolors[26],.5);
  bgcolors[26] = #D89078;
  bgcolors[27] = lerpColor(bgcolors[26],bgcolors[28],.5);
  bgcolors[28] = #D86060;
  bgcolors[29] = lerpColor(bgcolors[28],bgcolors[30],.5);
  bgcolors[30] = #F0C0A8;
  bgcolors[31] = lerpColor(bgcolors[30],bgcolors[32],.5);
  bgcolors[32] = #D87878;
  bgcolors[33] = lerpColor(bgcolors[32],bgcolors[34],.5);
  bgcolors[34] = #A84848;
  bgcolors[35] = lerpColor(bgcolors[34],bgcolors[36],.5);
  bgcolors[36] = #F09078;
  bgcolors[37] = lerpColor(bgcolors[36],bgcolors[38],.5);
  bgcolors[38] = #F0A890;
  stroke(bgcolors[reverseCounter]);
  reverseCounter = (reverseCounter - 1) % 38;
  if (reverseCounter <= 0){
    reverseCounter = 38;}
 
 // wavelength dynamics
  strokeWeight(10);
  noFill();
  waveform.analyze();
  beginShape();
  for (int i = 0; i < samples; i++) {
    vertex(
      map(i, 0, samples, 0, width), 
      map(waveform.data[i], -1, 1, 0, height*1.2)
      );
  }
  endShape();
}

  //sound graph visualization
void soundGraph () {
// changeds bar colors
  color[] bgcolors = new color[39];
  bgcolors[0] = #000018;
  bgcolors[1] = lerpColor(bgcolors[0],bgcolors[2],.5);
  bgcolors[2] = #180000;
  bgcolors[3] = lerpColor(bgcolors[2],bgcolors[4],.5);
  bgcolors[4] = #181818;  
  bgcolors[5] = lerpColor(bgcolors[4],bgcolors[6],.5);
  bgcolors[6] = #183030;
  bgcolors[7] =lerpColor(bgcolors[6],bgcolors[8],.5);
  bgcolors[8] = #303048;
  bgcolors[9] = lerpColor(bgcolors[8],bgcolors[10],.5);
  bgcolors[10] = #304860;
  bgcolors[11] = lerpColor(bgcolors[10],bgcolors[12],.5);
  bgcolors[12] = #486060;
  bgcolors[13] = lerpColor(bgcolors[12],bgcolors[14],.5);
  bgcolors[14] = #603018;
  bgcolors[15] = lerpColor(bgcolors[14],bgcolors[16],.5);
  bgcolors[16] = #903030;
  bgcolors[17] = lerpColor(bgcolors[16],bgcolors[18],.5);
  bgcolors[18] = #904818;
  bgcolors[19] = lerpColor(bgcolors[18],bgcolors[20],.5);
  bgcolors[20] = #C04848;
  bgcolors[21] = lerpColor(bgcolors[20],bgcolors[22],.5);
  bgcolors[22] = #D83030;
  bgcolors[23] = lerpColor(bgcolors[22],bgcolors[24],.5);
  bgcolors[24] = #A84848;
  bgcolors[25] = lerpColor(bgcolors[24],bgcolors[26],.5);
  bgcolors[26] = #D89078;
  bgcolors[27] = lerpColor(bgcolors[26],bgcolors[28],.5);
  bgcolors[28] = #D86060;
  bgcolors[29] = lerpColor(bgcolors[28],bgcolors[30],.5);
  bgcolors[30] = #F0C0A8;
  bgcolors[31] = lerpColor(bgcolors[30],bgcolors[32],.5);
  bgcolors[32] = #D87878;
  bgcolors[33] = lerpColor(bgcolors[32],bgcolors[34],.5);
  bgcolors[34] = #A84848;
  bgcolors[35] = lerpColor(bgcolors[34],bgcolors[36],.5);
  bgcolors[36] = #F09078;
  bgcolors[37] = lerpColor(bgcolors[36],bgcolors[38],.5);
  bgcolors[38] = #F0A890;
  fill((bgcolors[reverseCounter]));
  reverseCounter = (reverseCounter - 1) % 38;
  if (reverseCounter <= 0){
    reverseCounter = 38;}
 
  // sound graph dynamics
  noStroke();
  fft.analyze();
  for (int i = 0; i < bands; i++) {
    sum2[i] += (fft.spectrum[i] - sum2[i]) * smoothingFactor;
    rect(i*barWidth, height, barWidth, -sum2[i]*height*scale);
  }
}

  //circle resize visualization
void circleResize() {
  color[] bgcolors = new color[39];
  bgcolors[0] = #000018;
  bgcolors[1] = lerpColor(bgcolors[0],bgcolors[2],.5);
  bgcolors[2] = #180000;
  bgcolors[3] = lerpColor(bgcolors[2],bgcolors[4],.5);
  bgcolors[4] = #181818;  
  bgcolors[5] = lerpColor(bgcolors[4],bgcolors[6],.5);
  bgcolors[6] = #183030;
  bgcolors[7] =lerpColor(bgcolors[6],bgcolors[8],.5);
  bgcolors[8] = #303048;
  bgcolors[9] = lerpColor(bgcolors[8],bgcolors[10],.5);
  bgcolors[10] = #304860;
  bgcolors[11] = lerpColor(bgcolors[10],bgcolors[12],.5);
  bgcolors[12] = #486060;
  bgcolors[13] = lerpColor(bgcolors[12],bgcolors[14],.5);
  bgcolors[14] = #603018;
  bgcolors[15] = lerpColor(bgcolors[14],bgcolors[16],.5);
  bgcolors[16] = #903030;
  bgcolors[17] = lerpColor(bgcolors[16],bgcolors[18],.5);
  bgcolors[18] = #904818;
  bgcolors[19] = lerpColor(bgcolors[18],bgcolors[20],.5);
  bgcolors[20] = #C04848;
  bgcolors[21] = lerpColor(bgcolors[20],bgcolors[22],.5);
  bgcolors[22] = #D83030;
  bgcolors[23] = lerpColor(bgcolors[22],bgcolors[24],.5);
  bgcolors[24] = #A84848;
  bgcolors[25] = lerpColor(bgcolors[24],bgcolors[26],.5);
  bgcolors[26] = #D89078;
  bgcolors[27] = lerpColor(bgcolors[26],bgcolors[28],.5);
  bgcolors[28] = #D86060;
  bgcolors[29] = lerpColor(bgcolors[28],bgcolors[30],.5);
  bgcolors[30] = #F0C0A8;
  bgcolors[31] = lerpColor(bgcolors[30],bgcolors[32],.5);
  bgcolors[32] = #D87878;
  bgcolors[33] = lerpColor(bgcolors[32],bgcolors[34],.5);
  bgcolors[34] = #A84848;
  bgcolors[35] = lerpColor(bgcolors[34],bgcolors[36],.5);
  bgcolors[36] = #F09078;
  bgcolors[37] = lerpColor(bgcolors[36],bgcolors[38],.5);
  bgcolors[38] = #F0A890;
  fill((bgcolors[reverseCounter]));
  reverseCounter = (reverseCounter - 1) % 38;
  if (reverseCounter <= 0){
    reverseCounter = 38;}
 
 // circle dynamics and shape code
  sum += (rms.analyze() - sum) * smoothingFactor;
  float rms_scaled = sum * (height/2) * 2;
  ellipse(1200, 800, rms_scaled, rms_scaled);
}
