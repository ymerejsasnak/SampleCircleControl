void keyReleased() {
  //L to load, R to record, R to record, R again to stop recording 
  if (key == 'L' || key == 'l') {
    samplerAudio.loadNewFile();
    
  }
  else if (key == 'R' || key == 'r') {
    samplerAudio.record();
  }

}