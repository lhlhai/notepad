---
description: Test và xây dựng Regular Expression với các mẫu phổ biến cho Tester. Có sẵn templates cho email, phone, password, URL và nhiều pattern thường dùng.
---

# 🎯 Regex Builder & Tester

Công cụ test Regular Expression với các mẫu phổ biến sẵn có. Chọn template hoặc tự nhập pattern, sau đó test với dữ liệu thực.

<div id="regex-builder-root">
<style>
.regex-builder-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.regex-pattern-group {
  margin-bottom: 1rem;
}
.regex-pattern-group input {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  font-size: 1rem;
}
.regex-pattern-group input:focus {
  border-color: var(--secondary);
  outline: none;
}
.regex-templates {
  margin-bottom: 1rem;
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}
.regex-template-btn {
  padding: 0.4rem 0.8rem;
  background: rgba(0,0,0,0.05);
  border: 1px solid var(--gray);
  border-radius: 20px;
  cursor: pointer;
  font-size: 0.8rem;
  transition: all 0.2s;
}
.regex-template-btn:hover {
  background: var(--secondary);
  color: white;
  border-color: var(--secondary);
}
.regex-test-area textarea {
  width: 100%;
  height: 100px;
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  font-size: 0.85rem;
  margin-bottom: 0.5rem;
}
.regex-flags {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
  align-items: center;
}
.regex-flags label {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  cursor: pointer;
  font-size: 0.9rem;
}
.regex-result {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 80px;
  max-height: 400px;
  overflow-y: auto;
  font-family: monospace;
  font-size: 0.85rem;
  line-height: 1.8;
}
.regex-match {
  background: #d4edda;
  padding: 1px 3px;
  border-radius: 2px;
  border-bottom: 2px solid #28a745;
}
.regex-explanation {
  margin-top: 0.5rem;
  padding: 0.75rem;
  background: rgba(0,0,0,0.05);
  border-radius: 4px;
  font-size: 0.8rem;
  color: #555;
}
.regex-groups {
  margin-top: 0.5rem;
}
.regex-group-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 0.5rem;
}
.regex-group-table th, .regex-group-table td {
  border: 1px solid var(--lightgray);
  padding: 4px 8px;
  font-size: 0.8rem;
  text-align: left;
}
.regex-group-table th {
  background: var(--lightgray);
}
</style>

<div class="regex-builder-container">
  <div class="regex-pattern-group">
    <label><strong>Pattern (Regex):</strong></label>
    <input type="text" id="regex-pattern" placeholder="Nhập regex pattern..." value="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}">
  </div>

  <div style="margin-bottom:1rem;">
    <label style="font-weight:600;margin-bottom:0.5rem;display:block;"><strong>📋 Templates phổ biến:</strong></label>
    <div class="regex-templates">
      <button class="regex-template-btn" onclick="useTemplate('email')">Email</button>
      <button class="regex-template-btn" onclick="useTemplate('phone')">Phone VN</button>
      <button class="regex-template-btn" onclick="useTemplate('password')">Password mạnh</button>
      <button class="regex-template-btn" onclick="useTemplate('url')">URL</button>
      <button class="regex-template-btn" onclick="useTemplate('ip')">IPv4</button>
      <button class="regex-template-btn" onclick="useTemplate('date')">Date (YYYY-MM-DD)</button>
      <button class="regex-template-btn" onclick="useTemplate('username')">Username</button>
      <button class="regex-template-btn" onclick="useTemplate('creditcard')">Credit Card</button>
      <button class="regex-template-btn" onclick="useTemplate('number')">Number (int)</button>
      <button class="regex-template-btn" onclick="useTemplate('alphanumeric')">Alphanumeric</button>
      <button class="regex-template-btn" onclick="useTemplate('special')">No special chars</button>
      <button class="regex-template-btn" onclick="useTemplate('whitespace')">Contains spaces</button>
    </div>
  </div>

  <div class="regex-flags">
    <label><input type="checkbox" id="flag-g" checked> Global (g)</label>
    <label><input type="checkbox" id="flag-i" checked> Case-insensitive (i)</label>
    <label><input type="checkbox" id="flag-m"> Multiline (m)</label>
  </div>

  <div class="regex-test-area">
    <label><strong>Text để test:</strong></label>
    <textarea id="regex-text" placeholder="Nhập text để test regex...">john@test.com
invalid email
jane.doe@company.co.uk
test123@mail.com
not-an-email</textarea>
  </div>

  <button onclick="testRegexFull()" style="padding:0.5rem 1rem;background:var(--secondary);color:white;border:none;border-radius:4px;cursor:pointer;font-weight:600;margin-bottom:1rem;">🎯 Test Regex</button>

  <div class="regex-result" id="regex-result">Kết quả test sẽ hiển thị ở đây...</div>
  <div class="regex-explanation" id="regex-explanation"></div>
</div>

<script>
const templates = {
  email: { pattern: '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}', desc: 'Match email addresses', testText: 'john@test.com\ninvalid\njane@mail.co.uk' },
  phone: { pattern: '(?:\\+84|0)(?:3|5|7|8|9)\\d{8}', desc: 'Match Vietnamese phone numbers', testText: '0912345678\n+84912345678\n0123456789\n0312345678' },
  password: { pattern: '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$', desc: 'Password: min 8 chars, upper, lower, number, special', testText: 'Password1!\nweak\nNoSpecial1\nalllowercase123!\nStr0ng!Pass' },
  url: { pattern: 'https?:\\/\\/(?:www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b(?:[-a-zA-Z0-9()@:%_\\+.~#?&\\/=]*)', desc: 'Match URLs (http/https)', testText: 'https://www.google.com\nhttp://test.com/path\nftp://invalid\nhttps://api.example.com/v1/users' },
  ip: { pattern: '\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b', desc: 'Match IPv4 addresses', testText: '192.168.1.1\n10.0.0.1\n256.1.1.1\n8.8.8.8' },
  date: { pattern: '\\d{4}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12]\\d|3[01])', desc: 'Match dates in YYYY-MM-DD format', testText: '2024-01-15\n2024-13-01\n2024-06-31\n2023-12-25' },
  username: { pattern: '^[a-zA-Z0-9_]{3,20}$', desc: 'Username: 3-20 chars, alphanumeric + underscore', testText: 'john_doe\nab\nthis_username_is_too_long_for_validation_test\nuser123' },
  creditcard: { pattern: '\\b(?:\\d{4}[- ]?){3}\\d{4}\\b', desc: 'Match credit card numbers', testText: '1234-5678-9012-3456\n1234567890123456\n123-456-789\n4111 1111 1111 1111' },
  number: { pattern: '^-?\\d+$', desc: 'Match integers (positive/negative)', testText: '123\n-456\n12.5\nabc\n0' },
  alphanumeric: { pattern: '^[a-zA-Z0-9]+$', desc: 'Match alphanumeric only (no spaces/special)', testText: 'Hello123\nHello World\nhello!\ntest_123' },
  special: { pattern: '[!@#$%^&*(),.?":{}|<>]', desc: 'Detect special characters', testText: 'Hello!\nClean text\nTest@123\nNoSpecialHere' },
  whitespace: { pattern: '\\s+', desc: 'Detect whitespace characters', testText: 'Hello World\nNoSpace\nTab\there\nMultiple   spaces' }
};

function useTemplate(name) {
  const template = templates[name];
  document.getElementById("regex-pattern").value = template.pattern;
  document.getElementById("regex-text").value = template.testText;
  document.getElementById("regex-result").innerHTML = `<p style="color:#666;">Template loaded: <strong>${name}</strong> — ${template.desc}. Nhấn "Test Regex" để xem kết quả.</p>`;
}

function testRegexFull() {
  const pattern = document.getElementById("regex-pattern").value;
  const text = document.getElementById("regex-text").value;
  const flags = (document.getElementById("flag-g").checked ? 'g' : '') +
                (document.getElementById("flag-i").checked ? 'i' : '') +
                (document.getElementById("flag-m").checked ? 'm' : '');
  const resultDiv = document.getElementById("regex-result");
  const explanationDiv = document.getElementById("regex-explanation");

  if (!pattern.trim()) {
    resultDiv.innerHTML = "<span style='color:#dc3545;'>Vui lòng nhập regex pattern!</span>";
    return;
  }

  try {
    const regex = new RegExp(pattern, flags);

    // Show matches with highlighting
    let highlightedText = escapeHtml(text);
    let matches = [];

    if (flags.includes('g')) {
      let match;
      const regexForMatch = new RegExp(pattern, flags);
      while ((match = regexForMatch.exec(text)) !== null) {
        matches.push({ index: match.index, length: match[0].length, text: match[0], groups: match.slice(1) });
      }
    } else {
      const match = text.match(regex);
      if (match) {
        matches.push({ index: match.index, length: match[0].length, text: match[0], groups: match.slice(1) });
      }
    }

    if (matches.length === 0) {
      resultDiv.innerHTML = `<span style="color:#dc3545;">❌ Không tìm thấy match nào!</span>`;
    } else {
      // Build highlighted text
      let html = '';
      let lastIdx = 0;
      matches.sort((a, b) => a.index - b.index);
      for (const m of matches) {
        if (m.index >= lastIdx) {
          html += escapeHtml(text.substring(lastIdx, m.index));
          html += `<span class="regex-match">${escapeHtml(m.text)}</span>`;
          lastIdx = m.index + m.length;
        }
      }
      html += escapeHtml(text.substring(lastIdx));
      resultDiv.innerHTML = html;
    }

    // Explanation
    let expHtml = `<strong>📊 Kết quả:</strong> Tìm thấy <strong>${matches.length}</strong> match(es)<br>`;
    expHtml += `<strong>Pattern:</strong> <code>/${pattern}/${flags}</code><br>`;
    if (matches.length > 0 && matches.length <= 20) {
      expHtml += `<div class="regex-groups"><table class="regex-group-table"><tr><th>#</th><th>Match</th><th>Index</th><th>Groups</th></tr>`;
      matches.forEach((m, i) => {
        const groupsStr = m.groups && m.groups.length > 0 ? m.groups.map(g => g || '(empty)').join(', ') : '-';
        expHtml += `<tr><td>${i + 1}</td><td><code>${escapeHtml(m.text)}</code></td><td>${m.index}</td><td>${groupsStr}</td></tr>`;
      });
      expHtml += `</table></div>`;
    }

    // Pattern explanation
    expHtml += `<strong>💡 Giải thích pattern:</strong><br>`;
    expHtml += explainPattern(pattern);

    explanationDiv.innerHTML = expHtml;
  } catch (e) {
    resultDiv.innerHTML = `<span style="color:#dc3545;">❌ Lỗi: ${e.message}</span>`;
    explanationDiv.innerHTML = "";
  }
}

function explainPattern(pattern) {
  const explanations = [];
  const parts = [
    { regex: '\\[.*?\\]', desc: 'Character class [abc] — match bất kỳ ký tự nào trong ngoặc vuông' },
    { regex: '\\{\\d+,?\\d*\\}', desc: 'Quantifier {n,m} — match từ n đến m lần' },
    { regex: '\\+', desc: '+ — match 1 hoặc nhiều lần' },
    { regex: '\\*', desc: '* — match 0 hoặc nhiều lần' },
    { regex: '\\?', desc: '? — match 0 hoặc 1 lần (optional)' },
    { regex: '\\^', desc: '^ — bắt đầu dòng/string' },
    { regex: '\\$', desc: '$ — kết thúc dòng/string' },
    { regex: '\\(.*?\\)', desc: '() — Capture group, lưu match để tái sử dụng' },
    { regex: '\\|', desc: '| — OR operator, match pattern trái HOẶC phải' },
    { regex: '\\.', desc: '. — match bất kỳ ký tự nào (trừ newline)' },
    { regex: '\\\\\\d', desc: '\\d — match bất kỳ số nào (0-9)' },
    { regex: '\\\\\\w', desc: '\\w — match word character (a-z, A-Z, 0-9, _)' },
    { regex: '\\\\\\s', desc: '\\s — match whitespace' },
    { regex: '\\\\\\b', desc: '\\b — word boundary' },
  ];

  for (const part of parts) {
    try {
      if (new RegExp(part.regex).test(pattern)) {
        explanations.push(part.desc);
      }
    } catch (e) { /* skip */ }
  }

  if (explanations.length === 0) return "Pattern đơn giản, không có cấu trúc phức tạp.";
  return explanations.join('<br>');
}

function escapeHtml(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

// Auto-test on pattern change
document.getElementById("regex-pattern").addEventListener("input", function() {
  if (this.value.trim()) testRegexFull();
});
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Chọn Template** để load pattern phổ biến sẵn có (Email, Phone, Password, URL...).
2. **Tự nhập Pattern** nếu cần test regex custom.
3. **Nhập Text** cần test vào ô bên dưới.
4. Nhấn **Test Regex** hoặc tự động test khi thay đổi pattern.
5. Kết quả hiển thị:
   - 🟢 **Highlight** các phần match trên text
   - 📊 **Bảng** chi tiết: match text, index, capture groups
   - 💡 **Giải thích** ý nghĩa các thành phần trong pattern

> 💡 **Mẹo:** Dùng công cụ này khi viết test cases cho validation fields, hoặc khi cần verify input/output format trong automation tests.
