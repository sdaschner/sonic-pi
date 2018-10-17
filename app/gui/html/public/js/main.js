var host = document.location.hostname;

var oscPort = new osc.WebSocketPort({
    url: "ws://" + host + ":4558",
    metadata: true
});

var editor = CodeMirror.fromTextArea(document.getElementById("code-editor"), {
    mode: "text/x-ruby",
    tabMode: "indent",
    matchBrackets: true,
    indentUnit: 2,
    lineNumbers: true,
    value: "#code-editor"
});

var buttons = new Vue({
  el: '#buttons',
    methods: {
        runCode: function () {
            document.getElementById("audio").setAttribute("autoplay", "autoplay");
            oscPort.send({
                address: "/run-code",
                args: [
                    {
                        type: "s",
                        value: "websocket-gui"
                    },
                    {
                        type: "s",
                        value: editor.getValue()
                    },

                ]
            });
        },

        stopCode: function () {
            oscPort.send({
                address: "/stop-all-jobs",
                args: [
                    {
                        type: "s",
                        value: "websocket-gui"
                    }
                ]
            });
        }
    }
})


var debug_log = new Vue({
    el: '#debug-log',
    data: {
        logs: [
        ]
    }
})

var info_log = new Vue({
    el: '#info-log',
    data: {
        logs: [
        ]
    }
})

var oscPort = new osc.WebSocketPort({
    url: "ws://" + host + ":4558",
    metadata: true
});

var audioStreaming = new Vue({
    el: '#audio-streaming',
    data: {
        url: "http://" + host + ":8002/sonicpi"
    }
});

oscPort.on("message", function (oscMsg) {
    osc_path = oscMsg.address;
    osc_args = oscMsg.args.map(x => x.value);

    debug_log.logs.push(osc_path + ", " + JSON.stringify(osc_args));

    switch(osc_path) {
    case "/log/info":
        info_log.logs.push(JSON.stringify(osc_args[1]));
        break;
    case "/buffer/replace":
        editor.setValue(osc_args[1]);
        break;
    }
});

oscPort.open();
