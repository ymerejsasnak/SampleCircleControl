class SamplerAudio {
  
  AudioContext audioContext;
  
  int sampleLength;
  
  SamplePlayer sampler;
  Gain gain;
  Glide gainGlide;
  Glide rateGlide, directionGlide;
  Glide startGlide, endGlide;
  
  int playDirection = 1;
 
    
  String filename = dataPath("drums.wav");
  
  
  SamplerAudio() {
    
    audioContext = new AudioContext();
    
    try {
      sampler = new SamplePlayer(audioContext, SampleManager.sample(filename));
    }
    catch (Exception e) {
      println("error");
      stop();
    }
        
    sampleLength = (int)sampler.getSample().getLength();
    sampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    sampler.setToLoopStart();
    sampler.setKillOnEnd(false);
    
    gain = new Gain(audioContext, 2, 0.4);
    gainGlide = new Glide(audioContext, 0.4, 50);
    gain.setGain(gainGlide);
    
    rateGlide = new Glide(audioContext, 1, 50);
    directionGlide = new Glide(audioContext, 1, 50);
    sampler.setRate(rateGlide);
      
    startGlide = new Glide(audioContext, 0, 50);
    sampler.setLoopStart(startGlide);
    endGlide = new Glide(audioContext, sampleLength, 50);
    sampler.setLoopEnd(endGlide);
    
       
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
  
  
  void setRate(float rate) {
    rateGlide.setValue(rate * playDirection);
  }
  
  
  void setLoopStart(float loopStart) {
    startGlide.setValue(sampleLength * loopStart); 
  }
  
  void setLoopLength(float loopLength) {
    float loopEnd = startGlide.getValue() + loopLength * sampleLength;
    if (loopEnd > sampleLength) {
      loopEnd = sampleLength - 1;
    }
    endGlide.setValue(loopEnd); 
  }
  
 
  
  
}