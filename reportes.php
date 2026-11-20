<?php
require __DIR__ . '/includes/auth.php';
if ($usuario['rol'] !== 'admin') { header('Location: inicio.php'); exit; }
$titulo = 'Reportes';
$activo = 'reportes.php';
require __DIR__ . '/includes/header.php';
?>
<div class="card empty">
  <p>Reportes de publicaciones y comentarios.</p>
  <p class="muted small">Sección en construcción.</p>
</div>
<?php require __DIR__ . '/includes/footer.php'; ?>
