var accessToken = "eb214ecede6246dc9ab5811610b558bd",
//var accessToken = "7d4f45de34c64ab696990f4b81151ddd",
// var accessToken ="e9c210fd37ec4504bbcf8bfed7b6b0a2",
      baseUrl = "https://api.api.ai/v1/",
      $speechInput,
      $recBtn,
      recognition,
      messageRecording = "Recording...",
      messageCouldntHear = "I couldn't hear you, could you say that again?",
      messageInternalError = "Oh no, there has been an internal server error",
      messageSorry = "I'm sorry, I don't have the answer to that yet.";

    $(document).ready(function() {
      $speechInput = $("#speech");
      $recBtn = $("#start_img");

      $speechInput.keypress(function(event) {
        if (event.which == 13) {
          event.preventDefault();
          send();
        }
      });
      $recBtn.on("click", function(event) {
        start_img.src = 'images/mic-slash.gif';
        if (window.SpeechSynthesisUtterance === undefined) {
      // Not supported
        } else {
        switchRecognition();
    }
      });
      $(".debug__btn").on("click", function() {
        $(this).next().toggleClass("is-active");
        return false;
      });
    });

    function startRecognition() {
      recognition = new webkitSpeechRecognition();
      recognition.continuous = false;
      recognition.interimResults = false;

      recognition.onstart = function(event) {
        //respond(messageRecording);
        updateRec();
      };
      recognition.onresult = function(event) {
        recognition.onend = null;
        
        var text = "";
          for (var i = event.resultIndex; i < event.results.length; ++i) {
            text += event.results[i][0].transcript;
          }
          setInput(text);
        stopRecognition();
      };
      recognition.onend = function() {
        respond(messageCouldntHear);
        stopRecognition();
      };
      recognition.lang = "en-US";
      recognition.start();
    }
  
    function stopRecognition() {
      if (recognition) {
        recognition.stop();
        recognition = null;
      }
      updateRec();
    }

    function switchRecognition() {
      if (recognition) {
        stopRecognition();
      } else {
        startRecognition();
      }
    }

    function setInput(text) {
      $speechInput.val(text);
      send();
    }

    function updateRec() {
      //$recBtn.text(recognition ? "Stop" : "Speak");
      //start_img.src(recognition ? "Images/mic-animate.gif" : "Images/mic.gif");
      
      if(recognition)
      {
      start_img.src="images/mic-animate.gif"

    }
    else{start_img.src="images/mic.gif"}
    
    }
var strResultText="";
var strdivcontainer="";
var strdivrequest="";
var strdivresponse = "";

var sessionid = "guestsessionid"; 
var username = "guest"; 
if (document.getElementById("hdnsessionid") != null)
{
    sessionid = document.getElementById("hdnsessionid").innerHTML;
}
if (document.getElementById("hdnusername") != null)
{
    username = document.getElementById("hdnusername").innerHTML;;
}

    function send() {
      var text = $speechInput.val();
        
      printmessage_request(text) ;
                         
      $speechInput.val("");
      $.ajax({
        type: "POST",
        url: baseUrl + "query?v=20150910",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
          "Authorization": "Bearer " + accessToken
        },
        data: JSON.stringify({ query: text, lang: "en", sessionId: sessionid + "-" + username }),

        success: function(data) { 
          //alert( JSON.stringify(data, undefined, 2))
          prepareResponse(data);
        },
        error: function() { 
          //alert(JSON.stringify(data, undefined, 2))
          respond(messageInternalError);
        }
        
      });
      
    }

    function prepareResponse(val) {
      var debugJSON = JSON.stringify(val, undefined, 2);
      if(val.result.speech!=undefined)
      {
        spokenResponse = val.result.speech;
      }
      else if (val.result.fulfillment.speech !=undefined)
      {

        spokenResponse = val.result.fulfillment.speech;
      }
      else
      {
        spokenResponse=messageInternalError;

      }
    
      respond(spokenResponse);
      debugRespond(debugJSON);
    }

    function debugRespond(val) {
      $("#response").text(val);
    }

    function respond(val) {
   
      if (val == "") {
        val = messageSorry;
      }
      if(document.getElementById("chkspeaker").checked){
    if (window.SpeechSynthesisUtterance == undefined) {
      // Not supported
    } else {
      //var voices = speechSynthesis.getVoices();


      // var msg1 = new SpeechSynthesisUtterance("");
      //  msg1.text = "";
      //   msg1.voice=voices[3];
      //   msg1.voiceURI ="native";
      //   msg1.lang = "en-US";
      //   window.speechSynthesis.speak(msg1);


      // for(var i = 0; i < 7; i++ ) {
      //   //console.log("Voice " + i.toString() + ' ' + voices[i].name + ' ' + voices[i].uri);
      // }
       // Read my text
      if (val != messageRecording) {
        
        var msg = new SpeechSynthesisUtterance();
        msg.text = val;
        //msg.voice=voices[3];
        msg.voiceURI ="native";
        msg.lang = "en-US";
        window.speechSynthesis.speak(msg);
        // alert( "index " + i + "Name "+ voices[i].name +" uri " +voices[i].uri);
      }
           
    }
      }

    printmessage_response(val);

}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Helper function to print chat message to the chat window
    function printmessage_request(text) {

     strdivrequest= '<span class="user-request">'+
                           '<div class="user-request__text">'+text+'</div>'+
                          '</span>';
      $("#container").append(strdivrequest);
      
       $("#resultWrapper").animate({
        scrollTop: $("#resultWrapper")[0].scrollHeight}, -500);

    }

function printmessage_response(text) {

         
     strdivresponse= '<span class="server-response">'+
                           '<div class="spoken-response__text">'+text+'</div>'+
                          '</span>';
      $("#container").append(strdivresponse);
      
       $("#resultWrapper").animate({
        scrollTop: $("#resultWrapper")[0].scrollHeight}, -500);

    }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////