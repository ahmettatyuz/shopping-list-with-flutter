<?php 
	header("Content-Type: application/json;charset=utf-8");
	require("connection.php");
	$query = $conn->prepare("SELECT * FROM kategori");
	$query->execute();
	$result = $query->fetchAll(PDO::FETCH_ASSOC);

	$response = json_encode($result);
	echo $response;

 ?>	