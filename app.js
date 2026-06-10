const app = document.getElementById('app');

// Cấu hình Mermaid
mermaid.initialize({ 
    startOnLoad: false, 
    theme: 'default',
    securityLevel: 'loose'
});

// Cấu hình Marked
marked.setOptions({
    breaks: true,
    gfm: true
});

// Router đơn giản dựa trên Hash URL
function router() {
    const hash = window.location.hash;
    if (!hash || hash === '#') {
        renderHome();
    } else if (hash.startsWith('#note/')) {
        const noteId = hash.split('/')[1];
        renderNoteDetail(noteId);
    } else {
        renderHome();
    }
}

// Render Trang chủ (Danh sách Card)
async function renderHome() {
    app.innerHTML = `
        <div class="flex justify-center items-center h-64">
            <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>`;
    
    try {
        const response = await fetch('notes.json');
        const notes = await response.json();
        
        let html = `
            <div class="max-w-5xl mx-auto p-6">
                <header class="mb-10 text-center">
                    <h1 class="text-4xl font-bold text-gray-800 mb-2">📚 My Notepad</h1>
                    <p class="text-gray-500 mb-6">Kho lưu trữ kiến thức cá nhân (Readonly)</p>
                    <div class="max-w-md mx-auto relative">
                        <input type="text" id="search-input" placeholder="Tìm kiếm ghi chú..." 
                            class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition-all shadow-sm bg-white">
                        <svg class="w-5 h-5 text-gray-400 absolute right-3 top-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                    </div>
                </header>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="notes-grid">
        `;
        
        notes.forEach(note => {
            html += `
                <a href="#note/${note.id}" class="note-card block bg-white rounded-xl shadow-sm hover:shadow-lg hover:-translate-y-1 transition-all duration-300 border border-gray-100 p-6 group">
                    <h2 class="text-xl font-semibold text-gray-800 mb-2 group-hover:text-blue-600 transition-colors">${note.title}</h2>
                    <p class="text-gray-600 text-sm line-clamp-3 leading-relaxed">${note.description}</p>
                    <div class="mt-4 flex items-center text-blue-500 text-sm font-medium">
                        Xem chi tiết 
                        <svg class="w-4 h-4 ml-1 transform group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                    </div>
                </a>
            `;
        });
        
        html += `</div></div>`;
        app.innerHTML = html;
        
        // Xử lý logic tìm kiếm
        document.getElementById('search-input').addEventListener('input', (e) => {
            const keyword = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.note-card');
            cards.forEach(card => {
                const title = card.querySelector('h2').textContent.toLowerCase();
                const desc = card.querySelector('p').textContent.toLowerCase();
                card.style.display = (title.includes(keyword) || desc.includes(keyword)) ? 'block' : 'none';
            });
        });
        
    } catch (error) {
        app.innerHTML = `<div class="text-center text-red-500 mt-10">Lỗi tải danh sách note: ${error.message}</div>`;
    }
}

// Render Chi tiết Note
async function renderNoteDetail(noteId) {
    app.innerHTML = `
        <div class="flex justify-center items-center h-64">
            <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>`;
    
    try {
        const response = await fetch('notes.json');
        const notes = await response.json();
        const note = notes.find(n => n.id === noteId);
        
        if (!note) {
            app.innerHTML = `
                <div class="max-w-3xl mx-auto p-6 text-center">
                    <h2 class="text-2xl font-bold text-gray-800 mb-4">Không tìm thấy ghi chú!</h2>
                    <a href="#" class="text-blue-600 hover:underline">← Quay lại trang chủ</a>
                </div>`;
            return;
        }
        
        const mdResponse = await fetch(note.file);
        const mdText = await mdResponse.text();
        
        // Render Markdown
        const htmlContent = marked.parse(mdText);
        
        let html = `
            <div class="max-w-4xl mx-auto p-6">
                <a href="#" class="inline-flex items-center text-gray-600 hover:text-blue-600 mb-6 transition-colors font-medium">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                    Quay lại danh sách
                </a>
                <article class="bg-white rounded-xl shadow-sm border border-gray-100 p-8 markdown-body">
                    ${htmlContent}
                </article>
            </div>
        `;
        
        app.innerHTML = html;
        
        // Trigger Mermaid render cho các block <code class="language-mermaid">
        mermaid.run({
            querySelector: '.language-mermaid'
        }).then(() => {
            addCopyButtonsToCodeBlocks();
        });
        
    } catch (error) {
        app.innerHTML = `<div class="max-w-3xl mx-auto p-6 text-center text-red-500">Lỗi tải nội dung note: ${error.message}</div>`;
    }
}

// Hàm tự động thêm nút Copy vào các block code
function addCopyButtonsToCodeBlocks() {
    // Tìm tất cả các thẻ <pre> chứa <code>
    const preBlocks = document.querySelectorAll('pre');
    
    preBlocks.forEach(pre => {
        const code = pre.querySelector('code');
        if (!code) return;

        // Đảm bảo thẻ pre có position relative để nút copy absolute hoạt động đúng
        pre.style.position = 'relative';
        pre.classList.add('group'); // Để dùng hiệu ứng hover của Tailwind

        // Tạo nút Copy
        const copyBtn = document.createElement('button');
        copyBtn.className = 'copy-btn absolute top-2 right-2 flex items-center gap-1.5 px-2.5 py-1.5 text-xs font-medium text-gray-400 bg-gray-800/90 hover:bg-gray-700 hover:text-white rounded-md opacity-0 group-hover:opacity-100 transition-all duration-200 backdrop-blur-sm shadow-sm z-10';
        
        // Icon clipboard + Text
        copyBtn.innerHTML = `
            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
            </svg>
            <span>Copy</span>
        `;

        // Xử lý sự kiện click
        copyBtn.addEventListener('click', async () => {
            try {
                // Lấy nội dung text thuần, loại bỏ các ký tự thừa
                const textToCopy = code.innerText;
                await navigator.clipboard.writeText(textToCopy);
                
                // Đổi trạng thái nút thành "Copied!"
                copyBtn.innerHTML = `
                    <svg class="w-3.5 h-3.5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span class="text-green-400">Copied!</span>
                `;
                copyBtn.classList.add('bg-gray-900');

                // Trả lại trạng thái cũ sau 2 giây
                setTimeout(() => {
                    copyBtn.innerHTML = `
                        <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                        </svg>
                        <span>Copy</span>
                    `;
                    copyBtn.classList.remove('bg-gray-900');
                }, 2000);
            } catch (err) {
                console.error('Failed to copy text: ', err);
                copyBtn.querySelector('span').innerText = 'Error';
            }
        });

        // Gắn nút vào thẻ <pre>
        pre.appendChild(copyBtn);
    });
}

// Lắng nghe sự kiện thay đổi URL và load ban đầu
window.addEventListener('hashchange', router);
window.addEventListener('DOMContentLoaded', router);
