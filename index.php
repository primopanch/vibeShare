<?php
session_start();
if (!empty($_SESSION['usuario'])) { header('Location: inicio.php'); exit; }
$error  = $_SESSION['error_login'] ?? '';
$correo = $_SESSION['correo_login'] ?? '';
unset($_SESSION['error_login'], $_SESSION['correo_login']);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Iniciar sesión · VibeShare</title>
  <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body class="auth-page">
  <div class="auth-brand">VibeShare</div>
  <div class="card auth-card">
    <h1>Iniciar sesión</h1>
    <p class="muted">Introduce tus datos para acceder.</p>

    <?php if ($error): ?>
      <div class="alert" role="alert"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <form action="login.php" method="post" novalidate>
      <label for="correo">Correo electrónico</label>
      <input type="email" id="correo" name="correo" placeholder="tu@correo.com"
             value="<?= htmlspecialchars($correo) ?>" required autofocus>

      <label for="contrasena">Contraseña</label>
      <input type="password" id="contrasena" name="contrasena" placeholder="Introduce tu contraseña" required>

      <button type="submit" class="btn btn-primary btn-block">Iniciar sesión</button>
    </form>

    <a href="#" class="link small">¿Olvidaste tu contraseña?</a>
    <hr>
    <p class="small">¿No tienes cuenta? Crea una en segundos.</p>
    <a href="#" class="btn btn-outline btn-block">Registrarse</a>
  </div>
  <p class="footer">© 2026 VibeShare</p>
</body>
</html>
