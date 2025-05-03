Mostrar redes sociales dinámicamente.php







<?php
require 'db.php';

$stmt = $conn->prepare("SELECT plataforma, url_perfil FROM redes_sociales WHERE usuario_id = 1 ORDER BY orden");
$stmt->execute();
$redes = $stmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($redes as $red) {
    $icono = '';
    $clase = strtolower($red['plataforma']);
    
    switch ($red['plataforma']) {
        case 'Kick': $icono = 'fa-gamepad'; break;
        case 'Instagram': $icono = 'fa-instagram'; break;
        case 'TikTok': $icono = 'fa-tiktok'; break;
        default: $icono = 'fa-share-alt'; break;
    }
    
    echo '<a href="'.$red['url_perfil'].'" class="social-link '.$clase.'" target="_blank">
            <i class="fab '.$icono.'"></i> '.$red['plataforma'].'
          </a>';
}
?>
