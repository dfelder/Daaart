import 'dart:html';
import 'dart:math';

import 'Obstacle.dart';

CanvasElement canvas = querySelector("#game");
CanvasRenderingContext2D ctx = canvas.getContext('2d');
double lastHeight = canvas.height/2+15;
double gForce = 5.0;
double timeUp = double.INFINITY;
Random rand = new Random(); 
var margin = 0;
MediaElement plop = querySelector("#plop");
int distance = 0, pipes=0;

List<Obstacle> queue = new List();

void main() {
  window.animationFrame.then(draw);
  initListeners();
  MediaElement welcome = querySelector("#welcome");
  welcome.play();
}

void draw(num){
  ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  
  timeUp += 1;
  
  var y = height();
  
  if(queue.isEmpty || queue[queue.length-1].x+margin < ctx.canvas.width){
    queue.add(new Obstacle(ctx.canvas.width, ctx.canvas.height));
    margin = rand.nextInt(200)+500;
  }
  
  bool obs = false;
  for(Obstacle i in queue){
    i.x = i.x-6;
    if(i.x<-i.width){
      pipes++;
      obs = true;      
    }
    i.paint(ctx);
    if(i.checkCollision(100, y)){
      gameOver();
      return;
    }
  }
  if(obs) queue.removeAt(0);
  
  distance++;

  ctx.beginPath();
  
  ImageElement img = document.querySelector("#dart");
  ctx.drawImageScaled(img, 100, y, 32,32);
  
  window.animationFrame.then(draw);  
}

void gameOver(){
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  
  ctx.fillStyle = 'white';
  ctx.font="30px Arial";
  ctx.textAlign="center";
  ctx.fillText("Game over!", ctx.canvas.width/2, 120);
  
  ctx.font="14px Arial";
  ctx.fillText("Distance: " + distance.toString() + " | Pipes: "+pipes.toString()+" x 50", ctx.canvas.width/2, 150);
  ctx.fillText("Score:" + (distance + pipes*50).toString(), ctx.canvas.width/2, 170);
  
  
  
  
  MediaElement audioOver = querySelector("#audioGameOver");
  audioOver.play();
}

double height(){
  lastHeight = lastHeight + gForce - upForce(timeUp);
  return lastHeight;
}

void initListeners(){
  window.onKeyDown.listen((KeyboardEvent e) {
    if (e.keyCode == KeyCode.SPACE) {
      timeUp = 0.0;
      plop.play();
    }
  });
}

double upForce(double time){
  return (time/20 < PI/2) ? cos(time/20)*10 : 0.0;
}





