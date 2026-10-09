<script>
    document.addEventListener('DOMContentLoaded', function() {
    educates.register_action({
        name: "x-terminal:focus",
        glyph: "fa-eye",
        args: "yaml",
        title: (args) => {
            let session = args.session || "1"
            let prefix = args.prefix || "Terminal"
            let subject = args.title || `Switch to terminal "${session}"`
            return `${prefix}: ${subject}`
        },
        body: (args) => {
            if (args.description !== undefined)
                return args.description
            return ""
        },
        handler: (args, element, done, fail) => {
            let session = args.session || "1"
            educates.expose_terminal(session)
            setTimeout(function() {
                parent.educates.terminals.sessions[session].focus()
            }, 1000)
            done()
        }
    })
}, false);
</script>

## Focus on specific terminal

### Set `session`

In this example, we let Educates generate the title in the action bar:

Click here to focus on the lower terminal!

```x-terminal:focus
session: 2
```

### Set `title`

In this example, we set the action bar `title` ourselves:

Click here to focus on the upper terminal!

```x-terminal:focus
session: 1
title: Click Here for the Big Terminal
```

### Default

In this final example, we just use the basic action with no other attributes set:

Click here to focus on whatever the default one is!

```x-terminal:focus

Oh also proving that if you put other stuff in the block it's blithely ignored
```
