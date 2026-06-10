# 🌐 Web, JavaScript & Browser Automation

## 1. Browser Automation (Playwright & Appium)
### Playwright Setup
```bash
npm init playwright@latest
# Chọn JS, thư mục tests, không cần GitHub Actions

# Các lệnh thông dụng
npx playwright test               # Chạy test
npx playwright test --ui          # Chạy UI Mode
npx playwright test --project=chromium  # Chỉ chạy Chrome
npx playwright test example       # Chạy file cụ thể
npx playwright test --debug       # Debug mode
npx playwright codegen            # Auto generate test
```

### Playwright Multi-environment (.env)
- Tham khảo: https://medium.com/@hbsasithadilshan/executing-playwright-tests-in-multiple-environments-using-env-file-911ce6617182

### Appium: Find Package & Activity
```bash
adb shell dumpsys window windows | grep -E 'mCurrentFocus'
# Output: com.abc.smartoffice/com.abc.omni.mobile.MainActivity
```

### Appium: Launch Activity
```bash
adb shell am start -W -n com.abc.smartoffice/com.abc.omni.mobile.MainActivity -S -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -f 0x10200000
```

## 2. JavaScript DOM & Chrome DevTools
### Get Element by XPath
```javascript
function getElementByXpath(path) {
  return document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
}
console.log(getElementByXpath("//html[1]/body[1]/div[1]"));
```

### Scroll element into view (Selenium/JS)
```javascript
driver.execute_script("arguments[0].scrollIntoView({ behavior: 'auto', block: 'center', inline: 'center' });", element);
```

### Focus Out
```javascript
execute_javascript("document.activeElement.blur()");
```

### Extract Data from Angular Canvas
```javascript
let chart = $0; // Focus element in DevTools
let chartMaps = chart.__ngContext__.filter(item => item && item.data && item.options);
let datasets = chartMaps[0].data.datasets;
let legends = datasets.map(item => item.label);
let data = datasets.map(item => item.data);
```

### OCR Canvas using Tesseract.js
```javascript
const script = document.createElement('script');
script.src = 'https://cdn.jsdelivr.net/npm/tesseract.js';
document.head.appendChild(script);

const canvas = document.querySelector('canvas');
Tesseract.recognize(canvas.toDataURL(), 'eng', {
  logger: (info) => console.log(info)
}).then(({ data: { text } }) => {
  console.log('Extracted Text:', text);
}).catch((err) => {
  console.error('OCR Error:', err);
});
```

### Intercept Network Request & Download CSV
```javascript
function downloadData(filename, data) {
  const file = new File([data], { type: 'text/json' });
  const elem = document.createElement('a');
  elem.href = URL.createObjectURL(file);
  elem.download = filename;
  elem.click();
}

function getCurrentTime() {
  const now = new Date();
  return `${now.getFullYear()}${String(now.getMonth()+1).padStart(2,'0')}${String(now.getDate()).padStart(2,'0')}-${String(now.getHours()).padStart(2,'0')}${String(now.getMinutes()).padStart(2,'0')}`;
}

const request = performance.getEntriesByType("resource").filter(x => x.name.includes('integrationInfo'))[0];
fetch(request.name, {
  method: 'GET',
  headers: {
    'Authorization': `Bearer ${sessionStorage.getItem('nexeed-token')}`,
    'Content-Type': 'application/json'
  }
}).then(response => response.json())
  .then(data => {
    let writeData = "Module,Version\r\n";
    data.registrationIntegrationInfo.forEach(x => {
      writeData += `${x.name},${x.version}\r\n`;
    });
    downloadData(`Integration Status - ${getCurrentTime()}.csv`, writeData);
  })
  .catch(error => console.error('Fetch error:', error));
```

### Debug Event Listener
```javascript
document.addEventListener('keydown', function(event) {
  if (event.key === 'Enter') {
    console.log('Enter key pressed on:', event.target);
    debugger; // Tạm dừng để kiểm tra trong DevTools
  }
});
```

## 3. Chrome Search Engines Scripts
Mở `chrome://settings/searchEngines` hoặc `edge://settings/searchEngines`, mở DevTools Console.

### Export Chrome Search Engines
```javascript
(function exportSEs() {
  function downloadData(filename, data) {
    const file = new File([data], { type: 'text/json' });
    const elem = document.createElement('a');
    elem.href = URL.createObjectURL(file);
    elem.download = filename;
    elem.click();
  }
  let searchEngines = [];
  document.querySelector('settings-ui').shadowRoot
    .querySelector('settings-main').shadowRoot
    .querySelector('settings-basic-page').shadowRoot
    .querySelector('settings-search-page').shadowRoot
    .querySelector('settings-search-engines-page').shadowRoot
    .querySelector('settings-search-engines-list').shadowRoot
    .querySelectorAll('settings-search-engine-entry')
    .forEach($el => searchEngines.push({
      name: $el.shadowRoot.querySelector('#name-column').textContent,
      keyword: $el.shadowRoot.querySelector('#shortcut-column').textContent,
      url: $el.shadowRoot.querySelector('#url-column-padded').textContent
    }));
  downloadData('search_engines.json', JSON.stringify(searchEngines));
}());
```

### Export Edge Search Engines
```javascript
(function exportSEs() {
  function downloadData(filename, data) {
    const file = new File([data], { type: 'text/json' });
    const elem = document.createElement('a');
    elem.href = URL.createObjectURL(file);
    elem.download = filename;
    elem.click();
  }
  let searchEngines = [];
  document.querySelector('div[aria-labelledby*=all-engines-table]')
    .querySelectorAll('div[role=row][data-rowid]')
    .forEach($el => searchEngines.push({
      searchEngine: $el.querySelector('div[data-cellid=searchEngine]>span').textContent,
      keyword: $el.querySelector('div[data-cellid=keyword]>span').textContent,
      url: $el.querySelector('div[data-cellid=url]>span').textContent,
    }));
  downloadData('search_engines.json', JSON.stringify(searchEngines));
}());
```

### Import Search Engines (Chrome/Edge)
```javascript
(async function importSEs() {
  function selectFileToRead() {
    return new Promise((resolve) => {
      const input = document.createElement('input');
      input.setAttribute('type', 'file');
      input.addEventListener('change', (e) => resolve(e.target.files[0]), false);
      input.click();
    });
  }
  function readFile(file) {
    return new Promise((resolve) => {
      const reader = new FileReader();
      reader.addEventListener('load', (e) => resolve(e.target.result));
      reader.readAsText(file