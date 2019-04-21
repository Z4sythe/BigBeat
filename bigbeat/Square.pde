class Square {

  PVector location;
  PVector velocity;
  float xLength, yLength;
  int age;
  int fade;

  Square(float x, float y, float xLength, float yLength) {
    
    location = new PVector(x,y);
    velocity = new PVector(5,5);
    this.xLength = xLength;
    this.yLength = yLength;
    age = 0;
    fade = 500;
  }
  
  void update() {
    location.add(velocity);
  }
  
  void display(float[] wave){
    fill(hue,255,255,fade);
    stroke(255,fade);
    beginShape();
    //float randSpin = random(0, 40);  // Adjust with intensity of rhythm
    for(int i = 0 ; i < xLength; i +=1)
    {
      vertex(location.x+i,location.y+wave[i]);
    }
    for(int i = 0 ; i < yLength; i +=1)
    {
      vertex(location.x+xLength+wave[i],location.y+i);
    }
    for(int i = 0 ; i < xLength; i +=1)
    {
      vertex(location.x+xLength-i,location.y+yLength+wave[i]);
    }
    for(int i = 0; i < yLength; i +=1)
    {
      vertex(location.x+wave[i],location.y+yLength-i);
    }
    
    endShape(CLOSE);
          
  }
  
  void checkEdges(){
    
    if(location.x+xLength > width)
    {
      location.x = width-xLength;
      //velocity.x *= -1;
      velocity.x = -random(1,10);
    }
    else if(location.x < 0)
    {
      location.x = 0;
      //velocity.x *= -1;
      velocity.x = random(1,10);
    }
    else if(location.y+yLength > 500)
    {
      location.y = 500-yLength;
      //velocity.y *= -1;
      velocity.y = -random(1,10);
    }
    else if(location.y < 0){
      location.y = 0;
      //velocity.y *= -1;
      velocity.y = random(1,10);
    }
  }

  int ageCheck(){
    age++;
    return age;
  }

  boolean fadeOut(){
    fade -= 5;
    return(fade < 0);
  }
}
