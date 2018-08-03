import "phoenix_html"
import Turbolinks from "turbolinks"
// import { Socket } from "phoenix"

// let socket = new Socket("/socket", {params: {token: window.userToken}})
// socket.connect()

// Now that you are connected, you can join channels with a topic:
// let channel = socket.channel("topic:subtopic", {})

$( document ).ready(function() {
  Turbolinks.start()

  // channel.join()
  // .receive("ok", resp => { console.log("Joined successfully", resp) })
  // .receive("error", resp => { console.log("Unable to join", resp) })
});