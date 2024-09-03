const myLabel = Widget.Label({
    label: 'some example content',
})

const myBar = Widget.Window({
    name: 'bar',
    anchor: ['top', 'left', 'right'],
    child: myLabel,
})

App.config({ windows: [myBar] })
