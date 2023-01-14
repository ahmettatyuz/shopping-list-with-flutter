<?php
header("Content-Type: application/json;charset=utf-8");
require("connection.php");
$filter = $_GET["filter"];
$query = $conn->prepare("SELECT LISTE.ID,LISTE.ALINAN_URUN,LISTE.URUN_ADET,LISTE.KATEGORI_ID,LISTE.TANE_FIYAT,LISTE.TANE_FIYAT*LISTE.URUN_ADET as TOPLAM_TUTAR,LISTE.DATE FROM LISTE WHERE TAMAMLANDI=:filter ORDER BY LISTE.DATE DESC");

$query->bindParam(":filter",$filter);

$query->execute();
$result = $query->fetchAll(PDO::FETCH_ASSOC);


$response = json_encode($result);
echo $response;



