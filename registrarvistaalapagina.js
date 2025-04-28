// En tu script.js, puedes añadir esto al final:
document.addEventListener('DOMContentLoaded', function() {
    // Registrar visita via AJAX
    fetch('registrar_visita.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            pagina: window.location.pathname
        })
    });
});