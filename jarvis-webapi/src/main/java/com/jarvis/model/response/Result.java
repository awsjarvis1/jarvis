package com.jarvis.model.response;

import java.util.List;

public class Result {

private String source;
private String resolvedQuery;
private String action;
private Boolean actionIncomplete;
private Parameters parameters;
private List<Object> contexts = null;
private Metadata metadata;
private Fulfillment fulfillment;
private Double score;

public String getSource() {
return source;
 }

public void setSource(String source) {
this.source = source;
 }

public String getResolvedQuery() {
return resolvedQuery;
 }

public void setResolvedQuery(String resolvedQuery) {
this.resolvedQuery = resolvedQuery;
 }

public String getAction() {
return action;
 }

public void setAction(String action) {
this.action = action;
 }

public Boolean getActionIncomplete() {
return actionIncomplete;
 }

public void setActionIncomplete(Boolean actionIncomplete) {
this.actionIncomplete = actionIncomplete;
 }

public Parameters getParameters() {
return parameters;
 }

public void setParameters(Parameters parameters) {
this.parameters = parameters;
 }

public List<Object> getContexts() {
return contexts;
 }

public void setContexts(List<Object> contexts) {
this.contexts = contexts;
 }

public Metadata getMetadata() {
return metadata;
 }

public void setMetadata(Metadata metadata) {
this.metadata = metadata;
 }

public Fulfillment getFulfillment() {
return fulfillment;
 }

public void setFulfillment(Fulfillment fulfillment) {
this.fulfillment = fulfillment;
 }

public Double getScore() {
return score;
 }

public void setScore(Double score) {
this.score = score;
 }

}