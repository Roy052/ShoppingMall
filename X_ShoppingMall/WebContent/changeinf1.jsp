<!DOCTYPE html>
<html>
<head>
 	<link type="text/css" href="style2.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>UNMI : Register</title>
</head>
<body>
	<div id="top-bar" class="container">
		<div class="row">
			<a href="Main.jsp"><img src="/logo.png" alt=""></a>
		</div>
	</div>
<form action="changeinf.jsp">
  <div class="container">
  
  	<label for="name"><b>Your Name</b></label>
    <input type="text" placeholder="Enter Your name" name="name">
    
    <label for="address"><b>Address</b></label>
    <input type="text" placeholder="Enter Address" name="address">
    
    <label for="tel"><b>TEL</b></label>
    <input type="text" placeholder="Enter TEL" name="tel">
    
    <label for="sex"><b>Sex</b></label>
    <select name = "sex">
    	<option ></option>
		<option value='m'>Male</option>
		<option value='f'>Female</option>
	</select><br>
    
    <label for="age"><b>Age</b></label>
    <input type="number" placeholder="Enter Age" name="age">
    
    <label for="job"><b>Job</b></label>
    <input type="text" placeholder="Enter Job" name="job">
    
    <button type="submit">Change</button>
  </div>

  <div class="container" style="background-color:#f1f1f1">
    <button type="button" class="cancelbtn">Cancel</button>
  </div>
 </form>
</body>
</html>