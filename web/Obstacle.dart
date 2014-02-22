import 'dart:math' show Random;

class Obstacle{
  
  int x, y, height, width;
  String color;
  var colors = ['yellow', 'green', 'red', 'blue'];
  
  Obstacle(int xStart, int canvasHeight){
    Random rand = new Random();
    x = xStart;
    height = rand.nextInt(80)+80;
    width = rand.nextInt(50)+30;
    y = rand.nextInt(canvasHeight-height);
    color = colors[rand.nextInt(colors.length)];
  }
  
  
  bool checkCollision(xDart,yDart){
    if(xDart+30 >= x && xDart <= x+width){
      if(yDart < y || yDart+30 > y+height) return true;
    } 
    return false;
  }
  
  void paint(ctx){
    ctx.fillStyle = color;
    ctx.fillRect(x, 0, width, y);
    ctx.fillRect(x, y+height, width, ctx.canvas.height);
  }
  
}