---
title: "🎈 Test Case"
description: "Form tạo Test Case chuẩn template công nghiệp. Hỗ trợ nhiều loại test, auto-generate test ID, và export nhanh."
---

# ✅ Test Case Generator

Công cụ tạo Test Case chuẩn template. Điền thông tin, tự động generate Test ID, và copy nhanh để paste vào TestRail, Zephyr, hoặc hệ thống quản lý test case.

<div id="testcase-root">
<style>
.testcase-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.testcase-form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  margin-bottom: 1rem;
}
.testcase-form-group {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}
.testcase-form-group.full-width {
  grid-column: 1 / -1;
}
.testcase-form-group label {
  font-size: 0.85rem;
  font-weight: 600;
}
.testcase-form-group input,
.testcase-form-group select,
.testcase-form-group textarea {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: var(--font-body), system-ui, sans-serif;
  font-size: 0.9rem;
}
.testcase-form-group textarea {
  min-height: 60px;
  font-family: monospace;
  font-size: 0.85rem;
}
.testcase-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
  align-items: center;
}
.testcase-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.testcase-controls button:hover {
  opacity: 0.9;
}
.testcase-controls select {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
}
.testcase-preview {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 200px;
  max-height: 500px;
  overflow-y: auto;
  font-family: monospace;
  font-size: 0.85rem;
  white-space: pre-wrap;
  word-break: break-word;
  line-height: 1.6;
  position: relative;
}
.testcase-list {
  margin-top: 1rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 0.5rem;
  max-height: 300px;
  overflow-y: auto;
}
.testcase-list-item {
  padding: 0.5rem;
  border-bottom: 1px solid var(--lightgray);
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.testcase-list-item:last-child {
  border-bottom: none;
}
.testcase-copy-btn {
  position: absolute;
  top: 5px;
  right: 5px;
  padding: 2px 8px;
  font-size: 0.75rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 3px;
  cursor: pointer;
}
.batch-controls {
  margin-top: 1rem;
  padding: 0.75rem;
  background: rgba(0,0,0,0.05);
  border-radius: 4px;
}
</style>

<div class="testcase-container">
  <div class="testcase-form-grid">
    <div class="testcase-form-group">
      <label>Test ID Prefix</label>
      <input type="text" id="tc-prefix" placeholder="TC" value="TC">
    </div>
    <div class="testcase-form-group">
      <label>Test Type</label>
      <select id="tc-type">
        <option value="Functional">Functional</option>
        <option value="UI/UX">UI/UX</option>
        <option value="API">API</option>
        <option value="Performance">Performance</option>
        <option value="Security">Security</option>
        <option value="Regression">Regression</option>
        <option value="Smoke">Smoke</option>
        <option value="Exploratory">Exploratory</option>
      </select>
    </div>
    <div class="testcase-form-group">
      <label>Module / Feature *</label>
      <input type="text" id="tc-module" placeholder="Login, Cart, Checkout...">
    </div>
    <div class="testcase-form-group">
      <label>Priority</label>
      <select id="tc-priority">
        <option value="High">🔴 High</option>
        <option value="Medium" selected>🟡 Medium</option>
        <option value="Low">🟢 Low</option>
      </select>
    </div>
    <div class="testcase-form-group full-width">
      <label>Test Case Title *</label>
      <input type="text" id="tc-title" placeholder="Verify user can login with valid credentials">
    </div>
    <div class="testcase-form-group full-width">
      <label>Pre-conditions</label>
      <textarea id="tc-precondition" placeholder="- User account exists&#10;- User is on login page"></textarea>
    </div>
    <div class="testcase-form-group full-width">
      <label>Test Steps *</label>
      <textarea id="tc-steps" placeholder="1. Open login page&#10;2. Enter valid username&#10;3. Enter valid password&#10;4. Click Login button" style="min-height:100px;"></textarea>
    </div>
    <div class="testcase-form-group full-width">
      <label>Expected Result *</label>
      <textarea id="tc-expected" placeholder="User is redirected to Dashboard page. Welcome message is displayed."></textarea>
    </div>
    <div class="testcase-form-group">
      <label>Test Data</label>
      <input type="text" id="tc-data" placeholder="username: test@test.com, password: Pass123!">
    </div>
    <div class="testcase-form-group">
      <label>Post-conditions</label>
      <input type="text" id="tc-postcondition" placeholder="User session is active">
    </div>
  </div>

  <div class="testcase-controls">
    <button onclick="generateTestCase()">✅ Generate Test Case</button>
    <button onclick="addToList()">➕ Add to List</button>
    <button onclick="exportAll()">📥 Export All</button>
    <button onclick="clearForm()">Xóa Form</button>
    <label style="margin-left:0.5rem;">Format: </label>
    <select id="tc-format">
      <option value="standard">Standard</option>
      <option value="table">Table</option>
      <option value="markdown">Markdown</option>
    </select>
  </div>

  <div class="testcase-preview" id="tc-preview">
    <button class="testcase-copy-btn" onclick="copyTestCase()">Copy</button>
    Preview sẽ hiển thị ở đây...
  </div>

  <div class="batch-controls">
    <strong>📋 Danh sách Test Cases đã tạo:</strong>
    <div class="testcase-list" id="tc-list">
      <p style="color:#999;padding:0.5rem;">Chưa có test case nào. Nhấn "Add to List" để thêm.</p>
    </div>
  </div>
</div>

<script>
let testCaseCounter = 1;
let testCaseList = [];

function generateTestCase() {
  const format = document.getElementById("tc-format").value;
  const prefix = document.getElementById("tc-prefix").value || 'TC';
  const id = `${prefix}-${String(testCaseCounter).padStart(4, '0')}`;

  const data = {
    id: id,
    type: document.getElementById("tc-type").value,
    module: document.getElementById("tc-module").value || 'N/A',
    priority: document.getElementById("tc-priority").value,
    title: document.getElementById("tc-title").value || 'Untitled',
    precondition: document.getElementById("tc-precondition").value,
    steps: document.getElementById("tc-steps").value,
    expected: document.getElementById("tc-expected").value,
    testData: document.getElementById("tc-data").value,
    postcondition: document.getElementById("tc-postcondition").value
  };

  let output = '';
  if (format === 'standard') {
    output = `Test ID: ${data.id}\n`;
    output += `Type: ${data.type}\n`;
    output += `Module: ${data.module}\n`;
    output += `Priority: ${data.priority}\n`;
    output += `━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n`;
    output += `Title: ${data.title}\n\n`;
    if (data.precondition) output += `Pre-conditions:\n${data.precondition}\n\n`;
    output += `Test Steps:\n${data.steps}\n\n`;
    output += `Expected Result:\n${data.expected}\n`;
    if (data.testData) output += `\nTest Data: ${data.testData}`;
    if (data.postcondition) output += `\nPost-conditions: ${data.postcondition}`;
  } else if (format === 'table') {
    output = `| Field | Value |\n`;
    output += `|-------|-------|\n`;
    output += `| Test ID | ${data.id} |\n`;
    output += `| Title | ${data.title} |\n`;
    output += `| Type | ${data.type} |\n`;
    output += `| Module | ${data.module} |\n`;
    output += `| Priority | ${data.priority} |\n`;
    if (data.precondition) output += `| Pre-conditions | ${data.precondition.replace(/\n/g, '<br>')} |\n`;
    output += `| Steps | ${data.steps.replace(/\n/g, '<br>')} |\n`;
    output += `| Expected | ${data.expected.replace(/\n/g, '<br>')} |\n`;
    if (data.testData) output += `| Test Data | ${data.testData} |\n`;
    if (data.postcondition) output += `| Post-conditions | ${data.postcondition} |\n`;
  } else {
    output = `### ${data.id}: ${data.title}\n\n`;
    output += `- **Type:** ${data.type}\n`;
    output += `- **Module:** ${data.module}\n`;
    output += `- **Priority:** ${data.priority}\n`;
    if (data.precondition) output += `- **Pre-conditions:** ${data.precondition}\n`;
    output += `- **Steps:**\n${data.steps.split('\n').map(s => '  ' + s).join('\n')}\n`;
    output += `- **Expected:** ${data.expected}\n`;
    if (data.testData) output += `- **Test Data:** ${data.testData}\n`;
    if (data.postcondition) output += `- **Post-conditions:** ${data.postcondition}\n`;
  }

  const preview = document.getElementById("tc-preview");
  preview.innerHTML = `<button class="testcase-copy-btn" onclick="copyTestCase()">Copy</button>` + escapeHtml(output);
  return { id, data, output };
}

function addToList() {
  const result = generateTestCase();
  if (!result) return;
  testCaseList.push(result);
  renderList();
  testCaseCounter++;
  // Auto-increment title for batch creation
  document.getElementById("tc-title").value = "";
  document.getElementById("tc-steps").value = "";
  document.getElementById("tc-expected").value = "";
}

function renderList() {
  const listDiv = document.getElementById("tc-list");
  if (testCaseList.length === 0) {
    listDiv.innerHTML = '<p style="color:#999;padding:0.5rem;">Chưa có test case nào.</p>';
    return;
  }
  listDiv.innerHTML = testCaseList.map((tc, i) =>
    `<div class="testcase-list-item">
      <span><strong>${tc.id}</strong> — ${escapeHtml(tc.data.title)}</span>
      <span style="font-size:0.8rem;color:#666;">${tc.data.type} | ${tc.data.priority}</span>
    </div>`
  ).join('');
}

function exportAll() {
  const format = document.getElementById("tc-format").value;
  let allOutput = `# Test Case Export — ${new Date().toISOString().split('T')[0]}\n\n`;
  allOutput += `Total: ${testCaseList.length} test cases\n`;
  allOutput += `━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n`;

  testCaseList.forEach(tc => {
    allOutput += tc.output + '\n\n';
  });

  const preview = document.getElementById("tc-preview");
  preview.innerHTML = `<button class="testcase-copy-btn" onclick="copyTestCase()">Copy All</button>` + escapeHtml(allOutput);
}

function copyTestCase() {
  const preview = document.getElementById("tc-preview");
  const text = preview.innerText.replace('Copy', '').replace('Copy All', '').trim();
  navigator.clipboard.writeText(text).then(() => {
    const btn = preview.querySelector('.testcase-copy-btn');
    if (btn) { btn.textContent = 'Copied!'; setTimeout(() => btn.textContent = 'Copy', 1500); }
  });
}

function clearForm() {
  document.getElementById("tc-title").value = "";
  document.getElementById("tc-precondition").value = "";
  document.getElementById("tc-steps").value = "";
  document.getElementById("tc-expected").value = "";
  document.getElementById("tc-data").value = "";
  document.getElementById("tc-postcondition").value = "";
  document.getElementById("tc-preview").innerHTML = '<button class="testcase-copy-btn" onclick="copyTestCase()">Copy</button>Preview sẽ hiển thị ở đây...';
}

function escapeHtml(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Điền thông tin** Test Case vào form.
2. Nhấn **Generate Test Case** để xem preview.
3. Nhấn **Add to List** để thêm vào danh sách batch (tự động increment Test ID).
4. Chọn **Format** để đổi định dạng output (Standard, Table, Markdown).
5. Nhấn **Export All** để xuất toàn bộ danh sách test cases.
6. Nhấn **Copy** để copy và paste vào hệ thống quản lý test case.

> 💡 **Mẹo:** Dùng công cụ này để tạo nhanh nhiều test cases liên tiếp — sau khi Add to List, form sẽ tự clear fields chính (Title, Steps, Expected) để bạn điền test case tiếp theo.
