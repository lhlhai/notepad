---
title: "🎨 JSON Diff"
description: "So sánh hai JSON object, highlight sự khác biệt về cấu trúc và giá trị. Hữu ích khi kiểm tra API response trước/sau khi deploy."
---

# 🔀 JSON Diff

Công cụ so sánh hai JSON object và làm nổi bật những điểm khác biệt. Dán hai JSON vào ô bên dưới để xem kết quả.

<div id="json-diff-root">
<style>
.json-diff-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.json-diff-inputs {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
}
.json-diff-inputs > div {
  flex: 1;
}
.json-diff-inputs textarea {
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
.json-diff-controls {
  margin-bottom: 1rem;
  display: flex;
  gap: 0.5rem;
  align-items: center;
}
.json-diff-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.json-diff-controls button:hover {
  opacity: 0.9;
}
.json-diff-output {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 100px;
  max-height: 600px;
  overflow-y: auto;
  font-family: monospace;
  font-size: 0.85rem;
  white-space: pre-wrap;
  word-break: break-all;
}
.diff-key-added { color: #28a745; font-weight: bold; }
.diff-key-removed { color: #dc3545; font-weight: bold; text-decoration: line-through; }
.diff-value-changed { color: #ffc107; font-weight: bold; }
.diff-same { color: var(--dark); }
.diff-summary {
  background: rgba(0,0,0,0.05);
  padding: 0.75rem;
  border-radius: 4px;
  margin-bottom: 0.5rem;
  font-weight: 600;
}
.diff-summary .added { color: #28a745; }
.diff-summary .removed { color: #dc3545; }
.diff-summary .changed { color: #d39e00; }
</style>

<div class="json-diff-container">
  <div class="json-diff-inputs">
    <div>
      <label for="json1"><strong>JSON gốc (Expected):</strong></label>
      <textarea id="json1" placeholder='{"name":"John","age":30}'>{"name":"John","age":30,"city":"Hanoi"}</textarea>
    </div>
    <div>
      <label for="json2"><strong>JSON mới (Actual):</strong></label>
      <textarea id="json2" placeholder='{"name":"John","age":31}'>{"name":"John","age":31,"city":"Ho Chi Minh","email":"john@test.com"}</textarea>
    </div>
  </div>
  <div class="json-diff-controls">
    <button onclick="compareJSON()">🔀 So sánh JSON</button>
    <button onclick="swapJSON()">🔄 Hoán đổi</button>
    <button onclick="clearJSONDiff()">Xóa</button>
  </div>
  <div class="json-diff-output" id="json-diff-output">Kết quả so sánh sẽ hiển thị ở đây...</div>
</div>

<script>
function compareJSON() {
  const json1Str = document.getElementById("json1").value;
  const json2Str = document.getElementById("json2").value;
  const output = document.getElementById("json-diff-output");

  let obj1, obj2;
  try {
    obj1 = JSON.parse(json1Str);
  } catch (e) {
    output.innerHTML = `<span style="color:#dc3545;">❌ JSON gốc không hợp lệ: ${e.message}</span>`;
    return;
  }
  try {
    obj2 = JSON.parse(json2Str);
  } catch (e) {
    output.innerHTML = `<span style="color:#dc3545;">❌ JSON mới không hợp lệ: ${e.message}</span>`;
    return;
  }

  let stats = { added: 0, removed: 0, changed: 0, same: 0 };
  let html = "";

  function diffObjects(o1, o2, indent = 0) {
    const prefix = "  ".repeat(indent);
    const keys1 = Object.keys(o1);
    const keys2 = Object.keys(o2);
    const allKeys = [...new Set([...keys1, ...keys2])];
    allKeys.sort();

    let lines = [];
    lines.push(`${prefix}{`);

    for (const key of allKeys) {
      const hasIn1 = o1.hasOwnProperty(key);
      const hasIn2 = o2.hasOwnProperty(key);
      const k = JSON.stringify(key);

      if (hasIn1 && hasIn2) {
        const v1 = o1[key];
        const v2 = o2[key];
        if (typeof v1 === 'object' && v1 !== null && typeof v2 === 'object' && v2 !== null && !Array.isArray(v1) && !Array.isArray(v2)) {
          lines.push(`${prefix}  ${k}: `);
          const subDiff = diffObjects(v1, v2, indent + 2);
          lines.push(subDiff.lines.join('\n'));
          stats = { added: stats.added + subDiff.added, removed: stats.removed + subDiff.removed, changed: stats.changed + subDiff.changed, same: stats.same + subDiff.same };
        } else if (JSON.stringify(v1) === JSON.stringify(v2)) {
          stats.same++;
          lines.push(`<span class="diff-same">${prefix}  ${k}: ${JSON.stringify(v1)}</span>`);
        } else {
          stats.changed++;
          lines.push(`<span class="diff-value-changed">${prefix}  ${k}: ${JSON.stringify(v1)} → ${JSON.stringify(v2)}</span>`);
        }
      } else if (hasIn1 && !hasIn2) {
        stats.removed++;
        lines.push(`<span class="diff-key-removed">${prefix}  ${k}: ${JSON.stringify(o1[key])} (removed)</span>`);
      } else {
        stats.added++;
        lines.push(`<span class="diff-key-added">${prefix}  ${k}: ${JSON.stringify(o2[key])} (added)</span>`);
      }
    }

    lines.push(`${prefix}}`);
    return { lines, added: stats.added, removed: stats.removed, changed: stats.changed, same: stats.same };
  }

  const result = diffObjects(obj1, obj2);
  html += `<div class="diff-summary">📊 Tổng kết: <span class="added">+${stats.added} thêm</span> | <span class="removed">-${stats.removed} xóa</span> | <span class="changed">~${stats.changed} thay đổi</span> | ✅ ${stats.same} giống nhau</div>`;
  html += `<div>${result.lines.join('\n')}</div>`;
  output.innerHTML = html;
}

function swapJSON() {
  const el1 = document.getElementById("json1");
  const el2 = document.getElementById("json2");
  const temp = el1.value;
  el1.value = el2.value;
  el2.value = temp;
}

function clearJSONDiff() {
  document.getElementById("json1").value = "";
  document.getElementById("json2").value = "";
  document.getElementById("json-diff-output").innerHTML = "Kết quả so sánh sẽ hiển thị ở đây...";
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Dán JSON gốc** (Expected) vào ô bên trái và **JSON mới** (Actual) vào ô bên phải.
2. Nhấn **So sánh JSON** để xem kết quả.
3. Kết quả sẽ highlight:
   - 🟢 **Xanh lá**: Keys/Values được thêm mới
   - 🔴 **Đỏ gạch ngang**: Keys/Values bị xóa
   - 🟡 **Vàng**: Values bị thay đổi
   - ⚫ **Đen**: Không thay đổi

> 💡 **Mẹo:** Dùng công cụ này khi so sánh API response trước và sau khi deploy, hoặc kiểm tra sự khác biệt giữa các version dữ liệu.
