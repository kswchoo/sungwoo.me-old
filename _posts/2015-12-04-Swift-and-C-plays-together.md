---
layout: post
title:  "Swift와 C 함께 사용하기" 
date:   2015-12-04
---

<span class="dropcap">오</span>늘 공개된 [Swift 오픈소스](http://swift.org) 를 보면서, "아파치 모듈을 Swift로 만들 수 있게 된다면 꽤 괜찮은 서버 플랫폼이 되지 않을까?" 라는 생각이 들어 간단한 실험을 해 봤다.

먼저 Swift 개발 환경을 설정한다. Swift 홈페이지의 [Getting Started](https://swift.org/getting-started/) 를 보면 설치 절차가 잘 설명되어 있으니 (사실은 압축을 풀고 path를 걸어주는 것이 설치의 전부다.) 잘 따라해 봤다. 물론 Ubuntu로 시도.

이제 간단한 Swift파일을 만들어 보자. `function.swift` 를 아래와 같이 작성했다.

```Swift
public func sayHello() {
	print("Hello, swift!")
}
```

먼저 위에서 만든 Swift 파일을 컴파일 해 보자.

```
$ swiftc -c function.swift -parse-as-library
```

처음에는 `-parse-as-library` 를 붙이지 않았더니, `main` 심볼을 자꾸 만들어 내서 나중에 `main`을 포함한 C코드와 링크할 때 문제가 발생했다. 아무튼, 이 옵션을 쓰면 Swift 컴파일러는 `main`을 만들어내지 않는다.

이제 아까 작성한 `sayHello`가 어떤 이름으로 들어 있는지 확인하기 위해, objdump를 사용해서 오브젝트 파일을 들여다 보자.

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

위에서 만든 함수는 `_TF8function8sayHelloFT_T_` 심볼로 컴파일 된 것을 알 수 있다.
이제 이 심볼을 부르는 간단한 `main.c` 파일을 작성한다.

```C
#include <stdio.h>

void _TF8function8sayHelloFT_T_();

int main() {
    printf("Hello from C!\n");
    _TF8function8sayHelloFT_T_();
}
```

이제 C코드를 컴파일하고, 아까 컴파일한 Swift 코드와 링크해 보자.

```
$ gcc -c main.c
$ swiftc function.o main.o -o hello -L/usr/local/lib
```

별 메세지가 나오지 않는다면, 이제 실행.

```
$ ./hello
Hello from C!
Hello from Swift!
```

C에서 Swift 호출을 성공했다. C에서 Swift를 호출할 때, 간단한 케이스는 그냥 호출이 되는 것을 확인했다.

<strike>이제 뭐하지?</strike>