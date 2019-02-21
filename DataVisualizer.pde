import processing.serial.*;
Serial myPort;
String sensorReading="";
import java.io.BufferedWriter;
import java.io.FileWriter;
String outFilename = "data.csv";
String timestamp = "";

void setup() {
  size(400,200);
  myPort = new Serial(this,"/dev/cu.usbmodem14601", 9600);   //COM__       
  myPort.bufferUntil('\n');
  writeText("data visualization, stop with any key");            
}

void draw() {
 
}  

void serialEvent (Serial myPort){
 sensorReading = myPort.readStringUntil('\n');
  if(sensorReading != null){
    sensorReading=trim(sensorReading);
  }    
  writeText("Sensor Reading: " +  sensorReading);
  appendTextToFile(outFilename,  sensorReading);
}

void writeText(String textToWrite){
  background(255);
  fill(0);
  text(textToWrite, width/20, height/2);   
}

void keyPressed() {
  exit();  
}

void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));   
    out.println(text);
    out.close();                                      
  }catch (IOException e){
      e.printStackTrace();
  }
}
 
void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
     }
    catch(Exception e){
    e.printStackTrace();
    }
}    
