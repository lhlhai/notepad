---
title: "✅ Interactive QA Toolbox"
description: "Bộ 12+ công cụ tương tác trực tiếp trên trình duyệt dành cho QA - Modern Light Theme"
---

# 🛠️ Interactive QA Toolbox - Modern Edition

Trang này cung cấp các công cụ tiện ích chạy trực tiếp trên trình duyệt để hỗ trợ công việc kiểm thử hàng ngày. Giao diện light theme hiện đại, dễ nhìn.

<div id="qa-toolbox-root">
<style>
/* ===== ROOT VARIABLES - LIGHT THEME ===== */
:root {
  --qb-primary: #4f46e5;
  --qb-primary-hover: #4338ca;
  --qb-secondary: #0ea5e9;
  --qb-success: #22c55e;
  --qb-warning: #f59e0b;
  --qb-danger: #ef4444;
  --qb-info: #06b6d4;
  --qb-purple: #8b5cf6;
  --qb-pink: #ec4899;
  
  --qb-bg: #f8fafc;
  --qb-card-bg: #ffffff;
  --qb-border: #e2e8f0;
  --qb-text: #1e293b;
  --qb-text-muted: #64748b;
  --qb-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
  --qb-shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
}

/* ===== BASE STYLES ===== */
.toolbox-container {
  font-family: 'Inter', system-ui, -apple-system, sans-serif;
  color: var(--qb-text);
  background: var(--qb-bg);
  padding: 2rem;
  margin-top: 1rem;
}

.toolbox-header {
  text-align: center;
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: linear-gradient(135deg, var(--qb-primary), var(--qb-secondary));
  border-radius: 16px;
  color: white;
  box-shadow: var(--qb-shadow-lg);
}

.toolbox-header h2 {
  margin: 0 0 0.5rem 0;
  font-size: 1.8rem;
  font-weight: 700;
}

.toolbox-header p {
  margin: 0;
  opacity: 0.9;
  font-size: 1rem;
}

/* ===== TAB NAVIGATION ===== */
.toolbox-tabs {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  justify-content: center;
  margin-bottom: 2rem;
  padding: 1rem;
  background: var(--qb-card-bg);
  border-radius: 12px;
  box-shadow: var(--qb-shadow);
}

.toolbox-tab {
  padding: 0.75rem 1.25rem;
  border: none;
  background: var(--qb-bg);
  color: var(--qb-text-muted);
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  font-size: 0.9rem;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.toolbox-tab:hover {
  background: var(--qb-primary);
  color: white;
  transform: translateY(-2px);
}

.toolbox-tab.active {
  background: var(--qb-primary);
  color: white;
  box-shadow: 0 4px 12px rgba(79, 70, 229, 0.4);
}

/* ===== TOOL PANELS ===== */
.tool-panel {
  display: none;
  animation: fadeIn 0.3s ease;
}

.tool-panel.active {
  display: block;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

/* ===== CARD STYLES ===== */
.tool-card {
  background: var(--qb-card-bg);
  border: 1px solid var(--qb-border);
  border-radius: 12px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
  box-shadow: var(--qb-shadow);
}

.tool-card h3 {
  margin: 0 0 1.25rem 0;
  font-size: 1.25rem;
  color: var(--qb-primary);
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid var(--qb-border);
}

/* ===== INPUT GROUPS ===== */
.input-group {
  margin-bottom: 1rem;
}

.input-group label {
  display: block;
  font-size: 0.875rem;
  font-weight: 600;
  color: var(--qb-text);
  margin-bottom: 0.5rem;
}

.input-group input[type="text"],
.input-group input[type="number"],
.input-group textarea,
.input-group select {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid var(--qb-border);
  border-radius: 8px;
  background: var(--qb-bg);
  color: var(--qb-text);
  font-family: 'JetBrains Mono', 'Fira Code', monospace;
  font-size: 0.875rem;
  transition: all 0.2s ease;
  box-sizing: border-box;
}

.input-group input:focus,
.input-group textarea:focus,
.input-group select:focus {
  outline: none;
  border-color: var(--qb-primary);
  box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}

.input-group textarea {
  min-height: 120px;
  resize: vertical;
}

/* ===== BUTTONS ===== */
.btn {
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  font-size: 0.875rem;
  transition: all 0.2s ease;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  justify-content: center;
}

.btn-primary {
  background: var(--qb-primary);
  color: white;
}

.btn-primary:hover {
  background: var(--qb-primary-hover);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(79, 70, 229, 0.4);
}

.btn-secondary {
  background: var(--qb-secondary);
  color: white;
}

.btn-secondary:hover {
  background: #0284c7;
  transform: translateY(-2px);
}

.btn-success {
  background: var(--qb-success);
  color: white;
}

.btn-success:hover {
  background: #16a34a;
}

.btn-danger {
  background: var(--qb-danger);
  color: white;
}

.btn-danger:hover {
  background: #dc2626;
}

.btn-outline {
  background: transparent;
  border: 2px solid var(--qb-border);
  color: var(--qb-text-muted);
}

.btn-outline:hover {
  border-color: var(--qb-primary);
  color: var(--qb-primary);
}

.btn-group {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  margin-top: 1rem;
}

/* ===== RESULT AREAS ===== */
.result-area {
  margin-top: 1rem;
  padding: 1rem;
  background: var(--qb-bg);
  border: 1px solid var(--qb-border);
  border-radius: 8px;
  font-family: 'JetBrains Mono', 'Fira Code', monospace;
  font-size: 0.85rem;
  min-height: 3rem;
  max-height: 400px;
  overflow-y: auto;
  word-break: break-word;
  position: relative;
}

.result-area pre {
  margin: 0;
  white-space: pre-wrap;
}

.copy-btn {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  padding: 0.25rem 0.75rem !important;
  font-size: 0.75rem !important;
  background: var(--qb-primary) !important;
  border-radius: 4px;
}

/* ===== STATS CARDS ===== */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 1rem;
  margin-bottom: 1rem;
}

.stat-card {
  background: linear-gradient(135deg, var(--qb-primary), var(--qb-secondary));
  padding: 1rem;
  border-radius: 8px;
  text-align: center;
  color: white;
}

.stat-card.warning {
  background: linear-gradient(135deg, var(--qb-warning), #f97316);
}

.stat-card.success {
  background: linear-gradient(135deg, var(--qb-success), #16a34a);
}

.stat-card.danger {
  background: linear-gradient(135deg, var(--qb-danger), #dc2626);
}

.stat-number {
  font-size: 1.75rem;
  font-weight: 700;
  display: block;
}

.stat-label {
  font-size: 0.75rem;
  opacity: 0.9;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* ===== TABLES ===== */
.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.85rem;
}

.data-table th,
.data-table td {
  padding: 0.75rem;
  text-align: left;
  border: 1px solid var(--qb-border);
}

.data-table th {
  background: linear-gradient(135deg, var(--qb-primary), var(--qb-secondary));
  color: white;
  font-weight: 600;
  position: sticky;
  top: 0;
  z-index: 10;
}

.data-table tr:nth-child(even) {
  background: var(--qb-bg);
}

.data-table tr:hover {
  background: rgba(79, 70, 229, 0.05);
}

/* ===== DIFF HIGHLIGHTS ===== */
.diff-added { background-color: #dcfce7 !important; color: #166534; }
.diff-removed { background-color: #fee2e2 !important; color: #991b1b; text-decoration: line-through; }
.diff-changed { background-color: #fef3c7 !important; color: #92400e; }
.diff-same { color: var(--qb-text-muted); }

/* ===== LOG HIGHLIGHTS ===== */
.log-error { background-color: #fee2e2 !important; color: #991b1b; font-weight: 600; }
.log-warn { background-color: #fef3c7 !important; color: #92400e; }
.log-info { background-color: #dbeafe !important; color: #1e40af; }
.log-debug { background-color: #f3f4f6 !important; color: #4b5563; }

/* Custom highlight colors */
.log-custom-1 { background-color: #fecaca ! color: #991b1b; }
.log-custom-2 { background-color: #bfdbfe; color: #1e40af; }
.log-custom-3 { background-color: #bbf7d0; color: #166534; }
.log-custom-4 { background-color: #fed7aa; color: #92400e; }
.log-custom-5 { background-color: #e9d5ff; color: #6b21a8; }

/* ===== FLEX UTILITIES ===== */
.flex-row { display: flex; gap: 1rem; flex-wrap: wrap; }
.flex-col { display: flex; flex-direction: column; gap: 1rem; }
.flex-1 { flex: 1; }
.items-center { align-items: center; }
.justify-between { justify-content: space-between; }

/* ===== RESPONSIVE ===== */
@media (max-width: 768px) {
  .toolbox-container { padding: 1rem; }
  .flex-row { flex-direction: column; }
  .toolbox-tabs { overflow-x: auto; justify-content: flex-start; }
  .stats-grid { grid-template-columns: repeat(2, 1fr); }
}

/* ===== SCROLLBAR ===== */
::-webkit-scrollbar { width: 8px; height: 8px; }
::-webkit-scrollbar-track { background: var(--qb-bg); border-radius: 4px; }
::-webkit-scrollbar-thumb { background: var(--qb-border); border-radius: 4px; }
::-webkit-scrollbar-thumb:hover { background: var(--qb-text-muted); }

/* ===== COLOR PICKER ===== */
.color-picker-group {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
}

.color-picker-group input[type="color"] {
  width: 40px;
  height: 40px;
  border: 2px solid var(--qb-border);
  border-radius: 8px;
  cursor: pointer;
  padding: 0;
  background: transparent;
}

.color-picker-group input[type="text"] {
  flex: 1;
}

.color-picker-group .btn {
  padding: 0.5rem 1rem;
}
</style>

<div class="toolbox-container">
<div class="tool-grid">

<!-- UUID Generator -->
<div class="tool-card">
<h3>🆔 UUID Generator</h3>
<div class="tool-input-group">
<button onclick="generateUUID()">Generate UUID v4</button>
</div>
<div class="result-area" id="uuid-result">
Click to generate...
</div>
</div>

<!-- Password Generator -->
<div class="tool-card">
<h3>🔑 Password Generator</h3>
<div class="tool-input-group">
<label>Length: <span id="pass-len-val">16</span></label>
<input type="range" id="pass-length" min="8" max="64" value="16" oninput="document.getElementById('pass-len-val').innerText=this.value">
</div>
<button onclick="generatePassword()">Generate Password</button>
<div class="result-area" id="pass-result">
Click to generate...
</div>
</div>

<!-- Random Identity -->
<div class="tool-card">
<h3>👤 Random Identity</h3>
<button onclick="generateIdentity()">Generate Name & Email</button>
<div class="result-area" id="identity-result">
Click to generate...
</div>
</div>

<!-- Base64 Converter -->
<div class="tool-card">
<h3>📦 Base64 Encode/Decode</h3>
<textarea id="base64-input" placeholder="Enter text or base64..."></textarea>
<div style="display:flex; gap: 0.5rem; margin-top:0.5rem;">
<button style="flex:1" onclick="base64Action('encode')">Encode</button>
<button style="flex:1" onclick="base64Action('decode')">Decode</button>
</div>
<div class="result-area" id="base64-result">Result will appear here...</div>
</div>

<!-- JWT Decoder -->
<div class="tool-card">
<h3>🎫 JWT Decoder</h3>
<textarea id="jwt-input" placeholder="Paste JWT here..."></textarea>
<button onclick="decodeJWT()" style="margin-top:0.5rem;">Decode Payload</button>
<div class="result-area" id="jwt-result">Payload will appear here...</div>
</div>

<!-- Timestamp Converter -->
<div class="tool-card">
<h3>🕒 Timestamp Converter</h3>
<input type="text" id="ts-input" placeholder="Timestamp (ms) or Date string">
<div style="display:flex; gap: 0.5rem; margin-top:0.5rem;">
<button style="flex:1" onclick="tsAction('toDate')">To Date</button>
<button style="flex:1" onclick="tsAction('toTs')">To TS (ms)</button>
</div>
<div class="result-area" id="ts-result">Result will appear here...</div>
</div>

<!-- Regex Tester -->
<div class="tool-card">
<h3>🔍 Regex Tester</h3>
<input type="text" id="regex-pattern" placeholder="Pattern (e.g. [a-z]+)">
<input type="text" id="regex-text" placeholder="Text to test" style="margin-top:0.5rem;">
<button onclick="testRegex()" style="margin-top:0.5rem;">Test</button>
<div class="result-area" id="regex-result">Result will appear here...</div>
</div>

<!-- JSON Formatter -->
<div class="tool-card">
<h3>{ } JSON Formatter</h3>
<textarea id="json-input" placeholder="Paste messy JSON here..."></textarea>
<button onclick="formatJSON()" style="margin-top:0.5rem;">Format / Prettify</button>
<div class="result-area" id="json-result">Formatted JSON...</div>
</div>

<!-- Hash Generator -->
<div class="tool-card">
<h3># Hash Generator</h3>
<textarea id="hash-input" placeholder="Text to hash..."></textarea>
<div style="display:flex; gap: 0.5rem; margin-top:0.5rem;">
<button style="flex:1" onclick="generateHash('SHA-256')">SHA-256</button>
<button style="flex:1" onclick="generateHash('SHA-1')">SHA-1</button>
</div>
<div class="result-area" id="hash-result">Hash will appear here...</div>
</div>

<!-- QR Code Generator -->
<div class="tool-card">
<h3>📱 QR Code Generator</h3>
<input type="text" id="qr-input" placeholder="URL or Text">
<button onclick="generateQR()" style="margin-top:0.5rem;">Generate QR</button>
<div id="qr-result" style="margin-top:1rem; text-align:center;">
<!-- QR Image will appear here -->
</div>
</div>

<!-- Cron Parser -->
<div class="tool-card">
<h3>⏰ Cron Parser (Simple)</h3>
<input type="text" id="cron-input" placeholder="* * * * *" value="0 0 * * *">
<button onclick="parseCron()" style="margin-top:0.5rem;">Explain Cron</button>
<div class="result-area" id="cron-result">Explanation will appear here...</div>
</div>

<!-- URL Encoder/Decoder -->
<div class="tool-card">
<h3>🔗 URL Encoder/Decoder</h3>
<textarea id="url-input" placeholder="Enter URL or text..."></textarea>
<div style="display:flex; gap: 0.5rem; margin-top:0.5rem;">
<button style="flex:1" onclick="urlAction('encode')">Encode</button>
<button style="flex:1" onclick="urlAction('decode')">Decode</button>
</div>
<div class="result-area" id="url-result">Result will appear here...</div>
</div>

</div>
</div>

<script>
    // Utility: Copy to clipboard
    function copyToClipboard(text) {
      navigator.clipboard.writeText(text).then(() => {
        alert('Copied to clipboard!');
      });
    }

    function updateResult(id, text, showCopy = true) {
      const el = document.getElementById(id);
      el.innerText = text;
      if (showCopy && text && !text.includes('Click to') && !text.includes('Result will')) {
        const btn = document.createElement('button');
        btn.innerText = 'Copy';
        btn.className = 'copy-btn';
        btn.onclick = () => copyToClipboard(text);
        el.appendChild(btn);
      }
    }

    // 1. UUID
    function generateUUID() {
      const uuid = crypto.randomUUID();
      updateResult('uuid-result', uuid);
    }

    // 2. Password
    function generatePassword() {
      const length = document.getElementById('pass-length').value;
      const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+~`|}{[]:;?><,./-=";
      let retVal = "";
      for (let i = 0, n = charset.length; i < length; ++i) {
        retVal += charset.charAt(Math.floor(Math.random() * n));
      }
      updateResult('pass-result', retVal);
    }

    // 3. Identity
    function generateIdentity() {
      const firstNames = ["Nguyen", "Tran", "Le", "Pham", "Hoang", "Phan", "Vu", "Dang", "Bui", "Do"];
      const lastNames = ["Anh", "Binh", "Chi", "Dung", "Em", "Giang", "Hoa", "Hung", "Khanh", "Lan"];
      const domains = ["gmail.com", "outlook.com", "yahoo.com", "company.test"];
      
      const name = firstNames[Math.floor(Math.random() * firstNames.length)] + " " + lastNames[Math.floor(Math.random() * lastNames.length)];
      const email = name.toLowerCase().replace(" ", ".") + Math.floor(Math.random() * 1000) + "@" + domains[Math.floor(Math.random() * domains.length)];
      
      updateResult('identity-result', `Name: ${name}\nEmail: ${email}`);
    }

    // 4. Base64
    function base64Action(type) {
      const input = document.getElementById('base64-input').value;
      try {
        if (type === 'encode') {
          updateResult('base64-result', btoa(input));
        } else {
          updateResult('base64-result', atob(input));
        }
      } catch (e) {
        updateResult('base64-result', "Error: Invalid input for " + type);
      }
    }

    // 5. JWT
    function decodeJWT() {
      const token = document.getElementById('jwt-input').value;
      try {
        const base64Url = token.split('.')[1];
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const jsonPayload = decodeURIComponent(window.atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));
        updateResult('jwt-result', JSON.stringify(JSON.parse(jsonPayload), null, 2));
      } catch (e) {
        updateResult('jwt-result', "Error: Invalid JWT format");
      }
    }

    // 6. Timestamp
    function tsAction(type) {
      const input = document.getElementById('ts-input').value;
      try {
        if (type === 'toDate') {
          const d = new Date(isNaN(input) ? input : parseInt(input));
          updateResult('ts-result', d.toISOString() + " (" + d.toLocaleString() + ")");
        } else {
          const d = new Date(input);
          updateResult('ts-result', d.getTime().toString());
        }
      } catch (e) {
        updateResult('ts-result', "Error: Invalid Date/Timestamp");
      }
    }

    // 7. Regex
    function testRegex() {
      const pattern = document.getElementById('regex-pattern').value;
      const text = document.getElementById('regex-text').value;
      try {
        const re = new RegExp(pattern, 'g');
        const matches = text.match(re);
        if (matches) {
          updateResult('regex-result', `Found ${matches.length} matches: ${matches.join(', ')}`);
        } else {
          updateResult('regex-result', "No matches found.");
        }
      } catch (e) {
        updateResult('regex-result', "Error: " + e.message);
      }
    }

    // 8. JSON Formatter
    function formatJSON() {
      const input = document.getElementById('json-input').value;
      try {
        const obj = JSON.parse(input);
        updateResult('json-result', JSON.stringify(obj, null, 2));
      } catch (e) {
        updateResult('json-result', "Error: Invalid JSON");
      }
    }

    // 9. Hash
    async function generateHash(algo) {
      const text = document.getElementById('hash-input').value;
      if (!text) return;
      try {
        const msgUint8 = new TextEncoder().encode(text);
        const hashBuffer = await crypto.subtle.digest(algo, msgUint8);
        const hashArray = Array.from(new Uint8Array(hashBuffer));
        const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
        updateResult('hash-result', `${algo}: ${hashHex}`);
      } catch (e) {
        updateResult('hash-result', "Error: Algorithm not supported");
      }
    }

    // 10. QR Code
    function generateQR() {
      const text = document.getElementById('qr-input').value;
      if (!text) return;
      const url = `https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${encodeURIComponent(text)}`;
      const resultDiv = document.getElementById('qr-result');
      resultDiv.innerHTML = `<img src="${url}" alt="QR Code" style="border: 1px solid var(--gray); padding: 5px; background: white;"><br><small>${text}</small>`;
    }

    // 11. Cron Parser
    function parseCron() {
      const cron = document.getElementById('cron-input').value.split(' ');
      if (cron.length !== 5) {
        updateResult('cron-result', "Error: Cron must have 5 parts (* * * * *)");
        return;
      }
      const units = ["Minute", "Hour", "Day of Month", "Month", "Day of Week"];
      let explanation = cron.map((val, i) => {
        let desc = val === '*' ? "Every" : val;
        return `${units[i]}: ${desc}`;
      }).join('\n');
      updateResult('cron-result', explanation);
    }

    // 12. URL Encoder/Decoder
    function urlAction(type) {
      const input = document.getElementById('url-input').value;
      try {
        if (type === 'encode') {
          updateResult('url-result', encodeURIComponent(input));
        } else {
          updateResult('url-result', decodeURIComponent(input));
        }
      } catch (e) {
        updateResult('url-result', "Error: Invalid input for " + type);
      }
    }
  </script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1.  **UUID**: Tạo định danh duy nhất cho các bản ghi dữ liệu hoặc test case.
2.  **Password**: Tạo mật khẩu ngẫu nhiên với độ dài tùy chọn, bao gồm cả ký tự đặc biệt.
3.  **JSON Formatter**: Làm đẹp các chuỗi JSON bị nén để dễ dàng quan sát cấu trúc.
4.  **JWT Decoder**: Xem nhanh nội dung (payload) của các token JWT mà không cần gửi lên server bên thứ ba.
5.  **QR Code**: Tạo mã QR từ URL hoặc text để test các tính năng quét mã trên Mobile.

> 💡 **Mẹo bảo mật:** Tất cả các công cụ trên (trừ QR Code dùng API bên ngoài) đều chạy hoàn toàn bằng **Javascript cục bộ** trên trình duyệt của bạn. Dữ liệu của bạn không bao giờ rời khỏi máy tính, đảm bảo an toàn tuyệt đối cho các thông tin nhạy cảm như JWT hay Mật khẩu.
