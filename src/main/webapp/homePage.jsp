<%@ page language="java" contentType="text/html; charset=ISO-8859-1"    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>Infrastructure Automation</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
    <script>
        $(document).ready(function () {

            $(document).on("click", "#clrBtn", function () {
                $("#portalForm input[type=text]").each(function () {
                    var input = $(this);
                    input.val("");
                });
                
                $("#message").html("");
            });

            $(document).on("click", "#submitBtn", function () {
                $("#portalForm input[type=text]").each(function () {
                    var input = $(this).val();
                    if (input == undefined || input == null || input.length == 0) {
                        return false;
                    }
                });
                $("#message").html("<img src='loading.gif' style='height:30px;width:30px'/>");
            	$.ajax({
                    url: 'processInputs',
                    type: 'GET',
                    data: {"numActive":$("#numActive").val(), "numDaysActive":$("#numDaysActive").val(), "loc":$("#loc").val(), "numReopened":$("#numReopened").val(), "numDefects":$("#numDefects").val()},
                    error: function (result) {
                    	$("#message").html("Unexpected Error");
                    },
                    success: function (result) {
                    	$("#message").html(result);
                    }
                });
            	
            });
            
        });
    </script>
    <style>
        .header-top {
            background-color: #fff;
            border: 1px solid #28327f;
        }

    </style>
</head>
<body style="background-color: #fbfbfb;">
    <div class="header-top">
        <div class="container">
            <div class="col-md-3"> <img src="qa_icon.jpeg" style="width: 275px; height: 100px;"/></div>
            <div class="col-md-6">
                <!--            <img src="" style="width: 100%; height: 400px;" />-->
                <h1 style="text-align: center;margin-top: 6%;">QA Prediction Tool</h1>
            </div>
            <div class="col-md-3"> <img src="http://newtglobal.com/wp-content/uploads/2016/03/newtglobal_logo.png"/></div>
        </div>
    </div>
    
    <div class="container">
        <div id="loginbox" style="margin-top: 50px; text-align: center">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title">Enter QA Input Details for the next release predictions</div>
                    <div class="clearfix"></div>
                </div>
                <br/>
    			<div style="text-align: center;">
    				<div id="message" style="display: inline-block;	text-align: center; font-family: Arial, Helvetica, sans-serif; 
    		 				font-size: 15px; font-weight: bold;">
    				</div>
    			</div>
                <div style="" class="panel-body">
                    <div style="display: none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                    <form class="form-horizontal" role="form" id="portalForm">

                        <div class="col-md-8 col-md-offset-2">
                            <div class="form-group">
                                <div class="clearfix"></div>
                                <br/>								
                                <div class="form-group">
                                    <label class="control-label col-sm-4">Average Number of times Active per defect:</label>
                                    <div class="col-sm-7">
                                        <input type="text" id="numActive"   class="form-control" placeholder="" />
                                    </div>
                                </div>
								<div class="form-group">
                                    <label class="control-label col-sm-4">Average Number of days Active per defect:</label>
                                    <div class="col-sm-7">
                                        <input type="text" id="numDaysActive"   class="form-control" placeholder="" />
                                    </div>
                                </div>
								<div class="form-group">
                                    <label class="control-label col-sm-4">Average Lines of Code per defect:</label>
                                    <div class="col-sm-7">
                                        <input type="text" id="loc"   class="form-control" placeholder="" />
                                    </div>
                                </div>
								<div class="form-group">
                                    <label class="control-label col-sm-4">Average Number of times Reopened per defect:</label>
                                    <div class="col-sm-7">
                                        <input type="text" id="numReopened"   class="form-control" placeholder="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-4">Total Number of defects:</label>
                                    <div class="col-sm-7">
                                        <input type="text" id="numDefects"   class="form-control" placeholder="" />
                                    </div>
                                </div>
                                <div style="text-align: center">
                                <span><button type="button" id="submitBtn" class="btn btn-success" style="margin-right: 8px;">Request Prediction</button></span>
                                <span><input type="button" id="clrBtn" value="Clear" class="btn btn-danger"   /></span>
                                <span><a href="http://192.168.43.254:8080/job/Predictive_Analytics_R/ws/Rplots.pdf"><input type="button" value="Download Dashboard" class="btn btn-danger" /></a></span>
                                </div>
                            <br />
                            <br />

                        </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

</html>