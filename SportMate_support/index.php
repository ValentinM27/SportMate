<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Sport'Mate support</title>
    <link rel="stylesheet" href="style/style.css">
</head>
<nav>
    <h1>Sport'Mate</h1>
</nav>
<body>
    <form method="post" action="password/onSubmit.php">
        <!-- Enregistrement du token pour envoi -->
        <input type="hidden" name="token"  value="<?php if (isset($_GET['token']) && $_GET['token']){echo $_GET['token'];}?>">

        <label for="Email">Votre login</label>
        <input type="email" name="Email" required>

        <label for="PASSWORD">Nouveau mot de passe</label>
        <input type="password" name="PASSWORD" required>

        <label for="validatedPASSWORD">Valider votre mot de passe</label>
        <input type="password" name="validatePASSWORD" required>

        <input type="submit" name="valider" value="Changer mon mot de passe">
    </form>
</body>
</html>