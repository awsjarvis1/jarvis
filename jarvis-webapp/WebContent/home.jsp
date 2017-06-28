<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Jarvis Support Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="apple-touch-icon" href="apple-touch-icon.png">

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
            });
                 
        })

       

    </script>
</head>
<body>
    <!--<form id="frmdashboard" method="post" enctype="multipart/form-data" action="http://10.4.109.63:8080/upload">-->
        <!--<form method="POST" enctype="multipart/form-data" action="http://10.4.109.63:8080/upload">-->
           <form id="uploadimage" method="POST" enctype="multipart/form-data" action="http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123">
            <!--<form id="uploadimage" action="" method="post" enctype="multipart/form-data">-->
            <div class="layout-container">
                <header class="fixed-header">
                    <nav class="nav-brand">
                        <h3 class="nav-logo">
                            <a href="Dashboard.html">
                                <!--<img src="~/images/dell_emc_logo.png" alt="DELL EMC Logo" height="30" width="171" style="padding-right:15px;" />-->
                                <img src="images/jarvis.jpg" alt="DELL EMC Logo" height="35" width="50" style="padding-right:15px;" />
                                Jarvis Support Portal  <small>v1.0</small>
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
                                    Welcome Administrator
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
                                <a class="icon dashboard-icon" href="Dashboard.html" id="dashboard">Dashboard</a>
                            </li>
                            <!--<li>
                            <a class="icon help-icon" href="Dashboard.html" id="help">View Service Requests</a>
                        </li>-->
                            <li>
                                <a class="icon chat-icon" href="#" id="addClassChat">Open in chat</a>

                            </li>
                            <li>
                                <!--@Html.ActionLink("Help", "Index", "Help",
                            null, null, "", null, new { @class = "icon help-icon" }
                            )-->
                                <a class="icon help-icon" href="Dashboard.html" id="help">Help</a>
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
                                                        <div>
                                                            <div>
                                                                <table>
                                                                    <tr><td>File to upload:</td><td><input id="fileinput" type="file" name="file" /></td><td><input type="submit" id="btnsubmit" value="Upload" /></td></tr>
                                                                    <tr><td></td><td><br />
                                                                    <!--<input type="button" id="btnUpload" value="JS Upload" onclick="loadFile();" />-->
                                                                    </td></tr>
                                                                 <!--<h4 id='loading' >loading...</h4>
                                                                <div id="message"></div>-->
                                                                <!--<div id="image_preview"><img id="previewing" src="noimage.png" /></div>-->
                                                                 <!--<div class="container kv-main">
                                                                    <form enctype="multipart/form-data">
                                                                            <div class="form-group">
                                                                            <input id="file-1" type="file"  class="file1" data-overwrite-initial="false" data-min-file-count="1">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Preview File Icon</label>
                                                                            <input id="file-3" type="file"  data-overwrite-initial="false">
                                                                        </div>
                                                                        
                                                                    </form>
                                                                    
                                                                </div>-->
                                                                
                                                                <script>
                                                                $("#file-1").fileinput({
                                                                    showUpload: true,
                                                                    showCaption: false,
                                                                    //uploadUrl: 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123', // you must set a valid URL here else you will get an error
                                                                    allowedFileExtensions: ['jpg', 'png', 'gif','txt','log'],
                                                                    overwriteInitial: false,
                                                                    maxFileSize: 10240,
                                                                    maxFilesNum: 10,
                                                                    //allowedFileTypes: ['image', 'video', 'flash'],
                                                                    // slugCallback: function (filename) {
                                                                    //     return filename.replace('(', '_').replace(']', '_');
                                                                    // }
                                                                });

                                                                $("#file-3").fileinput({
                                                                        showUpload: true,
                                                                        showCaption: false,
                                                                         //uploadUrl: 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123',
                                                                        browseClass: "btn btn-primary btn-sm",
                                                                        allowedFileExtensions: ['jpg', 'png', 'gif','txt','log'],
                                                                        fileType: "any",
                                                                        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
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
                                                                
                                                                });
                                                            </script>
                                                                
                                                                </table>



                                                                <!--<input type="file" id="fileinput" multiple="multiple" accept="image/*" />-->
                                                                <div id="gallery"></div><br /><br /><br />

                                                                <label id="lblfilename"></label>&nbsp;&nbsp;<label id="lblfilesize"></label>&nbsp;&nbsp;<label id="lblfiletype"></label>
                                                                <!--<button id="btnSubmit" type="submit">Submit</button>-->
                                                                <script>

                                                        // fuction uploadImage1() 
                                                        // {

                                                        // file_data=$('#fileinput').val();

                                                        // $.ajax({
                                                        //     url: 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123', //call your upload fuction/page 
                                                        //     type: 'post',
                                                        //     dataType: 'json', //return type from given url called function
                                                        //     data: 'file=' + file_data, // pass the field data        
                                                        //     success: function(json) {
                                                        //         //fetch the success message here...
                                                        //         alert('successfully uploaded');
                                                        //     },
                                                        //     error: function(xhr, ajaxOptions, thrownError) {
                                                        //         alert('something went wrong');
                                                        //     }
                                                        // });

                                                        // }




                                                                    var uploadfiles = document.getElementById("fileinput"); //document.querySelector('#fileinput');
                                                                    uploadfiles.addEventListener('change', function () {
                                                                        var files = this.files;
                                                                        for (var i = 0; i < files.length; i++) {
                                                                            previewImage(this.files[i]);
                                                                        }

                                                                    }, false);


                                                                    function previewImage(file) {

                                                                        document.getElementById("lblfilename").innerHTML = "Name: " + file.name;
                                                                        document.getElementById("lblfilesize").innerHTML = "Size: " + file.size + "Bytes";
                                                                        document.getElementById("lblfiletype").innerHTML = "Type: " + file.type;


                                                                        var galleryId = "gallery";

                                                                        var gallery = document.getElementById(galleryId);
                                                                        var imageType = /image.*/;
                                                                        //alert(file.type);

                                                                        if (!file.type.match(imageType)) {
                                                                            throw "File Type must be an image";
                                                                        }

                                                                        var thumb = document.createElement("div");
                                                                        thumb.classList.add('thumbnail'); // Add the class thumbnail to the created div

                                                                        var img = document.createElement("img");
                                                                        img.file = file;
                                                                        thumb.appendChild(img);
                                                                        gallery.appendChild(thumb);

                                                                        // Using FileReader to display the image content
                                                                        var reader = new FileReader();
                                                                        reader.onload = (function (aImg) { return function (e) { aImg.src = e.target.result; }; })(img);
                                                                        reader.readAsDataURL(file);

                                                                        
                                                                        //var url= 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor';
                                                                         //var xhr = new XMLHttpRequest();
                                                                        //var fd = new FormData();
                                                                        
                                                                        //xhr.open("POST", url, true);
                                                                        //alert(xhr.responseText);
                                                                        //xhr.onreadystatechange = function () {
                                                                            
                                                                            //if (xhr.readyState == 4 && xhr.status == 200) {
                                                                                // Every thing ok, file uploaded
                                                                                //console.log(xhr.responseText); // handle response.
                                                                                ///alert("File uploaded successfully. "+xhr.responseText); // handle response.
                                                                            //}
                                                                            //else{
                                                                               // alert("File upload failed. Please try again."); // handle response.

                                                                            //}
                                                                       // };
                                                                       // fd.append("receiveFile", file);
                                                                        //fd.append("sessionId", "123");
                                                                        //xhr.send(fd);




                                                                        // $.ajax({
                                                                        //         url: 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123', //call your upload fuction/page 
                                                                        //         type: 'post',
                                                                        //         dataType: 'json', //return type from given url called function
                                                                        //         data: 'file=' + file, // pass the field data        
                                                                        //         success: function(json) {
                                                                        //             //fetch the success message here...
                                                                        //             alert('successfully uploaded'+ json);
                                                                        //         },
                                                                        //         error: function(xhr, ajaxOptions, thrownError) {
                                                                        //             alert('something went wrong' + json);
                                                                        //         }
                                                                        //     });
                                                                              //alert(file);                                                                                                      

                                                                        //uploadFile(file);


                                                                        // //var url = "http://10.4.109.63:8080/upload?sessionId=abc&intent=123";
                                                                        // var url = "http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile";
                                                                        // var xhr = new XMLHttpRequest();
                                                                        // var fd = new FormData();
                                                                        // xhr.open("POST", url, true);
                                                                        
                                                                        // xhr.onreadystatechange = function () {
                                                                            
                                                                        //     if (xhr.readyState == 4 && xhr.status == 200) {
                                                                        //         // Every thing ok, file uploaded
                                                                        //         console.log(xhr.responseText); // handle response.
                                                                        //         alert("File uploaded successfully. "+xhr.responseText); // handle response.
                                                                        //     }
                                                                        //     else{
                                                                        //         alert("File upload failed. Please try again."); // handle response.

                                                                        //     }
                                                                        // };
                                                                        // fd.append("file", file);
                                                                        // fd.append("sessionId", "123");
                                                                        // xhr.send(fd);
                                                                       
                                                                        
                                                                        //     var sTimeOut = setTimeout(function () {
                                                                                    
                                                                        // var url = "http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?";
                                                                        // var xhr = new XMLHttpRequest();
                                                                        // var fd = new FormData();
                                                                        // xhr.open("POST", url, true);
                                                                        
                                                                        // xhr.onreadystatechange = function () {
                                                                            
                                                                        //     if (xhr.readyState == 4 && xhr.status == 200) {
                                                                        //         // Every thing ok, file uploaded
                                                                        //         console.log(xhr.responseText); // handle response.
                                                                        //         alert("File uploaded successfully. "+xhr.responseText); // handle response.
                                                                        //     }
                                                                        //     else{
                                                                        //         alert("File upload failed. Please try again."); // handle response.

                                                                        //     }
                                                                        // };
                                                                        // fd.append("file", file);
                                                                        // fd.append("sessionId", "123");
                                                                        // xhr.send(fd);


                                                                        //         }, 15000);

                                                                        // var url = "http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123";
                                                                        // var xhr = new XMLHttpRequest();
                                                                        // var fd = new FormData();
                                                                        // xhr.open("POST", url, true);
                                                                        
                                                                        // xhr.onreadystatechange = function () {
                                                                            
                                                                        //     if (xhr.readyState == 4 && xhr.status == 200) {
                                                                        //         // Every thing ok, file uploaded
                                                                        //         console.log(xhr.responseText); // handle response.
                                                                        //         alert("File uploaded successfully. "+xhr.responseText); // handle response.
                                                                        //     }
                                                                        //     else{
                                                                        //         alert("File upload failed. Please try again."); // handle response.

                                                                        //     }
                                                                        // };
                                                                        // fd.append("file", file);
                                                                        // fd.append("sessionId", "123");
                                                                        // xhr.send(fd);


                                                                        // myFunction();
                                                                        // var myVar;

                                                                        // function myFunction() {
                                                                        //     myVar = setTimeout(alertFunc, 5000);
                                                                        // }

                                                                        // function alertFunc() {
                                                                        //     var url = "http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123";
                                                                        // var xhr = new XMLHttpRequest();
                                                                        // var fd = new FormData();
                                                                        //                                                                         fd.append("file", file);
                                                                        // // fd.append("sessionId", "123");
                                                                        // xhr.open("POST", url, true);
                                                                        
                                                                        // xhr.onreadystatechange = function () {
                                                                            
                                                                        //     if (xhr.readyState == 4 && xhr.status == 200) {
                                                                        //         // Every thing ok, file uploaded
                                                                        //         //console.log(xhr.responseText); // handle response.
                                                                        //         alert("File uploaded successfully. "+xhr.responseText); // handle response.
                                                                        //     }
                                                                        //     else{
                                                                        //         alert("File upload failed. Please try again."); // handle response.

                                                                        //     }
                                                                        // };

                                                                        // xhr.send(fd);
                                                                        // }
                                                                        
                                                                    }
                                                                    function uploadFile(myFileObject) {
                                                                    // Open Our formData Object
                                                                    var formData = new FormData();
                                                                
                                                                    // Append our file to the formData object
                                                                    // Notice the first argument "file" and keep it in mind
                                                                    //formData.append('receiveFile', myFileObject);
                                                                    //formData.append('sessionId', "123");
                                                                    // Create our XMLHttpRequest Object
                                                                    var xhr = new XMLHttpRequest();
                                                                
                                                                    // Open our connection using the POST method
                                                                    xhr.open("POST", 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/');
                                                                        xhr.onreadystatechange = function () {
                                                                            
                                                                           if (xhr.readyState == 4 && xhr.status == 200) 
                                                                            {
                                                                                // Every thing ok, file uploaded
                                                                                console.log(xhr.responseText); // handle response.
                                                                                alert("File uploaded successfully. "+xhr.response); // handle response.
                                                                            }
                                                                            else{
                                                                                alert("File upload failed. Please try again."+xhr.response); // handle response.

                                                                            }
                                                                        };                                                         

                                                                    // Send the file
                                                                    xhr.send(this);
                                                                     
                                                                        



                                                                }

                                                                function loadFile() {
                                                                        // Retrieve the FileList object from the referenced element ID
                                                                        var myFileList = document.getElementById('fileinput').files;
                                                                    
                                                                        // Grab the first File Object from the FileList
                                                                        var myFile = myFileList[0];
                                                                    
                                                                        // Set some variables containing the three attributes of the file
                                                                        var myFileName = myFile.name;
                                                                        var myFileSize = myFile.size;
                                                                        var myFileType = myFile.type;
                                                                    
                                                                        // Alert the information we just gathered
                                                                        alert("FileName: " + myFileName + "- FileSize: " + myFileSize + " - FileType: " + myFileType);
                                                                    
                                                                        // Let's upload the complete file object
                                                                        uploadFile(myFile);
                                                                    }

                                                                    // $(document).on("click", "#btnUpload", function() { alert("Called");
                                                                    //     var file_data = $("#fileinput").prop("files")[0];   // Getting the properties of file from file field
                                                                    //     var form_data = new FormData();                  // Creating object of FormData class
                                                                    //     form_data.append("file", file_data)              // Appending parameter named file with properties of file_field to form_data
                                                                    //     form_data.append("sessionId", 123)                 // Adding extra parameters to form_data
                                                                    //    $.ajax({
                                                                    //                 url: "http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?",
                                                                    //                 dataType: 'script',
                                                                    //                 cache: false,
                                                                    //                 contentType: false,
                                                                    //                 processData: false,
                                                                    //                 data: form_data,                         // Setting the data attribute of ajax with file_data
                                                                    //                 type: 'POST',
                                                                    //                 success: function(data)   // A function to be called if request succeeds
                                                                    //                 {
                                                                    //                     $('#loading').hide();
                                                                    //                     $("#message").html(data);
                                                                    //                     alert(data);
                                                                    //                 }
                                                                    //     });
                                                                         
                                                                    // })



                                                            //         $(document).ready(function (e) {
                                                            //         $("#uploadimage").on('submit',(function(e) {alert("Called");
                                                            //         e.preventDefault();
                                                            //         $("#message").empty();
                                                            //         $('#loading').show();
                                                            //         $.ajax({
                                                            //         url: "http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123", // Url to which the request is send
                                                            //         type: "POST",             // Type of request to be send, called as method
                                                            //         data: new FormData(this), // Data sent to server, a set of key/value pairs (i.e. form fields and values)
                                                            //         contentType: false,       // The content type used when sending data to the server.
                                                            //         cache: false,             // To unable request pages to be cached
                                                            //         processData:false,        // To send DOMDocument or non processed data file it is set to false
                                                            //         success: function(data)   // A function to be called if request succeeds
                                                            //         {
                                                            //         $('#loading').hide();
                                                            //         $("#message").html(data);
                                                            //         }
                                                                
                                                            //         });
                                                                   
                                                            //     }));
                                                                

                                                            //     // Function to preview image after validation
                                                            //     $(function() {
                                                            //     $("#fileinput").change(function() {
                                                            //     $("#message").empty(); // To remove the previous error message
                                                            //     var file = this.files[0];
                                                            //     var imagefile = file.type;
                                                            //     var match= ["image/jpeg","image/png","image/jpg"];
                                                            //     if(!((imagefile==match[0]) || (imagefile==match[1]) || (imagefile==match[2])))
                                                            //     {
                                                            //     $('#previewing').attr('src','noimage.png');
                                                                    //     $("#message").html("<p id='error'>Please Select A valid Image File</p>"+"<h4>Note</h4>"+"<span id='error_message'>Only jpeg, jpg and png images type allowed</span>");
                                                            //     return false;
                                                            //     }
                                                            //     else
                                                            //     {
                                                            //     var reader = new FileReader();
                                                            //     reader.onload = imageIsLoaded;
                                                            //     reader.readAsDataURL(this.files[0]);
                                                            //     }
                                                            //     });
                                                            //     });
                                                            //     function imageIsLoaded(e) {
                                                            //     $("#file").css("color","green");
                                                            //     $('#image_preview').css("display", "block");
                                                            //     $('#previewing').attr('src', e.target.result);
                                                            //     $('#previewing').attr('width', '250px');
                                                            //     $('#previewing').attr('height', '230px');
                                                            //     };
                                                            // });
                                                            



                                                                       // $("body").on("click", "#btnsubmit", function(e) { alert("called1");
                                                                        //e.preventDefault();
                                                                       // post_image();
                                                                       // });

                                                                        //function post_image() {
                                                                        //var img = find("fileinput").val();
                                                                        //alert(img);
                                                                        

                                                                        // $.ajax({
                                                                        //     url: 'http://ec2-34-227-222-250.compute-1.amazonaws.com:5000/api/imageprocessor/receiveFile?sessionId=123',
                                                                        //     type: 'POST',
                                                                        //     data: img,
                                                                        //     dataType: 'json',
                                                                        //     success: function(data) {
                                                                        //         //$("#photoreturn").fadeIn("fast");
                                                                        //         alert("img uploaded"+ data);
                                                                        //     },
                                                                        //      error: function(data) {
                                                                        //             alert('something went wrong' + data);
                                                                        //         }
                                                                        // }); // End of ajax call 



                                                                        








                                                                </script>
                                                            </div>

                                                        </div>

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
                                                        <div class="col-xs-6" style="width:980px">
                                                            <table class="table table-condensed table-no-border">
                                                                <tbody>
                                                                    <tr>
                                                                        Summary  here

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

                            </div>



                            <!--<div class="panel-body_Deleted">
                                <div id="powerSummaryPanel" >
                                    <iframe width="350" height="430" src="https://console.api.ai/api-client/demo/embedded/5beca097-fad4-4b60-bc74-8564a4fae2b9"></iframe>

                                </div>


                        </div>-->


                        </div>


                    </div>
                </div>




                <div class="popup-box chat-popup nav-brand" id="qnimate"><h4 class="nav-page-name">Jarvis Support Bot</h4>
                    <button data-widget="remove" id="removeClass" class="chat-header-button pull-right" type="button"><i class="glyphicon glyphicon-remove"></i></button>
                    <div class="popup-head nav-brand">
                        <div id="powerSummaryPanel1">
                            <!--<iframe width="335" height="430" src="https://console.api.ai/api-client/demo/embedded/5beca097-fad4-4b60-bc74-8564a4fae2b9"></iframe>-->
                            
                            <!--<iframe width="350" height="430" src="https://console.api.ai/api-client/demo/embedded/dd7a1219-f49f-4fa1-b99d-e37e3a560620"></iframe>-->
                            
                            <!--Developer Stsging Chatbot-->
                            <!--<iframe
                            width="350"
                            height="430"
                            src="https://console.api.ai/api-client/demo/embedded/5beca097-fad4-4b60-bc74-8564a4fae2b9">
                        </iframe>-->


                            <!--Custom Chatbot-->
                            <iframe id="ifapiai" width="335" height="430" src="apiai.jsp"></iframe>
                            
                            <!--jarvis portal chat bot-->
                            <!--<iframe
                                width="350"
                                height="430"
                                src="https://console.api.ai/api-client/demo/embedded/dd7a1219-f49f-4fa1-b99d-e37e3a560620">
                            </iframe>-->


                        </div>
                    </div>
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
        </form>
    
    <input id="licenceAccepted" type="hidden" data-value="@Model.IsLicenceAccepted">
</body>
</html>
