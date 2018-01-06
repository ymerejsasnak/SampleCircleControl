class SamplerAudio {
  
  AudioContext audioContext;
  
  int sampleLength;
  
  GranularSamplePlayer sampler;
  Gain gain;
  Glide gainGlide;
  Glide pitchGlide, directionGlide;
  Glide startGlide, endGlide;
  Glide grainIntervalGlide, grainSizeGlide;
    
  String filename = dataPath("dog.WAV");
  
  
  SamplerAudio() {
    
    audioContext = new AudioContext();
    
    try {
      sampler = new GranularSamplePlayer(audioContext, SampleManager.sample(filename));
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
    
    pitchGlide = new Glide(audioContext, 1, 50);
    sampler.setPitch(pitchGlide);
    
    directionGlide = new Glide(audioContext, 1, 50);
    sampler.setRate(directionGlide);
      
    startGlide = new Glide(audioContext, 0, 50);
    sampler.setLoopStart(startGlide);
    endGlide = new Glide(audioContext, sampleLength, 50);
    sampler.setLoopEnd(endGlide);
    
    grainIntervalGlide = new Glide(audioContext, 1, 50);
    sampler.setGrainInterval(grainIntervalGlide);
    grainSizeGlide = new Glide(audioContext, 1, 50);
    sampler.setGrainSize(grainSizeGlide);
       
    gain.addInput(sampler);
    audioContext.out.addInput(gain);
    
    audioContext.start();
  }
  
  
  void setPlayForward() {
    directionGlide.setValue(1);
  }
  
  
  void setPlayReverse() {
    directionGlide.setValue(-1);
  }
  
  
  void setPitch(float pitch) {
    pitchGlide.setValue(pitch);
  }
  
  
  void setLoopStart(float loopStart) {
    startGlide.setValue(sampleLength * loopStart); 
  }
  
  void setLoopLength(float loopLength) {
    float loopEnd = startGlide.getValue() + loopLength * sampleLength;
    if (loopEnd > sampleLength) {
      loopEnd = sampleLength;
    }
    endGlide.setValue(loopEnd); 
  }
  
  void setGrainInterval(float interval) {
    grainIntervalGlide.setValue(interval); 
  }
  
  void setGrainSize(float size) {
     grainSizeGlide.setValue(size);
  }
  
  
  
}