import sys
import json
from PIL import Image
from io import BytesIO
from mpd import MPDClient

from mpd.base import CommandError

def write_json(json_object, path):
    with open(path, "w+") as f:
        f.write(json.dumps(json_object, indent=4))

class Client:
    def __init__(self):
        self.client = MPDClient()
        self.client.timeout = 10
        self.client.idletimeout = None
        self.client.connect("localhost", 6600)

        print("MPD Client Running")

    def get_currentsong(self):
        self.client.command_list_ok_begin()
        self.client.currentsong()
        output = self.client.command_list_end()[0]

        data = {}
        data["file"] = output["file"]
        data["album"] = output["album"]
        data["albumartist"] = output["albumartist"]
        data["artist"] = output["artist"]
        data["title"] = output["title"]
        return data

    def idle_update(self):
        currentsong = self.get_currentsong()
        write_json(currentsong, sys.argv[2])
    
        cover_art = self.client.albumart(currentsong["file"])
        if "binary" not in cover_art:
            print("No embedded cover art")

        with Image.open(BytesIO(cover_art["binary"])) as img:
            img.save(sys.argv[3], format="PNG")

    def idle_mode(self):
        self.idle_update()
        while True:
            changed = self.client.idle()
            if "player" in changed:
                self.idle_update()

    def disconnect(self):
        self.client.disconnect()
        print("MPD Client Disconnected")


if __name__ == "__main__":
    client = Client()

    match sys.argv[1]:
        case "idle":
            client.idle_mode()


    client.disconnect()

    # client = MPDClient()
    # client.connect("localhost", 6600)

    # currentsong = client.currentsong()
    #
    # pretty = json.dumps(currentsong, indent=4)
    # print(client.find("any", "var"))

    # print(currentsong["file"])
    # print(client.albumart(currentsong["file"]).keys())

    # client.disconnect()

