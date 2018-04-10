vim-setup
=========

My `NeoVim` setup for Scala & Haskell development.

### [Haskell IDE Engine](https://github.com/haskell/haskell-ide-engine) Troubleshooting on Ubuntu 16 /17

#### Error

```
--  While building package text-icu-0.7.0.1 using: <my obnoxious path info>
    Process exited with code: ExitFailure 1
    Logs have been written to: /Users/jkachmar/src/haskell-ide-engine/.stack-work/logs/text-icu-0.7.0.1.log

    Configuring text-icu-0.7.0.1...
    Cabal-simple_mPHDZzAJ_1.24.2.0_ghc-8.0.2: Missing dependencies on foreign
    libraries:
    * Missing C libraries: icuuc, icui18n, icudata
    This problem can usually be solved by installing the system packages that
    provide these libraries (you may need the "-dev" versions). If the libraries
    are already installed but in a non-standard location then you can use the
    flags --extra-include-dirs= and --extra-lib-dirs= to specify where they are.
```

#### Fix

```
sudo apt install icu-devtools libicu-dev
```

#### Error

```
--  While building custom Setup.hs for package ghc-syb-utils-0.2.3.3 using:
      /home/gvolpe/.stack/setup-exe-cache/x86_64-linux-nopie/Cabal-simple_mPHDZzAJ_2.0.0.2_ghc-8.2.1 --builddir=.stack-work/dist/x86_64-linux-nopie/Cabal-2.0.0.2 build --ghc-options " -ddump-hi -ddump-to-file -fdiagnostics-color=always"
    Process exited with code: ExitFailure 1
    Logs have been written to: /home/gvolpe/development/haskell-ide-engine/.stack-work/logs/ghc-syb-utils-0.2.3.3.log

    Configuring ghc-syb-utils-0.2.3.3...
    Preprocessing library for ghc-syb-utils-0.2.3.3..
    Building library for ghc-syb-utils-0.2.3.3..
    [1 of 1] Compiling GHC.SYB.Utils    ( GHC/SYB/Utils.hs, .stack-work/dist/x86_64-linux-nopie/Cabal-2.0.0.2/build/GHC/SYB/Utils.o )
    /usr/bin/ld.gold: error: cannot find -ltinfo
    collect2: error: ld returned 1 exit status
    `gcc' failed in phase `Linker'. (Exit code: 1)


--  While building custom Setup.hs for package djinn-ghc-0.0.2.3 using:
      /home/gvolpe/.stack/setup-exe-cache/x86_64-linux-nopie/Cabal-simple_mPHDZzAJ_2.0.0.2_ghc-8.2.1 --builddir=.stack-work/dist/x86_64-linux-nopie/Cabal-2.0.0.2 build --ghc-options " -ddump-hi -ddump-to-file -fdiagnostics-color=always"
    Process exited with code: ExitFailure 1
    Logs have been written to: /home/gvolpe/development/haskell-ide-engine/.stack-work/logs/djinn-ghc-0.0.2.3.log

    Configuring djinn-ghc-0.0.2.3...
    Preprocessing library for djinn-ghc-0.0.2.3..
    Building library for djinn-ghc-0.0.2.3..
    [1 of 1] Compiling Djinn.GHC        ( src/Djinn/GHC.hs, .stack-work/dist/x86_64-linux-nopie/Cabal-2.0.0.2/build/Djinn/GHC.o )
    /usr/bin/ld.gold: error: cannot find -ltinfo
    collect2: error: ld returned 1 exit status
    `gcc' failed in phase `Linker'. (Exit code: 1)
Makefile:4: recipe for target 'build' failed
make: *** [build] Error 1
```

#### Fix

```
sudo apt install ghc
stack install cabal-install
```

Also, don't forget to add `~/.local/bin` to your `PATH` if the script doesn't do it automatically.

### [Scala Metals LSP](https://github.com/scalameta/metals) on NeoVim

Some of the instructions are the same as here: https://github.com/scalameta/metals/blob/master/docs/installation.md

#### Add global sbt plugin `MetalsPlugin`

Add the [MetalsPlugin](https://github.com/scalameta/metals/blob/master/project/MetalsPlugin.scala) to your global sbt
plugins:

- (sbt 0.13) `~/.sbt/0.13/plugins/MetalsPlugin.scala`
- (sbt 1.+) `~/.sbt/1.0/plugins/MetalsPlugin.scala`

### Add global sbt plugin `semanticdb-scalac`

Add this to `~/.sbt/1.0/plugins/build.sbt` (or `sbt 0.13`):

```
addCompilerPlugin("org.scalameta" % "semanticdb-scalac" % "2.1.8" cross CrossVersion.full)
scalacOptions += "-Yrangepos"
```

#### Install coursier

```
curl -L -o coursier https://git.io/vgvpD && chmod +x coursier
```

#### Generate scalameta_lsp executable

```
./coursier bootstrap org.scalameta:metaserver_2.12:a212acd7 -r bintray:scalameta/maven -r bintray:dhpcs/maven -M scala.meta.languageserver.Main -o scalameta_lsp -f --standalone
```

Where `a212acd7` is the Git hash version. Find out what the latest version is here: https://bintray.com/scalameta/maven/metaserver

#### Run `scalameta_lsp` using the `LanguageClient` plugin (see [init.vim](init.vim) file)

```
let g:LanguageClient_serverCommands = {
    \ 'scala': ['~/scalameta_lsp'],
    \ }
```

#### At the project level

Start an `sbt` session and run `*:metalsSetup` the first time. Leave the session open and start `NeoVim` in a different
terminal, it should start working as soon as you open a scala file of that project.

#### Features

- [x] Autocompletion on both my source and my dependencies source.
- [x] Jump to definition on both my source and my dependencies source.
- [x] Compiler errors in real time.
- [x] Unused imports warnings in real time.
- [x] Remove unused imports.
- [ ] Auto import from classpath (still no support).
- [ ] Rename functions and variable names (not working).
- [ ] Sort imports (possible by using vim-scala).

