<?php 
    header("Content-Type: application/json;charset=utf-8");
    require("connection.php");
    $type = $_GET["type"];
    if($type == 0){
        $query = $conn->prepare("SELECT ALINAN_URUN,sum(URUN_ADET) as TOPLAM_ADET,KATEGORI_ID,sum(URUN_ADET)*TANE_FIYAT as TOPLAM_HARCAMA,TANE_FIYAT FROM LISTE WHERE TAMAMLANDI=1 GROUP BY ALINAN_URUN,TANE_FIYAT ORDER BY TOPLAM_HARCAMA DESC");
    }
    else if($type==1){
        $query = $conn->prepare("SELECT ALINAN_URUN,sum(URUN_ADET) as TOPLAM_ADET,KATEGORI_ID,sum(URUN_ADET)*TANE_FIYAT as TOPLAM_HARCAMA,TANE_FIYAT FROM LISTE WHERE TAMAMLANDI=1 GROUP BY ALINAN_URUN,TANE_FIYAT ORDER BY TOPLAM_ADET DESC");
    }
    elseif($type==2){
        $query = $conn->prepare("SELECT KATEGORI_ID,sum(URUN_ADET) as TOPLAM_ADET,sum(URUN_ADET)*TANE_FIYAT AS TOPLAM_HARCAMA FROM LISTE WHERE TAMAMLANDI=1 GROUP BY KATEGORI_ID ORDER BY TOPLAM_ADET DESC");
    }
    
    $query->execute();
    $result = $query->fetchAll(PDO::FETCH_ASSOC);

    $response = json_encode($result);
    echo $response;

?>
