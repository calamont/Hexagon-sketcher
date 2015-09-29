class polySketch {
  int counter;
  float angle, dist, sx, sy, ssx, ssy, dx, dy;
  ArrayList<PVector> points;
  ArrayList<PVector> grads;
  PVector location;
  
  polySketch(float x, float y, float radius, int n_points) {
    counter = 0;
    angle = TWO_PI/n_points;
    dist = 2*radius*tan(PI/n_points);
    points = new ArrayList<PVector>();
    grads = new ArrayList<PVector>();
    
    //determining edges/vertices of the hexagon
    for (float a = 0; a < TWO_PI; a += angle) {
      sx = x + cos(a) * radius;
      sy = y + sin(a) * radius;
      if (a>0) {
        dx = (ssx-sx)/dist;
        dy = (ssy-sy)/dist;
        grads.add(new PVector(dx,dy));
      } else {
        location = new PVector(sx,sy);
      }
      ssx = sx;
      ssy = sy;
    }
    while (counter<(dist*n_points)) {
      int i = floor(counter/dist)%n_points;
      location.add(grads.get(i));
      PVector pt = new PVector(location.x+random(-1,1), location.y+random(-1,1));
      points.add(0, pt);
      counter += 1;
    }
  }
  
  ArrayList vertices() {
    return points;
  }
  
}