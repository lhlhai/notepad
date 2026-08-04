---
title: "✅ CSV Viewer"
description: "Xem và chỉnh sửa dữ liệu CSV trực tiếp trên trình duyệt. Hỗ trợ phân tích cấu trúc, lọc và xuất dữ liệu."
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
.csv-input-group { margin-bottom: 1rem; }
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
.csv-controls { display: flex; gap: 0.5rem; margin-bottom: 1rem; flex-wrap: wrap; }
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
.csv-controls button:hover { opacity: 0.9; }
.csv-table-container {
  max-height: 500px;
  overflow: auto;
  border: 1px solid var(--gray);
  border-radius: 4px;
}
.csv-table { width: 100%; border-collapse: collapse; }
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
.csv-stats {
  background: rgba(0,0,0,0.05);
  padding: 0.5rem 0.75rem;
  border-radius: 4px;
  margin-bottom: 0.5rem;
  font-size: 0.85rem;
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
  </div>
  <div id="csv-stats" class="csv-stats" style="display:none;"></div>
  <div class="csv-table-container" id="csv-output">Kết quả sẽ hiển thị ở đây...</div>
</div>

<script>
function parseCSV() {
  const csvData = document.getElementById("csv-data").value;
  const output = document.getElementById("csv-output");
  const statsEl = document.getElementById("csv-stats");

  function showEmptyMessage(text) {
    output.innerHTML = "";
    const msg = document.createElement("p");
    msg.style.color = "#999";
    msg.style.padding = "1rem";
    msg.textContent = text;
    output.appendChild(msg);
    statsEl.style.display = "none";
  }

  if (!csvData.trim()) {
    showEmptyMessage("Không có dữ liệu CSV để hiển thị.");
    return;
  }

  const lines = csvData.split(/\r\n|\r|\n/);
  const validLines = lines.filter(line => line.trim() !== "");

  if (validLines.length === 0) {
    showEmptyMessage("Không có dữ liệu CSV để hiển thị.");
    return;
  }

  function parseLine(line) {
    const result = [];
    let currentField = "";
    let inQuotes = false;

    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      const nextChar = line[i + 1];

      if (inQuotes) {
        if (Object.is(char, '"') && Object.is(nextChar, '"')) {
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

  const headers = parseLine(validLines[0]);

  const table = document.createElement("table");
  table.className = "csv-table";

  const thead = document.createElement("thead");
  const headerRow = document.createElement("tr");
  headers.forEach((h) => {
    const th = document.createElement("th");
    th.textContent = h;
    headerRow.appendChild(th);
  });
  thead.appendChild(headerRow);
  table.appendChild(thead);

  const tbody = document.createElement("tbody");
  let rowCount = 0;
  for (let i = 1; i < validLines.length; i++) {
    const cells = parseLine(validLines[i]);
    const row = document.createElement("tr");

    for (let j = 0; j < headers.length; j++) {
      const td = document.createElement("td");
      td.textContent = cells[j] || "";
      row.appendChild(td);
    }
    for (let j = headers.length; j < cells.length; j++) {
      const td = document.createElement("td");
      td.textContent = cells[j] || "";
      row.appendChild(td);
    }

    tbody.appendChild(row);
    rowCount++;
  }
  table.appendChild(tbody);

  output.innerHTML = "";
  output.appendChild(table);

  statsEl.style.display = "block";
  statsEl.innerHTML = "";
  const strongCols = document.createElement("strong");
  strongCols.textContent = headers.length;
  const strongRows = document.createElement("strong");
  strongRows.textContent = rowCount;

  statsEl.append(
    "📊 ",
    strongCols,
    " columns | ",
    strongRows,
    " rows | " + (validLines.length - 1) + " data lines parsed"
  );
}

function clearCSV() {
  document.getElementById("csv-data").value = "";
  document.getElementById("csv-output").textContent = "Kết quả sẽ hiển thị ở đây...";
  document.getElementById("csv-stats").style.display = "none";
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Dán dữ liệu CSV** vào ô input (có thể copy từ Excel, Google Sheets, hoặc file .csv).
2. Nhấn **Xem CSV** để hiển thị dữ liệu dưới dạng bảng.
3. Xem thống kê: số columns, số rows, số dòng đã parse.
4. Scroll ngang/dọc để xem toàn bộ dữ liệu nếu bảng lớn.
5. Nhấn **Xóa** để clear và nhập dữ liệu mới.

> 💡 **Mẹo:** Dùng công cụ này để nhanh chóng kiểm tra cấu trúc CSV, verify data format, hoặc xem trước dữ liệu trước khi import vào hệ thống.
