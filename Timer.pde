class Timer 
{
  
  int waitTime;
  int startTime;
  
  
  Timer(int waitTime) 
  {
    this.waitTime = waitTime; 
    startTime = millis();
  }
  
  
  void resetTimer()
  {
    startTime = millis(); 
  }
  
  
  boolean checkTimer()
  {
    if (millis() - startTime > waitTime)
    {
      resetTimer();
      return true;
    }  
    else 
    {
      return false; 
    }
    
  }
  
}