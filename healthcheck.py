from http.server import BaseHTTPRequestHandler, HTTPServer

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
    server_address = ("", 8080)  # 🟢 Changed from 10000 to 8080
    httpd = HTTPServer(server_address, HealthCheckHandler)
    print("Healthcheck server running on port 8080...")
    httpd.serve_forever()
