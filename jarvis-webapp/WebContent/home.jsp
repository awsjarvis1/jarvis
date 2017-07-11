<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Jarvis - Remote Data Center Operation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
    <!-- New code added for Image viewer-->
    <meta name="description" content="A simple jQuery image viewing plugin.">
    <meta name="keywords" content="HTML, CSS, JS, JavaScript, jQuery plugin, image viewing, front-end, frontend, web development">

	<link rel="icon" type="image/png" href="images/jarvis.jpg">
    <meta property="og:title" content="CustomerSupportBot" />
    <meta property="og:description" content="" />
    <meta property="og:locale" content="en" />
    <meta property="og:image" content="" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
	<style>
        @-moz-keyframes blink {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @-webkit-keyframes blink {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @-ms-keyframes blink {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @keyframes blink {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        #preloader {
            background: #fff;
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
            z-index: 999999;
            opacity: 1;
            -webkit-transition: opacity .5s ease;
            transition: opacity .5s ease;
        }

            #preloader .logo {
                display: block;
                width: 109px;
                height: 39px;
                background-repeat: no-repeat;
                background-image: url(https://console.api.ai/api-client/assets/img/logo@2x-black.png);
                background-size: contain;
                position: absolute;
                top: 50%;
                left: 50%;
                margin: -20px 0 0 -55px;
                -moz-transition: all 1s ease-in-out;
                -webkit-transition: all 1s ease-in-out;
                -o-transition: all 1s ease-in-out;
                -ms-transition: all 1s ease-in-out;
                transition: all 1s ease-in-out;
                -moz-animation: blink normal 2s infinite ease-in-out;
                -webkit-animation: blink normal 2s infinite ease-in-out;
                -ms-animation: blink normal 2s infinite ease-in-out;
                animation: blink normal 2s infinite ease-in-out;
            }

        noscript h1 {
            padding: 20px;
        }
        a:link {
    color:#000;
    text-decoration: none;
  }
  a:visited {
    color:#000;
  }
  a:hover {
    color:#33F;
  }
  .button {
    background: -webkit-linear-gradient(top,#008dfd 0,#0370ea 100%);
    border: 1px solid #076bd2;
    border-radius: 3px;
    color: #fff;
    display: none;
    font-size: 13px;
    font-weight: bold;
    line-height: 1.3;
    padding: 8px 25px;
    text-align: center;
    text-shadow: 1px 1px 1px #076bd2;
    letter-spacing: normal;
  }
  .center {
    padding: 10px;
    text-align: center;
  }
  .final {
    color: black;
    padding-right: 3px; 
  }
  .interim {
    color: gray;
  }
  .info {
    font-size: 14px;
    text-align: center;
    color: #777;
    display: none;
  }
  .right {
    float: right;
  }
  .sidebyside {
    display: inline-block;
    width: 45%;
    min-height: 40px;
    text-align: left;
    vertical-align: top;
  }
  #headline {
    font-size: 40px;
    font-weight: 300;
  }
  #info {
    font-size: 20px;
    text-align: center;
    color: #777;
    visibility: hidden;
  }
  #results {
    font-size: 14px;
    font-weight: bold;
    border: 1px solid #ddd;
    padding: 15px;
    text-align: left;
    min-height: 150px;
  }
  #start_button {
    border: 0;
    background-color:transparent;
    padding: 0;
  }
  .select {
    -webkit-appearance: menulist;
    box-sizing: border-box;
    align-items: center;
    white-space: pre;
    -webkit-rtl-ordering: logical;
    color: black;
    background-color: white;
    cursor: default;
    border-width: 1px;
    border-style: solid;
    border-color: initial;
    border-image: initial;
}
    </style>
    <!--[if lte IE 7]>
    <script src="https://console.api.ai/api-client/js/agentDemoApp/promise.min.js"></script>
    <![endif]-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="scripts/jquery.min.js"></script>
    
    <link href="css/ApiAi.css" rel="stylesheet" type="text/css" />
    <style>
        #gallery .thumbnail {
            width: 150px;
            height: 150px;
            float: left;
            margin: 2px;
        }

        #gallery .thumbnail img {
            width: 150px;
            height: 150px;
        }
        .imagePreview {
            width: 180px;
            height: 150px;
            background-position: center center;
            background-size: cover;
            -webkit-box-shadow: 0 0 1px 1px rgba(0, 0, 0, .3);
            display: inline-block;
            margin-bottom: 10px;
        }
        .respimage
        {
            width:600px;
            height:500px;
            padding-left:10px;
        }

    </style>

    <link rel="stylesheet" type="text/css" href="css/Dashboard.css" />
    <link rel="stylesheet" type="text/css" href="content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="css/Product.css" />
    <link rel="stylesheet" type="text/css" href="css/Site.css" />
    <link rel="stylesheet" type="text/css" href="css/icons.css" />
    <link rel="stylesheet" type="text/css" href="css/Configuration.css" />
    <link rel="stylesheet" type="text/css" href="css/SiteManager.css" />
    <link rel="stylesheet" type="text/css" href="css/Help.css" />
    <link rel="stylesheet" type="text/css" href="css/LicenseDisclaimer.css" />
    <link rel="stylesheet" type="text/css" href="content/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="css/chatbox.css" />
    <link rel="stylesheet" type="text/css" href="css/fileinput.css" media="all"  />
    <link rel="stylesheet" type="text/css" href="css/imageviewer.css" />
    <link rel="stylesheet" type="text/css" href="css/viewer.css" />

    <!--<script language="javascript" type="text/javascript" src="Javascript/TopBanner.js"></script>-->
    <script language="javascript" type="text/javascript" src="scripts/jquery-2.2.0.js"></script>
    <script language="javascript" type="text/javascript" src="scripts/html2canvas.js"></script>
    
    <script language="javascript" type="text/javascript" src="scripts/jquery-ui-1.11.4.js"></script>
    <script language="javascript" type="text/javascript" src="scripts/jquery-ui-touch-punch.js"></script>
    <script language="javascript" type="text/javascript" src="scripts/bootbox.js"></script>
    <script language="javascript" type="text/javascript" src="scripts/bootstrap.js"></script>
    <script language="javascript" type="text/javascript" src="js/Configuration.js"></script>
    <!--<script language="javascript" type="text/javascript" src="js/Dashboard.js"></script>-->
    <script language="javascript" type="text/javascript" src="js/License.js"></script>
    <script language="javascript" type="text/javascript" src="js/Product.js"></script>
    <script language="javascript" type="text/javascript" src="js/Site.js"></script>
    <script language="javascript" type="text/javascript" src="js/SiteManager.js"></script>
    <script language="javascript" type="text/javascript" src="js/plugins/sortable.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/fileinput.js"></script>
    <script>
        var elementList = "";
        var msgcounter=0;
    </script>
    
    
    
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#addClass").click(function () {
                $('#qnimate').addClass('popup-box-on');
                $('#qnimateButton').removeClass('popup-box-on');
                $('#pnlEnvironmentData').addClass('panel-width855');
                if(msgcounter==0)
                {
                respond("Hi " + document.getElementById("hdnusername").innerHTML + ";  Welcome!!!");
                respond("I can assist you on drive failure, lun not visible, sp in service mode and CLI commands related to Unity and VNX");
                respond("How can I help you ?");
                msgcounter+=1;
                respond("Click the microphone icon to enable speaking conversation.");               
            }
            
            });

            $("#removeClass").click(function () {
                $('#qnimate').removeClass('popup-box-on');
                $('#qnimateButton').addClass('popup-box-on');
                $('#pnlEnvironmentData').removeClass('panel-width855');
            });

            $("#addClassChat").click(function () {
                $('#qnimate').addClass('popup-box-on');
                $(".navbar-side").toggle();
                $('#hamburgerIcon').toggleClass("active");
                $('#qnimateButton').removeClass('popup-box-on');
                $('#pnlEnvironmentData').addClass('panel-width855');
                if(msgcounter==0)
                {
                respond("Hi " + document.getElementById("hdnusername").innerHTML + ";  Welcome!!!");
                respond("I can assist you on drive failure, lun not visible, sp in service mode,image processing, log analytics and CLI commands related to Unity and VNX.");
                respond("How can I help you ?");
                msgcounter+=1;
                respond("Click the microphone icon to enable speaking conversation.");   
                }

            });

            $("#viewsr").click(function () {
                location.hash = "srpage";
                $(".navbar-side").toggle();
                $('#hamburgerIcon').toggleClass("active");
                
                var username = "guest";
                if (document.getElementById("hdnusername") != null && document.getElementById("hdnusername") != "" && document.getElementById("hdnusername") != undefined) {
                    if (document.getElementById("hdnusername").innerHTML != '&lt;%= session.getAttribute("user") %&gt;') {
                        username = document.getElementById("hdnusername").innerHTML;
                    }
                }
                
                var strwebhookurl = "http://13.59.160.130:8081";

                if (document.getElementById("hdnwebhookurl") != null && document.getElementById("hdnwebhookurl").innerHTML != "" && document.getElementById("hdnwebhookurl").innerHTML != null && document.getElementById("hdnwebhookurl").innerHTML != '&lt;%= session.getAttribute("webhook_url") %&gt;') {
                    strwebhookurl = document.getElementById("hdnwebhookurl").innerHTML;
                }


                //$('#srpanel').addClass("panel-collapse collapse");

                //var urlviewsr = "http://ec2-18-220-11-119.us-east-2.compute.amazonaws.com:8081/getIssues?user=sujit";

                var urlviewsr = strwebhookurl + "/getIssues?user=" + username;

                $.ajax({
                    type: "GET",
                    url: urlviewsr,
                    
                   
                    headers: {
                        //"Authorization": "Bearer " + accessToken
                    },
                    data: {},
                    success: function (data) {
                         
                        //var logresponse = JSON.parse(data.response);
                        document.getElementById("spnsr").innerText = "";
                        document.getElementById("spnsr").innerText += "\n" + "srNo" + "    " + "problemType" + "    " + "reportedBy" + "    " + "date" + "    " + "product";
                        for (var i = 0; i < data.serviceRequest.length; i++)
                        {
                            document.getElementById("spnsr").innerText += "\n" + data.serviceRequest[i].srNo + "    " + data.serviceRequest[i].problemType + "    " + data.serviceRequest[i].reportedBy + "    " + data.serviceRequest[i].date + "    " + data.serviceRequest[i].product;
                            
                        }
                                                                          
                       location.hash = "srpage2";
                       
                        //printmessage_response("List of SR#  " + JSON.parse(data.serviceRequest[0].srNo));
                    },
                    error: function (data) {
                        alert("Error"+data);
                        respond(messageInternalError + "\n Server response: " + data);
                    }

                });

                       
                        
                

            });

            
                 
        })

       

    </script>
</head>
<body>
    <div id="preloader" style="opacity: 0; display: none;">
        <noscript>&lt;h1&gt;This application does'not work without javascript&lt;/h1&gt;</noscript>
        <!--<div class="logo"></div>-->
    </div>
    <!--<form id="frmdashboard" method="post" enctype="multipart/form-data" action="http://10.4.109.63:8080/upload">-->
        <!--<form method="POST" enctype="multipart/form-data" action="http://10.4.109.63:8080/upload">-->
           <!--<form id="uploadimage" method="POST" enctype="multipart/form-data" action="http://ec2-34-227-222-250.compute-1.amazonaws.com:5001/api/imageprocessor/receiveFile?sessionId=123">-->
		  <!--<form id="uploadimage" method="POST" enctype="multipart/form-data" action="http://ec2-34-227-222-250.compute-1.amazonaws.com:5001/api/imageprocessor/getImage?fileName=array.jpg&sessionId=123">-->

            <form id="uploadimage" action="" method="post" enctype="multipart/form-data">
            <!--<form>-->
            <div class="layout-container">
                <div style="display:none;">
                    <span id="hdnusername" style="display:none;"><%= session.getAttribute("user") %></span>
                    <span id="hdnsessionid" style="display:none;"><%= request.getSession().getId() %></span>
                    <span id="hdnimageurl" style="display:none;"><%= session.getAttribute("image_url") %></span>
                    <span id="hdnlogurl" style="display:none;"><%= session.getAttribute("log_url") %></span>
                    <span id="hdnwebhookurl" style="display:none;"><%= session.getAttribute("webhook_url") %></span>
                </div>
                <header class="fixed-header">
                    <nav class="nav-brand">
                        <h3 class="nav-logo">
                            <a href="home.jsp">
                                <!--<img src="~/images/dell_emc_logo.png" alt="DELL EMC Logo" height="30" width="171" style="padding-right:15px;" />-->
                                <img src="images/jarvis.jpg" alt="Jarvis Logo" height="35" width="50" style="padding-right:15px;" />
                                Jarvis - Remote Data Center Operation <small>v1.0</small>
                            </a>
                        </h3>
                    </nav>

                    <nav class="nav-user-controls">
                        <div class="nav-left">
                            <a id="hamburgerIcon" href="#" class="hamburger">
                                <span class="animate"></span>
                                <span class="animate"></span>
                                <span class="animate"></span>
                            </a>
                            <h4 class="nav-page-name">Dashboard</h4>
                        </div>
                       

                        <div class="nav-right">
                            <div class="dropdown nav-user">
                                <a class="dropdown-toggle" aria-expanded="true" aria-haspopup="true" role="button" data-toggle="dropdown" href="#">
                                    Welcome <%= session.getAttribute("user") %>
                                    <span class="caret"></span>
                                    
                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="sign-out">Sign Out</a>
                                    </li>
                                </ul>
                                <img src="images/profile.png" alt="Avatar" />
                            </div>
                        </div>
                    </nav>

                    <nav class="navbar-side-collapse">
                        <ul class="nav navbar-inverse navbar-side">
                            <li>
                                <!--@Html.ActionLink("Dashboard", "Index", "Dashboard",
                            null, null, "", null, new { @class = "icon dashboard-icon" }
                            )-->
                                <a class="icon dashboard-icon" href="home.jsp" id="dashboard">Dashboard</a>
                            </li>
                            <!--<li>
                            <a class="icon help-icon" href="Dashboard.html" id="help">View Service Requests</a>
                        </li>-->
                            
                            <li>
                                <!--@Html.ActionLink("Help", "Index", "Help",
                            null, null, "", null, new { @class = "icon help-icon" }
                            )-->
                            <a class="icon help-icon"  id="viewsr" style="cursor: pointer;">View Service Request(SR)</a>
                            </li>
                            <li>
                                <a class="icon chat-icon" href="#" id="addClassChat">Open in chat</a>

                            </li>
                        </ul>
                    </nav>
                </header>

                <div class="section-container">
                    <div class="container-fluid section-page">


                        <div id="pnlEnvironmentData" class="panel panel-primary">
                            <div data-collapsed="true" class="panel-heading animate clickable" data-toggle="collapse" href="#powerSummaryPanel2">
                                <h3 class="panel-title">
                                    Dashboard
                                    <span class="fa fa-angle-double-down fa-2x pull-right"></span>
                                </h3>

                            </div>

                            <div class="panel-body">
                                <div class="panel-group">

                                    <div class="panel panel-primary collapsible">
                                        <div class="panel-heading clickable animate" data-toggle="collapse" href="#powerSummaryPanel3">
                                            <h4 class="panel-title">
                                                Upload File (img/txt/log)
                                                <span class="fa fa-chevron-up fa-lg fa-rotate-180 animate pull-right"></span>
                                            </h4>
                                        </div>
                                        <div id="powerSummaryPanel3" class="panel-collapse ">
                                            <div class="panel-body">
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div id="divProcessingUpload" style="display:none;">

                                                            <img alt="processing" src="images/processing.gif" /><img alt="ajax-progress" src="images/ajax-progress.gif" width="50" height="50" />

                                                        </div>
                                                                                                                        
                                                                 <div class="kv-main">
                                                                    <!--<form action="" method="post" enctype="multipart/form-data">-->
                                                                            <!--<div class="form-group">
                                                                            <input id="file-1" type="file"  class="file1" data-overwrite-initial="false" data-min-file-count="1">
                                                                        </div>-->
                                                                     <div class="form-group">
                                                                         <table>
                                                                             <tbody>
                                                                                 <tr>
                                                                                     <td>
                                                                                         <label>Upload File : </label>
                                                                                     </td>
                                                                                     <td> <input type="checkbox" id="chksp" style="visibility:hidden" /><input type="checkbox" id="chkloganalytics" style="visibility:hidden" /></td>
                                                                                     <td style="padding-left:5px;">
                                                                                         <input id="file-3" type="file" data-overwrite-initial="false" multiple />
                                                                                     </td>
                                                                                     <td style="padding-left:20px;">
                                                                                         <input type="button" id="btnupload" value="Upload" class="btn btn-primary btn-md"/>
                                                                                        
                                                                                     </td>
                                                                                     </tr>
                                                                                 </tbody>
                                                                             </table>
                                                                        
                                                                    <!--</form>-->
                                                                    
                                                                </div>
                                                                
                                                               <script>
                                                                //$("#file-1").fileinput({
                                                                //    showUpload: false,
                                                                //    showCaption: false,
                                                                //    //uploadUrl: 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5001/api/imageprocessor/receiveFile?sessionId=123', // you must set a valid URL here else you will get an error
                                                                //    allowedFileExtensions: ['jpg', 'png', 'gif','txt','log'],
                                                                //    overwriteInitial: false,
                                                                //    maxFileSize: 10240,
                                                                //    maxFilesNum: 10,
                                                                //    allowedFileTypes: ['image', 'video', 'flash'],
                                                                //    slugCallback: function (filename) {
                                                                //        return filename.replace('(', '_').replace(']', '_');
                                                                //    }
                                                                //});

                                                                $("#file-3").fileinput({
                                                                        showUpload: false,
                                                                        showCaption: false,
                                                                        
                                                                        //uploadUrl: 'http://ec2-52-15-39-48.us-east-2.compute.amazonaws.com:5001/api/imageprocessor/receiveFile?sessionId=guestsessionid-guest&intent=drive_failure',
                                                                        browseClass: "btn btn-primary btn-md",
                                                                        allowedFileExtensions: ['jpg', 'png', 'gif', 'txt', 'log', 'mp4', 'flv', 'mkv', 'wmv'],
                                                                        fileType: "any",
                                                                        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                                                                        //maxFileSize: 10240,
                                                                        maxFilesNum: 2,
                                                                        overwriteInitial: false,
                                                                        initialPreviewAsData: true,
                                                                        initialPreview: [
                                                                            
                                                                        ],
                                                                        initialPreviewConfig: [
                                                                           
                                                                        ]
                                                                    });

                                                                /*
                                                                $(".file").on('fileselect', function(event, n, l) {
                                                                alert('File Selected. Name: ' + l + ', Num: ' + n);
                                                                });
                                                                */
                                                               
                                                                                                                               
                                                                $(".btn-warning").on('click', function () {
                                                                    var $el = $("#file-4");
                                                                    if ($el.attr('disabled')) {
                                                                        $el.fileinput('enable');
                                                                    } else {
                                                                        $el.fileinput('disable');
                                                                    }
                                                                });
                                                                $(".btn-info").on('click', function () {
                                                                    $("#file-4").fileinput('refresh', {previewClass: 'bg-info'});
                                                                });
                                                            
                                                                $(document).ready(function () {
                                                                   
                                                                    
                                                                    $speechInput = $("#speech");
                                                                    $recBtn = $("#start_img");
                                                                    $start_img = $("#start_img");
                                                                    $speechInput.keypress(function (event) {
                                                                        if (event.which == 13) {
                                                                            event.preventDefault();
                                                                            if ($speechInput.val().trim() != "") {
                                                                                send();
                                                                            }
                                                                        }
                                                                    });
                                                                    $recBtn.on("click", function (event) {
                                                                        
                                                                        $start_img.attr('src','images/mic-slash.gif');
                                                                        if (window.SpeechSynthesisUtterance == undefined) {
                                                                            // Not supported
                                                                            alert("Voice recognition not supported in your browser.");
                                                                        } else {
                                                                            switchRecognition();
                                                                        }
                                                                    });
                                                                    $(".debug__btn").on("click", function () {
                                                                        $(this).next().toggleClass("is-active");
                                                                        return false;
                                                                    });

                                                                    for (var i = 0; i < langs.length; i++) {
                                                                    select_language.options[i] = new Option(langs[i][0], i);
                                                                    }
                                                                    select_language.selectedIndex = 6;
                                                                    updateCountry();
                                                                    select_dialect.selectedIndex = 2;
                                                                    

                                                                   
                                                                

                                                                ///////////////////////////Voice//////////////////////////////////////

                                                                            

                                                                            






                                                                ////////////////////////////////////////////////////////////////


                                                                });
                                                           
                                                                 


                                                           
                                                            function preview_images(file)
                                                            {
                                                                //var total_file=document.getElementById("images").files.length;
                                                                // for(var i=0;i<total_file;i++)
                                                                // {
                                                                //  $('#image_preview').append("<div class='col-md-3'><img class='img-responsive' src='"+URL.createObjectURL(event.target.files[i])+"'></div>");
                                                                // }

                                                                 $('#image_preview').append("<div class='col-md-3'><img class='imagePreview' src='" + file + "' ></div>");

                                                                  //document.getElementById("requestimage").attr('data-original', file);
                                                                  //document.getElementById("requestimage").attr('src', file);
                                                            }
                                                            
                                                                    
                                                        

                                                                    var filesuploaded;
                                                                    var imageresponsetext="";
                                                                    var intent="";
                                                                    var producttype="";

                                                                    $("body").on("click", "#btnupload", function (e) {
                                                                     clearsummary();
                                                                     e.preventDefault();
                                                                     previewImage(filesuploaded);
                                                                     });
                                                                     

                                                                    var uploadfiles = document.getElementById("file-3"); //document.querySelector('#fileinput');
                                                                    uploadfiles.addEventListener('change', function () {
                                                                        var files = this.files;
                                                                        filesuploaded = files;
                                                                        //document.getElementById("divProcessing").style.display = "block";
                                                                        //for (var i = 0; i < files.length; i++) {
                                                                                                                                                        
                                                                        //    if (this.files[i].type.match("image/jpg") || this.files[i].type.match("image/jpeg") || this.files[i].type.match("image/gif") || this.files[i].type.match("image/png") || this.files[i].type.match("image/bmp"))
                                                                        //    {
                                                                        //        previewImage(this.files[i]);
                                                                        //    }
                                                                        //    else {
                                                                                
                                                                        //        previewLog(this.files[i])
                                                                        //    }
                                                                        //}

                                                                        //previewImage(files);

                                                                        

                                                                    }, false);

                                                                    function clearsummary()
                                                                    {
                                                                                                                                                 
                                                                        document.getElementById("divprocessedimage").style.display="none";

                                                                        document.getElementById("spnsummary").innerText="";

                                                                        document.getElementById("spnsummarylog").innerText="";

                                                                        document.getElementById("spnsummary").innerText="View image summary here";

                                                                        document.getElementById("spnsummarylog").innerText="View log analytics summary here";

                                                                    }

                                                                    function previewImage(files) {
                                                                        location.hash = 'summarypage';
                                                                        
                                                                        if (files.length > 0) {
                                                                            document.getElementById("divProcessing").style.display = "block";
                                                                        }
                                                                        for (var i = 0; i < files.length; i++) {

                                                                            if (files[i].type.match("image/jpg") || files[i].type.match("image/jpeg") || files[i].type.match("image/gif") || files[i].type.match("image/png") || files[i].type.match("image/bmp") || files[i].type.match("video/mp4") || files[i].type.match("video/flv") || files[i].type.match("video/wmv") || files[i].type.match("video/mkv"))
                                                                            {
                                                                                
                                                                                
                                                                                if (files[i].type.match("video/mp4") || files[i].type.match("video/flv") || files[i].type.match("video/wmv") || files[i].type.match("video/mkv"))
                                                                                {
                                                                                    intent="video"
                                                                                }
                                                                                else if (document.getElementById("chksp").checked == true && intent == "") {
                                                                                    intent = "sp_servicemode";
                                                                                }
                                                                                else if (intent == "") {
                                                                                    intent = "drive_failure";
                                                                                }

                                                                                
                                                                                //alert(intent);

                                                                                //previewImage(this.files[i]);

                                                                                //document.getElementById("lblfilename").innerHTML = "Name: " + files[i].name;
                                                                                //document.getElementById("lblfilesize").innerHTML = "Size: " + files[i].size + " Bytes";
                                                                                //document.getElementById("lblfiletype").innerHTML = "Type: " + files[i].type;


                                                                                //var galleryId = "gallery";

                                                                                //var gallery = document.getElementById(galleryId);
                                                                                //var imageType = /image.*/;
                                                                                ////alert(file.type);

                                                                                //if (!files[i].type.match(imageType)) {
                                                                                //    throw "File Type must be an image";
                                                                                //}

                                                                                //var thumb = document.createElement("div");
                                                                                //thumb.classList.add('thumbnail'); // Add the class thumbnail to the created div

                                                                                //var img = document.createElement("img");
                                                                                //img.file = files[i];
                                                                                //thumb.appendChild(img);
                                                                                //gallery.appendChild(thumb);

                                                                                //// Using FileReader to display the image content
                                                                                //var reader = new FileReader();
                                                                                //reader.onload = (function (aImg) { return function (e) { aImg.src = e.target.result; }; })(img);
                                                                                //reader.readAsDataURL(files[i]);

                                                                                var sessionid = "guestsessionid";
                                                                                var username = "guest";
                                                                                if (document.getElementById("hdnsessionid") != null && document.getElementById("hdnsessionid") != "" && document.getElementById("hdnsessionid") != undefined) {
                                                                                    
                                                                                    if (document.getElementById("hdnsessionid").innerHTML != '&lt;%= request.getSession().getId() %&gt;') {
                                                                                        sessionid = document.getElementById("hdnsessionid").innerHTML;
                                                                                    }
                                                                                }
                                                                                if (document.getElementById("hdnusername") != null && document.getElementById("hdnusername") != "" && document.getElementById("hdnusername") != undefined) {
                                                                                    if (document.getElementById("hdnusername").innerHTML != '&lt;%= session.getAttribute("user") %&gt;') {
                                                                                        username = document.getElementById("hdnusername").innerHTML;
                                                                                    }
                                                                                }

                                                                                sessionid = sessionid.substring(0, sessionid.length - 10);

                                                                                //alert("called ajax");

                                                                                var strimageurl = "http://ec2-13-59-239-56.us-east-2.compute.amazonaws.com:5001";
                                                                                
                                                                                if (document.getElementById("hdnimageurl").innerHTML != "" && document.getElementById("hdnimageurl").innerHTML != null && document.getElementById("hdnimageurl").innerHTML != '&lt;%= session.getAttribute("image_url") %&gt;')
                                                                                {
                                                                                    strimageurl = document.getElementById("hdnimageurl").innerHTML;
                                                                                }
                                                                               
                                                                                var url = strimageurl + '/api/imageprocessor/receiveFile?sessionId=' + sessionid + "-" + username + '&intent=' + intent;

                                                                                //if (document.getElementById("chksp").checked == true) {

                                                                                    //url = strimageurl + '/api/imageprocessor/receiveFile?sessionId=' + sessionid + "-" + username + '&intent=' + 'sp_servicemode';
                                                                                //}

                                                                               

                                                                                //var url = 'http://ec2-52-15-39-48.us-east-2.compute.amazonaws.com:5001/api/imageprocessor/receiveFile?sessionId=' + sessionid + "-" + username + '&intent=' + 'drive_failure';
                                                                                //if (document.getElementById("chksp").checked == true)
                                                                                //{
                                                                                    
                                                                                //    url = 'http://ec2-52-15-39-48.us-east-2.compute.amazonaws.com:5001/api/imageprocessor/receiveFile?sessionId=' + sessionid + "-" + username + '&intent=' + 'sp_servicemode';
                                                                                //}

                                                                                

                                                                                //alert(url);

                                                                                var xhr = new XMLHttpRequest();
                                                                                var fd = new FormData();

                                                                                xhr.open("POST", url, true);
                                                                                xhr.setRequestHeader("Access-Control-Allow-Origin", "*");
                                                                                xhr.setRequestHeader("crossDomain", "true");
                                                                                xhr.setRequestHeader("dataType", "jsonp");
                                                                                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                                                                                
                                                                                xhr.onreadystatechange = function () {
                                                                                    
                                                                                    if ((xhr.readyState == 4 && xhr.status == 200) || (xhr.readyState == 32 && xhr.status == 00)) {
                                                                                       
                                                                                        var imageresponse = JSON.parse(xhr.responseText);

                                                                                       
                                                                                        location.hash = 'summarypage2';
                                                                                        document.getElementById("spnsummary").innerText = "Image File uploaded successfully. Image successfully processed and received response as: \n" + imageresponse.response_text +"\n \n===============================================================================";
                                                                                        respond("Image File uploaded successfully. Image successfully processed and received response as: \n" + imageresponse.response_text);
                                                                                        document.getElementById("spnsummary").style.color = "green";
                                                                                        document.getElementById("divProcessing").style.display = "none";
                                                                                                                                                                               
                                                                                       
                                                                                        imageresponsetext = imageresponse.response_text;
                                                                                        
                                                                                        //alert(imagename.response_image);
                                                                                        //document.getElementById("divprocessedimage").style.display = "block";
                                                                                        //document.getElementById("imgprocessedimage").src = strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username;
                                                                                        //document.getElementById("imgprocessedimage").src = "http://ec2-52-15-39-48.us-east-2.compute.amazonaws.com:5001/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username;

                                                                                        for (var j = 0; j < files.length; j++) {

                                                                                            if (files[j].type.match("text/plain")) {

                                                                                                previewLog(files[j], imageresponse.response_text);
                                                                                            }

                                                                                        }
                                                                                        document.getElementById("divprocessedimage").style.display = "block";
                                                                                        document.getElementById("imgprocessedimage").style.display = "block";
                                                                                        document.getElementById("imgprocessedimage").src = strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username;
                                                                                        //preview_images( strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username)
                                                                                        
                                                                                        //respond("<div class='col-md-3'><img class='imagePreview' src='" + strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username + "' ></div>");
                                                                                        //respond("<div class='col-md-3'><img class='img-responsive' src='"+strimageurl+"'></div>");
                                                                                       // respond('<img id="requestimage" class="img-responsive" src='+ strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username +" data-original="+strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username +' alt=""/>');
                                                                                       respond('<div id="imageviewer"><div class="row"><div class="docs-galley"><ul class="docs-pictures clearfix">'+'<img id="responseimage" class="img-responsive" src='+ strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username +" data-original="+strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username +' alt=""/>'+ '</ul></div></div><footer class="docs-footer"></footer><script src="js/viewer.js"/>'+'<script src="js/main.js"/></div>'+"Click image to maximize.Press Escape to Cancel.");
                                                                                
                                                                            
                                                                                      }
                                                                                    else {

                                                                                        //var imageresponse = JSON.parse(xhr.responseText);
                                                                                        //alert("File upload failed. Please try again. State: " + xhr.readyState + "status: " + xhr.status + xhr.responseText); // handle response.
                                                                                        document.getElementById("spnsummary").innerText = xhr.responseText;
                                                                                       
                                                                                        document.getElementById("spnsummary").style.color = "red";
                                                                                        if (xhr.responseText != "") {
                                                                                            document.getElementById("divProcessing").style.display = "none";
                                                                                            
                                                                                            var resptext = xhr.responseText.toString();
                                                                                            if (resptext.search('{"response_image":"') == 0)
                                                                                            {

                                                                                            }
                                                                                            else {
                                                                                                respond(xhr.responseText);
                                                                                            }
                                                                                        }
                                                                                        
                                                                                    }
                                                                                };
                                                                                fd.append("file", files[i]);
                                                                                //fd.append("sessionId", "123");
                                                                                xhr.send(fd);




                                                                            }
                                                                            //else
                                                                            if (files.length == 1 || imageresponsetext != "") {

                                                                            for (var j = 0; j < files.length; j++) {
                                                                                   
                                                                                if (files[j].type.match("text/plain")) {
                                                                                        
                                                                                    previewLog(files[j], imageresponsetext);
                                                                                }

                                                                            }
                                                                        }
                                                                        }

                                                                                                                                                 
                                                                    }
                                                                                                                                       


                                                                    function previewLog(file, drivelist) {
                                                                                                                                                

                                                                        document.getElementById("divProcessing").style.display = "block";

                                                                        var sessionid = "guestsessionid";
                                                                        var username = "guest";
                                                                        if (document.getElementById("hdnsessionid") != null && document.getElementById("hdnsessionid") != "" && document.getElementById("hdnsessionid") != undefined) 
																		{
                                                                            if (document.getElementById("hdnsessionid").innerHTML != '&lt;%= request.getSession().getId() %&gt;') {
                                                                                sessionid = document.getElementById("hdnsessionid").innerHTML;
                                                                            }
                                                                        }
                                                                        if (document.getElementById("hdnusername") != null && document.getElementById("hdnusername") != "" && document.getElementById("hdnusername") != undefined) {
                                                                            if (document.getElementById("hdnusername").innerHTML != '&lt;%= session.getAttribute("user") %&gt;') {
                                                                                username = document.getElementById("hdnusername").innerHTML;
                                                                            }
                                                                        }

                                                                        sessionid = sessionid.substring(0, sessionid.length - 10);

                                                                        var strdrivelist = '0_0_0,0_0_1,0_0_12';
                                                                        if (drivelist!="")
                                                                        {
                                                                            strdrivelist = drivelist;
                                                                        }
                                                                        if (document.getElementById("chksp").checked == true && intent == "") {
                                                                            intent = "sp_servicemode";
                                                                        }
                                                                        else if (document.getElementById("chkloganalytics").checked == true && intent == "") {
                                                                            intent = "log_analytics";
                                                                        }
                                                                        else if (intent == "video") {
                                                                            intent = "sp_servicemode";
                                                                        }
                                                                        else if (intent == "")
                                                                        {
                                                                            intent = "drive_failure";
                                                                        }
                                                                        if (producttype == "") {
                                                                            producttype = "Unity";
                                                                        }
                                                                        //alert(intent);
                                                                        var strlogurl = "http://ec2-52-14-184-122.us-east-2.compute.amazonaws.com:5000";

                                                                        if (document.getElementById("hdnlogurl").innerHTML != "" && document.getElementById("hdnlogurl").innerHTML != null && document.getElementById("hdnlogurl").innerHTML != '&lt;%= session.getAttribute("log_url") %&gt;')
                                                                        {
                                                                            strlogurl = document.getElementById("hdnlogurl").innerHTML;
                                                                        }

                                                                                                                                               
                                                                        var url = strlogurl + '/upload?intent=' + intent + '&sessionId=' + sessionid + '-' + username + "&driveList=" + strdrivelist;
                                                                       
                                                                        //if (document.getElementById("chksp").checked == true) {
                                                                            //url = strlogurl + '/upload?intent=' + 'sp_servicemode' + '&sessionId=' + sessionid + '-' + username + "&driveList=" + strdrivelist;
                                                                        //}
                                                                        

                                                                        //var url = 'http://ec2-13-59-170-182.us-east-2.compute.amazonaws.com:5000/upload?intent=' + 'drive_failure' + '&sessionId=' + sessionid + '-' + username + "&driveList=" + strdrivelist;
                                                                        //if (document.getElementById("chksp").checked == true)
                                                                        //{
                                                                        //    url = 'http://ec2-13-59-170-182.us-east-2.compute.amazonaws.com:5000/upload?intent=' + 'sp_servicemode' + '&sessionId=' + sessionid + '-' + username + "&driveList=" + strdrivelist;
                                                                        //}

                                                                       
                                                                        var xhr = new XMLHttpRequest();
                                                                        var fd = new FormData();
                                                                        
                                                                        xhr.open("POST", url, true);
                                                                        xhr.setRequestHeader("Access-Control-Allow-Origin", "*");
                                                                        xhr.setRequestHeader("crossDomain", "true");
                                                                        xhr.setRequestHeader("dataType", "jsonp");
																		xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                                                                        
                                                                        xhr.onreadystatechange = function () {
                                                                            document.getElementById("divProcessing").style.display = "block";
                                                                            if ((xhr.readyState == 4 && xhr.status == 200) || (xhr.readyState == 32 && xhr.status == 00)) {
                                                                                
                                                                               
                                                                                var logresponse = JSON.parse(xhr.responseText);
                                                                                //if (logresponse.result != "")
                                                                                {

                                                                                    //alert(logresponse.result);
                                                                                    document.getElementById("spnsummarylog").style.color = "green";
                                                                                    document.getElementById("spnsummarylog").innerText = "Response from Log Analytics:\n ";
                                                                                    document.getElementById("spnsummarylog").innerText += "Log File uploaded successfully.\n" + logresponse.result;
                                                                                    respond("Log File uploaded successfully.\n" + logresponse.result);
                                                                                    document.getElementById("spnsummarylog").style.color = "green";
                                                                                    document.getElementById("divProcessing").style.display = "none";

                                                                                    location.hash = 'summarypage3';
                                                                                }
                                                                                
                                                                                if (( logresponse.result.toString().search("Miniport_Slowness issue") >=0 ||  logresponse.result.toString().search("failed due to") >= 0 || logresponse.result.toString().search("Unable to root cause") >= 0 || logresponse.result.toString().search("create service request") >= 0) && producttype!="")
                                                                                {
                                                                                    var strwebhookurl="http://13.59.160.130:8081";
                                                                                    
                                                                                    if (document.getElementById("hdnwebhookurl") != null && document.getElementById("hdnwebhookurl").innerHTML != "" && document.getElementById("hdnwebhookurl").innerHTML != null && document.getElementById("hdnwebhookurl").innerHTML != '&lt;%= session.getAttribute("webhook_url") %&gt;') {
                                                                                        strwebhookurl = document.getElementById("hdnwebhookurl").innerHTML;
                                                                                    }
                                                                                                                                                                        
                                                                                    //var urlinsert = "http://ec2-18-220-11-119.us-east-2.compute.amazonaws.com:8081/insertIssue?user=sujit&problemType=spfault&product=unity";
                                                                                    
                                                                                    var urlinsert = strwebhookurl + "/insertIssue?user=" + username + "&problemType=" + intent + "&product=" + producttype;
                                                                                   
                                                                                    $.ajax({
                                                                                        type: "GET",
                                                                                        url: urlinsert,
                                                                                        contentType: "text/plain; charset=utf-8",
                                                                                        headers: {
                                                                                            //"Authorization": "Bearer " + accessToken
                                                                                        },
                                                                                        data: {},
                                                                                        success: function (data) {
                                                                                            //alert(data);
                                                                                            document.getElementById("spnsummarylog").innerText += "\n A Service request (SR) has been generated. Please refer SR#  " + data;
                                                                                            respond("A Service request (SR) has been generated. Please refer SR#  " + data);
                                                                                        },
                                                                                        error: function (data) {
                                                                                            
                                                                                            respond(messageInternalError +"\n Server response: "+ data);
                                                                                        }

                                                                                    });


                                                                                }

                                                                            }
                                                                            else
                                                                            {
                                                                                //var debugJSON = JSON.stringify(xhr.responseText, undefined, 2);
                                                                                //alert(debugJSON);

                                                                                //alert("File upload failed. Please try again. State: " + xhr.readyState + "status: " + xhr.status + xhr.responseText); // handle response.
                                                                                document.getElementById("spnsummarylog").innerText = xhr.responseText;
                                                                               
                                                                                document.getElementById("spnsummarylog").style.color = "red";
                                                                                if (xhr.responseText != "")
                                                                                {
                                                                                    document.getElementById("divProcessing").style.display = "none";
                                                                                    var resptext = xhr.responseText.toString();
                                                                                    if (resptext.search('[{"result":"]')==0)
                                                                                    {
                                                                                       
                                                                                    }
                                                                                    else {
                                                                                        respond(xhr.responseText);
                                                                                    }
                                                                                }
                                                                            }
                                                                       };
                                                                       fd.append("file", file);
                                                                       //fd.append("sessionId", "123");
                                                                       xhr.send(fd);
                                                                                                                                              
                                                                        
                                                                    }
                                                                      
                                                                   ////////////////////********************ApiAI Page Script*****************////////////////////////////

                                                                    var accessToken = "eb214ecede6246dc9ab5811610b558bd";
                                                                     //var accessToken = "7d4f45de34c64ab696990f4b81151ddd";
                                                                     // var accessToken ="e9c210fd37ec4504bbcf8bfed7b6b0a2";
                                                                    var baseUrl = "https://api.api.ai/v1/";
                                                                    var speechInput;
                                                                    var recBtn;
                                                                    var recognition;
                                                                    var start_img;
                                                                    var messageRecording = "Recording...";
                                                                    var messageCouldntHear = "I couldn't hear you, could you say that again?";
                                                                    var messageInternalError = "Oh no, there has been an internal server error";
                                                                    var messageSorry = "I'm sorry, I don't have the answer to that yet.";

                                                                    
                                                                    function startRecognition() {
                                                                        
                                                                        recognition = new webkitSpeechRecognition();
                                                                        
                                                                        recognition.continuous = true;
                                                                        recognition.interimResults = false;
                                                                       
                                                                        
                                                                        recognition.onstart = function (event) {
                                                                           
                                                                            
                                                                            //respond(messageRecording);
                                                                            updateRec();
                                                                        };
                                                                        var final_transcript = '';
                                                                        recognition.onresult = function (event) {
                                                                           
                                                                            recognition.onend = null;

                                                                            var text = "";
                                                                            for (var i = event.resultIndex; i < event.results.length; ++i) {
                                                                                text += event.results[i][0].transcript;
                                                                            }
                                                                            setInput(text);
                                                                            //stopRecognition();

                                                                            // var interim_transcript = '';
                                                                            //     for (var i = event.resultIndex; i < event.results.length; ++i) {
                                                                            //     if (event.results[i].isFinal) {
                                                                            //         final_transcript += event.results[i][0].transcript;
                                                                            //     } else {
                                                                            //         interim_transcript += event.results[i][0].transcript;
                                                                            //     }
                                                                            //     }
                                                                            //     final_transcript = capitalize(final_transcript);
                                                                            //     final_span.innerHTML = linebreak(final_transcript);
                                                                            //     interim_span.innerHTML = linebreak(interim_transcript);
                                                                            //     //$speechInput.val(linebreak(interim_transcript));




                                                                        };
                                                                        var two_line = /\n\n/g;
                                                                        var one_line = /\n/g;
                                                                        function linebreak(s) {
                                                                        return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
                                                                        }

                                                                        var first_char = /\S/;
                                                                        function capitalize(s) {
                                                                        return s.replace(first_char, function(m) { return m.toUpperCase(); });
                                                                        }
                                                                        recognition.onend = function () {
                                                                            respond(messageCouldntHear);
                                                                            stopRecognition();
                                                                        };
                                                                        // recognition.onsoundend=function(){alert("onsoundend")};
                                                                        // recognition.onaudioend=function(){alert("onaudioend")};
                                                                        // recognition.onspeechend=function(){alert("onspeechend")};

                                                                        //recognition.lang = "en-US";
                                                                         recognition.lang = select_dialect.value;
                                                                         recognition.start();
                                                                    }

                                                                    function clearchat()
                                                                    {
                                                                    
                                                                        document.getElementById("container").innerHTML = "";
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

                                                                        if (recognition) {
                                                                            $start_img.attr('src', "images/mic-animate.gif");

                                                                        }
                                                                        else { $start_img.attr('src', "images/mic.gif"); }

                                                                    }
                                                                    var strResultText = "";
                                                                    var strdivcontainer = "";
                                                                    var strdivrequest = "";
                                                                    var strdivresponse = "";

                                                                    var sessionid = "guestsessionid";
                                                                    var username = "guest";
                                                                    //if (document.getElementById("hdnsessionid") != null) {
                                                                    //    sessionid = document.getElementById("hdnsessionid").innerHTML;
                                                                    //}
                                                                    //if (document.getElementById("hdnusername") != null) {
                                                                    //    username = document.getElementById("hdnusername").innerHTML;;
                                                                    //}

                                                                    function send() {

                                                                        if (document.getElementById("hdnsessionid") != null && document.getElementById("hdnsessionid") != "" && document.getElementById("hdnsessionid") != undefined) {
                                                                           
                                                                            if (document.getElementById("hdnsessionid").innerHTML != '&lt;%= request.getSession().getId() %&gt;') {
                                                                                sessionid = document.getElementById("hdnsessionid").innerHTML;
                                                                            }
                                                                        }
                                                                        if (document.getElementById("hdnusername") != null && document.getElementById("hdnusername") != "" && document.getElementById("hdnusername") != undefined) {
                                                                           
                                                                            if (document.getElementById("hdnusername").innerHTML != '&lt;%= session.getAttribute("user") %&gt;') {
                                                                                username = document.getElementById("hdnusername").innerHTML;
                                                                            }
                                                                        }
																		                                                                                                                                                  

																		sessionid=sessionid.substring(0,sessionid.length-10);
																		

                                                                        var text = $speechInput.val();
                                                                        text=text.trim();

                                                                        if(text=="clear"|| text=="refresh" || text=="clear the chat bot" || text=="refresh the chat bot" || text=="please clear the chat bot" || text=="please refresh the chat bot" || text=="can you please clear the chat bot" || text=="can you please refresh the chat bot")
                                                                        {
                                                                           printmessage_request(text);

                                                                           clearchat();
                                                                          respond("conversations cleared");
                                                                           $speechInput.val("");
                                                                        }
                                                                        else if(text=="stop" || text=="stop listening" || text=="stop microphone" || text=="stop micro phone" ||text=="stop the microphone" || text=="please stop the microphone" || text=="can you please stop the microphone" || text=="could you please stop the microphone" || text=="switch off microphone" || text=="please switch off the microphone" || text=="switch off the microphone" || text=="switch off the microphone" || text=="please switch off the microphone" )
                                                                        {
                                                                            printmessage_request(text);
                                                                            stopRecognition();
                                                                            respond("microphone stopped");
                                                                            $speechInput.val("");
                                                                           
                                                                        }
                                                                        else if(text=="stop audio" || text=="stop speaker" || text=="stop speaking" || text=="disable audio" || text=="disable speaker" || text=="disable speaking" || text=="switch off audio" || text=="please switch off the audio" || text=="switch off the audio" || text=="switch off the speaker" || text=="please switch off the speaker" )
                                                                        {
                                                                             printmessage_request(text);
                                                                            document.getElementById("chkspeaker").checked=false;
                                                                            //window.speechSynthesis.speak("");
                                                                             respond("chat bot speaker muted");
                                                                            $speechInput.val("");
                                                                            
                                                                        }
                                                                        else if(text=="enable audio" || text=="enable speaker" || text=="enable speaking" || text=="start audio" || text=="start speaker" || text=="start speaking")
                                                                        {
                                                                            printmessage_request(text);
                                                                            document.getElementById("chkspeaker").checked=true;
                                                                             respond("chat bot speaker enabled");
                                                                            $speechInput.val("");
                                                                            
                                                                        }
                                                                        else if(text=="can you please close the chat"||text=="can you please close the chatbot" || text=="can you please close the chat bot"||text=="please close chat"||text=="please close the chat" ||text=="please close the chat bot" || text=="please close the chatbot"|| text=="close chatbot" || text=="close chat bot" || text=="close chat" || text=="please close chat bot" || text=="please close the chatbot" || text=="please close the chat" || text=="close the chat window" || text=="close the chat bot")
                                                                        {
                                                                                                                                                      
                                                                            printmessage_request(text);
                                                                            $("#removeClass").click();
                                                                            stopRecognition();
                                                                            //clearchat();
                                                                            respond("chat bot closed");
                                                                            $speechInput.val("");
                                                                        }
                                                                         else
                                                                        {
                                                                        printmessage_request(text);
                                                                        //$speechInput.val("");
                                                                        $.ajax({
                                                                            type: "POST",
                                                                            url: baseUrl + "query?v=20150910",
                                                                            contentType: "application/json; charset=utf-8",
                                                                            dataType: "json",
                                                                            headers: {
                                                                                "Authorization": "Bearer " + accessToken
                                                                            },
                                                                            data: JSON.stringify({ query: text, lang: "en", sessionId: sessionid + "-" + username }),

                                                                            success: function (data) {
                                                                                //alert( JSON.stringify(data, undefined, 2));
																				//data.result.contexts[0].name
																				//alert(data.result.contexts);

                                                                                prepareResponse(data);

                                                                                producttype=data.result.parameters.ArrayType;

																				if(data.result.contexts!="" && data.result.contexts[0]!=undefined && data.result.contexts[0]!=null)
																				{
																				 
																				 if(data.result.contexts[0].name.includes("lunnotvisible"))// || data.result.contexts[1].name.includes("lunnotvisible") || data.result.contexts[2].name.includes("lunnotvisible") || data.result.contexts[0].name.includes("drivefault") || data.result.contexts[1].name.includes("drivefault") || data.result.contexts[2].name.includes("drivefault") || data.result.metadata.intentName.includes("drivefault") || data.result.metadata.intentName.includes("lunnotvisible"))
																				 {
																				   intent="drive_failure";
																				 }
																				 if(data.result.contexts[0].name.includes("spdownissue"))// || data.result.contexts[1].name.includes("spdownissue") || data.result.contexts[2].name.includes("spdownissue") || data.result.contexts[0].name.includes("spdownissue") || data.result.contexts[1].name.includes("spdownissue") || data.result.contexts[2].name.includes("spdownissue") || data.result.metadata.intentName.includes("spdownissue") )
																				 {
																				  intent="sp_servicemode";
																				 }
																				 if (data.result.contexts[0].name.includes("log_analytics")|| data.result.metadata.intentName.includes("log_analytics") )
																				 {
																				     intent = "log_analytics";
																				 }
																				
																				}
                                                                                 var clearchatbot=data.result.parameters.clearchatbot;
                                                                                if(clearchatbot=="yes" || clearchatbot=="yes please" || clearchatbot=="sure" || clearchatbot=="clear" || clearchatbot=="please clear" || clearchatbot=="please refresh")
                                                                                {
                                                                                  clearchat();
                                                                                }
                                                                            },
                                                                            error: function (data) {
                                                                                //alert(JSON.stringify(data, undefined, 2))
                                                                                respond(messageInternalError+JSON.stringify(data, undefined, 2));
                                                                            }

                                                                        });
                                                                        }
                                                                    }

                                                                    function prepareResponse(val) {
                                                                        var debugJSON = JSON.stringify(val, undefined, 2);
                                                                        if (val.result.speech != undefined) {
                                                                            spokenResponse = val.result.speech;
                                                                        }
                                                                        else if (val.result.fulfillment.speech != undefined) {

                                                                            spokenResponse = val.result.fulfillment.speech;
                                                                        }
                                                                        else {
                                                                            spokenResponse = messageInternalError;

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
                                                                        if (document.getElementById("chkspeaker").checked) {
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

                                                                                    // var msg = new SpeechSynthesisUtterance();
                                                                                    // msg.text = val;
                                                                                    // //msg.voice=voices[3];
                                                                                    // msg.voiceURI = "native";
                                                                                    // msg.lang = "en-US";
                                                                                    // window.speechSynthesis.speak(msg);
                                                                                    // // alert( "index " + i + "Name "+ voices[i].name +" uri " +voices[i].uri);
                                                                                   
                                                                                    speak(val);
                                                                                }

                                                                            }
                                                                        }

                                                                        printmessage_response(val);

                                                                    }


                                                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                    // Helper function to print chat message to the chat window
                                                                    function printmessage_request(text) {

                                                                        strdivrequest = '<span class="user-request">' +
                                                                                              '<div class="user-request__text">' + text + '</div>' +
                                                                                             '</span>';
                                                                        $("#container").append(strdivrequest);

                                                                        $("#resultWrapper").animate({
                                                                            scrollTop: $("#resultWrapper")[0].scrollHeight
                                                                        }, -500);

                                                                    }

                                                                    function printmessage_response(text) {


                                                                        strdivresponse = '<span class="server-response">' +
                                                                                              '<div class="spoken-response__text">' + text + '</div>' +
                                                                                             '</span>';
                                                                        $("#container").append(strdivresponse);

                                                                        $("#resultWrapper").animate({
                                                                            scrollTop: $("#resultWrapper")[0].scrollHeight
                                                                        }, -500);
                                                                        $speechInput.val("");
                                                                    }
                                                                            var synthesizer = null;
                                                                            var default_voiceURI = "native";
                                                                            var default_lang = "en-US";
                                                                            var voice=null;
                                                                            var available_voices=null;
                                                                            //u have to put speechSynthesis.getVoices() inside timer, beacuase without timer it returns a empty list. This is a bug in chrome.
                                                                            var timer = setInterval(function(){
                                                                                //window.speechSynthesis object contains information about speechSynthesis features available and also is used to control the SpeechSynthesisUtterance objects.
                                                                                //extract all available voices
                                                                                if("speechSynthesis" in window)
                                                                                {
                                                                                    //getVoices() gives a list of available human voices and their suitable language.
                                                                                    available_voices = speechSynthesis.getVoices();

                                                                                    //after running few times inside the timer callback the getVoices returns the list. Its also a bug.
                                                                                    if(available_voices.length !== 0)
                                                                                    {
                                                                                        //available_voices.length returns the total number of voices available. Every voice is made for a particular language. Bad mix will produce bad pronouncation. 
                                                                                        for(var count = 0; count < available_voices.length; count++)
                                                                                        {

                                                                                            //lang returns the langauage code for which the voice is made for.
                                                                                            //voiceURI returns a unique identifier for that voice. 
                                                                                            //voiceURI and lang come in pairs that means each voiceURI is trained for a particular language.
                                                                                            //name is the displayable name for the voice.
                                                                                            if(count == 0)
                                                                                            {
                                                                                                //we make the first voice as default.
                                                                                                default_voiceURI = available_voices[count].voiceURI;
                                                                                                default_lang = available_voices[count].lang;
                                                                                                voice=available_voices[0];
                                                                                            }

                                                                                            document.getElementById("select_voice").innerHTML += "<option value='" + available_voices[count].lang + "' data-voice-uri='" + available_voices[count].voiceURI +  "'>"+ available_voices[count].name + "</option>";
                                                                                        }
                                                                                        clearInterval(timer);
                                                                                    }
                                                                                }
                                                                                else
                                                                                {
                                                                                    alert("Speech Synthesis API not supported");
                                                                                    clearInterval(timer);
                                                                                }
                                                                            }, 1);

                                                                    function speak(val)
                                                                            {
                                                                                // var msg = new SpeechSynthesisUtterance();
                                                                                //     msg.text = val;
                                                                                //     //msg.voice=voices[3];
                                                                                //     msg.voiceURI = "native";
                                                                                //     msg.lang = "en-US";
                                                                                //     window.speechSynthesis.speak(msg);
                                                                                
                                                                                
                                                                                //if("SpeechSynthesisUtterance" in window)
                                                                                {
                                                                                    //select_voice();
                                                                                    // synthesizer = new SpeechSynthesisUtterance();
                                                                                    // synthesizer.text = text;//document.getElementById("text").value;
                                                                                    // synthesizer.voice = default_voiceURI;
                                                                                    // synthesizer.lang = default_lang;

                                                                                    var msg = synthesizer = new SpeechSynthesisUtterance();
                                                                                    msg.text = val;
                                                                                    if(voice!=null && voice!=undefined)
                                                                                    { msg.voice=voice;}
                                                                                   
                                                                                    msg.voiceURI = default_voiceURI;//"native";
                                                                                    msg.lang = default_lang;
                                                                                    
                                                                                    msg.onstart = function(){
                                                                                        //alert("Synthesis Started");
                                                                                       
                                                                                        if(recognition!=undefined && recognition!=null)
                                                                                        { 
                                                                                        recognition.stop();
                                                                                        $start_img.attr('src', "images/mic.gif");
                                                                                        }
                                                                                    }

                                                                                    msg.onend = function(){
                                                                                        //alert("Synthesis Stopped");
                                                                                        
                                                                                        if(recognition!=undefined && recognition!=null)
                                                                                        {                                                                                       
                                                                                         recognition.start();
                                                                                         $start_img.attr('src', "images/mic-animate.gif");
                                                                                        }
                                                                                    }

                                                                            
                                                                                    // alert( "index " + i + "Name "+ voices[i].name +" uri " +voices[i].uri);

                                                                                    //represents how fast the text will be spoken out. Value between 0.1 to 10.
                                                                                    //msg.rate = 1;

                                                                                    //represents the pitch. Value between 0 to 2.
                                                                                    //msg.pitch = 1;

                                                                                    // //fired when synthesizer is started
                                                                                    // synthesizer.onstart = function(){
                                                                                    //     console.log("Synthesis Started");
                                                                                    // }

                                                                                    // //fired when synthesizer is paused
                                                                                    // synthesizer.onpause = function(){
                                                                                    //     console.log("Synthesis Paused");
                                                                                    // }

                                                                                    // //fired when synthesizer is resumed after pause
                                                                                    // synthesizer.onresume = function(){
                                                                                    //     console.log("Synthesis Resumed after Pause");
                                                                                    // }

                                                                                    // //fired when synthesizer is stopped
                                                                                    // synthesizer.onend = function(){
                                                                                    //     console.log("Synthesis Stopped");
                                                                                    // }

                                                                                   window.speechSynthesis.speak(msg);
                                                                                }
                                                                            }

                                                                            // function pause()
                                                                            // {
                                                                            //     //speechSynthesis pauses all SpeechSynthesisUtterance objects outputs.
                                                                            //     if(speechSynthesis.paused === false)
                                                                            //     {
                                                                            //         speechSynthesis.pause();
                                                                            //     }
                                                                            // }   

                                                                            // function resume()
                                                                            // {
                                                                            //     //speechSynthesis resumes all SpeechSynthesisUtterance objects outputs.
                                                                            //     if(speechSynthesis.paused === true)
                                                                            //     {
                                                                            //         speechSynthesis.resume();
                                                                            //     }
                                                                            // }

                                                                            // function stop()
                                                                            // {
                                                                            //     //speechSynthesis stops all SpeechSynthesisUtterance objects outputs and deleted them from memory.
                                                                            //     speechSynthesis.cancel();
                                                                            // }

                                                                            function select_voices()
                                                                            {
                                                                                var sel_element = document.getElementById("select_voice").options[document.getElementById("select_voice").selectedIndex];
                                                                                default_lang = sel_element.getAttribute("value");
                                                                                default_voiceURI = sel_element.getAttribute("data-voice-uri");
                                                                                voice=available_voices[document.getElementById("select_voice").selectedIndex]; //sel_element.getAttribute("value");
                                                                                
                                                                            }
                                                                            


                                                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                                                                    var langs =
                                                                    [['Afrikaans',       ['af-ZA']],
                                                                    ['Bahasa Indonesia',['id-ID']],
                                                                    ['Bahasa Melayu',   ['ms-MY']],
                                                                    ['Català',          ['ca-ES']],
                                                                    ['Čeština',         ['cs-CZ']],
                                                                    ['Deutsch',         ['de-DE']],
                                                                    ['English',         ['en-AU', 'Australia'],
                                                                                        ['en-CA', 'Canada'],
                                                                                        ['en-IN', 'India'],
                                                                                        ['en-NZ', 'New Zealand'],
                                                                                        ['en-ZA', 'South Africa'],
                                                                                        ['en-GB', 'United Kingdom'],
                                                                                        ['en-US', 'United States']],
                                                                    ['Español',         ['es-AR', 'Argentina'],
                                                                                        ['es-BO', 'Bolivia'],
                                                                                        ['es-CL', 'Chile'],
                                                                                        ['es-CO', 'Colombia'],
                                                                                        ['es-CR', 'Costa Rica'],
                                                                                        ['es-EC', 'Ecuador'],
                                                                                        ['es-SV', 'El Salvador'],
                                                                                        ['es-ES', 'España'],
                                                                                        ['es-US', 'Estados Unidos'],
                                                                                        ['es-GT', 'Guatemala'],
                                                                                        ['es-HN', 'Honduras'],
                                                                                        ['es-MX', 'México'],
                                                                                        ['es-NI', 'Nicaragua'],
                                                                                        ['es-PA', 'Panamá'],
                                                                                        ['es-PY', 'Paraguay'],
                                                                                        ['es-PE', 'Perú'],
                                                                                        ['es-PR', 'Puerto Rico'],
                                                                                        ['es-DO', 'República Dominicana'],
                                                                                        ['es-UY', 'Uruguay'],
                                                                                        ['es-VE', 'Venezuela']],
                                                                    ['Euskara',         ['eu-ES']],
                                                                    ['Français',        ['fr-FR']],
                                                                    ['Galego',          ['gl-ES']],
                                                                    ['Hrvatski',        ['hr_HR']],
                                                                    ['IsiZulu',         ['zu-ZA']],
                                                                    ['Íslenska',        ['is-IS']],
                                                                    ['Italiano',        ['it-IT', 'Italia'],
                                                                                        ['it-CH', 'Svizzera']],
                                                                    ['Magyar',          ['hu-HU']],
                                                                    ['Nederlands',      ['nl-NL']],
                                                                    ['Norsk bokmål',    ['nb-NO']],
                                                                    ['Polski',          ['pl-PL']],
                                                                    ['Português',       ['pt-BR', 'Brasil'],
                                                                                        ['pt-PT', 'Portugal']],
                                                                    ['Română',          ['ro-RO']],
                                                                    ['Slovenčina',      ['sk-SK']],
                                                                    ['Suomi',           ['fi-FI']],
                                                                    ['Svenska',         ['sv-SE']],
                                                                    ['Türkçe',          ['tr-TR']],
                                                                    ['български',       ['bg-BG']],
                                                                    ['Pусский',         ['ru-RU']],
                                                                    ['Српски',          ['sr-RS']],
                                                                    ['한국어',            ['ko-KR']],
                                                                    ['中文',             ['cmn-Hans-CN', '普通话 (中国大陆)'],
                                                                                        ['cmn-Hans-HK', '普通话 (香港)'],
                                                                                        ['cmn-Hant-TW', '中文 (台灣)'],
                                                                                        ['yue-Hant-HK', '粵語 (香港)']],
                                                                    ['日本語',           ['ja-JP']],
                                                                    ['Lingua latīna',   ['la']]];


                                                                    function updateCountry() {
                                                                        for (var i = select_dialect.options.length - 1; i >= 0; i--) {
                                                                            select_dialect.remove(i);
                                                                        }
                                                                        var list = langs[select_language.selectedIndex];
                                                                        for (var i = 1; i < list.length; i++) {
                                                                            select_dialect.options.add(new Option(list[i][1], list[i][0]));
                                                                        }
                                                                        select_dialect.style.visibility = list[1].length == 1 ? 'hidden' : 'visible';
                                                                    }




                                                                </script>
                                                            

                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                          
                                        </div>
                                    <div class="panel panel-primary collapsible">
                                          <a name="summarypage3"></a>
                                           <a name="summarypage2"></a>
                                           <a name="summarypage"></a>
                                          
                                        <div class="panel-heading clickable animate" data-toggle="collapse" href="#powerInterfacePanel">
                                           
                                            <h4 class="panel-title">
                                                View Summary
                                                <span class="fa fa-chevron-up fa-lg fa-rotate-180 animate pull-right"></span>
                                            </h4>
                                             
                                        </div>
                                        <div id="powerInterfacePanel" class="panel-collapse ">
                                            <div class="panel-body">
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        
                                                            <table class="table table-condensed table-no-border">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>
                                                                            <div>
                                                                                 
                                                                                <div id="divProcessing" class="col-md-6" style="display:none;">

                                                                                    <img alt="processing" src="images/processing.gif" /><img alt="ajax-progress" src="images/ajax-progress.gif" width="50" height="50" />

                                                                                </div>
                                                                                <span id="spnsummary">View image summary here</span>
                                                                                <br /><br />
                                                                                <span id="spnsummarylog">View log analytics summary here</span>
                                                                                <div id="galleryResponse"></div><br />
                                                                                
                                                                                <!--[if lt IE 8]>
                                                                                    <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
                                                                                <![endif]-->
                                                                                <div id="imageviewerrequest">

                                                                                    <!-- Content -->
                                                                                    <div class="row">

                                                                                        <div class="docs-galley">
                                                                                            <ul class="docs-pictures clearfix">
                                                                                                <div class="row" id="image_preview"></div>
                                                                                                <!--<img id="requestimage" class='imagePreview' src="str_123.jpg" data-original="str_123.jpg" alt=""/>-->
                                                                                                <div id="divprocessedimage" style="padding-left:10px;">
                                                                                                    <span style="padding-left:5px;">See processed image/logs here</span>
                                                                                                    <img alt="" id="imgprocessedimage" src="" class="respimage" />
                                                                                                    <span style="padding-left:10px;">Click on the image to maximize. Press Escape or click on Close to cancel.</span>
                                                                                                </div>
                                                                                            </ul>
                                                                                        </div>

                                                                                    </div>
                                                                                    <!-- Footer -->
                                                                                    <footer class="docs-footer"></footer>

                                                                                    <!-- Scripts -->

                                                                                    <script src="js/viewer.js"></script>
                                                                                    <script src="js/main.js"></script>
                                                                                </div>
                                                                                 
                                                                            </div>
                                                                        </td>
                                                                    </tr>

                                                                </tbody>
                                                            </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                       
                                        <div class="panel panel-primary collapsible">
                                           <a name="srpage"></a>
                                           <a name="srpage2"></a>
                                            <div class="panel-heading clickable animate" data-toggle="collapse" href="#srpanel">

                                                <h4 class="panel-title">
                                                    View Service Request (SR)
                                                    <span class="fa fa-chevron-up fa-lg fa-rotate-180 animate pull-right"></span>
                                                </h4>
                                            </div>
                                            <div id="srpanel" class="panel-collapse ">
                                                <div class="panel-body">
                                                    <div class="container-fluid">
                                                        <div class="row">

                                                            <table class="table table-condensed table-no-border">
                                                                <tbody>
                                                                    <tr>
                                                                        <td>
                                                                            <div>

                                                                                <div id="divProcessingSR" class="col-md-6" style="display:none;">

                                                                                    <img alt="processing" src="images/processing.gif" /><img alt="ajax-progress" src="images/ajax-progress.gif" width="50" height="50" />

                                                                                </div>
                                                                                <div id="divsr">

                                                                                    <span id="spnsr"></span>
                                                                                </div>
                                                                                
                                                                            </div>
                                                                        </td>
                                                                    </tr>

                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    
                                     </div>

                            </div>
                                


                            <!--<div class="panel-body_Deleted">
                                <div id="powerSummaryPanel" >
                                    <iframe width="350" height="430" src="https://console.api.ai/api-client/demo/embedded/5beca097-fad4-4b60-bc74-8564a4fae2b9"></iframe>

                                </div>


                        </div>-->


                        </div>


                    </div>
                    
                </div>




                <div class="popup-box chat-popup nav-brand" id="qnimate"><h4 class="nav-page-name" style="vertical-align:top;padding-right:75px">Jarvis&nbsp;Support</h4><img id="imgefresh" src="images/btnrefresh.png" width="30" height="30" style="vertical-align:top;cursor: pointer;" onclick="clearchat()" />&nbsp;&nbsp;<label class="switch">
    <input type="checkbox" id="chkspeaker" checked>
    <div class="slider round"></div>
</label>

                    <button data-widget="remove" id="removeClass" class="chat-header-button pull-right" type="button"><i class="glyphicon glyphicon-remove"></i></button>
                    <div id="div_language">
    <select id="select_language" onchange="updateCountry()" style="width:80px;" class="select"></select>
    &nbsp;&nbsp;
    <select id="select_dialect" style="width:110px;" class="select"></select>
     &nbsp;&nbsp;
     <select id="select_voice" style="width:135px;" class="select" onchange="select_voices()"></select>
  </div>
                    <div class="popup-head nav-brand">
                        <div id="powerSummaryPanel1">
                            
                            <!--<iframe width="335" height="430" src="https://console.api.ai/api-client/demo/embedded/5beca097-fad4-4b60-bc74-8564a4fae2b9"></iframe>-->
                            
                            <!--<iframe width="350" height="430" src="https://console.api.ai/api-client/demo/embedded/dd7a1219-f49f-4fa1-b99d-e37e3a560620"></iframe>-->
                            
                            <!--Developer Staging Chatbot-->
                            <!--<iframe
                            width="350"
                            height="430"
                            src="https://console.api.ai/api-client/demo/embedded/5beca097-fad4-4b60-bc74-8564a4fae2b9">
                        </iframe>-->


                            <!--Custom Chatbot-->
                            <!--<iframe id="ifapiai" width="335" height="430" src="apiai.jsp"></iframe>-->
                            
                            <!--jarvis portal chat bot-->
                            <!--<iframe
                                width="350"
                                height="430"
                                src="https://console.api.ai/api-client/demo/embedded/dd7a1219-f49f-4fa1-b99d-e37e3a560620">
                            </iframe>-->



                            <div class="b-agent-demo">
                                <!--<span id="hdnusername" style="visibility:hidden;"> <%= session.getAttribute("user") %></span>
                                <span id="hdnsessionid" style="visibility:hidden;"> <%= request.getSession().getId() %></span>-->
                                    <div class="b-agent-demo-div" id="resultWrapper">
                                    <table class="b-agent-demo_result-table">
                                        <tbody>
                                            <tr>
                                                <td id="result">
                                                    <div id="container">
                                                       
                                                    </div>
                                                   
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="clearfix"></div>
                                <div class="b-agent-demo_input">
                                    <div id="agentDemoForm">
                                        <input type="text" name="query" id="speech" placeholder="Ask something..." class="inputtextchat" /><img id="start_img" src="images/mic.gif" alt="Start">
                                        
                                        <!--<div class="b-agent-demo_input-microphone icon-mic" id="mic" style="display: block;"></div>-->
                                        <!--<div class="container">
                  <input id="speech" type="text">
                  <button id="rec" class="btn">Speak</button>
                  <div id="spokenResponse" class="spoken-response">
                    <div class="spoken-response__text"></div>
                  </div>
                </div>-->
                                    </div>
                                    <div id="results">
  <span id="final_span" class="final"></span>
  <span id="interim_span" class="interim"></span>
  <p>
</div>
                                    <link href="https://fonts.googleapis.com/css?family=Titillium+Web:200" rel="stylesheet" type="text/css">
                                </div>
                            </div>







                        </div>
                    </div>
                    <!--<script src="js/ApiAiCustomScript.js"></script>-->
                </div>

                    
                <div class="popup-box-button popup-box-on" id="qnimateButton">
                    <div class="popup-head">
                        <div class="text-center">
                            <div class="row">
                                <div class="round hollow text-center">
                                    <a href="#" id="addClass"><span class="glyphicon glyphicon-comment"></span> Open in chat </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <footer>

                    <!--@Styles.Render("~/bundles/fontawesome")
                @RenderSection("Styles", required: false)
                @Scripts.Render("~/bundles/js/layout")
                @RenderSection("Scripts", required: false)-->
                </footer>
            </div>
                </div>
        </form>
    
    <input id="licenceAccepted" type="hidden" data-value="@Model.IsLicenceAccepted">
</body>
</html>
