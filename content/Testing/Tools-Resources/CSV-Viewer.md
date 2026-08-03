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
  const lines = csvData.split(/\r\n|\n/);
  if (lines.length === 0 || (lines.length === 1 && lines[0].trim() === "")) {
    document.getElementById("csv-output").innerHTML = "<p>Không có dữ liệu CSV để hiển thị.</p>";
    return;
  }

  const table = document.createElement("table");
  table.className = "csv-table";

  // Header
  const thead = document.createElement("thead");
  const headerRow = document.createElement("tr");
  lines[0].split(",").forEach(header => {
    const th = document.createElement("th");
    th.textContent = header.trim();
    headerRow.appendChild(th);
  });
  thead.appendChild(headerRow);
  table.appendChild(thead);

  // Body
  const tbody = document.createElement("tbody");
  for (let i = 1; i < lines.length; i++) {
    const line = lines[i].trim();
    if (line === "") continue;
    const dataRow = document.createElement("tr");
    line.split(",").forEach(cell => {
      const td = document.createElement("td");
      td.textContent = cell.trim();
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
