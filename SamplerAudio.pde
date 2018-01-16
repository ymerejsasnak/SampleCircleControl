enum RecordMode
{
  TO_LOOP, TO_FILE 
}

public class SamplerAudio 
{
  
  AudioContext audioContext;
  
  SamplePlayer[] samplers;
  int[] sampleLengths;
  
  
  LPRezFilter filter;
  TapIn combDelayIn;
  TapOut combDelayOut;
  Gain combGain;
  TapIn delayIn;
  TapOut delayOut;
  Gain delayGain; 
  Gain gain;

  Gain[] samplerGains;
  
  Glide[] gainGlides;
  Glide[] startGlides;
  Glide[] endGlides;
   
  Glide gainGlide;
  Glide rateGlide, directionGlide;
  Glide lpFreqGlide, lpRezGlide;
  Glide combTimeGlide, combFeedbackGlide;
  Glide delayTimeGlide, delayFeedbackGlide;

  Sample recordedOutput;
  RecordToSample recorder;
  
  SamplerAudio() 
  {
       
    audioContext = new AudioContext();
    
    samplers = new SamplePlayer[4];
    sampleLengths = new int[4]; 
    
    rateGlide = new Glide(audioContext, 1, GLIDE_TIME);
    directionGlide = new Glide(audioContext, 1, DIRECTION_GLIDE_TIME);
    
    samplerGains = new Gain[4];
    gainGlides = new Glide[4];
    startGlides = new Glide[4];
    endGlides = new Glide[4];
    for (int index = 0; index < 4; index++)
    {
      gainGlides[index] = new Glide(audioContext, MAX_SAMPLER_GAIN, GLIDE_TIME);
      samplerGains[index] = new Gain(audioContext, 2, gainGlides[index]);
      startGlides[index] = new Glide(audioContext, 0, GLIDE_TIME);      
      endGlides[index] = new Glide(audioContext, 1, GLIDE_TIME);
    }
        
        // need scaling mixer
        // need mix gain for each sampler
        
    lpFreqGlide = new Glide(audioContext, 11025, GLIDE_TIME);
    lpRezGlide = new Glide(audioContext, .4, GLIDE_TIME);
    filter = new LPRezFilter(audioContext, 2 /*channels*/, lpFreqGlide, lpRezGlide);
        
    combFeedbackGlide = new Glide(audioContext, 0.0, GLIDE_TIME);
    combGain = new Gain(audioContext, 1, combFeedbackGlide);
    
    combDelayIn = new TapIn(audioContext, 100);
    combTimeGlide = new Glide(audioContext, 40, GLIDE_TIME);
    combDelayOut = new TapOut(audioContext, combDelayIn, combTimeGlide);
    
    delayFeedbackGlide = new Glide(audioContext, 0.0, GLIDE_TIME);
    delayGain = new Gain(audioContext, 1, delayFeedbackGlide);
    
    delayIn = new TapIn(audioContext, 2000);
    delayTimeGlide = new Glide(audioContext, 1000, GLIDE_TIME);
    delayOut = new TapOut(audioContext, delayIn, delayTimeGlide);
    
    
    combDelayIn.addInput(filter);
    combGain.addInput(combDelayOut);
    combDelayIn.addInput(combGain);
    
    delayIn.addInput(combGain);
    delayIn.addInput(filter);
    delayGain.addInput(delayOut);
    delayIn.addInput(delayGain);
    
    //gain.addInput(filter);
    audioContext.out.addInput(filter);
    audioContext.out.addInput(combGain);
    audioContext.out.addInput(delayGain);
    
    recordedOutput = new Sample(100);
    recorder = new RecordToSample(audioContext, recordedOutput, RecordToSample.Mode.INFINITE);
    recorder.addInput(audioContext.out);
    recorder.pause(true);
    audioContext.out.addDependent(recorder);
    
    audioContext.start();
    
    
    //selectInput("load a file", "loadfile", dataFile("data"), this);
  }
  
  
  void loadNewFile()
  {
    //audioContext.stop();  //???
    selectInput("load a file", "loader", dataFile("data"), this);
  }
  
    
  public void loader(File selection)
  {
    //recorder.pause(true); //just in case??? or only run all this IF not recording?
    if (selection == null) {}
    
    else {
      setupSampler(surfaceListener.getLastSelectedIndex(), selection.getAbsolutePath());
    }
  }
  
  
  
  void setupSampler(int samplerIndex, String fileName) 
  {
    if (samplers[samplerIndex] == null)
    {
      samplers[samplerIndex] = new SamplePlayer(audioContext, SampleManager.sample(fileName));

      samplers[samplerIndex].setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
      samplers[samplerIndex].setInterpolationType(SamplePlayer.InterpolationType.CUBIC);
      samplers[samplerIndex].setKillOnEnd(false);
      
      samplers[samplerIndex].setRate(new Mult(audioContext, rateGlide, directionGlide));
       
      sampleLengths[samplerIndex] = (int)samplers[samplerIndex].getSample().getLength();  
       
      samplers[samplerIndex].setLoopStart(startGlides[samplerIndex]);
            
      samplers[samplerIndex].setLoopEnd(endGlides[samplerIndex]);
      endGlides[samplerIndex].setValueImmediately(sampleLengths[samplerIndex]);
    
      samplerGains[samplerIndex].addInput(samplers[samplerIndex]);
      filter.addInput(samplerGains[samplerIndex]); 
    }
    
    else
    {
      samplers[samplerIndex].setSample(SampleManager.sample(fileName));
      samplers[samplerIndex].setToLoopStart();
      
      sampleLengths[samplerIndex] = (int)samplers[samplerIndex].getSample().getLength();
      
                  
      endGlides[samplerIndex].setValueImmediately(sampleLengths[samplerIndex]);
    
      
      CircleControl loop = (LoopCircle) circles.get(1);
      loop.updateUgens();
      
      
      
    
    }
    
      
    //gainGlide = new Glide(audioContext, 0.6, 50);
    //gain = new Gain(audioContext, 2, gainGlide);
    
    //audioContext.start(); //?
        
  }
  
  
  /*boolean noSamplers() {
    for (int samplerIndex = 0; samplerIndex < 4; samplerIndex++)
    {
      if (samplers[samplerIndex] != null)
      {
        return false;
      }
    }
    return true;  
  }*/
  
  
  void setPlayForward() {
    directionGlide.setValue(1);
  }
  
  
  void setPlayReverse() {
    directionGlide.setValue(-1);
  }

  
 

  void recordToFile() {
    if (recorder.isPaused()) {
      println("now recording");
      recorder.pause(false);
    }
    else {
      recorder.pause(true); 
      recorder.clip();
                  //use SelectOutput to save file, not this junk!
      String saveName = String.valueOf(year() + month() + day() + hour() + minute() + second() + millis());
      try {
        recordedOutput.write(dataPath(saveName + ".wav"), AudioFileType.WAV);
        println("file " + saveName + ".wav saved");
      }
      catch (IOException e) {
        println("couldn't save");
      }
      recordedOutput = new Sample(100);
      recorder.setSample(recordedOutput);
      recorder.reset();
    }
  }
  
  void recordToLoop() {
    
  }
}