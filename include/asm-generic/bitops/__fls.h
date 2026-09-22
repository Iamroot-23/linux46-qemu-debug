#ifndef _ASM_GENERIC_BITOPS___FLS_H_
#define _ASM_GENERIC_BITOPS___FLS_H_

#include <asm/types.h>

/**
 * __fls - find last (most-significant) set bit in a long word
 * @word: the word to search
 *
 * Undefined if no set bit exists, so code should check against 0 first.
 */
/* IAMROOT23 20260919
 *  정수에서 가장 마지막(가장 높은 비트, MSB)으로 1이 설정된 비트의 위치
 *  x = 0x0000000000000001 (이진수: ...00000001) ──► 0 반환
 *  x = 0x0000000000000080 (이진수: ...10000000) ──► 7 반환
 *  x = 0x8000000000000000 (최상위 비트 1) ──► 63 반환
 */
static __always_inline unsigned long __fls(unsigned long word)
{
	int num = BITS_PER_LONG - 1;

#if BITS_PER_LONG == 64
	if (!(word & (~0ul << 32))) {
		num -= 32;
		word <<= 32;
	}
#endif
	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
		num -= 16;
		word <<= 16;
	}
	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
		num -= 8;
		word <<= 8;
	}
	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
		num -= 4;
		word <<= 4;
	}
	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
		num -= 2;
		word <<= 2;
	}
	if (!(word & (~0ul << (BITS_PER_LONG-1))))
		num -= 1;
	return num;
}

#endif /* _ASM_GENERIC_BITOPS___FLS_H_ */
