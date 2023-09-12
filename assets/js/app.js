// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
// SCOTT comment 
// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
//SCOTT START
//import Alpine from "alpinejs";
// scott import Alpine from "alpinejs"
//import Alpine from "alpinejs"
//import "alpinejs"
// SCOTT END

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

// comment by scott let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// coommnet scott let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
//SCOTT NEW ALPINEa
// SCOTT indow.Alpine = Alpine;
// scott Alpine.start();
let hooks = {};
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: hooks,
  dom: {
    onBeforeElUpdated(from, to) {
      if (from._x_dataStack) {
        window.Alpine.clone(from, to);
      }
    },
  },
});
// ENDALPINE
// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function demo() {
  let curr_article = $(".article-number.active");
  let delaytime = $(curr_article).data('delaytime');
  await sleep(delaytime * 1000);
  showNext();
  console.log('Done');
}

$(function(){
  $(".next-btn").on('click', showNext);
  $(".prev-btn").on('click', showPrevious);
  demo();
})


function showPrevious() {
  let curr_article = $(".article-number.active");
  let prev;
  if (curr_article.is(":first-child")) {
    prev = curr_article.closest(".columns").children().last();
  }else {
    prev = curr_article.prev();
  }
  curr_article.toggleClass("active");
  curr_article.toggleClass("hidden");
  $(prev).toggleClass("hidden");
  $(prev).toggleClass("active");
}


function showNext() {
  let curr_article = $(".article-number.active");
  let next;
  if (curr_article.is(":last-child")) {
    next = curr_article.closest(".columns").children().first();
  }else {
    next = curr_article.next();
  }
  curr_article.toggleClass("active");
  curr_article.toggleClass("hidden");
  $(next).toggleClass("hidden");
  $(next).toggleClass("active");
  demo();
}