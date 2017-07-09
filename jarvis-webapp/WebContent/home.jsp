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
            height: 180px;
            background-position: center center;
            background-size: cover;
            -webkit-box-shadow: 0 0 1px 1px rgba(0, 0, 0, .3);
            display: inline-block;
        }

    </style>

    <link rel="stylesheet" type="text/css" href="css/dashboard.css" />
    <link rel="stylesheet" type="text/css" href="content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="css/Product.css" />
    <link rel="stylesheet" type="text/css" href="css/Site.css" />
    <link rel="stylesheet" type="text/css" href="css/icons.css" />
    <link rel="stylesheet" type="text/css" href="css/configuration.css" />
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
    <script language="javascript" type="text/javascript" src="js/plugins/sortable.js"></script>
    <script language="javascript" type="text/javascript" src="js/fileinput.js"></script>
    <script>
        var elementList = "";
    </script>
    
    
    
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#addClass").click(function () {
                $('#qnimate').addClass('popup-box-on');
                $('#qnimateButton').removeClass('popup-box-on');
                $('#pnlEnvironmentData').addClass('panel-width855');

                respond("Hi " + document.getElementById("hdnusername").innerHTML + ";  Welcome!!!");
                respond("I can assist you on drive failure, lun not visible, sp in service mode and CLI commands related to Unity and VNX");
                respond("How can I help you ?");
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
                respond("Hi " + document.getElementById("hdnusername").innerHTML + ";  Welcome!!!");
                respond("I can assist you on drive failure, lun not visible, sp in service mode,image processing, log analytics and CLI commands related to Unity and VNX.");
                respond("How can I help you ?");

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
                
                var strwebhookurl = "http://ec2-18-220-11-119.us-east-2.compute.amazonaws.com:8081";

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
                                Jarvis - Remote Data Center Operation <small>v0.3</small>
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
                                <a class="icon help-icon" href="#" id="viewsr">View Service Request(SR)</a>
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
                            <div data-collapsed="true" class="panel-heading animate clickable" data-toggle="collapse" href="#powerSummaryPanel">
                                <h3 class="panel-title">
                                    Dashboard
                                    <span class="fa fa-angle-double-down fa-2x pull-right"></span>
                                </h3>

                            </div>

                            <div class="panel-body">
                                <div class="panel-group">

                                    <div class="panel panel-primary collapsible">
                                        <div class="panel-heading clickable animate" data-toggle="collapse" href="#powerSummaryPanel">
                                            <h4 class="panel-title">
                                                Upload File (img/txt/log)
                                                <span class="fa fa-chevron-up fa-lg fa-rotate-180 animate pull-right"></span>
                                            </h4>
                                        </div>
                                        <div id="powerSummaryPanel" class="panel-collapse ">
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
                                                                                     <td> <input type="checkbox" id="chksp" /><input type="checkbox" id="chkloganalytics" /></td>
                                                                                     <td style="padding-left:20px;">
                                                                                         <input id="file-3" type="file" data-overwrite-initial="false" multiple />
                                                                                     </td>
                                                                                     <td style="padding-left:20px;">
                                                                                         <input type="button" id="btnupload" value="Upload" class="btn btn-primary btn-md"/>
                                                                                         <a name="summarypage"></a>
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
                                                                        maxFileSize: 10240,
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

                                                                                var strimageurl = "http://ec2-52-15-39-48.us-east-2.compute.amazonaws.com:5001";
                                                                                
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

                                                                                       

                                                                                        document.getElementById("spnsummary").innerText = "Image File uploaded successfully. Image successfully processed and receivd response as: \n" + imageresponse.response_text +"\n \n=============================================================================";
                                                                                        respond("Image File uploaded successfully. Image successfully processed and receivd response as: \n" + imageresponse.response_text);
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
                                                                                        document.getElementById("imgprocessedimage").src = strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username;
                                                                                        //preview_images( strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username)
                                                                                        
                                                                                        respond("<div class='col-md-3'><img class='imagePreview' src='" + strimageurl + "/api/imageprocessor/getImage?fileName=" + imageresponse.response_image + "&sessionId=" + sessionid + "-" + username + "' ></div>");

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
                                                                        var strlogurl = "http://ec2-13-59-170-182.us-east-2.compute.amazonaws.com:5000";

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
                                                                                }
                                                                                
                                                                                if ((logresponse.result.toString().search("failed due to") >= 0 || logresponse.result.toString().search("Unable to root cause") >= 0 || logresponse.result.toString().search("create service request") >= 0) && producttype!="")
                                                                                {
                                                                                    var strwebhookurl="http://ec2-18-220-11-119.us-east-2.compute.amazonaws.com:8081";
                                                                                    
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
                                                                                            document.getElementById("spnsummarylog").innerText += "\n \n A Service request (SR) has been generated. Please refer SR#  " + data;
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
                                                                        
                                                                        recognition.continuous = false;
                                                                        recognition.interimResults = false;

                                                                        recognition.onstart = function (event) {
                                                                           
                                                                            
                                                                            //respond(messageRecording);
                                                                            updateRec();
                                                                        };
                                                                        recognition.onresult = function (event) {
                                                                           
                                                                            recognition.onend = null;

                                                                            var text = "";
                                                                            for (var i = event.resultIndex; i < event.results.length; ++i) {
                                                                                text += event.results[i][0].transcript;
                                                                            }
                                                                            setInput(text);
                                                                            stopRecognition();
                                                                        };
                                                                        recognition.onend = function () {
                                                                            respond(messageCouldntHear);
                                                                            stopRecognition();
                                                                        };
                                                                        recognition.lang = "en-US";
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
																		
                                                                        printmessage_request(text);
																		
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
																				 else if(data.result.contexts[0].name.includes("spdownissue"))// || data.result.contexts[1].name.includes("spdownissue") || data.result.contexts[2].name.includes("spdownissue") || data.result.contexts[0].name.includes("spdownissue") || data.result.contexts[1].name.includes("spdownissue") || data.result.contexts[2].name.includes("spdownissue") || data.result.metadata.intentName.includes("spdownissue") )
																				 {
																				  intent="sp_servicemode";
																				 }
																				 else if (data.result.contexts[0].name.includes("loganalytics"))
																				 {
																				     intent = "log_analytics";
																				 }
																				
																				}
                                                                            },
                                                                            error: function (data) {
                                                                                //alert(JSON.stringify(data, undefined, 2))
                                                                                respond(messageInternalError+JSON.stringify(data, undefined, 2));
                                                                            }

                                                                        });

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

                                                                                    var msg = new SpeechSynthesisUtterance();
                                                                                    msg.text = val;
                                                                                    //msg.voice=voices[3];
                                                                                    msg.voiceURI = "native";
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

                                                                    }

                                                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







                                                                </script>
                                                            

                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                           
                                        </div>
                                    <div class="panel panel-primary collapsible">
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
                                                                                <div id="imageviewer">

                                                                                    <!-- Content -->
                                                                                    <div class="row">

                                                                                        <div class="docs-galley">
                                                                                            <ul class="docs-pictures clearfix">
                                                                                                <div class="row" id="image_preview"></div>
                                                                                                <!--<img id="requestimage" class='imagePreview' src="C:\Users\patelsuj\Desktop\Code\30thJune2017\Final\str_123.jpg" data-original="C:\Users\patelsuj\Desktop\Code\30thJune2017\Final\str_123.jpg" alt=""/>-->
                                                                                            </ul>
                                                                                        </div>

                                                                                    </div>
                                                                                    <!-- Footer -->
                                                                                    <footer class="docs-footer"></footer>

                                                                                    <!-- Scripts -->

                                                                                    <script src="js/viewer.js"></script>
                                                                                    <script src="js/main.js"></script>
                                                                                </div>
                                                                                 <div id="divprocessedimage">
                                                                                   
                                                                                    <img alt="See processed image/logs here" id="imgprocessedimage" src="" width="600" height="500" />
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




                <div class="popup-box chat-popup nav-brand" id="qnimate"><h4 class="nav-page-name" style="vertical-align:top;padding-right:75px">Jarvis&nbsp;Support</h4><img id="imgefresh" src="images/btnrefresh.png" width="35" height="35" style="vertical-align:top" onclick="clearchat()" />&nbsp;&nbsp;<label class="switch">
    <input type="checkbox" id="chkspeaker" checked>
    <div class="slider round"></div>
</label>
                    <button data-widget="remove" id="removeClass" class="chat-header-button pull-right" type="button"><i class="glyphicon glyphicon-remove"></i></button>
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

                <footer><a name="srpage"></a>

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
