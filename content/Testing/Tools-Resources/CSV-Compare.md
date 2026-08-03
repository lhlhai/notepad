---
title: ↔️ CSV Compare
description: So sánh hai file CSV để tìm ra sự khác biệt về dữ liệu. Hữu ích cho việc kiểm tra dữ liệu trước và sau khi deploy, hoặc so sánh các bộ dữ liệu khác nhau.
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
}
.csv-compare-controls {
  margin-bottom: 1rem;
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
.csv-compare-results {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 100px;
  overflow-x: auto;
}
.diff-added {
  background-color: #d4edda; /* Greenish for added */
}
.diff-removed {
  background-color: #f8d7da; /* Reddish for removed */
}
.diff-changed {
  background-color: #fff3cd; /* Yellowish for changed */
}
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
</style>

<div class="csv-compare-container">
  <div class="csv-compare-inputs">
    <div>
      <label for="csv1">CSV gốc (trái):</label>
      <textarea id="csv1" placeholder="header1,header2\nvalue1,value2"></textarea>
    </div>
    <div>
      <label for="csv2">CSV mới (phải):</label>
      <textarea id="csv2" placeholder="header1,header2\nvalue1_new,value2"></textarea>
    </div>
  </div>
  <div class="csv-compare-controls">
    <button onclick="compareCSV()">So sánh CSV</button>
    <button onclick="clearCompare()">Xóa</button>
  </div>
  <div class="csv-compare-results" id="compare-output">Kết quả so sánh sẽ hiển thị ở đây...</div>
</div>

<script>
function parseCsvToObjects(csv) {
  const lines = csv.split(/\r\n|\n/).filter(line => line.trim() !== "");
  if (lines.length === 0) return [];

  const headers = lines[0].split(",").map(h => h.trim());
  const data = [];
  for (let i = 1; i < lines.length; i++) {
    const values = lines[i].split(",").map(v => v.trim());
    const obj = {};
    headers.forEach((header, index) => {
      obj[header] = values[index];
    });
    data.push(obj);
  }
  return data;
}

function compareCSV() {
  const csv1 = document.getElementById("csv1").value;
  const csv2 = document.getElementById("csv2").value;

  const data1 = parseCsvToObjects(csv1);
  const data2 = parseCsvToObjects(csv2);

  if (data1.length === 0 && data2.length === 0) {
    document.getElementById("compare-output").innerHTML = "<p>Không có dữ liệu để so sánh.</p>";
    return;
  }

  const outputDiv = document.getElementById("compare-output");
  outputDiv.innerHTML = "";

  const allHeaders = Array.from(new Set([...(data1[0] ? Object.keys(data1[0]) : []), ...(data2[0] ? Object.keys(data2[0]) : [])]));

  const table = document.createElement("table");
  table.className = "csv-compare-table";
  const thead = document.createElement("thead");
  const headerRow = document.createElement("tr");
  allHeaders.forEach(h => {
    const th = document.createElement("th");
    th.textContent = h;
    headerRow.appendChild(th);
  });
  thead.appendChild(headerRow);
  table.appendChild(thead);

  const tbody = document.createElement("tbody");

  const data1Map = new Map(data1.map(row => [JSON.stringify(row), row]));
  const data2Map = new Map(data2.map(row => [JSON.stringify(row), row]));

  // Check for removed rows (in data1 but not in data2)
  data1.forEach(row1 => {
    if (!data2Map.has(JSON.stringify(row1))) {
      const tr = document.createElement("tr");
      tr.classList.add("diff-removed");
      allHeaders.forEach(header => {
        const td = document.createElement("td");
        td.textContent = row1[header] || "";
        tr.appendChild(td);
      });
      tbody.appendChild(tr);
    }
  });

  // Check for added rows (in data2 but not in data1) and changed rows
  data2.forEach(row2 => {
    const row2String = JSON.stringify(row2);
    if (!data1Map.has(row2String)) {
      const tr = document.createElement("tr");
      tr.classList.add("diff-added");
      allHeaders.forEach(header => {
        const td = document.createElement("td");
        td.textContent = row2[header] || "";
        tr.appendChild(td);
      });
      tbody.appendChild(tr);
    } else {
      // Check for changed rows (same row, but some values changed)
      const row1 = data1.find(r => JSON.stringify(r) === row2String);
      if (row1) {
        let changed = false;
        const tr = document.createElement("tr");
        allHeaders.forEach(header => {
          const td = document.createElement("td");
          if (row1[header] !== row2[header]) {
            td.classList.add("diff-changed");
            td.innerHTML = `<span style="text-decoration: line-through; color: #dc3545;">${row1[header] || ""}</span> <span style="color: #28a745;">${row2[header] || ""}</span>`;
            changed = true;
          } else {
            td.textContent = row2[header] || "";
          }
          tr.appendChild(td);
        });
        if (changed) {
          tbody.appendChild(tr);
        }
      }
    }
  });

  table.appendChild(tbody);
  outputDiv.appendChild(table);

  if (tbody.children.length === 0) {
    outputDiv.innerHTML = "<p>Không tìm thấy sự khác biệt nào.</p>";
  }
}

function clearCompare() {
  document.getElementById("csv1").value = "";
  document.getElementById("csv2").value = "";
  document.getElementById("compare-output").innerHTML = "Kết quả so sánh sẽ hiển thị ở đây...";
}
</script>
</div>
