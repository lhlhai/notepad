---
title: "🛠️ Manual Templates"
description: "Tổng hợp các mẫu tài liệu dùng hàng ngày."
---

# 📋 Manual Testing: Professional Templates

Tổng hợp các mẫu tài liệu dùng hàng ngày.

## 1. Test Case Template
Copy nội dung này vào Excel hoặc Google Sheets:

```markdown
| Field | Content |
| :--- | :--- |
| **Test Case ID** | TC_XXX |
| **Title** | [Feature] - Action - Expected Result |
| **Pre-condition** | User logged in, account has balance... |
| **Test Steps** | 1. Navigate to... <br> 2. Click on... <br> 3. Input... |
| **Expected Result** | System should display... |
| **Actual Result** | (Fill during execution) |
| **Status** | Pass / Fail / Blocked |
```

## 2. Bug Report Template
Dùng để log bug lên Jira, Trello hoặc GitHub Issues:

```markdown
### [BUG] {Short Summary}
**Environment:** {OS, Browser, App Version}
**Severity:** {Critical/High/Medium/Low}
**Priority:** {P0/P1/P2}

**Steps to Reproduce:**
1. ...
2. ...
3. ...

**Actual Result:**
- {What happened?}

**Expected Result:**
- {What should have happened?}

**Evidence:**
- [Screenshot/Video Link]
- [Console Log/API Response]
```

## 3. Test Summary Report (TSR)
Dùng để báo cáo sau mỗi đợt test:
- **Total Test Cases:** 100
- **Passed:** 90 (90%)
- **Failed:** 5 (5%)
- **Blocked/Skipped:** 5 (5%)
- **Open Bugs:** 2 (1 High, 1 Medium)
- **Conclusion:** Build is stable/unstable for release.

---
> 💡 **AI Prompt Tip:** *"Dựa trên bug report sau, hãy viết lại một cách chuyên nghiệp và súc tích hơn để Dev dễ hiểu: [Dán Bug nháp]"*
