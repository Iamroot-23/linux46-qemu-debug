#ifndef _ASM_GENERIC_BITOPS_FLS64_H_
#define _ASM_GENERIC_BITOPS_FLS64_H_

#include <asm/types.h>

/**
 * fls64 - find last set bit in a 64-bit word
 * @x: the word to search
 *
 * This is defined in a similar way as the libc and compiler builtin
 * ffsll, but returns the position of the most significant set bit.
 *
 * fls64(value) returns 0 if value is 0 or the position of the last
 * set bit if value is nonzero. The last (most significant) bit is
 * at position 64.
 */
/* IAMROOT23 20260919
 *  정수에서 가장 마지막(가장 높은 비트, MSB)으로 1이 설정된 비트의 위치
 *  x = 0x0000000000000001 (이진수: ...00000001) ──► 0 반환
 *  x = 0x0000000000000080 (이진수: ...10000000) ──► 7 반환
 *  x = 0x8000000000000000 (최상위 비트 1) ──► 63 반환
 */
#if BITS_PER_LONG == 32
static __always_inline int fls64(__u64 x)
{
	__u32 h = x >> 32;
	if (h)
		return fls(h) + 32;
	return fls(x);
}
#elif BITS_PER_LONG == 64
static __always_inline int fls64(__u64 x)
{
	if (x == 0)
		return 0;
	return __fls(x) + 1;
}
#else
#error BITS_PER_LONG not 32 or 64
#endif

#endif /* _ASM_GENERIC_BITOPS_FLS64_H_ */
