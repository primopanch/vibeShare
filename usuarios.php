<?php
require __DIR__ . '/includes/auth.php';
if ($usuario['rol'] !== 'admin') { header('Location: inicio.php'); exit; }
$titulo = 'Usuarios';
$activo = 'usuarios.php';
require __DIR__ . '/includes/header.php';
?>
<div class="card empty">
  <p>Administración de usuarios de la plataforma.</p>
  <p class="muted small">Sección en construcción.</p>
</div>
<?php require __DIR__ . '/includes/footer.php'; ?>
