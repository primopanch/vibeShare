<?php
require __DIR__ . '/includes/auth.php';
$titulo = 'Inicio';
$activo = 'inicio.php';
require __DIR__ . '/includes/header.php';
$nombre = explode(' ', $usuario['nombre'])[0];
?>
<div class="card composer">
  <div class="composer-row">
    <span class="avatar"><?= e($inicial) ?></span>
    <span class="muted">¿Qué estás pensando, <?= e($nombre) ?>?</span>
  </div>
  <hr>
  <div class="composer-actions">
    <button class="btn btn-outline" disabled>Adjuntar imagen</button>
    <button class="btn btn-primary" disabled>Publicar</button>
  </div>
</div>
<div class="card empty">
  <p>¡Bienvenido a VibeShare! Aquí aparecerán las publicaciones de tus amigos.</p>
  <p class="muted small">Usa el menú superior para navegar por las secciones.</p>
</div>
<?php require __DIR__ . '/includes/footer.php'; ?>
