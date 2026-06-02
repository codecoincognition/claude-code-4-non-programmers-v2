// ============================================================
// PostHog analytics — anonymous, no cookies (Step 6)
// Replace phc_YOUR_PROJECT_KEY with your real PostHog project key.
// ============================================================
!function(t,e){var o,n,p,r;e.__SV||(window.posthog=e,e._i=[],
  e.init=function(i,s,a){/* posthog snippet body — paste the full
  official snippet from your PostHog project's "Web" install page */}}(
  document, window.posthog || []);

posthog.init('phc_YOUR_PROJECT_KEY', {
  api_host: 'https://us.i.posthog.com',
  persistence: 'memory',          // anonymous; no cookies
  capture_pageview: false,        // we'll fire it ourselves
});

// ============================================================
// A/B test on the hero headline — cookie-based 50/50 (Step 8)
// ============================================================
// Pick or remember variant
const cookieMatch = document.cookie.match(/(?:^|; )ab_headline=([AB])/);
let variant = cookieMatch ? cookieMatch[1] : (Math.random() < 0.5 ? 'A' : 'B');
if (!cookieMatch) {
  document.cookie = `ab_headline=${variant}; path=/; max-age=31536000; SameSite=Lax`;
}

// Swap the H1 if variant B
if (variant === 'B') {
  const h1 = document.querySelector('.hero-copy h1');
  if (h1) h1.textContent = 'Stop guessing what to charge for tier 2.';
}

// Tag every PostHog event with the variant
posthog.register({ headline_variant: variant });

// Fire the page_view event now that the variant is registered
posthog.capture('page_view', { page: 'pricing-webinar' });

// Track CTA clicks (hero + footer)
document.querySelectorAll('.cta').forEach(el => {
  el.addEventListener('click', () => {
    posthog.capture('cta_click', {
      location: el.classList.contains('cta-secondary') ? 'footer' : 'hero'
    });
  });
});

// ============================================================
// Form handler — POSTs to /api/submit, shows success/error (Step 4)
// ============================================================
const form = document.getElementById('register-form');
const status = form.querySelector('.status');

form.addEventListener('submit', async (e) => {
  e.preventDefault();
  const data = Object.fromEntries(new FormData(form));
  status.className = 'status';
  status.textContent = 'Saving your seat ...';
  try {
    const res = await fetch('/api/submit', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    });
    const json = await res.json();
    if (res.ok && json.success) {
      status.className = 'status ok';
      status.textContent = "You're in. Check your email for the link.";
      form.reset();
      posthog.capture('form_submit_success', { source: 'pricing-webinar' });
    } else {
      status.className = 'status err';
      status.textContent = json.message || 'Something went wrong. Try again.';
    }
  } catch (err) {
    status.className = 'status err';
    status.innerHTML = 'Network hiccup. <a href="#register">Try again</a>.';
  }
});
