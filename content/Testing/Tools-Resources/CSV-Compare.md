---
title: "💎 CSV Compare"
description: "So sánh hai file CSV để tìm ra sự khác biệt về dữ liệu. Hữu ích cho việc kiểm tra dữ liệu trước và sau khi deploy, hoặc so sánh các bộ dữ liệu khác nhau."
---

# ↔️ CSV Compare

Công cụ này giúp bạn so sánh hai bộ dữ liệu CSV và làm nổi bật những điểm khác biệt. Dán dữ liệu CSV vào hai ô bên dưới và nhấn "So sánh" để xem kết quả.

<div id="csv-compare-root">
<style>
.csv-compare-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.csv-compare-inputs {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
}
.csv-compare-inputs > div {
  flex: 1;
}
.csv-compare-inputs textarea {
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
.csv-compare-controls {
  margin-bottom: 1rem;
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  align-items: center;
}
.csv-compare-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.csv-compare-controls button:hover {
  opacity: 0.9;
}
.csv-compare-controls select {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
}
.csv-compare-results {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 100px;
  overflow-x: auto;
}
.diff-added { background-color: #d4edda; }
.diff-removed { background-color: #f8d7da; }
.diff-changed { background-color: #fff3cd; }
.csv-compare-table {
  width: 100%;
  border-collapse: collapse;
}
.csv-compare-table th, .csv-compare-table td {
  border: 1px solid var(--lightgray);
  padding: 8px;
  text-align: left;
  white-space: nowrap;
}
.csv-compare-table th {
  background-color: var(--lightgray);
  position: sticky;
  top: 0;
}
.csv-compare-summary {
  background: rgba(0,0,0,0.05);
  padding: 0.75rem;
  border-radius: 4px;
  margin-bottom: 0.5rem;
  font-weight: 600;
  font-size: 0.9rem;
}
</style>

<div class="csv-compare-container">
  <div class="csv-compare-inputs">
    <div>
      <label for="csv1"><strong>CSV gốc (Expected):</strong></label>
      <textarea id="csv1" placeholder="id,name,status&#10;1,John,active&#10;2,Jane,inactive"></textarea>
    </div>
    <div>
      <label for="csv2"><strong>CSV mới (Actual):</strong></label>
      <textarea id="csv2" placeholder="id,name,status&#10;1,John,active&#10;2,Jane,active&#10;3,Bob,active"></textarea>
    </div>
  </div>
  <div class="csv-compare-controls">
    <button onclick="compareCSV()">↔️ So sánh CSV</button>
    <button onclick="swapCSV()">🔄 Hoán đổi</button>
    <button onclick="clearCompare()">Xóa</button>
    <label style="margin-left:0.5rem;"><strong>Key Column:</strong></label>
    <select id="compare-key-col" style="margin-left:0.25rem;">
      <option value="0">Column 1 (auto)</option>
      <option value="-1">So sánh toàn bộ row</option>
    </select>
  </div>
  <div class="csv-compare-results" id="compare-output">Kết quả so sánh sẽ hiển thị ở đây...</div>
</div>

<script>
// Robust CSV parser
function parseCSVLines(csv) {
  const lines = csv.split(/\r\n|\r|\n/);
  const validLines = lines.filter(line => line.trim() !== "");
  if (validLines.length === 0) return { headers: [], rows: [] };

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

  const headers = parseLine(validLines[0]);
  const rows = [];
  for (let i = 1; i < validLines.length; i++) {
    rows.push(parseLine(validLines[i]));
  }
  return { headers, rows };
}

function rowToObject(headers, row) {
  const obj = {};
  headers.forEach((h, i) => {
    obj[h] = row[i] !== undefined ? row[i] : "";
  });
  return obj;
}

function compareCSV() {
  const csv1Text = document.getElementById("csv1").value;
  const csv2Text = document.getElementById("csv2").value;
  const outputDiv = document.getElementById("compare-output");
  const keyColSelect = document.getElementById("compare-key-col");

  if (!csv1Text.trim() && !csv2Text.trim()) {
    outputDiv.innerHTML = "<p style='color:#999;padding:1rem;'>Vui lòng dán dữ liệu CSV vào cả hai ô.</p>";
    return;
  }

  const data1 = parseCSVLines(csv1Text);
  const data2 = parseCSVLines(csv2Text);

  if (data1.rows.length === 0 && data2.rows.length === 0) {
    outputDiv.innerHTML = "<p style='color:#999;padding:1rem;'>Không có dữ liệu để so sánh.</p>";
    return;
  }

  // Determine headers
  const allHeaders = [...data1.headers];
  data2.headers.forEach(h => {
    if (!allHeaders.includes(h)) allHeaders.push(h);
  });

  // Determine key column index
  const keyColIndex = parseInt(keyColSelect.value);
  const useKeyCol = keyColIndex >= 0 && keyColIndex < Math.max(data1.headers.length, data2.headers.length);

  // Build maps by key
  const map1 = new Map();
  data1.rows.forEach(row => {
    if (useKeyCol) {
      const key = (row[keyColIndex] || "").trim();
      map1.set(key, rowToObject(data1.headers, row));
    } else {
      const key = JSON.stringify(rowToObject(data1.headers, row));
      map1.set(key, rowToObject(data1.headers, row));
    }
  });

  const map2 = new Map();
  data2.rows.forEach(row => {
    if (useKeyCol) {
      const key = (row[keyColIndex] || "").trim();
      map2.set(key, rowToObject(data2.headers, row));
    } else {
      const key = JSON.stringify(rowToObject(data2.headers, row));
      map2.set(key, rowToObject(data2.headers, row));
    }
  });

  // Stats
  let addedCount = 0, removedCount = 0, changedCount = 0, sameCount = 0;

  // Build table HTML
  let html = "";

  // Removed rows (in data1 but not in data2)
  const removedKeys = new Set();
  map1.forEach((obj1, key) => {
    const matchKey = useKeyCol ? key : JSON.stringify(obj1);
    const foundIn2 = useKeyCol ? map2.has(key) : map2.has(JSON.stringify(obj1));
    if (!foundIn2) {
      removedCount++;
      let rowHtml = '<tr class="diff-removed">';
      allHeaders.forEach(h => {
        rowHtml += '<td>' + escapeHtml(obj1[h] || "") + '</td>';
      });
      rowHtml += '</tr>';
      html += rowHtml;
    }
  });

  // Added and Changed rows (in data2)
  map2.forEach((obj2, key) => {
    const matchKey = useKeyCol ? key : JSON.stringify(obj2);
    const foundIn1 = useKeyCol ? map1.has(key) : map1.has(JSON.stringify(obj2));
    if (!foundIn1) {
      addedCount++;
      let rowHtml = '<tr class="diff-added">';
      allHeaders.forEach(h => {
        rowHtml += '<td>' + escapeHtml(obj2[h] || "") + '</td>';
      });
      rowHtml += '</tr>';
      html += rowHtml;
    } else {
      // Check for changed values
      const obj1 = useKeyCol ? map1.get(key) : null;
      if (obj1) {
        let rowHtml = '<tr>';
        let hasChange = false;
        allHeaders.forEach(h => {
          const v1 = obj1[h] || "";
          const v2 = obj2[h] || "";
          if (v1 !== v2) {
            hasChange = true;
            rowHtml += '<td class="diff-changed"><span style="text-decoration:line-through;color:#dc3545;">' + escapeHtml(v1) + '</span> → <span style="color:#28a745;font-weight:bold;">' + escapeHtml(v2) + '</span></td>';
          } else {
            rowHtml += '<td>' + escapeHtml(v2) + '</td>';
          }
        });
        rowHtml += '</tr>';
        if (hasChange) {
          changedCount++;
          html += rowHtml;
        } else {
          sameCount++;
        }
      }
    }
  });

  // Render
  let summaryHtml = '<div class="csv-compare-summary">📊 Tổng kết: ';
  summaryHtml += '<span style="color:#28a745;">+' + addedCount + ' thêm</span> | ';
  summaryHtml += '<span style="color:#dc3545;">-' + removedCount + ' xóa</span> | ';
  summaryHtml += '<span style="color:#d39e00;">~' + changedCount + ' thay đổi</span> | ';
  summaryHtml += '<span>✅ ' + sameCount + ' giống nhau</span></div>';

  let tableHtml = "";
  if (html) {
    tableHtml = '<table class="csv-compare-table"><thead><tr>';
    allHeaders.forEach(h => {
      tableHtml += '<th>' + escapeHtml(h) + '</th>';
    });
    tableHtml += '</tr></thead><tbody>' + html + '</tbody></table>';
  }

  outputDiv.innerHTML = summaryHtml + (html ? tableHtml : '<p>Không tìm thấy sự khác biệt nào. Hai bộ dữ liệu giống nhau!</p>');
}

function swapCSV() {
  const el1 = document.getElementById("csv1");
  const el2 = document.getElementById("csv2");
  const temp = el1.value;
  el1.value = el2.value;
  el2.value = temp;
}

function clearCompare() {
  document.getElementById("csv1").value = "";
  document.getElementById("csv2").value = "";
  document.getElementById("compare-output").innerHTML = "Kết quả so sánh sẽ hiển thị ở đây...";
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
