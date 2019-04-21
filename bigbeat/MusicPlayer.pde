class MusicPlayer implements Runnable {
  public int i;
  public int barLoc;
  MusicPlayer() {
    i = 0;
    barLoc = 0;
  }
  
  void run() {
    while (true) {
      if (!paused) {
        if (inst1Play[i]) {
          inst1Notes.get(inst1Note).rewind();
          inst1Notes.get(inst1Note).play();
        }
        if (inst2Play[i]) {
          inst2Notes.get(inst2Note).rewind();
          inst2Notes.get(inst2Note).play();
        }
        if (inst3Play[i]) {
          inst3Notes.get(inst3Note).rewind();
          inst3Notes.get(inst3Note).play();
        }
          
        if (i >= beats - 1) {
          i = 0;
          barLoc = beats - 1;
        } else {
          i++;
          barLoc = i - 1;
        }
        
        try { 
          Thread.sleep(delay);
        } catch (InterruptedException e) {
          println("oops");
        }
      }
    }
  }
  
}