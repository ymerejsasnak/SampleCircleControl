void keyReleased() {
  //L to load, R to record, R to record, S to stop recording 
  if (key == 'L' || key == 'l') {
    println("a");
    samplerAudio.loadNewFile();
    
  }
  else if (key == 'R' || key == 'r') {
    
  }
  else if (key == 'S' || key == 's') {
    
  }
}