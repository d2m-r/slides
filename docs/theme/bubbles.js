console.log("Bubble fitter script loaded");


function fitBubblesToScreen() {
  const chain = document.querySelector('.bubble-chain');
  if (!chain) return;

  // All bubble elements inside
  const bubbles = chain.querySelectorAll('p.bubble-left, p.bubble-right');
  if (!bubbles.length) return;

  // Reset to base size first
  bubbles.forEach(bubble => {
    bubble.style.fontSize = ".9em";
    bubble.style.padding = ".7em 1.2em";
  });

  let fits = false;
  let fontSize = 0.9;
  let paddingV = 0.7;
  let paddingH = 1.2;

  // Try reducing size until it fits or hits a minimum size
  while (!fits && fontSize > 0.4) {
    const rect = chain.getBoundingClientRect();
    if (rect.top >= 0 && rect.bottom <= window.innerHeight) {
      fits = true;
      break;
    }
    fontSize -= 0.05;
    paddingV -= 0.05; // shrink vertical padding a bit to save space
    paddingH -= 0.06; // shrink horizontal padding a bit
    bubbles.forEach(bubble => {
      bubble.style.fontSize = fontSize + "em";
      bubble.style.padding = paddingV + "em " + paddingH + "em";
    });
  }
}

// Run this on load and on resize
window.addEventListener('DOMContentLoaded', fitBubblesToScreen);
window.addEventListener('resize', fitBubblesToScreen);

// bubble fragments should always use appropriate fade effect
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.bubble-chain .fragment').forEach(el => {
      if(el.classList.contains('bubble-left') && !el.classList.contains('fade-right')){
        el.classList.add('fade-right');
      } else if(el.classList.contains('bubble-right') && !el.classList.contains('fade-left')){
        el.classList.add('fade-left');
      }
    });
  });
