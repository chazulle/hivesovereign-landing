# HIVE Sovereign Landing Page — Vercel Deployment

**Status:** Ready to deploy  
**Platform:** Vercel (static site)  
**Domain:** hivesovereign.com  
**Deployment time:** ~2 minutes

---

## QUICK DEPLOY (3 STEPS)

### **STEP 1: Install Vercel CLI (if not installed)**

```bash
npm install -g vercel
```

Or use npx (no installation needed):
```bash
npx vercel
```

---

### **STEP 2: Deploy from this directory**

**Option A — Deploy via CLI (fastest):**

```bash
# Navigate to this directory
cd /path/to/hivesovereign-landing

# Deploy (first time will ask you to login)
vercel

# Follow prompts:
# - Set up and deploy? Yes
# - Which scope? [Your Vercel account]
# - Link to existing project? No
# - Project name? hivesovereign-landing
# - Directory? ./
# - Override settings? No

# Production deployment
vercel --prod
```

**Option B — Deploy via Vercel Dashboard (recommended for custom domain):**

1. Go to **https://vercel.com/new**
2. Click **"Import Git Repository"** OR **"Deploy"**
3. If using Git:
   - Connect GitHub/GitLab
   - Select repository
   - Vercel auto-detects static site
4. If using drag-and-drop:
   - Drag this entire folder into Vercel
5. Click **Deploy**

---

### **STEP 3: Connect Custom Domain**

**After deployment completes:**

1. In Vercel dashboard → **Settings** → **Domains**
2. Add domain: **hivesovereign.com**
3. Vercel provides DNS configuration:

```
Type: A
Name: @ (or hivesovereign.com)
Value: 76.76.21.21

Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

4. Go to your domain registrar (GoDaddy, Namecheap, Cloudflare, etc.)
5. Add the DNS records Vercel provides
6. Wait 5-30 minutes for DNS propagation
7. Vercel auto-provisions SSL certificate

---

## ALTERNATIVE: ZIP & UPLOAD

If you don't have CLI access:

1. **Zip this directory:**
   ```bash
   zip -r hivesovereign-landing.zip .
   ```

2. **Go to Vercel dashboard** → New Project → Import
3. **Drag zip file** into upload area
4. **Deploy**

---

## FORM WEBHOOK CONFIGURATION

**CRITICAL:** The form currently has a placeholder submission handler.

**After deployment, update the form to submit to NoCodeBackend:**

### **Edit index.html lines 1102-1118:**

```javascript
// CURRENT (placeholder):
document.getElementById('applicationForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formData = {
        name: document.getElementById('name').value,
        org: document.getElementById('org').value,
        email: document.getElementById('email').value,
        teamType: document.getElementById('teamType').value,
        useCase: document.getElementById('useCase').value,
        timestamp: new Date().toISOString()
    };
    
    console.log('Form submission:', formData);
    alert('Thank you for your application. We will review and contact you within 48 hours.');
    e.target.reset();
});
```

**REPLACE WITH (NoCodeBackend integration):**

```javascript
document.getElementById('applicationForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formData = {
        customer_name: document.getElementById('name').value,
        customer_org: document.getElementById('org').value,
        customer_email: document.getElementById('email').value,
        team_type: document.getElementById('teamType').value,
        use_case: document.getElementById('useCase').value
    };
    
    try {
        const response = await fetch('https://[YOUR-WORKSPACE].nocodebackend.com/api/brief_orders', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer YOUR_NOCODEBACKEND_API_KEY'
            },
            body: JSON.stringify(formData)
        });
        
        if (response.ok) {
            alert('Thank you for your application. We will review and contact you within 48 hours.');
            e.target.reset();
        } else {
            throw new Error('Submission failed');
        }
    } catch (error) {
        console.error('Form submission error:', error);
        alert('Submission failed. Please email hello@hivesovereign.com directly.');
    }
});
```

**After making this change:**
```bash
# Redeploy
vercel --prod
```

---

## ENVIRONMENT VARIABLES (for API keys)

**Don't hardcode API keys in the HTML file.**

Instead, use Vercel Environment Variables:

1. Vercel Dashboard → Project → **Settings** → **Environment Variables**
2. Add:
   ```
   Name: NOCODEBACKEND_API_KEY
   Value: [your NoCodeBackend API key]
   ```

3. Update form handler to use serverless function (optional, more secure):
   - Create `/api/submit.js`
   - Move API call logic to serverless function
   - Frontend calls `/api/submit` instead of NoCodeBackend directly

---

## FILE STRUCTURE

```
hivesovereign-landing/
├── index.html          # Main landing page (ready to deploy)
├── vercel.json         # Vercel config (static site)
└── README.md           # This file
```

---

## DEPLOYMENT CHECKLIST

Before deploying:
- [ ] Review index.html content (all copy matches v6.18 handoff)
- [ ] Verify colors: Navy #0A1628, Teal #00D9C0, Cream #FDFBF7
- [ ] Fonts loading: Archivo + JetBrains Mono from Google Fonts

After deploying:
- [ ] Test live site at Vercel preview URL
- [ ] Test form submission (placeholder alert works)
- [ ] Connect hivesovereign.com domain
- [ ] Wait for SSL certificate (auto-provisioned)
- [ ] Update form handler with NoCodeBackend webhook
- [ ] Redeploy with production webhook
- [ ] Test end-to-end form submission

---

## VERCEL PREVIEW URL

After first deployment, Vercel gives you a preview URL:
```
https://hivesovereign-landing-[random].vercel.app
```

Test everything here before connecting custom domain.

---

## TROUBLESHOOTING

**Issue: Fonts not loading**
- Solution: Google Fonts CDN should work fine. If not, check console for CORS errors.

**Issue: Form not submitting**
- Solution: Check browser console for errors. Verify NoCodeBackend endpoint is correct.

**Issue: Domain not connecting**
- Solution: Verify DNS records exactly match Vercel's instructions. Wait 24hrs max.

**Issue: SSL certificate not provisioning**
- Solution: Ensure DNS is fully propagated first. Vercel auto-provisions once DNS resolves.

---

## NEXT STEPS AFTER DEPLOYMENT

1. ✅ Deploy to Vercel
2. ✅ Connect hivesovereign.com domain
3. ⏳ Set up NoCodeBackend (3 tables)
4. ⏳ Update form handler with NoCodeBackend webhook
5. ⏳ Redeploy with production webhook
6. ⏳ Test end-to-end submission flow
7. ⏳ Set up Stripe (products + webhook)
8. ⏳ Build API documentation page
9. ⏳ Breakcold outreach (3 design partners)

**R1 deadline: April 22, 2026 (11 days remaining)**

---

## VERCEL ADVANTAGES

✅ **Deploy in 2 minutes** (vs. hours learning Grigora)  
✅ **Git-based workflow** (push to GitHub → auto-deploy)  
✅ **Free SSL** (auto-provisioned)  
✅ **Global CDN** (instant load times)  
✅ **Serverless functions** (for secure form handling later)  
✅ **Preview deployments** (every commit gets unique URL)  
✅ **Zero config** (just drop files and deploy)

---

**Ready to deploy. Run `vercel` in this directory.**
# hivesovereign-landing
