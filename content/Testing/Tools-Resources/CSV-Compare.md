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
.csv-compare-inputs { display: flex; gap: 1rem; margin-bottom: 1rem; }
.csv-compare-inputs > div { flex: 1; }
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
.csv-compare-controls button:hover { opacity: 0.9; }
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
.csv-compare-table { width: 100%; border-collapse: collapse; }
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

function showCompareMessage(text) {
  const outputDiv = document.getElementById("compare-output");
  outputDiv.innerHTML = "";
  const msg = document.createElement("p");
  msg.style.color = "#999";
  msg.style.padding = "1rem";
  msg.textContent = text;
  outputDiv.appendChild(msg);
}

function compareCSV() {
  const csv1Text = document.getElementById("csv1").value;
  const csv2Text = document.getElementById("csv2").value;
  const outputDiv = document.getElementById("compare-output");
  const keyColSelect = document.getElementById("compare-key-col");

  if (!csv1Text.trim() && !csv2Text.trim()) {
    showCompareMessage("Vui lòng dán dữ liệu CSV vào cả hai ô.");
    return;
  }

  const data1 = parseCSVLines(csv1Text);
  const data2 = parseCSVLines(csv2Text);

  if (data1.rows.length === 0 && data2.rows.length === 0) {
    showCompareMessage("Không có dữ liệu để so sánh.");
    return;
  }

  const allHeaders = [...data1.headers];
  data2.headers.forEach(h => {
    if (!allHeaders.includes(h)) allHeaders.push(h);
  });

  const keyColIndex = parseInt(keyColSelect.value);
  const useKeyCol = keyColIndex >= 0 && keyColIndex < Math.max(data1.headers.length, data2.headers.length);

  const map1 = new Map();
  data1.rows.forEach(row => {
    const obj = rowToObject(data1.headers, row);
    const key = useKeyCol ? (row[keyColIndex] || "").trim() : JSON.stringify(obj);
    map1.set(key, obj);
  });

  const map2 = new Map();
  data2.rows.forEach(row => {
    const obj = rowToObject(data2.headers, row);
    const key = useKeyCol ? (row[keyColIndex] || "").trim() : JSON.stringify(obj);
    map2.set(key, obj);
  });

  let addedCount = 0, removedCount = 0, changedCount = 0, sameCount = 0;
  const bodyRows = [];

  // Removed rows (in data1 but not in data2)
  map1.forEach((obj1, key) => {
    if (!map2.has(key)) {
      removedCount++;
      const tr = document.createElement("tr");
      tr.className = "diff-removed";
      allHeaders.forEach(h => {
        const td = document.createElement("td");
        td.textContent = obj1[h] || "";
        tr.appendChild(td);
      });
      bodyRows.push(tr);
    }
  });

  // Added / changed rows (in data2)
  map2.forEach((obj2, key) => {
    const foundIn1 = map1.has(key);
    if (!foundIn1) {
      addedCount++;
      const tr = document.createElement("tr");
      tr.className = "diff-added";
      allHeaders.forEach(h => {
        const td = document.createElement("td");
        td.textContent = obj2[h] || "";
        tr.appendChild(td);
      });
      bodyRows.push(tr);
    } else {
      const obj1 = map1.get(key);
      const tr = document.createElement("tr");
      let hasChange = false;

      allHeaders.forEach(h => {
        const v1 = obj1[h] || "";
        const v2 = obj2[h] || "";
        const td = document.createElement("td");

        if (v1 !== v2) {
          hasChange = true;
          td.className = "diff-changed";

          const oldSpan = document.createElement("span");
          oldSpan.style.textDecoration = "line-through";
          oldSpan.style.color = "#dc3545";
          oldSpan.textContent = v1;

          const newSpan = document.createElement("span");
          newSpan.style.color = "#28a745";
          newSpan.style.fontWeight = "bold";
          newSpan.textContent = v2;

          td.appendChild(oldSpan);
          td.appendChild(document.createTextNode(" → "));
          td.appendChild(newSpan);
        } else {
          td.textContent = v2;
        }
        tr.appendChild(td);
      });

      if (hasChange) {
        changedCount++;
        bodyRows.push(tr);
      } else {
        sameCount++;
      }
    }
  });

  // Summary
  const summaryDiv = document.createElement("div");
  summaryDiv.className = "csv-compare-summary";

  const spanAdded = document.createElement("span");
  spanAdded.style.color = "#28a745";
  spanAdded.textContent = "+" + addedCount + " thêm";

  const spanRemoved = document.createElement("span");
  spanRemoved.style.color = "#dc3545";
  spanRemoved.textContent = "-" + removedCount + " xóa";

  const spanChanged = document.createElement("span");
  spanChanged.style.color = "#d39e00";
  spanChanged.textContent = "~" + changedCount + " thay đổi";

  const spanSame = document.createElement("span");
  spanSame.textContent = "✅ " + sameCount + " giống nhau";

  summaryDiv.append("📊 Tổng kết: ", spanAdded, " | ", spanRemoved, " | ", spanChanged, " | ", spanSame);

  outputDiv.innerHTML = "";
  outputDiv.appendChild(summaryDiv);

  if (bodyRows.length > 0) {
    const table = document.createElement("table");
    table.className = "csv-compare-table";

    const thead = document.createElement("thead");
    const headRow = document.createElement("tr");
    allHeaders.forEach(h => {
      const th = document.createElement("th");
      th.textContent = h;
      headRow.appendChild(th);
    });
    thead.appendChild(headRow);
    table.appendChild(thead);

    const tbody = document.createElement("tbody");
    bodyRows.forEach(tr => tbody.appendChild(tr));
    table.appendChild(tbody);

    outputDiv.appendChild(table);
  } else {
    const p = document.createElement("p");
    p.textContent = "Không tìm thấy sự khác biệt nào. Hai bộ dữ liệu giống nhau!";
    outputDiv.appendChild(p);
  }
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
  document.getElementById("compare-output").textContent = "Kết quả so sánh sẽ hiển thị ở đây...";
}
</script>
</div>
