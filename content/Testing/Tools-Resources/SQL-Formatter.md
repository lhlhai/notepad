---
description: Format và beautify các câu lệnh SQL rối thành code sạch, dễ đọc. Hữu ích khi debug queries, review SQL từ logs, hoặc chuẩn bị test data.
---

# 💾 SQL Formatter & Beautifier

Công cụ format SQL giúp biến các câu lệnh SQL rối thành code sạch, dễ đọc. Dán SQL vào ô bên dưới và nhấn Format.

<div id="sql-formatter-root">
<style>
.sql-formatter-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.sql-input-group textarea {
  width: 100%;
  height: 150px;
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  font-size: 0.85rem;
  margin-bottom: 0.5rem;
}
.sql-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
  align-items: center;
}
.sql-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.sql-controls button:hover {
  opacity: 0.9;
}
.sql-controls select {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
}
.sql-output-area {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: #1e1e1e;
  color: #d4d4d4;
  font-family: monospace;
  font-size: 0.85rem;
  white-space: pre-wrap;
  word-break: break-all;
  min-height: 150px;
  max-height: 600px;
  overflow-y: auto;
  line-height: 1.5;
}
.sql-keyword { color: #569cd6; font-weight: bold; }
.sql-function { color: #dcdcaa; }
.sql-string { color: #ce9178; }
.sql-comment { color: #6a9955; }
.sql-number { color: #b5cea8; }
.sql-operator { color: #d4d4d4; }
.sql-copy-btn {
  position: absolute;
  top: 5px;
  right: 5px;
  padding: 2px 8px;
  font-size: 0.75rem;
  background: #444;
  color: white;
  border: none;
  border-radius: 3px;
  cursor: pointer;
}
.sql-output-wrapper {
  position: relative;
}
</style>

<div class="sql-formatter-container">
  <div class="sql-input-group">
    <label for="sql-input"><strong>Dán câu lệnh SQL vào đây:</strong></label>
    <textarea id="sql-input" placeholder="SELECT * FROM users WHERE id = 1 AND name = 'test' ORDER BY created_at">SELECT u.id,u.name,u.email,o.order_id,o.total FROM users u INNER JOIN orders o ON u.id=o.user_id WHERE o.status='completed' AND u.created_at>='2024-01-01' ORDER BY o.total DESC LIMIT 100</textarea>
  </div>
  <div class="sql-controls">
    <button onclick="formatSQL()">✨ Format SQL</button>
    <button onclick="formatSQLCompact()">📐 Compact</button>
    <button onclick="uppercaseSQL()">🔠 UPPERCASE Keywords</button>
    <button onclick="clearSQL()">Xóa</button>
    <label style="margin-left:0.5rem;">Indent: </label>
    <select id="sql-indent">
      <option value="2">2 spaces</option>
      <option value="4" selected>4 spaces</option>
      <option value="tab">Tab</option>
    </select>
  </div>
  <div class="sql-output-wrapper">
    <div class="sql-output-area" id="sql-output">Kết quả format sẽ hiển thị ở đây...</div>
  </div>
</div>

<script>
function getIndent() {
  const val = document.getElementById("sql-indent").value;
  return val === "tab" ? "\t" : " ".repeat(parseInt(val));
}

function formatSQL() {
  const input = document.getElementById("sql-input").value;
  if (!input.trim()) return;
  const indent = getIndent();
  let result = formatSQLInternal(input, indent, true);
  displaySQL(result);
}

function formatSQLCompact() {
  const input = document.getElementById("sql-input").value;
  if (!input.trim()) return;
  const indent = getIndent();
  let result = formatSQLInternal(input, indent, false);
  displaySQL(result);
}

function formatSQLInternal(sql, indent, multiLine) {
  let result = sql;
  // Add space around operators
  result = result.replace(/\s*=\s*/g, ' = ');
  result = result.replace(/\s*<>\s*/g, ' <> ');
  result = result.replace(/\s*>=\s*/g, ' >= ');
  result = result.replace(/\s*<=\s*/g, ' <= ');
  result = result.replace(/\s*<\s*/g, ' < ');
  result = result.replace(/\s*>\s*/g, ' > ');
  result = result.replace(/\s*,\s*/g, ', ');

  // Format JOIN
  result = result.replace(/\b(INNER|LEFT|RIGHT|FULL|CROSS|OUTER)?\s*JOIN\b/gi, function(match) {
    return '\n' + indent + match.toUpperCase();
  });

  // Format major keywords
  const majorKeywords = ['SELECT', 'FROM', 'WHERE', 'GROUP BY', 'HAVING', 'ORDER BY', 'LIMIT', 'UNION', 'INSERT INTO', 'UPDATE', 'SET', 'DELETE FROM', 'VALUES', 'ON'];
  for (const kw of majorKeywords) {
    const regex = new RegExp('\\b' + kw.replace(' ', '\\s+') + '\\b', 'gi');
    result = result.replace(regex, '\n' + indent + kw.toUpperCase());
  }

  // Format AND/OR in WHERE
  result = result.replace(/\bAND\b/gi, '\n' + indent + indent + 'AND');
  result = result.replace(/\bOR\b/gi, '\n' + indent + indent + 'OR');

  // Format parentheses
  result = result.replace(/\s*\(\s*/g, ' (');
  result = result.replace(/\s*\)/g, ')');

  // Remove extra spaces and newlines
  result = result.replace(/\n\s*\n/g, '\n');
  result = result.replace(/^\n/, '');
  result = result.replace(/ +/g, ' ');

  return result;
}

function uppercaseSQL() {
  const input = document.getElementById("sql-input").value;
  const keywords = ['SELECT','FROM','WHERE','AND','OR','JOIN','INNER','LEFT','RIGHT','OUTER','FULL','CROSS','ON','GROUP BY','HAVING','ORDER BY','LIMIT','OFFSET','INSERT','INTO','VALUES','UPDATE','SET','DELETE','CREATE','TABLE','ALTER','DROP','INDEX','VIEW','AS','IN','NOT','NULL','IS','LIKE','BETWEEN','EXISTS','CASE','WHEN','THEN','ELSE','END','DISTINCT','COUNT','SUM','AVG','MAX','MIN','INNER JOIN','LEFT JOIN','RIGHT JOIN','FULL JOIN','GROUP BY','ORDER BY','INSERT INTO','DELETE FROM','CREATE TABLE'];
  let result = input;
  keywords.sort((a, b) => b.length - a.length);
  for (const kw of keywords) {
    const regex = new RegExp('\\b' + kw + '\\b', 'gi');
    result = result.replace(regex, kw.toUpperCase());
  }
  document.getElementById("sql-input").value = result;
  formatSQL();
}

function displaySQL(formatted) {
  let html = escapeHtml(formatted);
  // Highlight keywords
  const keywords = ['SELECT','FROM','WHERE','AND','OR','JOIN','INNER','LEFT','RIGHT','OUTER','FULL','CROSS','ON','GROUP BY','HAVING','ORDER BY','LIMIT','OFFSET','INSERT','INTO','VALUES','UPDATE','SET','DELETE','CREATE','TABLE','ALTER','DROP','INDEX','VIEW','AS','IN','NOT','NULL','IS','LIKE','BETWEEN','EXISTS','CASE','WHEN','THEN','ELSE','END','DISTINCT','UNION','ALL'];
  for (const kw of keywords) {
    const regex = new RegExp('\\b(' + kw + ')\\b', 'gi');
    html = html.replace(regex, '<span class="sql-keyword">$1</span>');
  }
  // Highlight strings
  html = html.replace(/('([^']*)')/g, '<span class="sql-string">$1</span>');
  // Highlight numbers
  html = html.replace(/\b(\d+\.?\d*)\b/g, '<span class="sql-number">$1</span>');

  const output = document.getElementById("sql-output");
  output.innerHTML = `<button class="sql-copy-btn" onclick="copySQL()">Copy</button>` + html;
}

function copySQL() {
  const text = document.getElementById("sql-output").innerText;
  navigator.clipboard.writeText(text).then(() => {
    const btn = document.querySelector('.sql-copy-btn');
    if (btn) { btn.textContent = 'Copied!'; setTimeout(() => btn.textContent = 'Copy', 1500); }
  });
}

function escapeHtml(text) {
  return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function clearSQL() {
  document.getElementById("sql-input").value = "";
  document.getElementById("sql-output").innerHTML = "Kết quả format sẽ hiển thị ở đây...";
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Dán câu lệnh SQL** (dù rối hay dài) vào ô input.
2. Nhấn **Format SQL** để format với nhiều dòng (multi-line) hoặc **Compact** để format gọn hơn.
3. Nhấn **UPPERCASE Keywords** để convert tất cả keywords sang chữ hoa.
4. Chọn **Indent** (2 spaces, 4 spaces, hoặc Tab) theo sở thích.
5. Nhấn **Copy** để copy kết quả đã format.

> 💡 **Mẹo:** Dùng công cụ này khi bạn nhận được SQL từ logs, API responses, hoặc developer gửi cho — format nhanh để dễ đọc và debug.
