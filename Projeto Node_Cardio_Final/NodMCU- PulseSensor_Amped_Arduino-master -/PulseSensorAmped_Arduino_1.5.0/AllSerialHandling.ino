void serialOutput(){   // Decide How To Output Serial.
  switch(outputType){
    case PROCESSING_VISUALIZER:
      sendDataToSerial('S', Signal);     // goes to sendDataToSerial function
      break;
    case SERIAL_PLOTTER:  // open the Arduino Serial Plotter to visualize these data

  //sprintf(sendBuffer, "%d", BPM);
 //client.publish("esp/test", sendBuffer);

 Serial.print(BPM);
 Serial.print(",");
 Serial.print(IBI);
  Serial.print(",");
      Serial.println(Signal);
     
      break;
    default:
      break;
  }


}



//  Sends Data to Pulse Sensor Processing App, Native Mac App, or Third-party Serial Readers.
void sendDataToSerial(char symbol, int data ){
    Serial.print(symbol);
    Serial.println(data);
  }
