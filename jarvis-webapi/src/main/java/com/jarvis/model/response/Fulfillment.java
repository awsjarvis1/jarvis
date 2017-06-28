package com.jarvis.model.response;

import java.util.List;

public class Fulfillment {

private String speech;
private String source;
private String displayText;
private List<Message> messages = null;

public String getSpeech() {
return speech;
 }

public void setSpeech(String speech) {
this.speech = speech;
 }

public String getSource() {
return source;
 }

public void setSource(String source) {
this.source = source;
 }

public String getDisplayText() {
return displayText;
 }

public void setDisplayText(String displayText) {
this.displayText = displayText;
 }

public List<Message> getMessages() {
return messages;
 }

public void setMessages(List<Message> messages) {
this.messages = messages;
 }

}