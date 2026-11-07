# ARM64 리눅스 커널 4.6 분석

## 커뮤니티: IAMROOT 23차
- [www.iamroot.org][#iamroot] | IAMROOT 홈페이지
- [리눅스 커널 심층분석 개정판 3 판][#book_lkd]
- [코드로 알아보는 ARM 리눅스 커널][#ebook]

[#iamroot]: http://www.iamroot.org
[#moonc]: http://jake.dothome.co.kr
[#ebook]: https://ebook-product.kyobobook.co.kr/dig/epd/ebook/E000002982276
[#book_lkd]: https://product.kyobobook.co.kr/detail/S000000935348

## 설명
 - k-build.sh  커널 빌드 스크립트
 - k-tags.sh  커널 ctags, cscope 태그생성 스크립트
 - k-g2.sh qemu gdb 디버깅용 스크립트 - head.S 까지
 - k-g3.sh qemu gdb 디버깅용 스크립트 - start_kernel 이후
 - k-dumpdtb.sh  qemu dump device tree 추출스크립트
 - cortex-a57.dts dumpdtb로 나온 device tree

## 필요한 패키지
 - Google에서 "aarch64 크로스 컴파일 환경 구성하기" 를 찿아 설치하자
 - arch 리눅스에서는 아래의 패키지를 설치했다.
  - aarch64-linux-gnu-binutils
  - aarch64-linux-gnu-gcc
  - aarch64-linux-gnu-gdb
  - aarch64-linux-gnu-glibc
  - qemu-system-aarch64
  - bc cscope ctags
 - Ubuntu 24.04 LTS 
  - bc cscope universal-ctags qemu-system-arm build-essential crossbuild-essential-arm64
  - gcc-aarch64-linux-gnu gdb-multiarch

## 실행 순서
 - cp vimrc ~/.vimrc        # 필요시 ~/.vimrc 백업
 - cp gdbinit ~/.gdbinit    # 필요시 ~/.gdbinit 백업.
 - k-build.sh 커널 소스를 처음 받거나 수정후에 실행해준다.
 - k-tags.sh 커널 소스를 처음 받거나 수정후에 실행해준다.(k-build.sh가 최소 한번 실행된후 해주는것을 추천)
 - k-g2.sh head.S 소스쪽 디버깅이 필요하면 실행해준다.
 - k-g3.sh start_kernel 이후 디버깅이 필요하면 실행해준다.

## vim 사용법
 - :ts 함수명 혹은 변수명
 - :ts 시작명+tab+tab   자동 완성기능
 - 선언으로 이동1 : ctrl + ] : 변수 함수명 위에서 ctrl + ]
 - 이전으로 이동 : ctrl + t
 - 선언으로 이동2 : 변수 함수명 위에서 ,css

## gdb 사용법
 - ./k-g3.sh 디버거 실행
 - b 함수명  # brakpoint tab키 두번 누르면 자동완성됨
 - c             # continue
 - p 변수명       # print tab키 두번 두느면 자동완성됨
 - n             # next
 - s             # step
 - quit          # 종료

## python 변수 보는 방법
 - 헥사코드 보는 방법
 - hex(1234567890)
 '0x499602d2'
 - 헥사코드 이쁘게 보는 방법
```python
 def h(n):
   return f'{n:#_x}'

   >>> h(1234567890)
   '0x4996_02d2'
```
 
## History
 ### 0주차
2021.04.18, Zoom 온라인
- Orientation

