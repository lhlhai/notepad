---
title: 🔍 API Response Inspector
description: Phân tích cấu trúc JSON response từ API — đếm fields, kiểm tra kiểu dữ liệu, tìm null/undefined, và validate cấu trúc. Hữu ích khi debug API testing.
---

# 🔍 API Response Inspector

Công cụ phân tích cấu trúc JSON response từ API. Tự động đếm số lượng fields, kiểm tra kiểu dữ liệu, tìm null values, và hiển thị cấu trúc phân cấp.

<div id="api-inspector-root">
<style>
.api-inspector-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.api-input-group textarea {
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
.api-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}
.api-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.api-controls button:hover {
  opacity: 0.9;
}
.api-stats {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 0.5rem;
  margin-bottom: 1rem;
}
.api-stat-card {
  background: rgba(0,0,0,0.05);
  padding: 0.75rem;
  border-radius: 4px;
  text-align: center;
}
.api-stat-card .stat-number {
  font-size: 1.5rem;
  font-weight: bold;
  color: var(--secondary);
}
.api-stat-card .stat-label {
  font-size: 0.8rem;
  color: #666;
}
.api-structure {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  font-family: monospace;
  font-size: 0.8rem;
  max-height: 500px;
  overflow-y: auto;
  line-height: 1.8;
}
.api-structure .tree-key { color: #881391; font-weight: bold; }
.api-structure .tree-string { color: #1a1aa6; }
.api-structure .tree-number { color: #098658; }
.api-structure .tree-boolean { color: #0451a5; }
.api-structure .tree-null { color: #ff0000; font-weight: bold; }
.api-structure .tree-type { color: #888; font-size: 0.7rem; }
.api-structure .tree-bracket { color: #666; }
.api-null-warning {
  background: #fff3cd;
  border-left: 3px solid #ffc107;
  padding: 0.25rem 0.5rem;
  margin: 2px 0;
  font-size: 0.75rem;
}
</style>

<div class="api-inspector-container">
  <div class="api-input-group">
    <label for="api-input"><strong>Dán JSON Response từ API vào đây:</strong></label>
    <textarea id="api-input" placeholder='{"status":200,"data":{"users":[{"id":1,"name":"John","email":"john@test.com","profile":null}]}}'>{"status":200,"data":{"users":[{"id":1,"name":"John","email":"john@test.com","age":30,"active":true},{"id":2,"name":"Jane","email":"jane@test.com","age":null,"active":false}],"total":2,"page":1,"metadata":{"version":"1.0","lastUpdated":"2024-01-01"}}}</textarea>
  </div>
  <div class="api-controls">
    <button onclick="inspectAPI()">🔍 Phân tích API</button>
    <button onclick="prettyPrint()">✨ Pretty Print</button>
    <button onclick="collapseAll()">📁 Collapse All</button>
    <button onclick="expandAll()">📂 Expand All</button>
    <button onclick="clearAPIInspector()">Xóa</button>
  </div>
  <div id="api-stats-area" class="api-stats"></div>
  <div class="api-structure" id="api-structure">Kết quả phân tích sẽ hiển thị ở đây...</div>
</div>

<script>
let currentJson = null;

function inspectAPI() {
  const input = document.getElementById("api-input").value;
  const output = document.getElementById("api-structure");
  const statsArea = document.getElementById("api-stats-area");

  try {
    currentJson = JSON.parse(input);
  } catch (e) {
    output.innerHTML = `<span style="color:#dc3545;">❌ JSON không hợp lệ: ${e.message}</span>`;
    statsArea.innerHTML = "";
    return;
  }

  const stats = analyzeJSON(currentJson);
  displayStats(stats);
  displayStructure(currentJson);
}

function analyzeJSON(obj) {
  const stats = { totalFields: 0, strings: 0, numbers: 0, booleans: 0, nulls: 0, arrays: 0, objects: 0, maxDepth: 0, nullPaths: [] };

  function traverse(o, depth, path) {
    stats.maxDepth = Math.max(stats.maxDepth, depth);
    if (Array.isArray(o)) {
      stats.arrays++;
      o.forEach((item, i) => traverse(item, depth + 1, `${path}[${i}]`));
    } else if (o !== null && typeof o === 'object') {
      stats.objects++;
      for (const [key, value] of Object.entries(o)) {
        stats.totalFields++;
        const newPath = `${path}.${key}`;
        if (value === null) {
          stats.nulls++;
          stats.nullPaths.push(newPath);
        } else if (typeof value === 'string') stats.strings++;
        else if (typeof value === 'number') stats.numbers++;
        else if (typeof value === 'boolean') stats.booleans++;
        traverse(value, depth + 1, newPath);
      }
    }
  }

  traverse(obj, 0, 'root');
  return stats;
}

function displayStats(stats) {
  const statsArea = document.getElementById("api-stats-area");
  statsArea.innerHTML = `
    <div class="api-stat-card"><div class="stat-number">${stats.totalFields}</div><div class="stat-label">Total Fields</div></div>
    <div class="api-stat-card"><div class="stat-number">${stats.strings}</div><div class="stat-label">Strings</div></div>
    <div class="api-stat-card"><div class="stat-number">${stats.numbers}</div><div class="stat-label">Numbers</div></div>
    <div class="api-stat-card"><div class="stat-number">${stats.booleans}</div><div class="stat-label">Booleans</div></div>
    <div class="api-stat-card"><div class="stat-number" style="color:${stats.nulls > 0 ? '#dc3545' : 'var(--secondary)'}">${stats.nulls}</div><div class="stat-label">Null Values ⚠️</div></div>
    <div class="api-stat-card"><div class="stat-number">${stats.arrays}</div><div class="stat-label">Arrays</div></div>
    <div class="api-stat-card"><div class="stat-number">${stats.objects}</div><div class="stat-label">Objects</div></div>
    <div class="api-stat-card"><div class="stat-number">${stats.maxDepth}</div><div class="stat-label">Max Depth</div></div>
  `;
}

function displayStructure(obj, container = null) {
  const output = document.getElementById("api-structure");
  if (!container) {
    output.innerHTML = "";
    container = document.createElement("div");
    container.id = "tree-container";
  }
  container.innerHTML = "";

  function buildTree(o, depth, path) {
    const div = document.createElement("div");
    div.style.marginLeft = (depth * 1.5) + "rem";

    if (o === null) {
      div.innerHTML = `<span class="tree-null">null</span> <span class="tree-type">(null)</span>`;
    } else if (typeof o === 'string') {
      div.innerHTML = `<span class="tree-string">"${escapeHtml(o)}"</span> <span class="tree-type">(string)</span>`;
    } else if (typeof o === 'number') {
      div.innerHTML = `<span class="tree-number">${o}</span> <span class="tree-type">(number)</span>`;
    } else if (typeof o === 'boolean') {
      div.innerHTML = `<span class="tree-boolean">${o}</span> <span class="tree-type">(boolean)</span>`;
    } else if (Array.isArray(o)) {
      div.innerHTML = `<span class="tree-bracket">[</span> <span class="tree-type">Array(${o.length})</span>`;
      const childDiv = document.createElement("div");
      childDiv.className = "tree-children";
      o.forEach((item, i) => {
        const itemDiv = document.createElement("div");
        itemDiv.style.marginLeft = "1rem";
        itemDiv.innerHTML = `<span style="color:#666;">[${i}]</span> `;
        itemDiv.appendChild(buildTree(item, depth + 1, `${path}[${i}]`));
        childDiv.appendChild(itemDiv);
      });
      const closeDiv = document.createElement("div");
      closeDiv.innerHTML = `<span class="tree-bracket">]</span>`;
      div.appendChild(childDiv);
      div.appendChild(closeDiv);
    } else if (typeof o === 'object') {
      div.innerHTML = `<span class="tree-bracket">{</span> <span class="tree-type">Object</span>`;
      const childDiv = document.createElement("div");
      childDiv.className = "tree-children";
      for (const [key, value] of Object.entries(o)) {
        const itemDiv = document.createElement("div");
        itemDiv.style.marginLeft = "1rem";
        const keyDisplay = value === null ? `<span class="tree-null-warning">⚠️ ${key}</span>` : `<span class="tree-key">${escapeHtml(key)}</span>`;
        itemDiv.innerHTML = `<span>${keyDisplay}: </span>`;
        itemDiv.appendChild(buildTree(value, depth + 1, `${path}.${key}`));
        childDiv.appendChild(itemDiv);
      }
      const closeDiv = document.createElement("div");
      closeDiv.innerHTML = `<span class="tree-bracket">}</span>`;
      div.appendChild(childDiv);
      div.appendChild(closeDiv);
    }

    return div;
  }

  const tree = buildTree(obj, 0, 'root');
  container.appendChild(tree);
  output.appendChild(container);

  // Show null warnings
  if (currentJson) {
    const stats = analyzeJSON(currentJson);
    if (stats.nullPaths.length > 0) {
      const warningDiv = document.createElement("div");
      warningDiv.style.marginTop = "1rem";
      warningDiv.innerHTML = `<strong>⚠️ Null Paths (${stats.nullPaths.length}):</strong>`;
      stats.nullPaths.forEach(p => {
        warningDiv.innerHTML += `<div class="api-null-warning">${escapeHtml(p)}</div>`;
      });
      output.appendChild(warningDiv);
    }
  }
}

function prettyPrint() {
  const input = document.getElementById("api-input").value;
  try {
    const obj = JSON.parse(input);
    document.getElementById("api-input").value = JSON.stringify(obj, null, 2);
  } catch (e) {
    alert("JSON không hợp lệ!");
  }
}

function collapseAll() {
  document.querySelectorAll(".tree-children").forEach(el => el.style.display = "none");
}

function expandAll() {
  document.querySelectorAll(".tree-children").forEach(el => el.style.display = "block");
}

function clearAPIInspector() {
  document.getElementById("api-input").value = "";
  document.getElementById("api-structure").innerHTML = "Kết quả phân tích sẽ hiển thị ở đây...";
  document.getElementById("api-stats-area").innerHTML = "";
}

function escapeHtml(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Dán JSON Response** từ API vào ô input (có thể copy từ Postman, DevTools Network tab).
2. Nhấn **Phân tích API** để xem cấu trúc phân cấp và thống kê.
3. Các thông tin hiển thị:
   - 📊 **Thống kê**: Số lượng fields, strings, numbers, booleans, nulls, arrays, objects, max depth
   - 🌳 **Cấu trúc cây**: Hiển thị phân cấp với màu sắc cho từng kiểu dữ liệu
   - ⚠️ **Null Warnings**: Highlight tất cả các đường dẫn có giá trị null
4. Nhấn **Collapse All / Expand All** để thu gọn/mở rộng cấu trúc cây.
5. Nhấn **Pretty Print** để format lại JSON input cho dễ đọc.

> 💡 **Mẹo:** Dùng công cụ này ngay sau khi test API — paste response vào và kiểm tra nhanh xem có field nào bị null, thiếu data không mong đợi, hoặc cấu trúc có đúng như documentation không.
