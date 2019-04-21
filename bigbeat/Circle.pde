
class Circle {

  PVector location;
  PVector velocity;
  float radius;
  int age;
  int fade;

  Circle(float x, float y, float r){
    
    location = new PVector(x,y);
    velocity = new PVector(5,5);
    radius = r;
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
    
    pushMatrix();
    translate(location.x,location.y);
    for(float i = 0; i < TWO_PI; i += 0.1){
      float x = radius * cos(i);
      float y = radius * sin(i);
      vertex(x+(wave[floor(i*1)]),y+(wave[floor(i*1)]));
    }
    
    endShape(CLOSE);
    popMatrix();
    //ellipse(location.x,location.y,100,100);
      
  }
  
  void checkEdges(){
    
    if(location.x+radius > width)
    {
      location.x = width-radius;
      //velocity.x *= -1;
      velocity.x = -random(1,10);
    }
    else if(location.x < 0)
    {
      location.x = 0;
      //velocity.x *= -1;
      velocity.x = random(1,10);
    }
    else if(location.y+radius > 500)
    {
      location.y = 500-radius;
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
    fade -= 3;
    return(fade < 0);
  }
  
}
