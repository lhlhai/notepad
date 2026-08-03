---
title: 🐛 Bug Report Generator
description: Form tạo Bug Report chuẩn template công nghiệp. Điền thông tin, preview kết quả, và copy nhanh để paste vào Jira/GitHub.
---

# 🐛 Bug Report Generator

Công cụ tạo Bug Report chuẩn template công nghiệp. Điền thông tin vào form, xem preview, và copy nhanh để paste vào Jira, GitHub Issues, hoặc bất kỳ hệ thống nào.

<div id="bug-report-root">
<style>
.bug-report-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.bug-form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  margin-bottom: 1rem;
}
.bug-form-group {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}
.bug-form-group.full-width {
  grid-column: 1 / -1;
}
.bug-form-group label {
  font-size: 0.85rem;
  font-weight: 600;
}
.bug-form-group input,
.bug-form-group select,
.bug-form-group textarea {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: var(--font-body), system-ui, sans-serif;
  font-size: 0.9rem;
}
.bug-form-group textarea {
  min-height: 80px;
  font-family: monospace;
  font-size: 0.85rem;
}
.bug-form-group input::placeholder,
.bug-form-group textarea::placeholder {
  color: #999;
}
.bug-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}
.bug-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.bug-controls button:hover {
  opacity: 0.9;
}
.bug-preview {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 200px;
  max-height: 600px;
  overflow-y: auto;
  font-family: monospace;
  font-size: 0.85rem;
  white-space: pre-wrap;
  word-break: break-word;
  line-height: 1.6;
  position: relative;
}
.bug-severity-high { color: #dc3545; font-weight: bold; }
.bug-severity-medium { color: #ffc107; font-weight: bold; }
.bug-severity-low { color: #28a745; font-weight: bold; }
.bug-copy-btn {
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
.bug-template-selector {
  margin-bottom: 1rem;
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}
.bug-template-btn {
  padding: 0.3rem 0.6rem;
  background: rgba(0,0,0,0.05);
  border: 1px solid var(--gray);
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.8rem;
}
.bug-template-btn:hover {
  background: var(--secondary);
  color: white;
}
</style>

<div class="bug-report-container">
  <div style="margin-bottom:1rem;">
    <label style="font-weight:600;"><strong>📋 Chọn Template:</strong></label>
    <div class="bug-template-selector">
      <button class="bug-template-btn" onclick="loadBugTemplate('standard')">Standard</button>
      <button class="bug-template-btn" onclick="loadBugTemplate('jira')">Jira Format</button>
      <button class="bug-template-btn" onclick="loadBugTemplate('github')">GitHub Issues</button>
      <button class="bug-template-btn" onclick="loadBugTemplate('minimal')">Minimal</button>
    </div>
  </div>

  <div class="bug-form-grid">
    <div class="bug-form-group">
      <label>Tiêu đề Bug *</label>
      <input type="text" id="bug-title" placeholder="Ví dụ: Login button not responding on Chrome">
    </div>
    <div class="bug-form-group">
      <label>Severity *</label>
      <select id="bug-severity">
        <option value="Critical">🔴 Critical</option>
        <option value="High">🟠 High</option>
        <option value="Medium" selected>🟡 Medium</option>
        <option value="Low">🟢 Low</option>
      </select>
    </div>
    <div class="bug-form-group">
      <label>Environment / Browser</label>
      <input type="text" id="bug-environment" placeholder="Chrome 120, Windows 11" value="Chrome, Windows 11">
    </div>
    <div class="bug-form-group">
      <label>Priority</label>
      <select id="bug-priority">
        <option value="P1">P1 - Urgent</option>
        <option value="P2" selected>P2 - High</option>
        <option value="P3">P3 - Medium</option>
        <option value="P4">P4 - Low</option>
      </select>
    </div>
    <div class="bug-form-group">
      <label>Module / Feature</label>
      <input type="text" id="bug-module" placeholder="Authentication, Cart, Dashboard...">
    </div>
    <div class="bug-form-group">
      <label>Assignee / Reporter</label>
      <input type="text" id="bug-reporter" placeholder="Tên người report">
    </div>
    <div class="bug-form-group full-width">
      <label>Môi trường *</label>
      <select id="bug-env-type">
        <option value="Staging" selected>Staging</option>
        <option value="UAT">UAT</option>
        <option value="Production">Production</option>
        <option value="Development">Development</option>
      </select>
    </div>
    <div class="bug-form-group full-width">
      <label>Steps to Reproduce *</label>
      <textarea id="bug-steps" placeholder="1. Mở trang login&#10;2. Nhập username: test@test.com&#10;3. Nhập password: 123456&#10;4. Click nút Login"></textarea>
    </div>
    <div class="bug-form-group full-width">
      <label>Expected Result *</label>
      <textarea id="bug-expected" placeholder="User được chuyển đến Dashboard sau khi login thành công"></textarea>
    </div>
    <div class="bug-form-group full-width">
      <label>Actual Result *</label>
      <textarea id="bug-actual" placeholder="Nút Login không phản hồi, không có thông báo lỗi hiển thị"></textarea>
    </div>
    <div class="bug-form-group full-width">
      <label>Additional Notes / Attachments</label>
      <textarea id="bug-notes" placeholder="Console log, screenshot URL, HAR file..."></textarea>
    </div>
  </div>

  <div class="bug-controls">
    <button onclick="generateBugReport()">🐛 Generate Report</button>
    <button onclick="clearBugForm()">Xóa Form</button>
  </div>

  <div class="bug-preview" id="bug-preview">
    <button class="bug-copy-btn" onclick="copyBugReport()">Copy</button>
    Preview sẽ hiển thị ở đây...
  </div>
</div>

<script>
let currentTemplate = 'standard';

const templates = {
  standard: {
    format: function(data) {
      let report = `🐛 **BUG REPORT**\n`;
      report += `━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n`;
      report += `\n`;
      report += `**Title:** ${data.title}\n`;
      report += `**Severity:** ${data.severity}\n`;
      report += `**Priority:** ${data.priority}\n`;
      report += `**Environment:** ${data.environment}\n`;
      report += `**Module:** ${data.module || 'N/A'}\n`;
      report += `**Reporter:** ${data.reporter || 'N/A'}\n`;
      report += `\n`;
      report += `**Steps to Reproduce:**\n`;
      report += `${data.steps}\n`;
      report += `\n`;
      report += `**Expected Result:**\n`;
      report += `${data.expected}\n`;
      report += `\n`;
      report += `**Actual Result:**\n`;
      report += `${data.actual}\n`;
      if (data.notes) {
        report += `\n`;
        report += `**Notes:**\n`;
        report += `${data.notes}\n`;
      }
      return report;
    }
  },
  jira: {
    format: function(data) {
      let report = `h3. Bug Report: ${data.title}\n\n`;
      report += `||Field||Value||\n`;
      report += `|Severity|${data.severity}|\n`;
      report += `|Priority|${data.priority}|\n`;
      report += `|Environment|${data.environment} (${data.envType})|\n`;
      report += `|Module|${data.module || 'N/A'}|\n`;
      report += `|Reporter|${data.reporter || 'N/A'}|\n\n`;
      report += `h4. Steps to Reproduce\n`;
      report += `# ${data.steps.replace(/\n/g, '\n# ')}\n\n`;
      report += `h4. Expected Result\n${data.expected}\n\n`;
      report += `h4. Actual Result\n${data.actual}\n\n`;
      if (data.notes) {
        report += `h4. Additional Notes\n${data.notes}\n`;
      }
      return report;
    }
  },
  github: {
    format: function(data) {
      let report = `## 🐛 ${data.title}\n\n`;
      report += `### Information\n`;
      report += `- **Severity:** ${data.severity}\n`;
      report += `- **Priority:** ${data.priority}\n`;
      report += `- **Environment:** \`${data.environment}\`\n`;
      report += `- **Environment Type:** ${data.envType}\n`;
      report += `- **Module:** ${data.module || 'N/A'}\n`;
      report += `- **Reporter:** ${data.reporter || 'N/A'}\n\n`;
      report += `### Steps to Reproduce\n`;
      report += `\`\`\`\n${data.steps}\n\`\`\`\n\n`;
      report += `### Expected Behavior\n${data.expected}\n\n`;
      report += `### Actual Behavior\n${data.actual}\n\n`;
      if (data.notes) {
        report += `### Additional Notes\n${data.notes}\n`;
      }
      return report;
    }
  },
  minimal: {
    format: function(data) {
      let report = `BUG: ${data.title}\n`;
      report += `Sev: ${data.severity} | Pri: ${data.priority} | Env: ${data.environment}\n`;
      report += `Steps: ${data.steps}\n`;
      report += `Expected: ${data.expected}\n`;
      report += `Actual: ${data.actual}\n`;
      return report;
    }
  }
};

function loadBugTemplate(name) {
  currentTemplate = name;
  document.querySelectorAll('.bug-template-btn').forEach(btn => {
    btn.style.background = '';
    btn.style.color = '';
  });
  event.target.style.background = 'var(--secondary)';
  event.target.style.color = 'white';
  generateBugReport();
}

function generateBugReport() {
  const data = {
    title: document.getElementById("bug-title").value || 'Untitled Bug',
    severity: document.getElementById("bug-severity").value,
    priority: document.getElementById("bug-priority").value,
    environment: document.getElementById("bug-environment").value || 'N/A',
    envType: document.getElementById("bug-env-type").value,
    module: document.getElementById("bug-module").value,
    reporter: document.getElementById("bug-reporter").value,
    steps: document.getElementById("bug-steps").value || 'N/A',
    expected: document.getElementById("bug-expected").value || 'N/A',
    actual: document.getElementById("bug-actual").value || 'N/A',
    notes: document.getElementById("bug-notes").value
  };

  const template = templates[currentTemplate];
  const report = template.format(data);
  const preview = document.getElementById("bug-preview");
  preview.innerHTML = `<button class="bug-copy-btn" onclick="copyBugReport()">Copy</button>` + escapeHtml(report);
}

function copyBugReport() {
  const preview = document.getElementById("bug-preview");
  const text = preview.innerText.replace('Copy', '').trim();
  navigator.clipboard.writeText(text).then(() => {
    const btn = preview.querySelector('.bug-copy-btn');
    if (btn) { btn.textContent = 'Copied!'; setTimeout(() => btn.textContent = 'Copy', 1500); }
  });
}

function clearBugForm() {
  document.getElementById("bug-title").value = "";
  document.getElementById("bug-environment").value = "Chrome, Windows 11";
  document.getElementById("bug-module").value = "";
  document.getElementById("bug-reporter").value = "";
  document.getElementById("bug-steps").value = "";
  document.getElementById("bug-expected").value = "";
  document.getElementById("bug-actual").value = "";
  document.getElementById("bug-notes").value = "";
  document.getElementById("bug-preview").innerHTML = '<button class="bug-copy-btn" onclick="copyBugReport()">Copy</button>Preview sẽ hiển thị ở đây...';
}

function escapeHtml(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Chọn Template** phù hợp với hệ thống bạn đang dùng (Standard, Jira, GitHub Issues, Minimal).
2. **Điền thông tin** vào form — các field có dấu * là bắt buộc.
3. Nhấn **Generate Report** để xem preview.
4. Nhấn **Copy** để copy toàn bộ report và paste vào Jira/GitHub/Slack.

> 💡 **Mẹo:** Điền sẵn Environment mặc định để tiết kiệm thời gian. Khi gặp bug, chỉ cần điền Title, Steps, Expected/Actual rồi copy paste ngay.
