package com.cg.hackathon.imageprocessor.message;

import org.json.JSONObject;

public class ImageProcessorMessage {

       private JSONObject jsonMessage;
 
       public JSONObject getJsonMessage() {
              return jsonMessage;
       }
 
       public void setJsonMessage(JSONObject jsonMessage) {
              this.jsonMessage = jsonMessage;
       }
 
       @Override
       public String toString() {
              return "ImageProcessorMessage [jsonMessage=" + jsonMessage + "]";
       }

}
