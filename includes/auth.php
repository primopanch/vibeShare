<?php
// Incluir al inicio de cada página protegida.
session_start();
if (empty($_SESSION['usuario'])) {
    header('Location: index.php');
    exit;
}
$usuario = $_SESSION['usuario'];
function e($s) { return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }
