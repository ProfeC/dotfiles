# ProfeC's dotfiles

A repository for diligently handcrafted (_or blatantly copied, in the spirit of open-source_) config files and nifty scripts for my systems.

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove what you don’t want or need. Don’t blindly use my settings unless you want to have EXACTLY what I do. _Use at your own risk!_

## Installation

```dotfiles``` are managed and installed with [dotbot](https://github.com/anishathalye/dotbot). To install these dotfiles simplly clone this repository and run the installation script.

```shell
$ git clone https://github.com/ProfeC/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/install [config file(s)] # chose correct config file for the distribution you're updating
```

#### MacOS

```shell
$ ~/.dotfiles/install macos
```

#### MacOS - Fresh Install

Install Xcode and Xcode Tools from the AppStore. Once that has completed,

```shell
$ ~/.dotfiles/install macos macos-new
```

#### Linux

```shell
$ ~/.dotfiles/install linux
```

#### Arch Linux

```shell
$ ~/.dotfiles/install linux arch
```


### Acknowledgments

_Thanks to **ALL** of the people with dotfiles out there that I've looked at to configure my system(s)._

Inspired by [this article](http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/) and [Dotbot](https://github.com/anishathalye/dotbot). You can [fork](https://github.com/anishathalye/dotfiles_template/fork) Anish Athalye's template if you'd like or take a look at [his dotfiles](https://github.com/anishathalye/dotfiles).

**The following have been extensivley used:**

* [Anish Athalye](https://github.com/anishathalye) and his:
  *  [dotfiles repository](https://github.com/anishathalye/dotfiles)
* [Mathias Bynens](https://github.com/mathiasbynens) and his:
  * [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
  * [Sensible MacOS Defaults](https://github.com/mathiasbynens/dotfiles#sensible-macos-defaults)
* [Samuel Walladge](https://github.com/swalladge) and his:
  *  [dotfiles repository](https://github.com/swalladge/dotfiles) 
  *  parts of his README. 

----

###### This repository contains both original and third party content.

<sub>Content can be assumed to be original unless stated otherwise. All third party content is copyright their respective authors and bound by their original licenses.</sub>

<sub>Attempts have been made to identify third party content within the repository, with sources and attribution given
where necessary. Please contact me if any issues are discovered.</sub>
