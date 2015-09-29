ArrayList<polySketch> hexs;
ArrayList<PVector> hexagons;
PVector pick;
float radius;
int n_points, counter, i, sketchCount, j, p;
float minDist, y_increment;

void setup() {
  size(500,500);
  background(255);
  sketchCount = 0;
  
  radius = 100;
  minDist = radius;
  n_points = 6;
  j = 0;
  p = 0;
  
  hexs = new ArrayList<polySketch>();
  hexagons = new ArrayList<PVector>();
  
  y_increment = radius*sqrt(3)/2;

  for (y=0; y<height; y+= y_increment) {
    p++;
    for (x=-radius; x<width; x+=3*radius) {
      if (p%2 == 0) {
        hexs.add(new polySketch(x+1.5*radius,y,radius,n_points));
      } else {
        //offsets hexagon to allow for tessellation
        hexs.add(new polySketch(x,y,radius,n_points));
      }
    }
  }
}

void draw() {
  colorMode(HSB);
  for(int i=0; i<50; i++) {
    strokeWeight(0.01);
    for(polySketch points : hexs) {
      sketchCount++;
      //randomly assigning colour
      stroke((sketchCount*10)%255,255,255);  
      hexagons = points.vertices();
      for (PVector p : hexagons) {
        pick = hexagons.get(int(random(0,hexagons.size()-1)));
        if (pick.dist(p) > minDist && random(0,1) > 0.99) {
          line(p.x, p.y, pick.x, pick.y);
       }
     }
    }
    sketchCount = 0;
  }
  noLoop();
}