<?php
// Configuración de la base de datos
$host = 'localhost';
$dbname = 'esthebxn_social';
$username = 'esthebxn_web';
$password = 'password_seguro';

// Configuración adicional
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    // Crear conexión PDO
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password, $options);
    
    // Verificar conexión (opcional)
    $conn->query('SELECT 1');
    
} catch(PDOException $e) {
    // Registrar el error en un archivo de log (recomendado para producción)
    error_log('Error de conexión: ' . $e->getMessage());
    
    // Mostrar mensaje seguro al usuario
    die('Lo sentimos, estamos experimentando problemas técnicos. Por favor intenta más tarde.');
}

// Función para cerrar conexión (opcional)
function closeConnection(&$conn) {
    $conn = null;
}

// Ejemplo de uso:
// $stmt = $conn->prepare("SELECT * FROM usuarios WHERE username = ?");
// $stmt->execute([$username]);
// $user = $stmt->fetch();
?>