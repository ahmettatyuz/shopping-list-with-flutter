<?php 
    header("Content-Type: application/json;charset=utf-8");
    require("connection.php");

    $alinan_urun_id = $_GET["urun_id"];
    $currentTime=date("Y-m-d H:i:s");
    $query=$conn->prepare("UPDATE `LISTE` SET `TAMAMLANDI`='1',DATE=:current WHERE ID=:satis_id");
    $query->bindParam(":satis_id",$alinan_urun_id);
    $query->bindParam(":current",$currentTime);
    $query->execute();





