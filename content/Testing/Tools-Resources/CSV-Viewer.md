---
title: "✅ CSV Viewer"
description: "Xem và chỉnh sửa dữ liệu CSV trực tiếp trên trình duyệt. Hỗ trợ phân tích cấu trúc, lọc và xuất dữ liệu."
---

# 📊 CSV Viewer & Editor

Công cụ này giúp bạn dễ dàng xem, phân tích và chỉnh sửa dữ liệu CSV ngay trong trình duyệt. Dán dữ liệu CSV vào, và bạn sẽ có một bảng tương tác để làm việc.

<div id="csv-viewer-root">
<style>
:root {
  --primary: #4f46e5;
  --primary-hover: #4338ca;
  --secondary: #06b6d4;
  --success: #10b981;
  --warning: #f59e0b;
  --danger: #ef4444;
  --light-bg: #f9fafb;
  --card-bg: #ffffff;
  --border-color: #e5e7eb;
  --text-primary: #111827;
  --text-secondary: #6b7280;
}

.csv-viewer-container {
  font-family: 'Inter', system-ui, -apple-system, sans-serif;
  color: var(--text-primary);
  margin-top: 2rem;
  background: linear-gradient(135deg, #fff1f2 0%, #ffe4e6 100%);
  padding: 2rem;
  border-radius: 16px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.csv-input-group {
  margin-bottom: 1rem;
}

.csv-input-group label {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 0.5rem;
  display: block;
}

.csv-input-group textarea {
  width: 100%;
  height: 150px;
  padding: 0.75rem;
  border: 1px solid var(--border-color);
  border-radius: 8px;
  background: var(--card-bg);
  color: var(--text-primary);
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.85rem;
  transition: border-color 0.2s, box-shadow 0.2s;
  box-sizing: border-box;
}

.csv-input-group textarea:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}

.csv-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}

.csv-controls button {
  padding: 0.6rem 1.25rem;
  background: linear-gradient(135deg, var(--primary) 0%, var(--primary-hover) 100%);
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  font-size: 0.85rem;
  transition: all 0.2s;
  box-shadow: 0 2px 4px rgba(79, 70, 229, 0.3);
}

.csv-controls button:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(79, 70, 229, 0.4);
}

.csv-stats {
  background: var(--card-bg);
  padding: 0.75rem 1rem;
  border-radius: 8px;
  margin-bottom: 0.5rem;
  font-size: 0.85rem;
  border: 1px solid var(--border-color);
  display: none;
}

.csv-table-container {
  max-height: 500px;
  overflow: auto;
  border: 1px solid var(--border-color);
  border-radius: 8px;
  background: var(--card-bg);
}

.csv-table {
  width: 100%;
  border-collapse: collapse;
}

.csv-table th, .csv-table td {
  border: 1px solid var(--border-color);
  padding: 10px;
  text-align: left;
  white-space: nowrap;
  font-size: 0.85rem;
}

.csv-table th {
  background: linear-gradient(135deg, var(--primary) 0%, var(--primary-hover) 100%);
  color: white;
  position: sticky;
  top: 0;
  font-weight: 600;
  z-index: 10;
}

.csv-table tr:nth-child(even) {
  background-color: var(--light-bg);
}

.csv-table tr:hover {
  background-color: #eff6ff;
}

.csv-table tbody tr {
  transition: background-color 0.2s;
}
</style>

<div class="csv-viewer-container">
  <div class="csv-input-group">
    <label for="csv-data"><strong>Dán dữ liệu CSV vào đây:</strong></label>
    <textarea id="csv-data" placeholder="header1,header2,header3&#10;value1,value2,value3&#10;value4,value5,value6"></textarea>
  </div>
  <div class="csv-controls">
    <button onclick="parseCSV()">Xem CSV</button>
    <button onclick="clearCSV()">Xóa</button>
    <button onclick="exportCSV()" style="background: linear-gradient(135deg, var(--success) 0%, #059669 100%);">📥 Export CSV</button>
  </div>
  <div id="csv-stats" class="csv-stats"></div>
  <div class="csv-table-container" id="csv-output"><p style="color:#999;padding:1rem;text-align:center;">Kết quả sẽ hiển thị ở đây...</p></div>
</div>

<script>
let currentCSVData = null;
let currentHeaders = [];

function parseCSV() {
  const csvData = document.getElementById("csv-data").value;
  const output = document.getElementById("csv-output");
  const statsEl = document.getElementById("csv-stats");

  if (!csvData.trim()) {
    output.innerHTML = "<p style='color:#999;padding:1rem;text-align:center;'>Không có dữ liệu CSV để hiển thị.</p>";
    statsEl.style.display = "none";
    currentCSVData = null;
    return;
  }

  // Parse CSV lines
  const lines = csvData.split(/\r\n|\r|\n/);
  const validLines = lines.filter(line => line.trim() !== "");

  if (validLines.length === 0) {
    output.innerHTML = "<p style='color:#999;padding:1rem;text-align:center;'>Không có dữ liệu CSV để hiển thị.</p>";
    statsEl.style.display = "none";
    currentCSVData = null;
    return;
  }

  // Robust CSV parser
  function parseLine(line) {
    const result = [];
    let currentField = "";
    let inQuotes = false;

    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      const nextChar = line[i + 1];

      if (inQuotes) {
        if (char === '"' && nextChar === '"') {
          currentField += '"';
          i++;
        } else if (char === '"') {
          inQuotes = false;
        } else {
          currentField += char;
        }
      } else {
        if (char === '"') {
          inQuotes = true;
        } else if (char === ',') {
          result.push(currentField);
          currentField = "";
        } else {
          currentField += char;
        }
      }
    }
    result.push(currentField);
    return result;
  }

  // Parse header
  currentHeaders = parseLine(validLines[0]);

  // Build table
  let html = '<table class="csv-table"><thead><tr>';
  for (let h = 0; h < currentHeaders.length; h++) {
    html += '<th>' + escapeHtml(currentHeaders[h]) + '</th>';
  }
  html += '</tr></thead><tbody>';

  let rowCount = 0;
  currentCSVData = [];
  
  for (let i = 1; i < validLines.length; i++) {
    const cells = parseLine(validLines[i]);
    currentCSVData.push(cells);
    html += '<tr>';
    for (let j = 0; j < currentHeaders.length; j++) {
      html += '<td>' + escapeHtml(cells[j] || '') + '</td>';
    }
    for (let j = currentHeaders.length; j < cells.length; j++) {
      html += '<td>' + escapeHtml(cells[j] || '') + '</td>';
    }
    html += '</tr>';
    rowCount++;
  }

  html += '</tbody></table>';
  output.innerHTML = html;

  // Show stats
  statsEl.style.display = "block";
  statsEl.innerHTML = '📊 <strong>' + currentHeaders.length + '</strong> columns | <strong>' + rowCount + '</strong> rows | ' + (validLines.length - 1) + ' data lines parsed';
}

function clearCSV() {
  document.getElementById("csv-data").value = "";
  document.getElementById("csv-output").innerHTML = "<p style='color:#999;padding:1rem;text-align:center;'>Kết quả sẽ hiển thị ở đây...</p>";
  document.getElementById("csv-stats").style.display = "none";
  currentCSVData = null;
  currentHeaders = [];
}

function exportCSV() {
  const csvData = document.getElementById("csv-data").value;
  if (!csvData.trim()) {
    alert("Không có dữ liệu để export!");
    return;
  }
  
  const blob = new Blob([csvData], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement("a");
  const url = URL.createObjectURL(blob);
  link.setAttribute("href", url);
  link.setAttribute("download", "data_" + new Date().toISOString().slice(0,10) + ".csv");
  link.style.visibility = 'hidden';
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}

function escapeHtml(text) {
  if (!text) return "";
  return String(text)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Dán dữ liệu CSV** vào ô input (có thể copy từ Excel, Google Sheets).
2. Nhấn **Xem CSV** để hiển thị dữ liệu dưới dạng bảng.
3. Sử dụng **Export CSV** để tải dữ liệu về máy.
4. Bảng hiển thị có thể scroll ngang/dọc nếu dữ liệu lớn.

> 💡 **Mẹo:** Công cụ hỗ trợ CSV có dấu phẩy, tab, hoặc bất kỳ delimiter nào. Các field chứa dấu phẩy nên được bao bởi dấu ngoặc kép.
