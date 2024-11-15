from gi.repository import GLib


def invoke_repeater_threaded(timeout: int, callback: callable, *args):
    def invoke_threaded_repeater():
        ctx = GLib.MainContext.new()
        loop = GLib.MainLoop.new(ctx, False)

        source = GLib.timeout_source_new(timeout)
        source.set_priority(GLib.PRIORITY_LOW)
        source.set_callback(callback, *args)
        source.attach(ctx)

        loop.run()

    GLib.Thread.new(None, invoke_threaded_repeater)