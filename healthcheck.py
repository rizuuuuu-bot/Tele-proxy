from http.server import BaseHTTPRequestHandler, HTTPServer
import os

class HealthCheckHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/healthz":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"OK")
        else:
            self.send_response(404)
            self.end_headers()

if __name__ == "__main__":
    PORT = int(os.environ.get("PORT", 8080))
    server_address = ("", PORT)
    print(f"Healthcheck server running on port {PORT}...")
    httpd = HTTPServer(server_address, HealthCheckHandler)
    httpd.serve_forever()
