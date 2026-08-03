# Tìm ra sự khác biệt giữa Interactive-Toolbox (work) và các tool khác (không work)

## Interactive-Toolbox (ĐANG HOẠT ĐỘNG)
- Frontmatter: KHÔNG CÓ `title:` field, chỉ có `description:`
- Dùng `<div id="qa-toolbox-root">` wrapper
- HTML structure: ĐƠN GIẢN, không có nested complex elements
- Script: Dùng `onclick` attribute trên buttons
- Script content: INLINE trong cùng block `<script>`
- Style: Dùng CSS variables `var(--font-body)`, `var(--dark)`, `var(--secondary)`, `var(--gray)`, `var(--lightgray)`, `var(--light)`, `var(--light)`

## Các tool khác (KHÔNG HOẠT ĐỘNG)
- Frontmatter: CÓ `title:` và `description:`
- Dùng wrapper div với id khác nhau
- HTML structure: PHỨC TẠP hơn - có nested tables, forms, selects
- Script: Dùng `onclick` attribute trên buttons (giống)
- Script content: INLINE trong cùng block `<script>` (giống)

## Điểm nghi ngờ
1. Frontmatter có `title:` field - có thể conflict với Obsidian/Notepad rendering
2. Script có thể bị sandbox hoặc filtered bởi markdown renderer
3. Có thể CSS variables không available trong context các page khác
4. Có thể `<script>` tag bị block trong các page có certain frontmatter

## Kiểm tra thêm
- Toolbox.md file xem có config gì đặc biệt không
