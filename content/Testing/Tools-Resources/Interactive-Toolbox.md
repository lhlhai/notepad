# 🛠️ Interactive QA Toolbox

Trang này cung cấp các công cụ tiện ích chạy trực tiếp trên trình duyệt để hỗ trợ công việc kiểm thử hàng ngày.

<div id="qa-toolbox-root">
  <style>
    .toolbox-container {
      font-family: var(--font-body), system-ui, -apple-system, sans-serif;
      color: var(--dark);
      margin-top: 2rem;
    }
    .tool-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2rem;
    }
    .tool-card {
      background: var(--light);
      border: 1px solid var(--gray);
      border-radius: 8px;
      padding: 1.5rem;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
      display: flex;
      flex-direction: column;
    }
    .tool-card h3 {
      margin-top: 0;
      margin-bottom: 1rem;
      font-size: 1.2rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      color: var(--secondary);
    }
    .tool-input-group {
      margin-bottom: 1rem;
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }
    .tool-input-group label {
      font-size: 0.9rem;
      font-weight: 600;
    }
    .tool-card input, .tool-card textarea, .tool-card select {
      width: 100%;
      padding: 0.5rem;
      border: 1px solid var(--gray);
      border-radius: 4px;
      background: var(--light);
      color: var(--dark);
      font-family: monospace;
    }
    .tool-card button {
      padding: 0.5rem 1rem;
      background: var(--secondary);
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 600;
      transition: opacity 0.2s;
    }
    .tool-card button:hover {
      opacity: 0.9;
    }
    .result-area {
      margin-top: 1rem;
      padding: 0.75rem;
      background: rgba(0,0,0,0.05);
      border-radius: 4px;
      word-break: break-all;
      font-family: monospace;
      font-size: 0.9rem;
      min-height: 1.5rem;
      position: relative;
    }
    .copy-btn {
      position: absolute;
      top: 5px;
      right: 5px;
      padding: 2px 6px !important;
      font-size: 0.7rem !important;
      background: var(--gray) !important;
    }
    .hidden { display: none; }
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
