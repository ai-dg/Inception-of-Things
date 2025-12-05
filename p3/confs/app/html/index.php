<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Hello kubernetes</title>
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Ubuntu:300">
</head>
<body>
	<?php 
		$version = 2;
		$prev = $version - 1
	?>

	<div class="main">
		<div class="message">
			<img src="./images/Kubernetes.svg" height="74px" width="74px" alt="k8s">
			 Hello This is v<?php echo $version; ?>	
		</div>
		<div class="content">
			Here is some content !!, I'm different from <?php echo $prev ; ?> !!
		</div>
	</div>
</body>
</html>