---
description: Kiểm tra độ tương phản màu sắc giữa foreground và background. Đảm bảo accessibility (WCAG AA/AAA) cho UI testing.
---

# 🎨 Color Contrast Checker

Công cụ kiểm tra độ tương phản màu sắc giữa text (foreground) và background. Đảm bảo đạt chuẩn WCAG AA/AAA cho accessibility testing.

<div id="contrast-root">
<style>
.contrast-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.contrast-colors {
  display: flex;
  gap: 2rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}
.contrast-color-picker {
  flex: 1;
  min-width: 200px;
}
.contrast-color-picker label {
  font-size: 0.85rem;
  font-weight: 600;
  display: block;
  margin-bottom: 0.25rem;
}
.contrast-color-picker input[type="color"] {
  width: 60px;
  height: 40px;
  border: 1px solid var(--gray);
  border-radius: 4px;
  cursor: pointer;
  padding: 2px;
}
.contrast-color-picker input[type="text"] {
  width: 120px;
  padding: 0.4rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  margin-left: 0.5rem;
}
.contrast-preview {
  padding: 2rem;
  border-radius: 8px;
  text-align: center;
  margin-bottom: 1rem;
  border: 1px solid var(--gray);
}
.contrast-preview-text {
  font-size: 2rem;
  font-weight: bold;
}
.contrast-results {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 0.75rem;
  margin-bottom: 1rem;
}
.contrast-result-card {
  padding: 1rem;
  border-radius: 4px;
  text-align: center;
  border: 1px solid var(--gray);
}
.contrast-ratio {
  font-size: 2rem;
  font-weight: bold;
}
.contrast-status {
  font-size: 0.85rem;
  margin-top: 0.25rem;
}
.contrast-pass { color: #28a745; }
.contrast-fail { color: #dc3545; }
.contrast-extra-info {
  padding: 0.75rem;
  background: rgba(0,0,0,0.05);
  border-radius: 4px;
  font-size: 0.85rem;
  margin-top: 1rem;
}
.contrast-presets {
  margin-bottom: 1rem;
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}
.contrast-preset-btn {
  padding: 0.3rem 0.6rem;
  background: rgba(0,0,0,0.05);
  border: 1px solid var(--gray);
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.8rem;
}
.contrast-preset-btn:hover {
  background: var(--secondary);
  color: white;
}
</style>

<div class="contrast-container">
  <div class="contrast-presets">
    <strong>Presets:</strong>
    <button class="contrast-preset-btn" onclick="setPreset('#000000','#FFFFFF')">Black on White</button>
    <button class="contrast-preset-btn" onclick="setPreset('#FFFFFF','#000000')">White on Black</button>
    <button class="contrast-preset-btn" onclick="setPreset('#666666','#FFFFFF')">Gray on White</button>
    <button class="contrast-preset-btn" onclick="setPreset('#FF0000','#FFFFFF')">Red on White</button>
    <button class="contrast-preset-btn" onclick="setPreset('#007BFF','#FFFFFF')">Blue on White</button>
    <button class="contrast-preset-btn" onclick="setPreset('#777777','#CCCCCC')">Gray on Light Gray</button>
  </div>

  <div class="contrast-colors">
    <div class="contrast-color-picker">
      <label>🖊️ Foreground (Text):</label>
      <div style="display:flex;align-items:center;gap:0.5rem;">
        <input type="color" id="fg-color" value="#000000" onchange="updateContrast()">
        <input type="text" id="fg-hex" value="#000000" onchange="syncColor('fg')" maxlength="7">
      </div>
    </div>
    <div class="contrast-color-picker">
      <label>🖼️ Background:</label>
      <div style="display:flex;align-items:center;gap:0.5rem;">
        <input type="color" id="bg-color" value="#FFFFFF" onchange="updateContrast()">
        <input type="text" id="bg-hex" value="#FFFFFF" onchange="syncColor('bg')" maxlength="7">
      </div>
    </div>
    <div class="contrast-color-picker">
      <label>🔤 Preview Text:</label>
      <input type="text" id="preview-text" value="Sample Text" onchange="updateContrast()" style="width:200px;">
    </div>
  </div>

  <div class="contrast-preview" id="contrast-preview" style="background:#FFFFFF;color:#000000;">
    <div class="contrast-preview-text" id="preview-text-display">Sample Text</div>
    <div style="margin-top:0.5rem;font-size:0.9rem;">Aa Bb Cc 123 !@#</div>
  </div>

  <div class="contrast-results" id="contrast-results">
    <div class="contrast-result-card">
      <div class="contrast-ratio" id="ratio-value">21.00</div>
      <div>Contrast Ratio</div>
    </div>
    <div class="contrast-result-card">
      <div class="contrast-status contrast-pass" id="wcag-aa-normal">✅ PASS</div>
      <div>WCAG AA (Normal Text)</div>
    </div>
    <div class="contrast-result-card">
      <div class="contrast-status contrast-pass" id="wcag-aa-large">✅ PASS</div>
      <div>WCAG AA (Large Text)</div>
    </div>
    <div class="contrast-result-card">
      <div class="contrast-status contrast-fail" id="wcag-aaa-normal">❌ FAIL</div>
      <div>WCAG AAA (Normal Text)</div>
    </div>
    <div class="contrast-result-card">
      <div class="contrast-status contrast-pass" id="wcag-aaa-large">✅ PASS</div>
      <div>WCAG AAA (Large Text)</div>
    </div>
  </div>

  <div class="contrast-extra-info">
    <strong>📊 Thông tin màu:</strong>
    <div id="color-info"></div>
  </div>
</div>

<script>
function hexToRgb(hex) {
  hex = hex.replace('#', '');
  if (hex.length === 3) hex = hex.split('').map(c => c + c).join('');
  const r = parseInt(hex.substring(0, 2), 16);
  const g = parseInt(hex.substring(2, 4), 16);
  const b = parseInt(hex.substring(4, 6), 16);
  return [r, g, b];
}

function rgbToHex(r, g, b) {
  return '#' + [r, g, b].map(x => {
    const hex = x.toString(16);
    return hex.length === 1 ? '0' + hex : hex;
  }).join('');
}

function getLuminance(r, g, b) {
  const [rs, gs, bs] = [r, g, b].map(c => {
    c = c / 255;
    return c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
  });
  return 0.2126 * rs + 0.7152 * gs + 0.0722 * bs;
}

function getContrastRatio(hex1, hex2) {
  const [r1, g1, b1] = hexToRgb(hex1);
  const [r2, g2, b2] = hexToRgb(hex2);
  const l1 = getLuminance(r1, g1, b1);
  const l2 = getLuminance(r2, g2, b2);
  const lighter = Math.max(l1, l2);
  const darker = Math.min(l1, l2);
  return (lighter + 0.05) / (darker + 0.05);
}

function updateContrast() {
  const fgHex = document.getElementById("fg-color").value;
  const bgHex = document.getElementById("bg-color").value;
  const previewText = document.getElementById("preview-text").value || 'Sample Text';

  document.getElementById("fg-hex").value = fgHex;
  document.getElementById("bg-hex").value = bgHex;

  const preview = document.getElementById("contrast-preview");
  preview.style.background = bgHex;
  preview.style.color = fgHex;
  document.getElementById("preview-text-display").textContent = previewText;

  const ratio = getContrastRatio(fgHex, bgHex);
  document.getElementById("ratio-value").textContent = ratio.toFixed(2);

  // WCAG AA Normal Text: >= 4.5:1
  const aaNormal = ratio >= 4.5;
  document.getElementById("wcag-aa-normal").textContent = aaNormal ? '✅ PASS' : '❌ FAIL';
  document.getElementById("wcag-aa-normal").className = 'contrast-status ' + (aaNormal ? 'contrast-pass' : 'contrast-fail');

  // WCAG AA Large Text: >= 3:1
  const aaLarge = ratio >= 3;
  document.getElementById("wcag-aa-large").textContent = aaLarge ? '✅ PASS' : '❌ FAIL';
  document.getElementById("wcag-aa-large").className = 'contrast-status ' + (aaLarge ? 'contrast-pass' : 'contrast-fail');

  // WCAG AAA Normal Text: >= 7:1
  const aaaNormal = ratio >= 7;
  document.getElementById("wcag-aaa-normal").textContent = aaaNormal ? '✅ PASS' : '❌ FAIL';
  document.getElementById("wcag-aaa-normal").className = 'contrast-status ' + (aaaNormal ? 'contrast-pass' : 'contrast-fail');

  // WCAG AAA Large Text: >= 4.5:1
  const aaaLarge = ratio >= 4.5;
  document.getElementById("wcag-aaa-large").textContent = aaaLarge ? '✅ PASS' : '❌ FAIL';
  document.getElementById("wcag-aaa-large").className = 'contrast-status ' + (aaaLarge ? 'contrast-pass' : 'contrast-fail');

  // Color info
  const [r, g, b] = hexToRgb(fgHex);
  const [rb, gb, bb] = hexToRgb(bgHex);
  document.getElementById("color-info").innerHTML = `
    <strong>Foreground:</strong> ${fgHex} (RGB: ${r}, ${g}, ${b}) — Luminance: ${getLuminance(r,g,b).toFixed(4)}<br>
    <strong>Background:</strong> ${bgHex} (RGB: ${rb}, ${gb}, ${bb}) — Luminance: ${getLuminance(rb,gb,bb).toFixed(4)}
  `;
}

function syncColor(type) {
  const hexInput = document.getElementById(`${type}-hex`).value;
  if (/^#[0-9a-fA-F]{6}$/.test(hexInput)) {
    document.getElementById(`${type}-color`).value = hexInput;
    updateContrast();
  }
}

function setPreset(fg, bg) {
  document.getElementById("fg-color").value = fg;
  document.getElementById("bg-color").value = bg;
  updateContrast();
}

// Initialize
updateContrast();
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Chọn màu** Foreground (text) và Background bằng color picker hoặc nhập hex code.
2. **Xem Preview** trực tiếp với màu đã chọn.
3. **Kiểm tra kết quả** WCAG AA/AAA cho cả normal text và large text.
4. Dùng **Presets** để test nhanh các cặp màu phổ biến.

> 💡 **Mẹo:** Dùng công cụ này khi review UI/UX — kiểm tra xem màu text có đủ tương phản với background để người dùng (kể cả người khiếm thị) có thể đọc được không. WCAG AA yêu cầu minimum 4.5:1 cho normal text.
