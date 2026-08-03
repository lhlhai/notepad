---
description: Tạo dữ liệu giả (fake data) nhanh chóng cho testing. Hỗ trợ tạo names, emails, addresses, phones, credit cards và nhiều loại data khác. Export CSV/JSON.
---

# 🎲 Data Faker

Công cụ tạo dữ liệu giả nhanh chóng cho testing. Tạo hàng loạt fake data với nhiều loại field khác nhau, xuất ra CSV hoặc JSON.

<div id="data-faker-root">
<style>
.data-faker-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.faker-config {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  margin-bottom: 1rem;
}
.faker-config-item {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}
.faker-config-item label {
  font-size: 0.85rem;
  font-weight: 600;
}
.faker-config-item input,
.faker-config-item select {
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: var(--font-body), system-ui, sans-serif;
}
.faker-fields {
  margin-bottom: 1rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
}
.faker-field-row {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
  align-items: center;
}
.faker-field-row input {
  flex: 1;
  padding: 0.4rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-size: 0.85rem;
}
.faker-field-row select {
  width: 180px;
  padding: 0.4rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-size: 0.85rem;
}
.faker-field-row button {
  padding: 0.3rem 0.5rem;
  background: #dc3545;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.8rem;
}
.faker-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}
.faker-controls button {
  padding: 0.5rem 1rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  transition: opacity 0.2s;
}
.faker-controls button:hover {
  opacity: 0.9;
}
.faker-add-btn {
  padding: 0.4rem 0.8rem;
  background: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.85rem;
  margin-bottom: 0.5rem;
}
.faker-output {
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 100px;
  max-height: 500px;
  overflow-y: auto;
  font-family: monospace;
  font-size: 0.8rem;
  white-space: pre-wrap;
  word-break: break-all;
  position: relative;
}
.faker-table {
  width: 100%;
  border-collapse: collapse;
  font-family: monospace;
  font-size: 0.8rem;
}
.faker-table th, .faker-table td {
  border: 1px solid var(--lightgray);
  padding: 4px 8px;
  text-align: left;
}
.faker-table th {
  background: var(--lightgray);
  position: sticky;
  top: 0;
}
.faker-table tr:nth-child(even) {
  background: rgba(0,0,0,0.02);
}
.faker-copy-btn {
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
</style>

<div class="data-faker-container">
  <div class="faker-config">
    <div class="faker-config-item">
      <label>Số lượng records:</label>
      <input type="number" id="faker-count" value="10" min="1" max="1000">
    </div>
    <div class="faker-config-item">
      <label>Ngôn ngữ:</label>
      <select id="faker-locale">
        <option value="en">English</option>
        <option value="vi" selected>Vietnamese</option>
      </select>
    </div>
  </div>

  <div class="faker-fields">
    <label style="font-weight:600;margin-bottom:0.5rem;display:block;"><strong>Fields:</strong></label>
    <button class="faker-add-btn" onclick="addFieldRow()">➕ Thêm Field</button>
    <div id="faker-fields-container">
      <!-- Dynamic field rows -->
    </div>
  </div>

  <div class="faker-controls">
    <button onclick="generateData()">🎲 Generate Data</button>
    <button onclick="exportCSV()">📄 Export CSV</button>
    <button onclick="exportJSON()">📦 Export JSON</button>
    <button onclick="clearFaker()">Xóa</button>
  </div>

  <div class="faker-output" id="faker-output">
    <button class="faker-copy-btn" onclick="copyFakerData()">Copy</button>
    Kết quả sẽ hiển thị ở đây...
  </div>
</div>

<script>
const fieldTypes = {
  firstName: { label: 'First Name', generate: (locale) => locale === 'vi' ? randomFrom(['Anh','Binh','Chi','Dung','Em','Giang','Hoa','Huong','Khanh','Lan','Mai','Nam','Phong','Quynh','Thao','Tuan','Vy','Xuan']) : randomFrom(['John','Jane','Mike','Sarah','David','Emily','James','Lisa','Robert','Jennifer','Michael','Emma']) },
  lastName: { label: 'Last Name', generate: (locale) => locale === 'vi' ? randomFrom(['Nguyen','Tran','Le','Pham','Hoang','Phan','Vu','Dang','Bui','Do','Vo','Ngô']) : randomFrom(['Smith','Johnson','Williams','Brown','Jones','Garcia','Miller','Davis','Rodriguez','Martinez']) },
  fullName: { label: 'Full Name', generate: (locale) => locale === 'vi' ? 'Nguyen Van ' + randomFrom(['Anh','Binh','Chi','Dung','Em','Hoa','Khanh','Lan','Mai','Nam']) : randomFrom(['John Smith','Jane Doe','Mike Johnson','Sarah Williams','David Brown']) },
  email: { label: 'Email', generate: () => { const names = ['john','jane','mike','sarah','alex','emma','test','user']; const domains = ['gmail.com','yahoo.com','outlook.com','hotmail.com','company.test']; return randomFrom(names) + Math.floor(Math.random()*9999) + '@' + randomFrom(domains); } },
  phone: { label: 'Phone', generate: (locale) => locale === 'vi' ? '0' + randomFrom(['3','5','7','8','9']) + Math.floor(Math.random()*100000000).toString().padStart(8,'0') : '+1(' + Math.floor(Math.random()*900+100) + ')' + Math.floor(Math.random()*900+100) + '-' + Math.floor(Math.random()*9000+1000) },
  address: { label: 'Address', generate: (locale) => locale === 'vi' ? Math.floor(Math.random()*999+1) + ' ' + randomFrom(['Nguyen Hue','Le Loi','Tran Hung Dao','Pham Ngoc Thach','Vo Van Tan']) + ', Quan ' + Math.floor(Math.random()*12+1) : Math.floor(Math.random()*9999+1) + ' ' + randomFrom(['Main St','Oak Ave','Elm St','Park Rd','Lake Dr']) + ', ' + randomFrom(['New York','Los Angeles','Chicago','Houston','Phoenix']) },
  city: { label: 'City', generate: (locale) => locale === 'vi' ? randomFrom(['Ha Noi','Ho Chi Minh','Da Nang','Hai Phong','Can Tho','Nha Trang','Da Lat','Hue']) : randomFrom(['New York','Los Angeles','Chicago','Houston','Phoenix','Philadelphia']) },
  country: { label: 'Country', generate: () => randomFrom(['Vietnam','United States','Japan','Singapore','Australia','Germany','France','Canada']) },
  password: { label: 'Password', generate: () => { const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%'; let p = ''; for(let i=0;i<Math.floor(Math.random()*8+8);i++) p += chars[Math.floor(Math.random()*chars.length)]; return p; } },
  number: { label: 'Number', generate: () => Math.floor(Math.random()*10000).toString() },
  uuid: { label: 'UUID', generate: () => crypto.randomUUID() },
  date: { label: 'Date', generate: () => { const d = new Date(2020+Math.floor(Math.random()*6), Math.floor(Math.random()*12), Math.floor(Math.random()*28)+1); return d.toISOString().split('T')[0]; } },
  boolean: { label: 'Boolean', generate: () => Math.random() > 0.5 ? 'true' : 'false' },
  status: { label: 'Status', generate: () => randomFrom(['active','inactive','pending','deleted','archived']) },
  role: { label: 'Role', generate: () => randomFrom(['admin','user','moderator','editor','viewer','guest']) },
  creditCard: { label: 'Credit Card', generate: () => { const types = ['4','5','3']; const prefix = randomFrom(types); let num = prefix; for(let i=0;i<15;i++) num += Math.floor(Math.random()*10); return num.replace(/(.{4})/g, '$1 ').trim(); } },
  ipAddress: { label: 'IP Address', generate: () => Math.floor(Math.random()*256)+'.'+Math.floor(Math.random()*256)+'.'+Math.floor(Math.random()*256)+'.'+Math.floor(Math.random()*256) },
  url: { label: 'URL', generate: () => 'https://' + randomFrom(['example','test','demo','sample']) + '.com/' + randomFrom(['api','users','products','orders','auth']) + '/' + Math.floor(Math.random()*1000) },
  lorem: { label: 'Lorem Text', generate: () => { const words = ['lorem','ipsum','dolor','sit','amet','consectetur','adipiscing','elit','sed','do','eiusmod','tempor']; let text = ''; for(let i=0;i<Math.floor(Math.random()*10+5);i++) text += words[Math.floor(Math.random()*words.length)] + ' '; return text.trim(); } },
  custom: { label: 'Custom (random string)', generate: () => Math.random().toString(36).substring(2, 15) }
};

let fieldCounter = 0;

function addFieldRow(fieldName = '', fieldType = 'firstName') {
  fieldCounter++;
  const container = document.getElementById("faker-fields-container");
  const row = document.createElement("div");
  row.className = "faker-field-row";
  row.id = `field-row-${fieldCounter}`;

  let typeOptions = Object.entries(fieldTypes).map(([key, val]) =>
    `<option value="${key}" ${key === fieldType ? 'selected' : ''}>${val.label}</option>`
  ).join('');

  row.innerHTML = `
    <input type="text" placeholder="Column name" value="${fieldName}" id="field-name-${fieldCounter}">
    <select id="field-type-${fieldCounter}">${typeOptions}</select>
    <button onclick="removeField(${fieldCounter})">✕</button>
  `;
  container.appendChild(row);
}

function removeField(id) {
  const row = document.getElementById(`field-row-${id}`);
  if (row) row.remove();
}

function generateData() {
  const count = parseInt(document.getElementById("faker-count").value) || 10;
  const locale = document.getElementById("faker-locale").value;
  const rows = document.querySelectorAll(".faker-field-row");

  if (rows.length === 0) {
    document.getElementById("faker-output").innerHTML = '<button class="faker-copy-btn" onclick="copyFakerData()">Copy</button><span style="color:#dc3545;">Vui lòng thêm ít nhất 1 field!</span>';
    return;
  }

  const fields = [];
  rows.forEach(row => {
    const nameInput = row.querySelector('input');
    const typeSelect = row.querySelector('select');
    const name = nameInput.value || typeSelect.options[typeSelect.selectedIndex].text;
    fields.push({ name, type: typeSelect.value });
  });

  const data = [];
  for (let i = 0; i < count; i++) {
    const record = {};
    fields.forEach(f => {
      record[f.name] = fieldTypes[f.type].generate(locale);
    });
    data.push(record);
  }

  // Display as table
  let html = '<table class="faker-table"><thead><tr>';
  fields.forEach(f => html += `<th>${escapeHtml(f.name)}</th>`);
  html += '</tr></thead><tbody>';
  data.forEach(record => {
    html += '<tr>';
    fields.forEach(f => html += `<td>${escapeHtml(record[f.name])}</td>`);
    html += '</tr>';
  });
  html += '</tbody></table>';

  const output = document.getElementById("faker-output");
  output.innerHTML = `<button class="faker-copy-btn" onclick="copyFakerData()">Copy</button>` + html;
  output.dataset.jsonData = JSON.stringify(data, null, 2);
  output.dataset.csvData = generateCSV(data, fields);
}

function generateCSV(data, fields) {
  let csv = fields.map(f => f.name).join(',') + '\n';
  data.forEach(record => {
    csv += fields.map(f => {
      let val = record[f.name] || '';
      if (val.includes(',') || val.includes('"')) val = '"' + val.replace(/"/g, '""') + '"';
      return val;
    }).join(',') + '\n';
  });
  return csv;
}

function exportCSV() {
  const output = document.getElementById("faker-output");
  const csv = output.dataset.csvData;
  if (!csv) { alert("Vui lòng generate data trước!"); return; }
  output.innerHTML = `<button class="faker-copy-btn" onclick="copyFakerData()">Copy</button>` + escapeHtml(csv);
}

function exportJSON() {
  const output = document.getElementById("faker-output");
  const json = output.dataset.jsonData;
  if (!json) { alert("Vui lòng generate data trước!"); return; }
  output.innerHTML = `<button class="faker-copy-btn" onclick="copyFakerData()">Copy</button>` + escapeHtml(json);
}

function copyFakerData() {
  const output = document.getElementById("faker-output");
  const text = output.innerText.replace('Copy', '').trim();
  navigator.clipboard.writeText(text).then(() => {
    const btn = output.querySelector('.faker-copy-btn');
    if (btn) { btn.textContent = 'Copied!'; setTimeout(() => btn.textContent = 'Copy', 1500); }
  });
}

function randomFrom(arr) { return arr[Math.floor(Math.random() * arr.length)]; }

function clearFaker() {
  document.getElementById("faker-fields-container").innerHTML = "";
  document.getElementById("faker-output").innerHTML = '<button class="faker-copy-btn" onclick="copyFakerData()">Copy</button>Kết quả sẽ hiển thị ở đây...';
  fieldCounter = 0;
  addFieldRow('first_name', 'firstName');
  addFieldRow('last_name', 'lastName');
  addFieldRow('email', 'email');
  addFieldRow('phone', 'phone');
}

function escapeHtml(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

// Initialize with default fields
addFieldRow('first_name', 'firstName');
addFieldRow('last_name', 'lastName');
addFieldRow('email', 'email');
addFieldRow('phone', 'phone');
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Cấu hình** số lượng records và ngôn ngữ (Vietnamese/English).
2. **Thêm/Xóa Fields** — chọn loại data cho mỗi column (Name, Email, Phone, UUID...).
3. Nhấn **Generate Data** để tạo dữ liệu giả.
4. Nhấn **Export CSV** hoặc **Export JSON** để đổi định dạng xuất.
5. Nhấn **Copy** để copy data.

> 💡 **Mẹo:** Dùng công cụ này khi cần chuẩn bị test data cho form filling, database seeding, hoặc test scenarios yêu cầu nhiều user records khác nhau.
