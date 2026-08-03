---
description: Phân tích log nhanh chóng, highlight các lỗi và lọc theo từ khóa. Hữu ích cho việc debug và kiểm tra log hệ thống.
---

# 📜 Log Tracer

Công cụ này giúp bạn dễ dàng phân tích các file log. Dán nội dung log vào ô bên dưới, sau đó bạn có thể highlight các dòng lỗi và lọc theo từ khóa để tìm kiếm thông tin quan trọng.

<div id="log-tracer-root">
<style>
.log-tracer-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.log-input-group textarea {
  width: 100%;
  height: 250px;
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  margin-bottom: 1rem;
  font-size: 0.85rem;
}
.log-controls {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 1rem;
  align-items: flex-end;
}
.log-controls > div {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}
.log-controls label {
  font-size: 0.85rem;
  font-weight: 600;
}
.log-controls input[type="text"] {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  min-width: 200px;
  font-size: 0.85rem;
}
.log-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
  height: 38px;
}
.log-controls button:hover {
  opacity: 0.9;
}
.log-output-area {
  background: rgba(0,0,0,0.05);
  border-radius: 4px;
  padding: 1rem;
  min-height: 150px;
  max-height: 600px;
  overflow-y: auto;
  font-family: monospace;
  font-size: 0.85rem;
  white-space: pre-wrap;
  word-break: break-all;
  line-height: 1.6;
}
.log-output-area .error-highlight {
  background-color: #f8d7da;
  color: #721c24;
  font-weight: bold;
}
.log-output-area .filter-highlight {
  background-color: #fff3cd;
  color: #856404;
}
.log-stats {
  background: rgba(0,0,0,0.05);
  padding: 0.5rem 0.75rem;
  border-radius: 4px;
  margin-bottom: 0.5rem;
  font-size: 0.85rem;
  display: none;
}
</style>

<div class="log-tracer-container">
  <div class="log-input-group">
    <label for="log-data"><strong>Dán nội dung log vào đây:</strong></label>
    <textarea id="log-data" placeholder="[2023-10-26 10:00:00] INFO: Application started.&#10;[2023-10-26 10:00:05] ERROR: Database connection failed.&#10;[2023-10-26 10:00:10] DEBUG: User 'admin' logged in."></textarea>
  </div>
  <div class="log-controls">
    <div>
      <label for="error-keywords">Từ khóa lỗi (cách nhau bởi dấu phẩy):</label>
      <input type="text" id="error-keywords" value="ERROR,FAIL,EXCEPTION,CRITICAL,WARN">
    </div>
    <div>
      <label for="filter-keywords">Lọc theo từ khóa (cách nhau bởi dấu phẩy):</label>
      <input type="text" id="filter-keywords" placeholder="ví dụ: admin, database">
    </div>
    <div>
      <label for="log-max-lines">Max dòng hiển thị:</label>
      <input type="number" id="log-max-lines" value="500" min="50" max="5000" style="width:100px;">
    </div>
    <button onclick="processLogs()">📜 Phân tích Log</button>
    <button onclick="clearLogs()">Xóa</button>
  </div>
  <div class="log-stats" id="log-stats"></div>
  <div class="log-output-area" id="log-output">Kết quả phân tích log sẽ hiển thị ở đây...</div>
</div>

<script>
function processLogs() {
  const logData = document.getElementById("log-data").value;
  const errorKeywordsInput = document.getElementById("error-keywords").value;
  const filterKeywordsInput = document.getElementById("filter-keywords").value;
  const maxLines = parseInt(document.getElementById("log-max-lines").value) || 500;
  const outputArea = document.getElementById("log-output");
  const statsEl = document.getElementById("log-stats");

  if (!logData.trim()) {
    outputArea.innerHTML = "<p style='color:#999;'>Không có dữ liệu log để phân tích.</p>";
    statsEl.style.display = "none";
    return;
  }

  const errorKeywords = errorKeywordsInput
    .split(',')
    .map(k => k.trim().toUpperCase())
    .filter(k => k !== '');

  const filterKeywords = filterKeywordsInput
    .split(',')
    .map(k => k.trim().toLowerCase())
    .filter(k => k !== '');

  const lines = logData.split(/\r\n|\r|\n/);
  let totalLines = lines.length;
  let errorCount = 0;
  let filteredCount = 0;
  let shownCount = 0;

  let processedHtml = '';

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    // Skip empty lines
    if (line.trim() === '') {
      processedHtml += '\n';
      continue;
    }

    const upperLine = line.toUpperCase();
    const lowerLine = line.toLowerCase();

    // Check for error keywords
    let isError = false;
    for (let k = 0; k < errorKeywords.length; k++) {
      if (upperLine.indexOf(errorKeywords[k]) !== -1) {
        isError = true;
        break;
      }
    }
    if (isError) errorCount++;

    // Check for filter keywords
    if (filterKeywords.length > 0) {
      let lineMatchesFilter = false;
      for (let k = 0; k < filterKeywords.length; k++) {
        if (lowerLine.indexOf(filterKeywords[k]) !== -1) {
          lineMatchesFilter = true;
          break;
        }
      }
      if (!lineMatchesFilter) {
        continue; // Skip this line — does NOT use return
      }
      filteredCount++;
    }

    // Apply highlighting
    let displayLine = escapeHtml(line);

    if (isError) {
      displayLine = '<span class="error-highlight">' + displayLine + '</span>';
    } else if (filterKeywords.length > 0) {
      // Highlight filter keywords in non-error lines
      for (let k = 0; k < filterKeywords.length; k++) {
        const keyword = filterKeywords[k];
        // Case-insensitive replace
        const regex = new RegExp('(' + keyword.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + ')', 'gi');
        displayLine = displayLine.replace(regex, '<span class="filter-highlight">$1</span>');
      }
    }

    processedHtml += displayLine + '\n';
    shownCount++;

    // Limit output
    if (shownCount >= maxLines) {
      processedHtml += '\n--- (' + (totalLines - shownCount) + ' dòng còn lại bị ẩn ---)\n';
      break;
    }
  }

  outputArea.innerHTML = processedHtml || '<p>Không tìm thấy dòng log nào phù hợp với bộ lọc.</p>';

  // Show stats
  statsEl.style.display = "block";
  statsEl.innerHTML = '📊 Tổng: <strong>' + totalLines + '</strong> dòng | ' +
    '<span style="color:#dc3545;">❌ ' + errorCount + ' lỗi</span> | ' +
    (filterKeywords.length > 0 ? '<span style="color:#d39e00;">🔍 ' + filteredCount + ' match filter</span> | ' : '') +
    'Hiển thị: <strong>' + shownCount + '</strong> dòng';
}

function clearLogs() {
  document.getElementById("log-data").value = "";
  document.getElementById("error-keywords").value = "ERROR,FAIL,EXCEPTION,CRITICAL,WARN";
  document.getElementById("filter-keywords").value = "";
  document.getElementById("log-output").innerHTML = "Kết quả phân tích log sẽ hiển thị ở đây...";
  document.getElementById("log-stats").style.display = "none";
}

function escapeHtml(text) {
  return String(text)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}
</script>
</div>
