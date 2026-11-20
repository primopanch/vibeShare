<?php
session_start();
require __DIR__ . '/config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') { header('Location: index.php'); exit; }

$correo     = trim($_POST['correo'] ?? '');
$contrasena = $_POST['contrasena'] ?? '';

function fallar($msg, $correo) {
    $_SESSION['error_login']  = $msg;
    $_SESSION['correo_login'] = $correo;
    header('Location: index.php');
    exit;
}

if ($correo === '' || $contrasena === '') {
    fallar('Completa el correo y la contraseña.', $correo);
}
if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    fallar('El correo electrónico no es válido.', $correo);
}

try {
    $st = db()->prepare('SELECT id_usuario, nombre_completo, correo, contrasena, rol FROM usuarios WHERE correo = ? LIMIT 1');
    $st->execute([$correo]);
    $u = $st->fetch();
} catch (PDOException $ex) {
    fallar('No se pudo conectar con la base de datos. Inténtalo más tarde.', $correo);
}

if (!$u || !password_verify($contrasena, $u['contrasena'])) {
    fallar('Correo o contraseña incorrectos.', $correo);
}

session_regenerate_id(true);
$_SESSION['usuario'] = [
    'id'     => (int)$u['id_usuario'],
    'nombre' => $u['nombre_completo'],
    'correo' => $u['correo'],
    'rol'    => $u['rol'],
];
header('Location: inicio.php');
exit;
