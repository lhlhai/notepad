---
description: So sánh hai đoạn văn bản, highlight những dòng thêm, xóa và thay đổi. Hữu ích khi kiểm tra config files, log outputs, hoặc nội dung trang web.
---

# 📝 Text Diff Compare

Công cụ so sánh hai đoạn văn bản và làm nổi bật những điểm khác biệt. Hữu ích khi kiểm tra config files, so sánh output trước/sau, hoặc nội dung trang web.

<div id="text-diff-root">
<style>
.text-diff-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.text-diff-inputs {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
}
.text-diff-inputs > div {
  flex: 1;
}
.text-diff-inputs textarea {
  width: 100%;
  height: 200px;
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  font-size: 0.85rem;
}
.text-diff-controls {
  margin-bottom: 1rem;
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  align-items: center;
}
.text-diff-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.text-diff-controls button:hover {
  opacity: 0.9;
}
.text-diff-controls select {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
}
.text-diff-output {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 100px;
  max-height: 600px;
  overflow-y: auto;
  font-family: monospace;
  font-size: 0.85rem;
}
.text-diff-output table {
  width: 100%;
  border-collapse: collapse;
}
.text-diff-output td {
  padding: 2px 8px;
  border: none;
  white-space: pre-wrap;
  word-break: break-all;
}
.line-added { background-color: #d4edda; }
.line-removed { background-color: #f8d7da; }
.line-changed-left { background-color: #ffe0b2; }
.line-changed-right { background-color: #ffe0b2; }
.line-number {
  color: #999;
  user-select: none;
  width: 40px;
  text-align: right;
  border-right: 1px solid var(--gray);
}
</style>

<div class="text-diff-container">
  <div class="text-diff-inputs">
    <div>
      <label for="text1"><strong>Văn bản gốc (Expected):</strong></label>
      <textarea id="text1" placeholder="Dán văn bản gốc vào đây...">Line 1: Hello World
Line 2: Welcome to testing
Line 3: This is unchanged
Line 4: Old version
Line 5: Footer text</textarea>
    </div>
    <div>
      <label for="text2"><strong>Văn bản mới (Actual):</strong></label>
      <textarea id="text2" placeholder="Dán văn bản mới vào đây...">Line 1: Hello World!
Line 2: Welcome to testing
Line 3: This is unchanged
Line 4: New version updated
Line 5: Footer text
Line 6: Extra new line</textarea>
    </div>
  </div>
  <div class="text-diff-controls">
    <button onclick="compareText()">📝 So sánh Text</button>
    <button onclick="swapText()">🔄 Hoán đổi</button>
    <button onclick="clearTextDiff()">Xóa</button>
    <label style="margin-left: 1rem;">Mode: </label>
    <select id="diff-mode">
      <option value="line">Line-by-Line</option>
      <option value="word">Word-level</option>
    </select>
  </div>
  <div class="text-diff-output" id="text-diff-output">Kết quả so sánh sẽ hiển thị ở đây...</div>
</div>

<script>
function compareText() {
  const text1 = document.getElementById("text1").value;
  const text2 = document.getElementById("text2").value;
  const mode = document.getElementById("diff-mode").value;
  const output = document.getElementById("text-diff-output");

  if (!text1.trim() && !text2.trim()) {
    output.innerHTML = "<p>Vui lòng nhập ít nhất một đoạn văn bản để so sánh.</p>";
    return;
  }

  const lines1 = text1.split(/\r\n|\n/);
  const lines2 = text2.split(/\r\n|\n/);

  // LCS-based diff
  const lcs = computeLCS(lines1, lines2);
  let html = "<table>";
  let stats = { added: 0, removed: 0, changed: 0, same: 0 };
  let i = 0, j = 0, l = 0;

  while (i < lines1.length || j < lines2.length) {
    if (l < lcs.length && i < lines1.length && j < lines2.length && lines1[i] === lcs[l] && lines2[j] === lcs[l]) {
      stats.same++;
      html += `<tr><td class="line-number">${i + 1}</td><td class="line-number">${j + 1}</td><td>${escapeHtml(lines1[i])}</td></tr>`;
      i++; j++; l++;
    } else if (j < lines2.length && (l >= lcs.length || lines2[j] !== lcs[l])) {
      stats.added++;
      html += `<tr><td class="line-number">-</td><td class="line-number">${j + 1}</td><td class="line-added">+ ${escapeHtml(lines2[j])}</td></tr>`;
      j++;
    } else if (i < lines1.length && (l >= lcs.length || lines1[i] !== lcs[l])) {
      stats.removed++;
      html += `<tr><td class="line-number">${i + 1}</td><td class="line-number">-</td><td class="line-removed">- ${escapeHtml(lines1[i])}</td></tr>`;
      i++;
    }
  }

  html += "</table>";
  output.innerHTML = `<div style="margin-bottom:0.5rem;font-weight:600;">📊 Tổng kết: <span style="color:#28a745;">+${stats.added} dòng thêm</span> | <span style="color:#dc3545;">-${stats.removed} dòng xóa</span> | ✅ ${stats.same} dòng giống nhau</div>` + html;
}

function computeLCS(a, b) {
  const m = a.length, n = b.length;
  const dp = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));
  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      dp[i][j] = a[i-1] === b[j-1] ? dp[i-1][j-1] + 1 : Math.max(dp[i-1][j], dp[i][j-1]);
    }
  }
  const result = [];
  let i = m, j = n;
  while (i > 0 && j > 0) {
    if (a[i-1] === b[j-1]) { result.unshift(a[i-1]); i--; j--; }
    else if (dp[i-1][j] > dp[i][j-1]) i--;
    else j--;
  }
  return result;
}

function escapeHtml(text) {
  return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function swapText() {
  const el1 = document.getElementById("text1");
  const el2 = document.getElementById("text2");
  const temp = el1.value;
  el1.value = el2.value;
  el2.value = temp;
}

function clearTextDiff() {
  document.getElementById("text1").value = "";
  document.getElementById("text2").value = "";
  document.getElementById("text-diff-output").innerHTML = "Kết quả so sánh sẽ hiển thị ở đây...";
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Dán văn bản gốc** (Expected) vào ô bên trái và **văn bản mới** (Actual) vào ô bên phải.
2. Nhấn **So sánh Text** để xem kết quả.
3. Kết quả sẽ hiển thị:
   - 🟢 **Xanh lá**: Dòng được thêm mới
   - 🔴 **Đỏ**: Dòng bị xóa
   - ⚫ **Bình thường**: Dòng không thay đổi
4. Chọn **Mode** để đổi cách so sánh (Line-by-Line hoặc Word-level).

> 💡 **Mẹo:** Dùng công cụ này khi so sánh config files, so sánh output log trước/sau fix bug, hoặc kiểm tra nội dung trang web thay đổi.
