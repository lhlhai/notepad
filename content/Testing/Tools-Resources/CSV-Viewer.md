---
title: 📊 CSV Viewer & Editor
description: Xem và chỉnh sửa dữ liệu CSV trực tiếp trên trình duyệt. Hỗ trợ phân tích cấu trúc, lọc và xuất dữ liệu.
---

# 📊 CSV Viewer & Editor

Công cụ này giúp bạn dễ dàng xem, phân tích và chỉnh sửa dữ liệu CSV ngay trong trình duyệt. Dán dữ liệu CSV vào, và bạn sẽ có một bảng tương tác để làm việc.

<div id="csv-viewer-root">
<style>
.csv-viewer-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.csv-input-group {
  margin-bottom: 1rem;
}
.csv-input-group textarea {
  width: 100%;
  height: 150px;
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
}
.csv-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
}
.csv-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.csv-controls button:hover {
  opacity: 0.9;
}
.csv-table-container {
  max-height: 500px;
  overflow: auto;
  border: 1px solid var(--gray);
  border-radius: 4px;
}
.csv-table {
  width: 100%;
  border-collapse: collapse;
}
.csv-table th, .csv-table td {
  border: 1px solid var(--lightgray);
  padding: 8px;
  text-align: left;
  white-space: nowrap;
}
.csv-table th {
  background-color: var(--lightgray);
  position: sticky;
  top: 0;
}
</style>

<div class="csv-viewer-container">
  <div class="csv-input-group">
    <label for="csv-data">Dán dữ liệu CSV vào đây:</label>
    <textarea id="csv-data" placeholder="header1,header2\nvalue1,value2"></textarea>
  </div>
  <div class="csv-controls">
    <button onclick="parseCSV()">Xem CSV</button>
    <button onclick="clearCSV()">Xóa</button>
  </div>
  <div class="csv-table-container" id="csv-output"></div>
</div>

<script>
function parseCSV() {
  const csvData = document.getElementById("csv-data").value;
  // Robust CSV parsing to handle commas and newlines within quoted fields
  const lines = csvData.split(/\r\n|\n/).filter(line => line.trim() !== "");

  if (lines.length === 0) {
    document.getElementById("csv-output").innerHTML = "<p>Không có dữ liệu CSV để hiển thị.</p>";
    return;
  }

  // Simple CSV parser that handles quoted fields (but not escaped quotes within quotes)
  const parseLine = (line) => {
    const result = [];
    let inQuote = false;
    let currentField = "";
    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      if (char === "," && !inQuote) {
        result.push(currentField.trim());
        currentField = "";
      } else if (char === "," && inQuote) {
        currentField += char;
      } else if (char === "\"" && (i === 0 || line[i-1] === "," || line[i-1] === " ")) {
        inQuote = !inQuote;
      } else {
        currentField += char;
      }
    }
    result.push(currentField.trim());
    return result;
  };

  const table = document.createElement("table");
  table.className = "csv-table";

  // Header
  const thead = document.createElement("thead");
  const headerRow = document.createElement("tr");
  const headers = parseLine(lines[0]);
  headers.forEach(header => {
    const th = document.createElement("th");
    th.textContent = header;
    headerRow.appendChild(th);
  });
  thead.appendChild(headerRow);
  table.appendChild(thead);

  // Body
  const tbody = document.createElement("tbody");
  for (let i = 1; i < lines.length; i++) {
    const line = lines[i];
    if (line.trim() === "") continue;
    const dataRow = document.createElement("tr");
    parseLine(line).forEach(cell => {
      const td = document.createElement("td");
      td.textContent = cell;
      dataRow.appendChild(td);
    });
    tbody.appendChild(dataRow);
  }
  table.appendChild(tbody);

  document.getElementById("csv-output").innerHTML = "";
  document.getElementById("csv-output").appendChild(table);
}

function clearCSV() {
  document.getElementById("csv-data").value = "";
  document.getElementById("csv-output").innerHTML = "";
}
</script>
</div>
