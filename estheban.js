document.addEventListener('DOMContentLoaded', function() {
    // Efecto de aparición escalonada para los elementos
    const profile = document.querySelector('.profile');
    const socialLinks = document.querySelectorAll('.social-link');
    
    profile.style.opacity = '0';
    profile.style.animation = 'fadeIn 1s ease-in-out 0.5s forwards';
    
    socialLinks.forEach((link, index) => {
        link.style.opacity = '0';
        link.style.transform = 'translateY(20px)';
        link.style.animation = `fadeIn 0.6s ease-in-out ${index * 0.15 + 0.8}s forwards`;
        
        // Añadir efecto de onda a cada botón
        const wave = document.createElement('div');
        wave.className = 'wave';
        link.appendChild(wave);
    });
    
    // Control de video para móviles
    const video = document.getElementById('myVideo');
    
    function handleVisibilityChange() {
        if (document.hidden) {
            video.pause();
        } else {
            video.play().catch(e => console.log(e));
        }
    }
    
    document.addEventListener("visibilitychange", handleVisibilityChange);
    
    // Configuración para móviles
    if (/Mobi|Android/i.test(navigator.userAgent)) {
        video.muted = true;
        video.setAttribute('playsinline', '');
        video.setAttribute('webkit-playsinline', '');
    }
    
    // Intentar reproducir el video con interacción del usuario
    function playVideo() {
        const promise = video.play();
        
        if (promise !== undefined) {
            promise.catch(error => {
                // Mostrar mensaje para interactuar si el autoplay está bloqueado
                const playButton = document.createElement('div');
                playButton.className = 'play-button';
                playButton.innerHTML = '<i class="fas fa-play"></i> Haz clic para reproducir fondo';
                playButton.style.position = 'fixed';
                playButton.style.top = '20px';
                playButton.style.right = '20px';
                playButton.style.background = 'rgba(0,0,0,0.7)';
                playButton.style.color = 'white';
                playButton.style.padding = '10px 15px';
                playButton.style.borderRadius = '5px';
                playButton.style.cursor = 'pointer';
                playButton.style.zIndex = '1000';
                playButton.addEventListener('click', function() {
                    video.play();
                    playButton.remove();
                });
                document.body.appendChild(playButton);
            });
        }
    }
    
    // Reproducir al hacer clic en cualquier parte
    document.addEventListener('click', function init() {
        playVideo();
        document.removeEventListener('click', init);
    }, { once: true });
    
    // Efecto especial para el botón de TikTok
    const tiktokBtn = document.querySelector('.tiktok');
    if (tiktokBtn) {
        setInterval(() => {
            const hue = Math.floor(Math.random() * 360);
            tiktokBtn.style.boxShadow = `0 5px 20px hsla(${hue}, 100%, 50%, 0.7)`;
        }, 1500);
    }
    
    // Efecto de rotación para los iconos al pasar el mouse
    socialLinks.forEach(link => {
        const icon = link.querySelector('i');
        link.addEventListener('mouseenter', () => {
            icon.style.transform = 'rotate(360deg)';
        });
        link.addEventListener('mouseleave', () => {
            icon.style.transform = 'rotate(0deg)';
        });
    });
});