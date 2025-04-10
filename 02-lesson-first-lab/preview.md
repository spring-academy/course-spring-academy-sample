## Preview Section TestTest of a preview.

Does it show up?

### Some stuff here

The Makefile Tools extension process of configuring your project is about to run 'make --dry-run' in order to parse the output for useful information. This is needed to calculate accurate IntelliSense and targets information. Although in general 'make --dry-run' only lists (without executing) the operations 'make' would do in the current context, it is still possible some code to be executed, like $(shell) syntax in the makefile or recursive invocations of the $(MAKE) variable.
If you don't feel comfortable allowing this configure process and 'make --dry-run' to be invoked by the extension, you can chose a recent full, clean, verbose and up-to-date build log as an alternative, via the setting 'makefile.buildLog'.
