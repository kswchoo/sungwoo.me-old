---
layout: post
title:  "Swift and C plays together" 
date:   2015-12-04
---

<span class="dropcap">T</span>oday, Apple released [Swif](http://swift.org) by open source.
I thought that "If can, writing Apache module in Swift must be a cool idea!", so I did some experiment.

First of all, configure Swift development environment. [Getting Started](https://swift.org/getting-started/) section of Swift homepage is great starting point. (Actually untaring the package is everything I did...)

Now let's write simple Swift file. I named this as `function.swfit`.

```Swift
public func sayHello() {
	print("Hello, swift!")
}
```

Compile this Swift file.

```
$ swiftc -c function.swift -parse-as-library
```

At first attempt, Swift compiler added unnecessary `main` symbol into object file when i didn't add `-parse-as-library` flag.
Anyway, the problem was solved by using this flag.

Now let's find the name of `sayHello` function in object file. We can use objdump tool to do this.

```
$ objdump -t function.o

function.o:     file format elf64-x86-64

SYMBOL TABLE:
0000000000000000 l    df *ABS*	0000000000000000 function.o
0000000000000000 l     O .rodata.str1.16	0000000000000011 .L__unnamed_1
0000000000000000 l    d  .text	0000000000000000 .text
0000000000000000 g     F .text	000000000000009e _TF8function8sayHelloFT_T_
0000000000000000         *UND*	0000000000000000 _TFSSCfT21_builtinStringLiteralBp8byteSizeBw7isASCIIBi1__SS
0000000000000000         *UND*	0000000000000000 _TFs5printFTGSaP__9separatorSS10terminatorSS_T_
0000000000000000         *UND*	0000000000000000 _TIFs5printFTGSaP__9separatorSS10terminatorSS_T_A0_
0000000000000000         *UND*	0000000000000000 _TIFs5printFTGSaP__9separatorSS10terminatorSS_T_A1_
0000000000000000         *UND*	0000000000000000 _TMSS
0000000000000000         *UND*	0000000000000000 _TTSg5P____TFs27_allocateUninitializedArrayurFBwTGSax_Bp_
```

We can find out that the compiled name of the function is `_TF8function8sayHelloFT_T_`.
Now write simple `main.c` C code to call this symbol.

```C
#include <stdio.h>

void _TF8function8sayHelloFT_T_();

int main() {
    printf("Hello from C!\n");
    _TF8function8sayHelloFT_T_();
}
```

Now compile C code and link with Swift object file that we rolled before.

```
$ gcc -c main.c
$ swiftc function.o main.o -o hello -L/usr/local/lib
```

Execute.

```
$ ./hello
Hello from C!
Hello from Swift!
```

It worked. C can call Swift code. 

<strike>Now what shell I do?</strike>