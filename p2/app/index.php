<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo getenv('APP_NAME'); ?></title>
    <link rel="stylesheet" href="main.css">
</head>
<body>
    <main class="card">
        <div class="logo">
            <img src="images/Kubernetes.svg" alt="Kubernetes logo">
        </div>
        <h1 class="title">kubernetes</h1>
        <p class="subtitle">Hello from <?php echo getenv('APP_NAME'); ?>.</p>
        <span class="badge">Application status</span>
        <dl class="metrics">
            <dt>Pod</dt>
            <dd><?php echo getenv('POD_NAME'); ?></dd>
            <dt>Node</dt>
            <dd><?php echo getenv('NODE_NAME'); ?></dd>
            <dt>Pop id</dt>
            <dd><?php echo getenv('POP_ID'); ?></dd>
        </dl>
        <p class="footer">Inception of Things</p>
    </main>
</body>
</html>

