package com.jarvis.model.response;

public class Response {

private String id;
private String timestamp;
private String lang;
private Result result;
private Status status;
private String sessionId;

public String getId() {
return id;
 }

public void setId(String id) {
this.id = id;
 }

public String getTimestamp() {
return timestamp;
 }

public void setTimestamp(String timestamp) {
this.timestamp = timestamp;
 }

public String getLang() {
return lang;
 }

public void setLang(String lang) {
this.lang = lang;
 }

public Result getResult() {
return result;
 }

public void setResult(Result result) {
this.result = result;
 }

public Status getStatus() {
return status;
 }

public void setStatus(Status status) {
this.status = status;
 }

public String getSessionId() {
return sessionId;
 }

public void setSessionId(String sessionId) {
this.sessionId = sessionId;
 }

}