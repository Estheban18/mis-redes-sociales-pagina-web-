registrar_visita.php














<?php
require 'db.php';

$data = json_decode(file_get_contents('php://input'), true);
$pagina = basename($data['pagina']);

$stmt = $conn->prepare("INSERT INTO visitas_pagina (pagina_visitada, ip_address, user_agent) 
                         VALUES (:pagina, :ip, :ua)");
$stmt->bindParam(':pagina', $pagina);
$stmt->bindParam(':ip', $_SERVER['REMOTE_ADDR']);
$stmt->bindParam(':ua', $_SERVER['HTTP_USER_AGENT']);
$stmt->execute();
?>
