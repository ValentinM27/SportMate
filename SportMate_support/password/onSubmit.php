<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style/style.css">
    <title>Demande envoyée</title>
</head>

<nav>
    <h1>Sport'Mate</h1>
</nav>

<body>
    <?php 
        header("Access-Control-Allow-Origin: *");
        
        if(!empty($_POST['valider'])){

            if(!empty($_POST['PASSWORD']) && !empty($_POST['validatePASSWORD']) && !empty($_POST['Email'])){

                // Data affectation
                $_Email = $_POST['Email'];
                $_PASSWORD = $_POST['PASSWORD'];
                $_validatePASSWORD = $_POST['validatePASSWORD'];
                $_token = $_POST['token'];

            
                /**
                 * Proceed to data sending to API
                 */
                $url = "http://appart.dialyx.fr:9670/MyS1CLj3JOBZqShqkdUyAz4tZkggWigKvDTtwUnT/api/user/changePassword";

                $curl = curl_init($url);
                curl_setopt($curl, CURLOPT_URL, $url);
                curl_setopt($curl, CURLOPT_POST, true);
                curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

                $headers = array(
                "Accept: application/json",
                "Content-Type: application/json",
                );
                curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);

                $_data = array(
                    'Email' => $_Email,
                    'PASSWORD' => $_PASSWORD,
                    'validatePASSWORD' => $_validatePASSWORD,
                    'token' => $_token,
                );

                $_dataJson = json_encode($_data);

                curl_setopt($curl, CURLOPT_POSTFIELDS, $_dataJson);
                curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);


                $resp = curl_exec($curl);
                curl_close($curl);

                $respJson = json_decode($resp);

                echo $respJson->{'message'};
            }
        }
    ?>    
</body>
</html>
