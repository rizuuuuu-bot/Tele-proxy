# healthcheck.py
from http.server import BaseHTTPRequestHandler, HTTPServer

class HealthCheckHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"OK")

httpd = HTTPServer(("", 10000), HealthCheckHandler)
httpd.serve_forever()
