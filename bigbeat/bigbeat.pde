// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;
import ddf.minim.*;
import java.awt.Font;
import ddf.minim.analysis.*;

public int tempo, beats, delay, inst1Note, inst2Note, inst3Note;
public float inst1Vel, inst2Vel, inst3Vel;
public boolean[] inst1Play, inst2Play, inst3Play;
volatile boolean paused;
public String[] insts1, insts2, insts3;
public GCheckbox[][] boxes;
int i = 0;
PFont font;

Minim minim;
AudioInput input;
public ArrayList<AudioPlayer> inst1Notes, inst2Notes, inst3Notes;
MusicPlayer musicPlayer;

//visualizer stuff
ArrayList<Square> square;
ArrayList<Circle> circle;
float hue = 20;
boolean sq = true;
float[] wave;

Bars bars;
BeatDetect beat;
FFT fft;

long startTime = System.currentTimeMillis();

public void setup(){
  fullScreen(JAVA2D);
  //background(0);
  createGUI();
  customGUI();
  // Place your setup code here
  inst1Play = new boolean[]{false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false};
  inst2Play = new boolean[]{false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false};
  inst3Play = new boolean[]{false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false};
  
  tempo = tempoSlider.getValueI();
  beats = beatsSlider.getValueI();
  inst1Vel = inst1Velo.getValueF();
  inst2Vel = inst2Velo.getValueF();
  inst3Vel = inst3Velo.getValueF();
  delay = (15000 / tempo);
  paused = true;
  inst1Note = 0;
  inst2Note = 0;
  inst3Note = 0;
  font = createFont("Helvetica", 16);
  
  minim = new Minim(this);
  input = minim.getLineIn();
  inst1Notes = new ArrayList<AudioPlayer>();
  inst2Notes = new ArrayList<AudioPlayer>();
  inst3Notes = new ArrayList<AudioPlayer>();
  inst1Notes.add(minim.loadFile("BluntKick.wav"));
  inst1Notes.add(minim.loadFile("Kick02.wav"));
  inst2Notes.add(minim.loadFile("Snare01.wav"));
  inst2Notes.add(minim.loadFile("Rim01.wav"));
  inst2Notes.add(minim.loadFile("Strings01.wav"));
  inst3Notes.add(minim.loadFile("HiHat01.wav"));
  inst3Notes.add(minim.loadFile("Ride01.wav"));
  inst3Notes.add(minim.loadFile("KotoTest01.wav"));
  inst3Notes.add(minim.loadFile("Strings01.wav"));
  
  beat = new BeatDetect();
  fft = new FFT(input.bufferSize(), input.sampleRate());
  square = new ArrayList<Square>();
  circle = new ArrayList<Circle>();
  bars = new Bars(100);
  wave = new float[input.mix.size()];
  colorMode(HSB);
  
  musicPlayer = new MusicPlayer();
  Thread musicThread = new Thread(musicPlayer);
  musicThread.start();
}

public void draw() {
  background(20);
  fill(255);
  textSize(68);
  fill(hue, 255, 255);
  text("BIGBEAT", 675, 690);
  visualize();
  
  textFont(font);
  textSize(16);
  fill(220);
  text("Instruments", 47, 540);
  text("Beat Selection", 265, 540);
  text("Velocity", 542, 540);
  text("Tempo", 705, 540);
  text("Beats per Measure", 824, 540);
  
  fill(45, 255, 250, 90);
  rect(157 + ((musicPlayer.barLoc) * 20), 560, 20, 140);
  
  if (keyPressed && key == 'p') {
     paused = !paused;
     println("paused is now " + paused);
  }
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  Font font = FontManager.getFont("Helvetica", Font.PLAIN, 13);
  instList1.setFont(font);
  instList2.setFont(font);
  instList3.setFont(font);
  
  String strings1[] = new String[] {"Kick", "Kick 2"};
  String strings2[] = new String[] {"Snare", "Rim", "Strings"};
  String strings3[] = new String[] {"HiHat", "Ride", "Koto", "Strings"};
  
  instList1.setItems(strings1, 0);
  instList2.setItems(strings2, 0);
  instList3.setItems(strings3, 0);
}

public void visualize() {
  beat.detect(input.mix);
  bars.update();  
  bars.display();
  
  for(int i = 0; i < input.mix.size() - 1; i++) {
    wave[i] = input.mix.get(i)*8;
  }
    
  for(int s = square.size()-1; s >= 0; s--) {
    square.get(s).update();
    square.get(s).display(wave);
    square.get(s).checkEdges();
    if(square.get(s).ageCheck() > 260) {
      if(square.get(s).fadeOut()) {
        square.remove(s);
      }
    }
  }
    
  for(int i = 0; i < circle.size()-1; i++) {
    circle.get(i).update();
    circle.get(i).display(wave);
    circle.get(i).checkEdges();
    if(circle.get(i).ageCheck() > 260){
      if(circle.get(i).fadeOut()) {
        circle.remove(i);
      }
    }
   }

  if(beat.isOnset()) {
    hue = random(255);
    float d = random(16,64);
    if(sq && square.size() < 100) {
      square.add(new Square(random(width),random(500),d,d));
      sq = false;
    }
    else if(!sq && circle.size() < 100) {
      circle.add(new Circle(random(width),random(500),d/2));
      sq = true;
    }
  } 
}