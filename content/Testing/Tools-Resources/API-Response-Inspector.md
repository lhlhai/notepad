---
title: "🚀 API Response"
description: "Phân tích cấu trúc JSON response từ API — đếm fields, kiểm tra kiểu dữ liệu, tìm null/undefined, và validate cấu trúc. Hữu ích khi debug API testing."
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
.api-controls { display: flex; gap: 0.5rem; margin-bottom: 1rem; flex-wrap: wrap; }
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
.api-controls button:hover { opacity: 0.9; }
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
.api-stat-card .stat-number { font-size: 1.5rem; font-weight: bold; color: var(--secondary); }
.api-stat-card .stat-label { font-size: 0.8rem; color: #666; }
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
    <button onclick="apiInspect()">🔍 Phân tích API</button>
    <button onclick="apiPrettyPrint()">✨ Pretty Print</button>
    <button onclick="apiCollapseAll()">📁 Collapse All</button>
    <button onclick="apiExpandAll()">📂 Expand All</button>
    <button onclick="apiClearInspector()">Xóa</button>
  </div>
  <div id="api-stats-area" class="api-stats"></div>
  <div class="api-structure" id="api-structure">Kết quả phân tích sẽ hiển thị ở đây...</div>
</div>

<script>
let apiCurrentJson = null;

function apiEscapeHtml(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function apiInspect() {
  const input = document.getElementById("api-input").value;
  const output = document.getElementById("api-structure");
  const statsArea = document.getElementById("api-stats-area");

  try {
    apiCurrentJson = JSON.parse(input);
  } catch (e) {
    output.innerHTML = "";
    const errSpan = document.createElement("span");
    errSpan.style.color = "#dc3545";
    errSpan.textContent = "❌ JSON không hợp lệ: " + e.message;
    output.appendChild(errSpan);
    statsArea.innerHTML = "";
    return;
  }

  const stats = apiAnalyzeJSON(apiCurrentJson);
  apiDisplayStats(stats);
  apiDisplayStructure(apiCurrentJson, stats);
}

function apiAnalyzeJSON(obj) {
  const stats = { totalFields: 0, strings: 0, numbers: 0, booleans: 0, nulls: 0, arrays: 0, objects: 0, maxDepth: 0, nullPaths: [] };

  function traverse(o, depth, path) {
    stats.maxDepth = Math.max(stats.maxDepth, depth);
    if (Array.isArray(o)) {
      stats.arrays++;
      o.forEach((item, i) => traverse(item, depth + 1, path + "[" + i + "]"));
    } else if (o !== null && typeof o === 'object') {
      stats.objects++;
      for (const [key, value] of Object.entries(o)) {
        stats.totalFields++;
        const newPath = path + "." + key;
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

function apiMakeStatCard(number, label, color) {
  const card = document.createElement("div");
  card.className = "api-stat-card";

  const numDiv = document.createElement("div");
  numDiv.className = "stat-number";
  if (color) numDiv.style.color = color;
  numDiv.textContent = number;

  const labelDiv = document.createElement("div");
  labelDiv.className = "stat-label";
  labelDiv.textContent = label;

  card.appendChild(numDiv);
  card.appendChild(labelDiv);
  return card;
}

function apiDisplayStats(stats) {
  const statsArea = document.getElementById("api-stats-area");
  statsArea.innerHTML = "";
  statsArea.appendChild(apiMakeStatCard(stats.totalFields, "Total Fields"));
  statsArea.appendChild(apiMakeStatCard(stats.strings, "Strings"));
  statsArea.appendChild(apiMakeStatCard(stats.numbers, "Numbers"));
  statsArea.appendChild(apiMakeStatCard(stats.booleans, "Booleans"));
  statsArea.appendChild(apiMakeStatCard(stats.nulls, "Null Values ⚠️", stats.nulls > 0 ? '#dc3545' : null));
  statsArea.appendChild(apiMakeStatCard(stats.arrays, "Arrays"));
  statsArea.appendChild(apiMakeStatCard(stats.objects, "Objects"));
  statsArea.appendChild(apiMakeStatCard(stats.maxDepth, "Max Depth"));
}

function apiBuildTree(o, depth) {
  const div = document.createElement("div");
  div.style.marginLeft = (depth * 1.5) + "rem";

  function typeTag(text) {
    const span = document.createElement("span");
    span.className = "tree-type";
    span.textContent = " (" + text + ")";
    return span;
  }

  if (o === null) {
    const nullSpan = document.createElement("span");
    nullSpan.className = "tree-null";
    nullSpan.textContent = "null";
    div.appendChild(nullSpan);
    div.appendChild(typeTag("null"));
  } else if (typeof o === 'string') {
    const strSpan = document.createElement("span");
    strSpan.className = "tree-string";
    strSpan.textContent = '"' + o + '"';
    div.appendChild(strSpan);
    div.appendChild(typeTag("string"));
  } else if (typeof o === 'number') {
    const numSpan = document.createElement("span");
    numSpan.className = "tree-number";
    numSpan.textContent = o;
    div.appendChild(numSpan);
    div.appendChild(typeTag("number"));
  } else if (typeof o === 'boolean') {
    const boolSpan = document.createElement("span");
    boolSpan.className = "tree-boolean";
    boolSpan.textContent = o;
    div.appendChild(boolSpan);
    div.appendChild(typeTag("boolean"));
  } else if (Array.isArray(o)) {
    const openSpan = document.createElement("span");
    openSpan.className = "tree-bracket";
    openSpan.textContent = "[";
    div.appendChild(openSpan);
    div.appendChild(typeTag("Array(" + o.length + ")"));

    const childDiv = document.createElement("div");
    childDiv.className = "tree-children";
    o.forEach((item, i) => {
      const itemDiv = document.createElement("div");
      itemDiv.style.marginLeft = "1rem";
      const idxSpan = document.createElement("span");
      idxSpan.style.color = "#666";
      idxSpan.textContent = "[" + i + "] ";
      itemDiv.appendChild(idxSpan);
      itemDiv.appendChild(apiBuildTree(item, depth + 1));
      childDiv.appendChild(itemDiv);
    });

    const closeDiv = document.createElement("div");
    const closeSpan = document.createElement("span");
    closeSpan.className = "tree-bracket";
    closeSpan.textContent = "]";
    closeDiv.appendChild(closeSpan);

    div.appendChild(childDiv);
    div.appendChild(closeDiv);
  } else if (typeof o === 'object') {
    const openSpan = document.createElement("span");
    openSpan.className = "tree-bracket";
    openSpan.textContent = "{";
    div.appendChild(openSpan);
    div.appendChild(typeTag("Object"));

    const childDiv = document.createElement("div");
    childDiv.className = "tree-children";
    for (const [key, value] of Object.entries(o)) {
      const itemDiv = document.createElement("div");
      itemDiv.style.marginLeft = "1rem";

      const keySpan = document.createElement("span");
      if (value === null) {
        keySpan.className = "tree-null-warning";
        keySpan.textContent = "⚠️ " + key;
      } else {
        keySpan.className = "tree-key";
        keySpan.textContent = key;
      }
      itemDiv.appendChild(keySpan);
      itemDiv.appendChild(document.createTextNode(": "));
      itemDiv.appendChild(apiBuildTree(value, depth + 1));
      childDiv.appendChild(itemDiv);
    }

    const closeDiv = document.createElement("div");
    const closeSpan = document.createElement("span");
    closeSpan.className = "tree-bracket";
    closeSpan.textContent = "}";
    closeDiv.appendChild(closeSpan);

    div.appendChild(childDiv);
    div.appendChild(closeDiv);
  }

  return div;
}

function apiDisplayStructure(obj, stats) {
  const output = document.getElementById("api-structure");
  output.innerHTML = "";

  const container = document.createElement("div");
  container.id = "tree-container";
  container.appendChild(apiBuildTree(obj, 0));
  output.appendChild(container);

  if (stats.nullPaths.length > 0) {
    const warningDiv = document.createElement("div");
    warningDiv.style.marginTop = "1rem";

    const title = document.createElement("strong");
    title.textContent = "⚠️ Null Paths (" + stats.nullPaths.length + "):";
    warningDiv.appendChild(title);

    stats.nullPaths.forEach(p => {
      const pathDiv = document.createElement("div");
      pathDiv.className = "api-null-warning";
      pathDiv.textContent = p;
      warningDiv.appendChild(pathDiv);
    });

    output.appendChild(warningDiv);
  }
}

function apiPrettyPrint() {
  const input = document.getElementById("api-input");
  try {
    const obj = JSON.parse(input.value);
    input.value = JSON.stringify(obj, null, 2);
  } catch (e) {
    alert("JSON không hợp lệ!");
  }
}

function apiCollapseAll() {
  document.querySelectorAll("#api-structure .tree-children").forEach(el => el.style.display = "none");
}

function apiExpandAll() {
  document.querySelectorAll("#api-structure .tree-children").forEach(el => el.style.display = "block");
}

function apiClearInspector() {
  document.getElementById("api-input").value = "";
  document.getElementById("api-structure").textContent = "Kết quả phân tích sẽ hiển thị ở đây...";
  document.getElementById("api-stats-area").innerHTML = "";
  apiCurrentJson = null;
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
