# 🛠️ Developer Tools, VS Code & Regex

## 1. VS Code Variables
| Biến | Ý nghĩa |
|---|---|
| `${workspaceFolder}` | Đường dẫn tới thư mục chính của workspace |
| `${workspaceFolder:name}` | Đường dẫn tới workspace có tên cụ thể |
| `${file}` | Đường dẫn đầy đủ đến file đang mở |
| `${fileWorkspaceFolder}` | Thư mục workspace chứa file đang mở |
| `${fileDirname}` | Thư mục chứa file đang mở |
| `${fileBasename}` | Tên file (không có đường dẫn) |
| `${fileBasenameNoExtension}` | Tên file không có phần mở rộng |
| `${fileExtname}` | Phần mở rộng của file đang mở |
| `${cwd}` | Current working directory |
| `${lineNumber}` | Dòng hiện tại của con trỏ |
| `${selectedText}` | Văn bản được chọn trong editor |
| `${execPath}` | Đường dẫn đến VS Code executable |
| `${env:NAME}` | Giá trị của biến môi trường NAME |
| `${config:SETTING_ID}` | Giá trị của một cài đặt VS Code |
| `${command:COMMAND_ID}` | Chạy một lệnh và lấy kết quả |

## 2. Regex
### Extract text between 2 strings
**Pattern:** `(?<=abc)(\w+)(?=xyz)`

**Example:** Extract value after `accent-color:` and before `;`
```regex
(?<=accent-color: )(.*)(?=;)
```

### Simple replacement
```regex
^(\w+)_(\w+)=  ---> $1$2=
```

### Match Vietnamese Characters
```regex
[ăâđêôơưĂÂĐÊÔƠƯáàảãạấầẩẫậắằẳẵặéèẻẽẹếềểễệíìỉĩịóòỏõọốồổỗộớờởỡợúùủũụứừửữựýỳỷỹỵ]
```

## 3. Excel VBA
### Delete rows if Column N contains "N"
```vba
Sub DeleteRowWithContents()
    Last = Cells(Rows.Count, "N").End(xlUp).Row
    For i = Last To 1 Step -1
        If (Cells(i, "N").Value) = "N" Then
            ' Cells(i, "N").EntireRow.ClearContents ' Clear contents only
            Cells(i, "N").EntireRow.Delete          ' Delete entire row
        End If
    Next i
End Sub
```

## 4. Markdown & Cheatsheets
- Markdown Cheatsheet: https://gist.github.com/OleksiyRudenko/0a491b2a8841523980c1c283830565a5
- Advanced PR filtering: https://gist.github.com/OleksiyRudenko/6791cf8c77cb7656b58d605948080ad0
- Notepad++ User Defined Languages: https://github.com/notepad-plus-plus/userDefinedLanguages/blob/master/udl-list.md

## 5. UV (Python Package Manager)
- Documentation: https://docs.astral.sh/uv/