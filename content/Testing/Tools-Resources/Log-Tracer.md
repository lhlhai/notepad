---
title: 📜 Log Tracer
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
  font-size: 0.9rem;
  font-weight: 600;
}
.log-controls input[type="text"] {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  min-width: 150px;
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
  height: 38px; /* Align with input fields */
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
}
.log-output-area .error-highlight {
  background-color: #f8d7da; /* Light red */
  color: #721c24; /* Dark red text */
  font-weight: bold;
}
.log-output-area .filter-highlight {
  background-color: #fff3cd; /* Light yellow */
  color: #856404; /* Dark yellow text */
}
</style>

<div class="log-tracer-container">
  <div class="log-input-group">
    <label for="log-data">Dán nội dung log vào đây:</label>
    <textarea id="log-data" placeholder="[2023-10-26 10:00:00] INFO: Application started.\n[2023-10-26 10:00:05] ERROR: Database connection failed.\n[2023-10-26 10:00:10] DEBUG: User 'admin' logged in."></textarea>
  </div>
  <div class="log-controls">
    <div>
      <label for="error-keywords">Từ khóa lỗi (cách nhau bởi dấu phẩy):</label>
      <input type="text" id="error-keywords" value="ERROR,FAIL,EXCEPTION,CRITICAL">
    </div>
    <div>
      <label for="filter-keywords">Lọc theo từ khóa (cách nhau bởi dấu phẩy):</label>
      <input type="text" id="filter-keywords" placeholder="ví dụ: admin, database">
    </div>
    <button onclick="processLogs()">Phân tích Log</button>
    <button onclick="clearLogs()">Xóa</button>
  </div>
  <div class="log-output-area" id="log-output">Kết quả phân tích log sẽ hiển thị ở đây...</div>
</div>

<script>
function processLogs() {
  const logData = document.getElementById("log-data").value;
  const errorKeywordsInput = document.getElementById("error-keywords").value;
  const filterKeywordsInput = document.getElementById("filter-keywords").value;
  const outputArea = document.getElementById("log-output");

  if (!logData.trim()) {
    outputArea.innerHTML = "<p>Không có dữ liệu log để phân tích.</p>";
    return;
  }

  const errorKeywords = errorKeywordsInput.split(',').map(k => k.trim().toUpperCase()).filter(k => k !== '');
  const filterKeywords = filterKeywordsInput.split(',').map(k => k.trim().toLowerCase()).filter(k => k !== '');

  const lines = logData.split(/\r\n|\n/);
  let processedHtml = '';

  lines.forEach(line => {
    let displayLine = line;
    let isError = false;
    let isFiltered = false;

    // Check for error keywords
    for (const keyword of errorKeywords) {
      if (line.toUpperCase().includes(keyword)) {
        isError = true;
        break;
      }
    }

    // Check for filter keywords
    if (filterKeywords.length > 0) {
      isFiltered = true; // Assume filtered until proven otherwise
      let lineMatchesFilter = false;
      for (const keyword of filterKeywords) {
        if (line.toLowerCase().includes(keyword)) {
          lineMatchesFilter = true;
          break;
        }
      }
      if (!lineMatchesFilter) {
        return; // Skip this line if it doesn't match any filter keyword
      }
    }

    // Apply highlighting
    if (isError) {
      displayLine = `<span class="error-highlight">${displayLine}</span>`;
    } else if (isFiltered && filterKeywords.length > 0) {
      // Only highlight filter if it's not an error line and it was filtered
      for (const keyword of filterKeywords) {
        const regex = new RegExp(`(${keyword})`, 'gi');
        displayLine = displayLine.replace(regex, `<span class="filter-highlight">$1</span>`);
      }
    }

    processedHtml += `${displayLine}\n`;
  });

  outputArea.innerHTML = processedHtml || "<p>Không tìm thấy dòng log nào phù hợp với bộ lọc.</p>";
}

function clearLogs() {
  document.getElementById("log-data").value = "";
  document.getElementById("error-keywords").value = "ERROR,FAIL,EXCEPTION,CRITICAL";
  document.getElementById("filter-keywords").value = "";
  document.getElementById("log-output").innerHTML = "Kết quả phân tích log sẽ hiển thị ở đây...";
}
</script>
</div>
