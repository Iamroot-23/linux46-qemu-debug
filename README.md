# ARM64 리눅스 커널 4.6 분석

## 커뮤니티: IAMROOT 23차
- [www.iamroot.org][#iamroot] | IAMROOT 홈페이지
- [jake.dothome.co.kr][#moonc] | 문c 블로그

[#iamroot]: http://www.iamroot.org
[#moonc]: http://jake.dothome.co.kr

## 설명
 - k-build.sh  커널 빌드 스크립트
 - k-tags.sh  커널 ctags, cscope 태그생성 스크립트
 - k-g3.sh qemu gdb 디버깅용 스크립트.

## 필요한 패키지
 - Google에서 "aarch64 크로스 컴파일 환경 구성하기" 를 찿아 설치하자
 - arch 리눅스에서는 아래의 패키지를 설치했다.
 - aarch64-linux-gnu-binutils
 - aarch64-linux-gnu-gcc
 - aarch64-linux-gnu-gdb
 - aarch64-linux-gnu-glibc
 - qemu-system-aarch64

## 실행 순서
 - k-build.sh 커널 소스를 처음 받거나 수정후에 실행해준다.
 - k-tags.sh 커널 소스를 처음 받거나 수정후에 실행해준다.
 - k-g3.sh 디버깅이 필요하면 실행해준다.
 
## History
 ### 0주차
2021.04.18, Zoom 온라인
- Orientation

