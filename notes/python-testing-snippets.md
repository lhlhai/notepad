# 🐍 Python & Testing Snippets

## 1. Python Core
### Replace keys in Dictionary
```python
dict_1 = {
    'a_a': 'A',
    'a_b': 'B',
    'a_c': 'C',
    'a_d': 'D'
}
dict_2 = {k.replace('a_', ''): v for k, v in dict_1.items()}
```

### *args and **kwargs
```python
def foo(a, b, *args):
    print('normal arguments', a, b)
    for x in args:
        print('another argument through *args', x)

def foo_kwargs(**kwargs):
    for key, value in kwargs.items():
        print(key, value)

# Unpacking tuple
x = (4, 5, 6)
def foo_abc(a, b, c):
    print("a = %d, b = %d, c = %d" % (a, b, c))
foo_abc(*x)  # a = 4, b = 5, c = 6

# Unpacking dict
def foo_default(a=0, b=1, c=2):
    print(a, b, c)
y = {'c': 3, 'b': 4, 'a': 5}
foo_default(**y)  # 5 4 3
```

### Regex in Python
```python
import re
pattern = re.compile(r'(\d+)x(\d+)')
print_size_temp = re.search(r'-?\d+(?:\.\d+)x\d+(?:\.\d+)', print_size_temp).group()
min_height, min_width = tuple(float(x)*96 for x in print_size_temp.split("x"))

# Extract text between 2 strings
# Pattern: (?<=accent-color: )(.*)(?=;)
```

### Class Inheritance with dynamic properties
```python
class A:
    __info = {}
    __properties = {'prop1', 'prop2'}
    
    def __init__(self, **kwargs):
        self._set_properties(self.__properties, **kwargs)
    
    def _set_properties(self, properties, **kwargs):
        self.__dict__.update((k, None) for k in properties)
        self.__dict__.update((k, v) for k, v in kwargs.items() if k in properties)
    
    @staticmethod
    def get_info(name):
        return A.__info

class B(A):
    __properties = {'prop3'}
    
    def __init__(self, **kwargs):
        A.__init__(self, **kwargs)
        self._set_properties(self.__properties, **kwargs)
```

### Method Inheritance
```python
class C:
    def method_a(self):
        print("Method A")
    
    def method_common(self):
        self.method_a()
        print("Method Common")

class D(C):
    def method_d(self):
        print("Method D")
    
    def method_common(self):
        super().method_common()
        self.method_d()
```

## 2. Testing Frameworks
### Pytest Parallel (xdist)
```bash
pipenv run pytest -d --tx 2*popen//python=C:\\Users\\hailehl\\.virtualenvs\\zTkqNnCB\\Scripts\\python -v -m "<marks>" --alluredir allure-reports
```

### Maven TestNG
```bash
mvn verify -Dsuite="example" -DexcelFile="test.xls" -DexcelSheet="TEST" -DlogDir="report_example"
```

## 3. Python HTTP Server (For SPA)
```python
import http.server
import socketserver
import os

PORT = 8000
DIRECTORY = "dist/your-app/browser"

class SPARequestHandler(http.server.SimpleHTTPRequestHandler):
    def translate_path(self, path):
        path = super().translate_path(path)
        return path

    def do_GET(self):
        if self.path.startswith('/'):
            file_path = os.path.join(DIRECTORY, self.path.lstrip('/'))
            if not os.path.exists(file_path):
                self.path = '/index.html'
        return super().do_GET()

os.chdir(DIRECTORY)
with socketserver.TCPServer(("", PORT), SPARequestHandler) as httpd:
    print(f"Serving at http://localhost:{PORT}")
    httpd.serve_forever()
```

### Simple HTTP server (Quick)
```bash
python -m http.server
```

## 4. MCP Server
```bash
echo '{"method":"tools/list","id":1,"jsonrpc": "2.0"}' | python mcp_server.py
```