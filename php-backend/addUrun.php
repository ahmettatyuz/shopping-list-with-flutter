<?php 
    require("connection.php");
    $urunAd=strtoupper($_GET["urunAd"]);
    $adet=$_GET["adet"];
    $kategoriId=$_GET["kategoriId"];
    $tane_fiyat=$_GET["tane_fiyat"];
    $query=$conn->prepare("SELECT * FROM LISTE WHERE ALINAN_URUN=:urunAd AND TAMAMLANDI=0");
    $query->bindParam(":urunAd",$urunAd);
    $query->execute();
    if(count($query->fetchAll(PDO::FETCH_ASSOC))>0){
        $result =  array(
            "result"=>"2",
        );
        echo json_encode($result);
    }else{
        $query = $conn->prepare("INSERT INTO `LISTE`(`ALINAN_URUN`, `URUN_ADET`, `KATEGORI_ID`, `TANE_FIYAT`) VALUES (:urunAd,:adet,:kategoriId,:tane_fiyat)");
        $query->bindParam(":urunAd",$urunAd);
        $query->bindParam(":adet",$adet);
        $query->bindParam(":kategoriId",$kategoriId);
        $query->bindParam(":tane_fiyat",$tane_fiyat);
        if($query->execute()){
            $result =  array(
                "result"=>"1",
            );
            echo json_encode($result);
        }
        
    }