// Takarik Example App JavaScript

document.addEventListener('DOMContentLoaded', function() {
    console.log('🚀 Takarik Example App Loaded!');

    // Add some interactive features
    initializeFeatureCards();
    showLoadingTime();
    addClickTracking();
});

function initializeFeatureCards() {
    const cards = document.querySelectorAll('.feature-card');

    cards.forEach((card, index) => {
        // Add staggered animation
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';

        setTimeout(() => {
            card.style.transition = 'all 0.6s ease';
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 200);

        // Add hover effects
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px) scale(1.02)';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });
}

function showLoadingTime() {
    const loadTime = performance.now();
    console.log(`Page loaded in ${loadTime.toFixed(2)}ms`);

    // Add load time to footer if there's a spot for it
    const footer = document.querySelector('.footer');
    if (footer) {
        const loadTimeElement = document.createElement('p');
        loadTimeElement.innerHTML = `<small>Page loaded in ${loadTime.toFixed(2)}ms ⚡</small>`;
        loadTimeElement.style.opacity = '0.7';
        loadTimeElement.style.fontSize = '0.8rem';
        footer.appendChild(loadTimeElement);
    }
}

function addClickTracking() {
    const buttons = document.querySelectorAll('.btn');

    buttons.forEach(button => {
        button.addEventListener('click', function(e) {
            console.log(`Button clicked: ${this.textContent}`);

            // Add ripple effect
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.cssText = `
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.6);
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
                pointer-events: none;
                transform: scale(0);
                animation: ripple 0.6s ease-out;
            `;

            this.style.position = 'relative';
            this.style.overflow = 'hidden';
            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });
}

// Add CSS for ripple animation
const style = document.createElement('style');
style.textContent = `
    @keyframes ripple {
        to {
            transform: scale(2);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// API demo functionality
function fetchUsers() {
    fetch('/users')
        .then(response => response.json())
        .then(data => {
            console.log('Users API response:', data);
            showApiResponse(data);
        })
        .catch(error => {
            console.error('API Error:', error);
            showApiResponse({ error: error.message });
        });
}

function showApiResponse(data) {
    const existingResponse = document.querySelector('.api-response');
    if (existingResponse) {
        existingResponse.remove();
    }

    const responseDiv = document.createElement('div');
    responseDiv.className = 'api-response code-block';
    responseDiv.innerHTML = `
        <strong>API Response:</strong><br>
        <pre>${JSON.stringify(data, null, 2)}</pre>
    `;

    const container = document.querySelector('.container');
    if (container) {
        container.appendChild(responseDiv);
    }
}

// Make functions available globally for button clicks
window.fetchUsers = fetchUsers;