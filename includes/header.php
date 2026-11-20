<?php
// Requiere: $titulo y $activo definidos por la página.
$secciones = [
    'inicio.php'         => 'Inicio',
    'perfil.php'         => 'Mi perfil',
    'amigos.php'         => 'Amigos',
    'notificaciones.php' => 'Notificaciones',
    'mensajes.php'       => 'Mensajes',
    'configuracion.php'  => 'Configuración',
];
if ($usuario['rol'] === 'admin') {
    $secciones['usuarios.php'] = 'Usuarios';
    $secciones['reportes.php'] = 'Reportes';
}
$inicial = mb_strtoupper(mb_substr($usuario['nombre'], 0, 1));
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= e($titulo) ?> · VibeShare</title>
  <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
<header class="topbar">
  <a href="inicio.php" class="brand">VibeShare</a>
  <form class="search" action="amigos.php" method="get">
    <svg viewBox="0 0 24 24" width="16" height="16" aria-hidden="true"><circle cx="11" cy="11" r="7" fill="none" stroke="currentColor" stroke-width="2"/><path d="M20 20l-3.5-3.5" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
    <input type="search" name="q" placeholder="Buscar personas">
  </form>
  <div class="top-actions">
    <a href="notificaciones.php" title="Notificaciones" class="icon-btn">
      <svg viewBox="0 0 24 24" width="20" height="20"><path d="M6 16V11a6 6 0 1112 0v5l2 2H4l2-2zM10 20a2 2 0 004 0" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linejoin="round"/></svg>
    </a>
    <a href="mensajes.php" title="Mensajes" class="icon-btn">
      <svg viewBox="0 0 24 24" width="20" height="20"><path d="M4 12a8 8 0 1 1 3.5 6.6L4 20l1.3-3.6A8 8 0 0 1 4 12z" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linejoin="round"/></svg>
    </a>
    <details class="user-menu">
      <summary class="avatar" title="<?= e($usuario['nombre']) ?>"><?= e($inicial) ?></summary>
      <div class="dropdown">
        <strong><?= e($usuario['nombre']) ?></strong>
        <span class="muted"><?= e($usuario['correo']) ?></span>
        <a href="perfil.php">Mi perfil</a>
        <a href="configuracion.php">Configuración</a>
        <a href="logout.php" class="danger">Cerrar sesión</a>
      </div>
    </details>
  </div>
</header>
<nav class="tabs">
  <div class="tabs-inner">
    <?php foreach ($secciones as $url => $nombre): ?>
      <a href="<?= $url ?>" class="<?= $activo === $url ? 'active' : '' ?>"><?= $nombre ?></a>
    <?php endforeach; ?>
  </div>
</nav>
<main class="container">
  <h1><?= e($titulo) ?></h1>
