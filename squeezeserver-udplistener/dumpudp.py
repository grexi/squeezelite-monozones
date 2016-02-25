import socket
import re
import os
import json

UDP_IP = "0.0.0.0"
UDP_PORT = 3639

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

players = {}
while True:
    data, addr = sock.recvfrom(1024) # buffer size is 1024 bytes
    data = data.decode("latin-1").encode("utf-8")
    if "output.state" in data:
		source = re.search("source=(.*)",data)
		state = re.search("State=(.*)", data)
		
		players[source.group(1)] = state.group(1)
		print json.dumps(players, indent=2)
