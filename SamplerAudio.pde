class SamplerAudio {
  
  AudioContext audioContext;
  
  SamplePlayer sampler;
  Gain gain;
  Glide pitchGlide, gainGlide;
  
  int playDirection = 1;
  
  String filename = dataPath("horns.wav");
  
  
  SamplerAudio() {
    
    audioContext = new AudioContext();
    
    try {
      sampler = new SamplePlayer(audioContext, SampleManager.sample(filename));
    }
    catch (Exception e) {
      println("error");
      stop();
    }
    
    sampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    sampler.setToLoopStart();
    sampler.setKillOnEnd(false);
    gain = new Gain(audioContext, 2, 0.4);
   
    pitchGlide = new Glide(audioContext, 1, 50);
    sampler.setRate(pitchGlide);
   
    gainGlide = new Glide(audioContext, 0.4, 50);
    gain.setGain(gainGlide);
   
    gain.addInput(sampler);
    audioContext.out.addInput(gain);
    
    audioContext.start();
  }
  
  
  void setPlayForward() {
    playDirection = 1;
  }
  
  
  void setPlayReverse() {
    playDirection = -1;
  }
  
  
  void setPlayRate(float playRate) {
    pitchGlide.setValue(playRate * playDirection);
  }
  
  
  
  
}