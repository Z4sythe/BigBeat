class Bars {
  
  float[] arr;
  int fade = 500;
  
  Bars(int barCount){
    arr = new float[barCount];
  }
  
  void update(){
    fft.forward(input.mix);

    for(int i = 0; i < arr.length; i+=1){
      float val = map(fft.getBand(i),0,200,0,500);
      arr[i] = val;
    }
  }
  
  void display(){
    int w = width/arr.length;
    stroke(0);
    strokeWeight(0.5);
    fill(255,100);
    for(int i = 0; i < arr.length; i++)
    {
      fill(map(arr[i],0,500,100,255), 100*random(0,255), 100*random(0,255));
      rect(i*w,500-arr[i],w-0.5,arr[i]);
    }
  }
}
