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
<form action="changepwd.jsp">
  <div class="container">
  
  	<label for="old-pwd"><b>Your Password</b></label>
    <input type="text" placeholder="Enter Your password" name="old-pwd">
    
    <label for="new-pwd"><b>New Password</b></label>
    <input type="text" placeholder="Enter New password" name="new-pwd">
    
    <button type="submit">Change</button>
  </div>

  <div class="container" style="background-color:#f1f1f1">
    <button type="button" class="cancelbtn">Cancel</button>
  </div>
 </form>
</body>
</html>