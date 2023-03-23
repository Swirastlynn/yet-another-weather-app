### How do I get set up?

FVM
Install [fvm](https://fvm.app/) on your machine. Project configuration for fvm is in [.fvm/fvm_config.json](.fvm/fvm_config.json). To set up the same Flutter SDK version like the one I was working on, run in your project path: 
```bash
fvm install
``` 

## Testing
How to run tests:
```
flutter test
```

To be able to see the code coverage:
1. Install Coverage Gutters VS plugin
2. Set in your `settings.json` a `"coverage-gutters.showGutterCoverage": true` line to see which lines are test-uncovered. Or `false` to be able to set up breakpoints. There's a bug (13.02.2023) so you can't do both at the same time.

## Before Pull Request

Call 
```
make check
```
from command line. 

The command setup is in the `Makefile` at the root directory. It formats code, calls static analysis, linter, and a few code metrics. If everything is fine, you'll see `GOOD JOB, THE CODE IS SPOTLESS CLEAN AND READY FOR PULL REQUEST!`.