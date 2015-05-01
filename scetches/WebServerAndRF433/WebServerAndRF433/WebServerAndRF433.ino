/*
  Web Server + Proove RF library to controll power outlets.
  A simple web server using an Arduino Wiznet Ethernet shield. 
 
 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13
 * Analog inputs attached to pins A0 through A5 (optional)
 
 created 18 Dec 2009
 by David A. Mellis
 modified 9 Apr 2012
 by Tom Igoe
 
 2014-05-01
 Added RF Library (Proove) to be able to send RF commands to Proove devices.
 */

#include <SPI.h>
#include <Ethernet.h>
#include <tx433.h>

// Proove setup
String tx_proove = "0101010101010101010101010101010101010101010101010101";
String ch_proove="0101";
Tx433 Proove(7, tx_proove, ch_proove);
String request;

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = { 
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192,168,1,177);

// Initialize the Ethernet server library
// with the IP address and port you want to use 
// (port 80 is default for HTTP):
EthernetServer server(80);

void setup() {
 // Open serial communications and wait for port to open:
  Serial.begin(9600);
   while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // start the Ethernet connection and the server:
  Ethernet.begin(mac, ip);
  server.begin();
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());
}


void loop() {
  // listen for incoming clients
  EthernetClient client = server.available();
  
  if (client) {
    request = "";
    Serial.println("new client");
    
    // an http request ends with a blank line
    boolean currentLineIsBlank = true;
    
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        Serial.write(c);
        
        request += c;
        
        // if you've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so you can send a reply
        if (c == '\n' && currentLineIsBlank) {      
          
          // send a standard http response header
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/html");
          client.println("Connection: close");  // the connection will be closed after completion of the response
	  //client.println("Refresh: 5");  // refresh the page automatically every 5 sec

          client.println();
          client.println("<!DOCTYPE HTML>");
          client.println("<html>");
          client.println("<h3>Devices</h3>");
          
          /*
          client.println("<a href='http://192.168.1.177/?deviceOn0'>Device 1 on!</a><br><br>");
          client.println("<a href='?deviceOn1'>Device 2 on!</a><br><br>");
          client.println("<a href='?deviceOn2'>Device 3 on!</a><br><br>");
          client.println("<a href='?deviceOn3'>All devices on!</a><br><br>");
          
          client.println("<a href='http://192.168.1.177/?deviceOff0'>Device 1 off!</a><br><br>");
          client.println("<a href='?deviceOff1'>Device 2 off!</a><br><br>");
          client.println("<a href='?deviceOff2'>Device 3 off!</a><br><br>");
          client.println("<a href='?deviceOff3'>All devices off!</a><br><br>");
          */
          
          // output the value of each analog input pin
          /*
          for (int analogChannel = 0; analogChannel < 6; analogChannel++) {
            int sensorReading = analogRead(analogChannel);
            client.print("analog input ");
            client.print(analogChannel);
            client.print(" is ");
            client.print(sensorReading);
            client.println("<br />");       
          }*/
              
          client.println("</html>");
          break;
        }
        if (c == '\n') {
          // you're starting a new line
          currentLineIsBlank = true;
        } 
        else if (c != '\r') {
          // you've gotten a character on the current line
          currentLineIsBlank = false;
        }
      }
    }
    
    // Check for on commands
    if(request.indexOf("deviceOn0") >0) {
        Proove.Device_On(0);
        Serial.println("Device On: 0");
    }
    if(request.indexOf("deviceOn1") >0) {
      Proove.Device_On(1);
      Serial.println("Device On: 1");
    }
    if(request.indexOf("deviceOn2") >0) {
       Proove.Device_On(2);
       Serial.println("Device On: 2");
    }
    if(request.indexOf("deviceOnAll") >0) {
       Proove.Device_On(3);
       Serial.println("Device On: All");
    }
    
    // Check for off commands
    if(request.indexOf("deviceOff0") >0) { 
        Proove.Device_Off(0);
        Serial.println("Device Off: 0");
    }
    if(request.indexOf("deviceOff1") >0) {
       Proove.Device_Off(1);
       Serial.println("Device Off: 1");
    }
    if(request.indexOf("deviceOff2") >0) { 
       Proove.Device_Off(2);
       Serial.println("Device Off: 2");
    }
    if(request.indexOf("deviceOffAll") >0) { 
       Proove.Device_Off(3);
       Serial.println("Device Off: All");
    }
    
    
    // give the web browser time to receive the data
    delay(1);
    // close the connection:
    client.stop();
    Serial.println("client disconnected");

  }
}

