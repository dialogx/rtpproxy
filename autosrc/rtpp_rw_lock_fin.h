/* Auto-generated by genfincode_stat.sh - DO NOT EDIT! */
#if !defined(_rtpp_rw_lock_fin_h)
#define _rtpp_rw_lock_fin_h
#if !defined(RTPP_AUTOTRAP)
#define RTPP_AUTOTRAP() abort()
#else
extern int _naborts;
#endif
#if defined(RTPP_DEBUG)
struct rtpp_rw_lock;
void rtpp_rw_lock_fin(struct rtpp_rw_lock *);
#else
#define rtpp_rw_lock_fin(arg) /* nop */
#endif
#if defined(RTPP_FINTEST)
void rtpp_rw_lock_fintest(void);
#endif /* RTPP_FINTEST */
#endif /* _rtpp_rw_lock_fin_h */
