
user/_schedset:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if (argc != 2)
   8:	4789                	li	a5,2
   a:	00f50f63          	beq	a0,a5,28 <main+0x28>
    {
        printf("Usage: schedset [SCHED ID]\n");
   e:	00001517          	auipc	a0,0x1
  12:	a1250513          	addi	a0,a0,-1518 # a20 <malloc+0xea>
  16:	00001097          	auipc	ra,0x1
  1a:	868080e7          	jalr	-1944(ra) # 87e <printf>
        exit(1);
  1e:	4505                	li	a0,1
  20:	00000097          	auipc	ra,0x0
  24:	4de080e7          	jalr	1246(ra) # 4fe <exit>
    }
    int schedid = (*argv[1]) - '0';
  28:	659c                	ld	a5,8(a1)
  2a:	0007c503          	lbu	a0,0(a5)
    schedset(schedid);
  2e:	fd05051b          	addiw	a0,a0,-48
  32:	00000097          	auipc	ra,0x0
  36:	57c080e7          	jalr	1404(ra) # 5ae <schedset>
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	4c2080e7          	jalr	1218(ra) # 4fe <exit>

0000000000000044 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  44:	1141                	addi	sp,sp,-16
  46:	e422                	sd	s0,8(sp)
  48:	0800                	addi	s0,sp,16
    lk->name = name;
  4a:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  4c:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  50:	57fd                	li	a5,-1
  52:	00f50823          	sb	a5,16(a0)
}
  56:	6422                	ld	s0,8(sp)
  58:	0141                	addi	sp,sp,16
  5a:	8082                	ret

000000000000005c <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  5c:	00054783          	lbu	a5,0(a0)
  60:	e399                	bnez	a5,66 <holding+0xa>
  62:	4501                	li	a0,0
}
  64:	8082                	ret
{
  66:	1101                	addi	sp,sp,-32
  68:	ec06                	sd	ra,24(sp)
  6a:	e822                	sd	s0,16(sp)
  6c:	e426                	sd	s1,8(sp)
  6e:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  70:	01054483          	lbu	s1,16(a0)
  74:	00000097          	auipc	ra,0x0
  78:	172080e7          	jalr	370(ra) # 1e6 <twhoami>
  7c:	2501                	sext.w	a0,a0
  7e:	40a48533          	sub	a0,s1,a0
  82:	00153513          	seqz	a0,a0
}
  86:	60e2                	ld	ra,24(sp)
  88:	6442                	ld	s0,16(sp)
  8a:	64a2                	ld	s1,8(sp)
  8c:	6105                	addi	sp,sp,32
  8e:	8082                	ret

0000000000000090 <acquire>:

void acquire(struct lock *lk)
{
  90:	7179                	addi	sp,sp,-48
  92:	f406                	sd	ra,40(sp)
  94:	f022                	sd	s0,32(sp)
  96:	ec26                	sd	s1,24(sp)
  98:	e84a                	sd	s2,16(sp)
  9a:	e44e                	sd	s3,8(sp)
  9c:	e052                	sd	s4,0(sp)
  9e:	1800                	addi	s0,sp,48
  a0:	8a2a                	mv	s4,a0
    if (holding(lk))
  a2:	00000097          	auipc	ra,0x0
  a6:	fba080e7          	jalr	-70(ra) # 5c <holding>
  aa:	e919                	bnez	a0,c0 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  ac:	ffca7493          	andi	s1,s4,-4
  b0:	003a7913          	andi	s2,s4,3
  b4:	0039191b          	slliw	s2,s2,0x3
  b8:	4985                	li	s3,1
  ba:	012999bb          	sllw	s3,s3,s2
  be:	a015                	j	e2 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  c0:	00001517          	auipc	a0,0x1
  c4:	98050513          	addi	a0,a0,-1664 # a40 <malloc+0x10a>
  c8:	00000097          	auipc	ra,0x0
  cc:	7b6080e7          	jalr	1974(ra) # 87e <printf>
        exit(-1);
  d0:	557d                	li	a0,-1
  d2:	00000097          	auipc	ra,0x0
  d6:	42c080e7          	jalr	1068(ra) # 4fe <exit>
    {
        // give up the cpu for other threads
        tyield();
  da:	00000097          	auipc	ra,0x0
  de:	0f4080e7          	jalr	244(ra) # 1ce <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  e2:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  e6:	0127d7bb          	srlw	a5,a5,s2
  ea:	0ff7f793          	zext.b	a5,a5
  ee:	f7f5                	bnez	a5,da <acquire+0x4a>
    }

    __sync_synchronize();
  f0:	0ff0000f          	fence

    lk->tid = twhoami();
  f4:	00000097          	auipc	ra,0x0
  f8:	0f2080e7          	jalr	242(ra) # 1e6 <twhoami>
  fc:	00aa0823          	sb	a0,16(s4)
}
 100:	70a2                	ld	ra,40(sp)
 102:	7402                	ld	s0,32(sp)
 104:	64e2                	ld	s1,24(sp)
 106:	6942                	ld	s2,16(sp)
 108:	69a2                	ld	s3,8(sp)
 10a:	6a02                	ld	s4,0(sp)
 10c:	6145                	addi	sp,sp,48
 10e:	8082                	ret

0000000000000110 <release>:

void release(struct lock *lk)
{
 110:	1101                	addi	sp,sp,-32
 112:	ec06                	sd	ra,24(sp)
 114:	e822                	sd	s0,16(sp)
 116:	e426                	sd	s1,8(sp)
 118:	1000                	addi	s0,sp,32
 11a:	84aa                	mv	s1,a0
    if (!holding(lk))
 11c:	00000097          	auipc	ra,0x0
 120:	f40080e7          	jalr	-192(ra) # 5c <holding>
 124:	c11d                	beqz	a0,14a <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 126:	57fd                	li	a5,-1
 128:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 12c:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 130:	0ff0000f          	fence
 134:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 138:	00000097          	auipc	ra,0x0
 13c:	096080e7          	jalr	150(ra) # 1ce <tyield>
}
 140:	60e2                	ld	ra,24(sp)
 142:	6442                	ld	s0,16(sp)
 144:	64a2                	ld	s1,8(sp)
 146:	6105                	addi	sp,sp,32
 148:	8082                	ret
        printf("releasing lock we are not holding");
 14a:	00001517          	auipc	a0,0x1
 14e:	91e50513          	addi	a0,a0,-1762 # a68 <malloc+0x132>
 152:	00000097          	auipc	ra,0x0
 156:	72c080e7          	jalr	1836(ra) # 87e <printf>
        exit(-1);
 15a:	557d                	li	a0,-1
 15c:	00000097          	auipc	ra,0x0
 160:	3a2080e7          	jalr	930(ra) # 4fe <exit>

0000000000000164 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 164:	1141                	addi	sp,sp,-16
 166:	e422                	sd	s0,8(sp)
 168:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 16a:	00001717          	auipc	a4,0x1
 16e:	e9673703          	ld	a4,-362(a4) # 1000 <current_thread>
 172:	47c1                	li	a5,16
 174:	c319                	beqz	a4,17a <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 176:	37fd                	addiw	a5,a5,-1
 178:	fff5                	bnez	a5,174 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret

0000000000000180 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 180:	7179                	addi	sp,sp,-48
 182:	f406                	sd	ra,40(sp)
 184:	f022                	sd	s0,32(sp)
 186:	ec26                	sd	s1,24(sp)
 188:	e84a                	sd	s2,16(sp)
 18a:	e44e                	sd	s3,8(sp)
 18c:	1800                	addi	s0,sp,48
 18e:	84aa                	mv	s1,a0
 190:	89b2                	mv	s3,a2
 192:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 194:	09000513          	li	a0,144
 198:	00000097          	auipc	ra,0x0
 19c:	79e080e7          	jalr	1950(ra) # 936 <malloc>
 1a0:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 1a2:	478d                	li	a5,3
 1a4:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 1a6:	609c                	ld	a5,0(s1)
 1a8:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 1ac:	609c                	ld	a5,0(s1)
 1ae:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 1b2:	70a2                	ld	ra,40(sp)
 1b4:	7402                	ld	s0,32(sp)
 1b6:	64e2                	ld	s1,24(sp)
 1b8:	6942                	ld	s2,16(sp)
 1ba:	69a2                	ld	s3,8(sp)
 1bc:	6145                	addi	sp,sp,48
 1be:	8082                	ret

00000000000001c0 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 1c6:	4501                	li	a0,0
 1c8:	6422                	ld	s0,8(sp)
 1ca:	0141                	addi	sp,sp,16
 1cc:	8082                	ret

00000000000001ce <tyield>:

void tyield()
{
 1ce:	1141                	addi	sp,sp,-16
 1d0:	e422                	sd	s0,8(sp)
 1d2:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 1d4:	00001797          	auipc	a5,0x1
 1d8:	e2c7b783          	ld	a5,-468(a5) # 1000 <current_thread>
 1dc:	470d                	li	a4,3
 1de:	dfb8                	sw	a4,120(a5)
    tsched();
}
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret

00000000000001e6 <twhoami>:

uint8 twhoami()
{
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 1ec:	4501                	li	a0,0
 1ee:	6422                	ld	s0,8(sp)
 1f0:	0141                	addi	sp,sp,16
 1f2:	8082                	ret

00000000000001f4 <tswtch>:
 1f4:	00153023          	sd	ra,0(a0)
 1f8:	00253423          	sd	sp,8(a0)
 1fc:	e900                	sd	s0,16(a0)
 1fe:	ed04                	sd	s1,24(a0)
 200:	03253023          	sd	s2,32(a0)
 204:	03353423          	sd	s3,40(a0)
 208:	03453823          	sd	s4,48(a0)
 20c:	03553c23          	sd	s5,56(a0)
 210:	05653023          	sd	s6,64(a0)
 214:	05753423          	sd	s7,72(a0)
 218:	05853823          	sd	s8,80(a0)
 21c:	05953c23          	sd	s9,88(a0)
 220:	07a53023          	sd	s10,96(a0)
 224:	07b53423          	sd	s11,104(a0)
 228:	0005b083          	ld	ra,0(a1)
 22c:	0085b103          	ld	sp,8(a1)
 230:	6980                	ld	s0,16(a1)
 232:	6d84                	ld	s1,24(a1)
 234:	0205b903          	ld	s2,32(a1)
 238:	0285b983          	ld	s3,40(a1)
 23c:	0305ba03          	ld	s4,48(a1)
 240:	0385ba83          	ld	s5,56(a1)
 244:	0405bb03          	ld	s6,64(a1)
 248:	0485bb83          	ld	s7,72(a1)
 24c:	0505bc03          	ld	s8,80(a1)
 250:	0585bc83          	ld	s9,88(a1)
 254:	0605bd03          	ld	s10,96(a1)
 258:	0685bd83          	ld	s11,104(a1)
 25c:	8082                	ret

000000000000025e <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 25e:	1101                	addi	sp,sp,-32
 260:	ec06                	sd	ra,24(sp)
 262:	e822                	sd	s0,16(sp)
 264:	e426                	sd	s1,8(sp)
 266:	e04a                	sd	s2,0(sp)
 268:	1000                	addi	s0,sp,32
 26a:	84aa                	mv	s1,a0
 26c:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 26e:	09000513          	li	a0,144
 272:	00000097          	auipc	ra,0x0
 276:	6c4080e7          	jalr	1732(ra) # 936 <malloc>

    main_thread->tid = 0;
 27a:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 27e:	85ca                	mv	a1,s2
 280:	8526                	mv	a0,s1
 282:	00000097          	auipc	ra,0x0
 286:	d7e080e7          	jalr	-642(ra) # 0 <main>
    exit(res);
 28a:	00000097          	auipc	ra,0x0
 28e:	274080e7          	jalr	628(ra) # 4fe <exit>

0000000000000292 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 298:	87aa                	mv	a5,a0
 29a:	0585                	addi	a1,a1,1
 29c:	0785                	addi	a5,a5,1
 29e:	fff5c703          	lbu	a4,-1(a1)
 2a2:	fee78fa3          	sb	a4,-1(a5)
 2a6:	fb75                	bnez	a4,29a <strcpy+0x8>
        ;
    return os;
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <strcmp>:

int strcmp(const char *p, const char *q)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2b4:	00054783          	lbu	a5,0(a0)
 2b8:	cb91                	beqz	a5,2cc <strcmp+0x1e>
 2ba:	0005c703          	lbu	a4,0(a1)
 2be:	00f71763          	bne	a4,a5,2cc <strcmp+0x1e>
        p++, q++;
 2c2:	0505                	addi	a0,a0,1
 2c4:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	fbe5                	bnez	a5,2ba <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2cc:	0005c503          	lbu	a0,0(a1)
}
 2d0:	40a7853b          	subw	a0,a5,a0
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret

00000000000002da <strlen>:

uint strlen(const char *s)
{
 2da:	1141                	addi	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 2e0:	00054783          	lbu	a5,0(a0)
 2e4:	cf91                	beqz	a5,300 <strlen+0x26>
 2e6:	0505                	addi	a0,a0,1
 2e8:	87aa                	mv	a5,a0
 2ea:	86be                	mv	a3,a5
 2ec:	0785                	addi	a5,a5,1
 2ee:	fff7c703          	lbu	a4,-1(a5)
 2f2:	ff65                	bnez	a4,2ea <strlen+0x10>
 2f4:	40a6853b          	subw	a0,a3,a0
 2f8:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret
    for (n = 0; s[n]; n++)
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <strlen+0x20>

0000000000000304 <memset>:

void *
memset(void *dst, int c, uint n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 30a:	ca19                	beqz	a2,320 <memset+0x1c>
 30c:	87aa                	mv	a5,a0
 30e:	1602                	slli	a2,a2,0x20
 310:	9201                	srli	a2,a2,0x20
 312:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 316:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 31a:	0785                	addi	a5,a5,1
 31c:	fee79de3          	bne	a5,a4,316 <memset+0x12>
    }
    return dst;
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <strchr>:

char *
strchr(const char *s, char c)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
    for (; *s; s++)
 32c:	00054783          	lbu	a5,0(a0)
 330:	cb99                	beqz	a5,346 <strchr+0x20>
        if (*s == c)
 332:	00f58763          	beq	a1,a5,340 <strchr+0x1a>
    for (; *s; s++)
 336:	0505                	addi	a0,a0,1
 338:	00054783          	lbu	a5,0(a0)
 33c:	fbfd                	bnez	a5,332 <strchr+0xc>
            return (char *)s;
    return 0;
 33e:	4501                	li	a0,0
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret
    return 0;
 346:	4501                	li	a0,0
 348:	bfe5                	j	340 <strchr+0x1a>

000000000000034a <gets>:

char *
gets(char *buf, int max)
{
 34a:	711d                	addi	sp,sp,-96
 34c:	ec86                	sd	ra,88(sp)
 34e:	e8a2                	sd	s0,80(sp)
 350:	e4a6                	sd	s1,72(sp)
 352:	e0ca                	sd	s2,64(sp)
 354:	fc4e                	sd	s3,56(sp)
 356:	f852                	sd	s4,48(sp)
 358:	f456                	sd	s5,40(sp)
 35a:	f05a                	sd	s6,32(sp)
 35c:	ec5e                	sd	s7,24(sp)
 35e:	1080                	addi	s0,sp,96
 360:	8baa                	mv	s7,a0
 362:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 364:	892a                	mv	s2,a0
 366:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 368:	4aa9                	li	s5,10
 36a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 36c:	89a6                	mv	s3,s1
 36e:	2485                	addiw	s1,s1,1
 370:	0344d863          	bge	s1,s4,3a0 <gets+0x56>
        cc = read(0, &c, 1);
 374:	4605                	li	a2,1
 376:	faf40593          	addi	a1,s0,-81
 37a:	4501                	li	a0,0
 37c:	00000097          	auipc	ra,0x0
 380:	19a080e7          	jalr	410(ra) # 516 <read>
        if (cc < 1)
 384:	00a05e63          	blez	a0,3a0 <gets+0x56>
        buf[i++] = c;
 388:	faf44783          	lbu	a5,-81(s0)
 38c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 390:	01578763          	beq	a5,s5,39e <gets+0x54>
 394:	0905                	addi	s2,s2,1
 396:	fd679be3          	bne	a5,s6,36c <gets+0x22>
    for (i = 0; i + 1 < max;)
 39a:	89a6                	mv	s3,s1
 39c:	a011                	j	3a0 <gets+0x56>
 39e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3a0:	99de                	add	s3,s3,s7
 3a2:	00098023          	sb	zero,0(s3)
    return buf;
}
 3a6:	855e                	mv	a0,s7
 3a8:	60e6                	ld	ra,88(sp)
 3aa:	6446                	ld	s0,80(sp)
 3ac:	64a6                	ld	s1,72(sp)
 3ae:	6906                	ld	s2,64(sp)
 3b0:	79e2                	ld	s3,56(sp)
 3b2:	7a42                	ld	s4,48(sp)
 3b4:	7aa2                	ld	s5,40(sp)
 3b6:	7b02                	ld	s6,32(sp)
 3b8:	6be2                	ld	s7,24(sp)
 3ba:	6125                	addi	sp,sp,96
 3bc:	8082                	ret

00000000000003be <stat>:

int stat(const char *n, struct stat *st)
{
 3be:	1101                	addi	sp,sp,-32
 3c0:	ec06                	sd	ra,24(sp)
 3c2:	e822                	sd	s0,16(sp)
 3c4:	e426                	sd	s1,8(sp)
 3c6:	e04a                	sd	s2,0(sp)
 3c8:	1000                	addi	s0,sp,32
 3ca:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3cc:	4581                	li	a1,0
 3ce:	00000097          	auipc	ra,0x0
 3d2:	170080e7          	jalr	368(ra) # 53e <open>
    if (fd < 0)
 3d6:	02054563          	bltz	a0,400 <stat+0x42>
 3da:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3dc:	85ca                	mv	a1,s2
 3de:	00000097          	auipc	ra,0x0
 3e2:	178080e7          	jalr	376(ra) # 556 <fstat>
 3e6:	892a                	mv	s2,a0
    close(fd);
 3e8:	8526                	mv	a0,s1
 3ea:	00000097          	auipc	ra,0x0
 3ee:	13c080e7          	jalr	316(ra) # 526 <close>
    return r;
}
 3f2:	854a                	mv	a0,s2
 3f4:	60e2                	ld	ra,24(sp)
 3f6:	6442                	ld	s0,16(sp)
 3f8:	64a2                	ld	s1,8(sp)
 3fa:	6902                	ld	s2,0(sp)
 3fc:	6105                	addi	sp,sp,32
 3fe:	8082                	ret
        return -1;
 400:	597d                	li	s2,-1
 402:	bfc5                	j	3f2 <stat+0x34>

0000000000000404 <atoi>:

int atoi(const char *s)
{
 404:	1141                	addi	sp,sp,-16
 406:	e422                	sd	s0,8(sp)
 408:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 40a:	00054683          	lbu	a3,0(a0)
 40e:	fd06879b          	addiw	a5,a3,-48
 412:	0ff7f793          	zext.b	a5,a5
 416:	4625                	li	a2,9
 418:	02f66863          	bltu	a2,a5,448 <atoi+0x44>
 41c:	872a                	mv	a4,a0
    n = 0;
 41e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 420:	0705                	addi	a4,a4,1
 422:	0025179b          	slliw	a5,a0,0x2
 426:	9fa9                	addw	a5,a5,a0
 428:	0017979b          	slliw	a5,a5,0x1
 42c:	9fb5                	addw	a5,a5,a3
 42e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 432:	00074683          	lbu	a3,0(a4)
 436:	fd06879b          	addiw	a5,a3,-48
 43a:	0ff7f793          	zext.b	a5,a5
 43e:	fef671e3          	bgeu	a2,a5,420 <atoi+0x1c>
    return n;
}
 442:	6422                	ld	s0,8(sp)
 444:	0141                	addi	sp,sp,16
 446:	8082                	ret
    n = 0;
 448:	4501                	li	a0,0
 44a:	bfe5                	j	442 <atoi+0x3e>

000000000000044c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e422                	sd	s0,8(sp)
 450:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 452:	02b57463          	bgeu	a0,a1,47a <memmove+0x2e>
    {
        while (n-- > 0)
 456:	00c05f63          	blez	a2,474 <memmove+0x28>
 45a:	1602                	slli	a2,a2,0x20
 45c:	9201                	srli	a2,a2,0x20
 45e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 462:	872a                	mv	a4,a0
            *dst++ = *src++;
 464:	0585                	addi	a1,a1,1
 466:	0705                	addi	a4,a4,1
 468:	fff5c683          	lbu	a3,-1(a1)
 46c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 470:	fee79ae3          	bne	a5,a4,464 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
        dst += n;
 47a:	00c50733          	add	a4,a0,a2
        src += n;
 47e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 480:	fec05ae3          	blez	a2,474 <memmove+0x28>
 484:	fff6079b          	addiw	a5,a2,-1
 488:	1782                	slli	a5,a5,0x20
 48a:	9381                	srli	a5,a5,0x20
 48c:	fff7c793          	not	a5,a5
 490:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 492:	15fd                	addi	a1,a1,-1
 494:	177d                	addi	a4,a4,-1
 496:	0005c683          	lbu	a3,0(a1)
 49a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 49e:	fee79ae3          	bne	a5,a4,492 <memmove+0x46>
 4a2:	bfc9                	j	474 <memmove+0x28>

00000000000004a4 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4a4:	1141                	addi	sp,sp,-16
 4a6:	e422                	sd	s0,8(sp)
 4a8:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 4aa:	ca05                	beqz	a2,4da <memcmp+0x36>
 4ac:	fff6069b          	addiw	a3,a2,-1
 4b0:	1682                	slli	a3,a3,0x20
 4b2:	9281                	srli	a3,a3,0x20
 4b4:	0685                	addi	a3,a3,1
 4b6:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 4b8:	00054783          	lbu	a5,0(a0)
 4bc:	0005c703          	lbu	a4,0(a1)
 4c0:	00e79863          	bne	a5,a4,4d0 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 4c4:	0505                	addi	a0,a0,1
        p2++;
 4c6:	0585                	addi	a1,a1,1
    while (n-- > 0)
 4c8:	fed518e3          	bne	a0,a3,4b8 <memcmp+0x14>
    }
    return 0;
 4cc:	4501                	li	a0,0
 4ce:	a019                	j	4d4 <memcmp+0x30>
            return *p1 - *p2;
 4d0:	40e7853b          	subw	a0,a5,a4
}
 4d4:	6422                	ld	s0,8(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
    return 0;
 4da:	4501                	li	a0,0
 4dc:	bfe5                	j	4d4 <memcmp+0x30>

00000000000004de <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e406                	sd	ra,8(sp)
 4e2:	e022                	sd	s0,0(sp)
 4e4:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 4e6:	00000097          	auipc	ra,0x0
 4ea:	f66080e7          	jalr	-154(ra) # 44c <memmove>
}
 4ee:	60a2                	ld	ra,8(sp)
 4f0:	6402                	ld	s0,0(sp)
 4f2:	0141                	addi	sp,sp,16
 4f4:	8082                	ret

00000000000004f6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4f6:	4885                	li	a7,1
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <exit>:
.global exit
exit:
 li a7, SYS_exit
 4fe:	4889                	li	a7,2
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <wait>:
.global wait
wait:
 li a7, SYS_wait
 506:	488d                	li	a7,3
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 50e:	4891                	li	a7,4
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <read>:
.global read
read:
 li a7, SYS_read
 516:	4895                	li	a7,5
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <write>:
.global write
write:
 li a7, SYS_write
 51e:	48c1                	li	a7,16
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <close>:
.global close
close:
 li a7, SYS_close
 526:	48d5                	li	a7,21
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <kill>:
.global kill
kill:
 li a7, SYS_kill
 52e:	4899                	li	a7,6
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <exec>:
.global exec
exec:
 li a7, SYS_exec
 536:	489d                	li	a7,7
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <open>:
.global open
open:
 li a7, SYS_open
 53e:	48bd                	li	a7,15
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 546:	48c5                	li	a7,17
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 54e:	48c9                	li	a7,18
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 556:	48a1                	li	a7,8
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <link>:
.global link
link:
 li a7, SYS_link
 55e:	48cd                	li	a7,19
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 566:	48d1                	li	a7,20
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 56e:	48a5                	li	a7,9
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <dup>:
.global dup
dup:
 li a7, SYS_dup
 576:	48a9                	li	a7,10
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 57e:	48ad                	li	a7,11
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 586:	48b1                	li	a7,12
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 58e:	48b5                	li	a7,13
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 596:	48b9                	li	a7,14
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <ps>:
.global ps
ps:
 li a7, SYS_ps
 59e:	48d9                	li	a7,22
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 5a6:	48dd                	li	a7,23
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 5ae:	48e1                	li	a7,24
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5b6:	1101                	addi	sp,sp,-32
 5b8:	ec06                	sd	ra,24(sp)
 5ba:	e822                	sd	s0,16(sp)
 5bc:	1000                	addi	s0,sp,32
 5be:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5c2:	4605                	li	a2,1
 5c4:	fef40593          	addi	a1,s0,-17
 5c8:	00000097          	auipc	ra,0x0
 5cc:	f56080e7          	jalr	-170(ra) # 51e <write>
}
 5d0:	60e2                	ld	ra,24(sp)
 5d2:	6442                	ld	s0,16(sp)
 5d4:	6105                	addi	sp,sp,32
 5d6:	8082                	ret

00000000000005d8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5d8:	7139                	addi	sp,sp,-64
 5da:	fc06                	sd	ra,56(sp)
 5dc:	f822                	sd	s0,48(sp)
 5de:	f426                	sd	s1,40(sp)
 5e0:	f04a                	sd	s2,32(sp)
 5e2:	ec4e                	sd	s3,24(sp)
 5e4:	0080                	addi	s0,sp,64
 5e6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5e8:	c299                	beqz	a3,5ee <printint+0x16>
 5ea:	0805c963          	bltz	a1,67c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5ee:	2581                	sext.w	a1,a1
  neg = 0;
 5f0:	4881                	li	a7,0
 5f2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5f6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5f8:	2601                	sext.w	a2,a2
 5fa:	00000517          	auipc	a0,0x0
 5fe:	4f650513          	addi	a0,a0,1270 # af0 <digits>
 602:	883a                	mv	a6,a4
 604:	2705                	addiw	a4,a4,1
 606:	02c5f7bb          	remuw	a5,a1,a2
 60a:	1782                	slli	a5,a5,0x20
 60c:	9381                	srli	a5,a5,0x20
 60e:	97aa                	add	a5,a5,a0
 610:	0007c783          	lbu	a5,0(a5)
 614:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 618:	0005879b          	sext.w	a5,a1
 61c:	02c5d5bb          	divuw	a1,a1,a2
 620:	0685                	addi	a3,a3,1
 622:	fec7f0e3          	bgeu	a5,a2,602 <printint+0x2a>
  if(neg)
 626:	00088c63          	beqz	a7,63e <printint+0x66>
    buf[i++] = '-';
 62a:	fd070793          	addi	a5,a4,-48
 62e:	00878733          	add	a4,a5,s0
 632:	02d00793          	li	a5,45
 636:	fef70823          	sb	a5,-16(a4)
 63a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 63e:	02e05863          	blez	a4,66e <printint+0x96>
 642:	fc040793          	addi	a5,s0,-64
 646:	00e78933          	add	s2,a5,a4
 64a:	fff78993          	addi	s3,a5,-1
 64e:	99ba                	add	s3,s3,a4
 650:	377d                	addiw	a4,a4,-1
 652:	1702                	slli	a4,a4,0x20
 654:	9301                	srli	a4,a4,0x20
 656:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 65a:	fff94583          	lbu	a1,-1(s2)
 65e:	8526                	mv	a0,s1
 660:	00000097          	auipc	ra,0x0
 664:	f56080e7          	jalr	-170(ra) # 5b6 <putc>
  while(--i >= 0)
 668:	197d                	addi	s2,s2,-1
 66a:	ff3918e3          	bne	s2,s3,65a <printint+0x82>
}
 66e:	70e2                	ld	ra,56(sp)
 670:	7442                	ld	s0,48(sp)
 672:	74a2                	ld	s1,40(sp)
 674:	7902                	ld	s2,32(sp)
 676:	69e2                	ld	s3,24(sp)
 678:	6121                	addi	sp,sp,64
 67a:	8082                	ret
    x = -xx;
 67c:	40b005bb          	negw	a1,a1
    neg = 1;
 680:	4885                	li	a7,1
    x = -xx;
 682:	bf85                	j	5f2 <printint+0x1a>

0000000000000684 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 684:	715d                	addi	sp,sp,-80
 686:	e486                	sd	ra,72(sp)
 688:	e0a2                	sd	s0,64(sp)
 68a:	fc26                	sd	s1,56(sp)
 68c:	f84a                	sd	s2,48(sp)
 68e:	f44e                	sd	s3,40(sp)
 690:	f052                	sd	s4,32(sp)
 692:	ec56                	sd	s5,24(sp)
 694:	e85a                	sd	s6,16(sp)
 696:	e45e                	sd	s7,8(sp)
 698:	e062                	sd	s8,0(sp)
 69a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 69c:	0005c903          	lbu	s2,0(a1)
 6a0:	18090c63          	beqz	s2,838 <vprintf+0x1b4>
 6a4:	8aaa                	mv	s5,a0
 6a6:	8bb2                	mv	s7,a2
 6a8:	00158493          	addi	s1,a1,1
  state = 0;
 6ac:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ae:	02500a13          	li	s4,37
 6b2:	4b55                	li	s6,21
 6b4:	a839                	j	6d2 <vprintf+0x4e>
        putc(fd, c);
 6b6:	85ca                	mv	a1,s2
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	efc080e7          	jalr	-260(ra) # 5b6 <putc>
 6c2:	a019                	j	6c8 <vprintf+0x44>
    } else if(state == '%'){
 6c4:	01498d63          	beq	s3,s4,6de <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6c8:	0485                	addi	s1,s1,1
 6ca:	fff4c903          	lbu	s2,-1(s1)
 6ce:	16090563          	beqz	s2,838 <vprintf+0x1b4>
    if(state == 0){
 6d2:	fe0999e3          	bnez	s3,6c4 <vprintf+0x40>
      if(c == '%'){
 6d6:	ff4910e3          	bne	s2,s4,6b6 <vprintf+0x32>
        state = '%';
 6da:	89d2                	mv	s3,s4
 6dc:	b7f5                	j	6c8 <vprintf+0x44>
      if(c == 'd'){
 6de:	13490263          	beq	s2,s4,802 <vprintf+0x17e>
 6e2:	f9d9079b          	addiw	a5,s2,-99
 6e6:	0ff7f793          	zext.b	a5,a5
 6ea:	12fb6563          	bltu	s6,a5,814 <vprintf+0x190>
 6ee:	f9d9079b          	addiw	a5,s2,-99
 6f2:	0ff7f713          	zext.b	a4,a5
 6f6:	10eb6f63          	bltu	s6,a4,814 <vprintf+0x190>
 6fa:	00271793          	slli	a5,a4,0x2
 6fe:	00000717          	auipc	a4,0x0
 702:	39a70713          	addi	a4,a4,922 # a98 <malloc+0x162>
 706:	97ba                	add	a5,a5,a4
 708:	439c                	lw	a5,0(a5)
 70a:	97ba                	add	a5,a5,a4
 70c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 70e:	008b8913          	addi	s2,s7,8
 712:	4685                	li	a3,1
 714:	4629                	li	a2,10
 716:	000ba583          	lw	a1,0(s7)
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	ebc080e7          	jalr	-324(ra) # 5d8 <printint>
 724:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 726:	4981                	li	s3,0
 728:	b745                	j	6c8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 72a:	008b8913          	addi	s2,s7,8
 72e:	4681                	li	a3,0
 730:	4629                	li	a2,10
 732:	000ba583          	lw	a1,0(s7)
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	ea0080e7          	jalr	-352(ra) # 5d8 <printint>
 740:	8bca                	mv	s7,s2
      state = 0;
 742:	4981                	li	s3,0
 744:	b751                	j	6c8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 746:	008b8913          	addi	s2,s7,8
 74a:	4681                	li	a3,0
 74c:	4641                	li	a2,16
 74e:	000ba583          	lw	a1,0(s7)
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	e84080e7          	jalr	-380(ra) # 5d8 <printint>
 75c:	8bca                	mv	s7,s2
      state = 0;
 75e:	4981                	li	s3,0
 760:	b7a5                	j	6c8 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 762:	008b8c13          	addi	s8,s7,8
 766:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 76a:	03000593          	li	a1,48
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e46080e7          	jalr	-442(ra) # 5b6 <putc>
  putc(fd, 'x');
 778:	07800593          	li	a1,120
 77c:	8556                	mv	a0,s5
 77e:	00000097          	auipc	ra,0x0
 782:	e38080e7          	jalr	-456(ra) # 5b6 <putc>
 786:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 788:	00000b97          	auipc	s7,0x0
 78c:	368b8b93          	addi	s7,s7,872 # af0 <digits>
 790:	03c9d793          	srli	a5,s3,0x3c
 794:	97de                	add	a5,a5,s7
 796:	0007c583          	lbu	a1,0(a5)
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	e1a080e7          	jalr	-486(ra) # 5b6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a4:	0992                	slli	s3,s3,0x4
 7a6:	397d                	addiw	s2,s2,-1
 7a8:	fe0914e3          	bnez	s2,790 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7ac:	8be2                	mv	s7,s8
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	bf21                	j	6c8 <vprintf+0x44>
        s = va_arg(ap, char*);
 7b2:	008b8993          	addi	s3,s7,8
 7b6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7ba:	02090163          	beqz	s2,7dc <vprintf+0x158>
        while(*s != 0){
 7be:	00094583          	lbu	a1,0(s2)
 7c2:	c9a5                	beqz	a1,832 <vprintf+0x1ae>
          putc(fd, *s);
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	df0080e7          	jalr	-528(ra) # 5b6 <putc>
          s++;
 7ce:	0905                	addi	s2,s2,1
        while(*s != 0){
 7d0:	00094583          	lbu	a1,0(s2)
 7d4:	f9e5                	bnez	a1,7c4 <vprintf+0x140>
        s = va_arg(ap, char*);
 7d6:	8bce                	mv	s7,s3
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	b5fd                	j	6c8 <vprintf+0x44>
          s = "(null)";
 7dc:	00000917          	auipc	s2,0x0
 7e0:	2b490913          	addi	s2,s2,692 # a90 <malloc+0x15a>
        while(*s != 0){
 7e4:	02800593          	li	a1,40
 7e8:	bff1                	j	7c4 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 7ea:	008b8913          	addi	s2,s7,8
 7ee:	000bc583          	lbu	a1,0(s7)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	dc2080e7          	jalr	-574(ra) # 5b6 <putc>
 7fc:	8bca                	mv	s7,s2
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b5e1                	j	6c8 <vprintf+0x44>
        putc(fd, c);
 802:	02500593          	li	a1,37
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	dae080e7          	jalr	-594(ra) # 5b6 <putc>
      state = 0;
 810:	4981                	li	s3,0
 812:	bd5d                	j	6c8 <vprintf+0x44>
        putc(fd, '%');
 814:	02500593          	li	a1,37
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	d9c080e7          	jalr	-612(ra) # 5b6 <putc>
        putc(fd, c);
 822:	85ca                	mv	a1,s2
 824:	8556                	mv	a0,s5
 826:	00000097          	auipc	ra,0x0
 82a:	d90080e7          	jalr	-624(ra) # 5b6 <putc>
      state = 0;
 82e:	4981                	li	s3,0
 830:	bd61                	j	6c8 <vprintf+0x44>
        s = va_arg(ap, char*);
 832:	8bce                	mv	s7,s3
      state = 0;
 834:	4981                	li	s3,0
 836:	bd49                	j	6c8 <vprintf+0x44>
    }
  }
}
 838:	60a6                	ld	ra,72(sp)
 83a:	6406                	ld	s0,64(sp)
 83c:	74e2                	ld	s1,56(sp)
 83e:	7942                	ld	s2,48(sp)
 840:	79a2                	ld	s3,40(sp)
 842:	7a02                	ld	s4,32(sp)
 844:	6ae2                	ld	s5,24(sp)
 846:	6b42                	ld	s6,16(sp)
 848:	6ba2                	ld	s7,8(sp)
 84a:	6c02                	ld	s8,0(sp)
 84c:	6161                	addi	sp,sp,80
 84e:	8082                	ret

0000000000000850 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 850:	715d                	addi	sp,sp,-80
 852:	ec06                	sd	ra,24(sp)
 854:	e822                	sd	s0,16(sp)
 856:	1000                	addi	s0,sp,32
 858:	e010                	sd	a2,0(s0)
 85a:	e414                	sd	a3,8(s0)
 85c:	e818                	sd	a4,16(s0)
 85e:	ec1c                	sd	a5,24(s0)
 860:	03043023          	sd	a6,32(s0)
 864:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 868:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 86c:	8622                	mv	a2,s0
 86e:	00000097          	auipc	ra,0x0
 872:	e16080e7          	jalr	-490(ra) # 684 <vprintf>
}
 876:	60e2                	ld	ra,24(sp)
 878:	6442                	ld	s0,16(sp)
 87a:	6161                	addi	sp,sp,80
 87c:	8082                	ret

000000000000087e <printf>:

void
printf(const char *fmt, ...)
{
 87e:	711d                	addi	sp,sp,-96
 880:	ec06                	sd	ra,24(sp)
 882:	e822                	sd	s0,16(sp)
 884:	1000                	addi	s0,sp,32
 886:	e40c                	sd	a1,8(s0)
 888:	e810                	sd	a2,16(s0)
 88a:	ec14                	sd	a3,24(s0)
 88c:	f018                	sd	a4,32(s0)
 88e:	f41c                	sd	a5,40(s0)
 890:	03043823          	sd	a6,48(s0)
 894:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 898:	00840613          	addi	a2,s0,8
 89c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8a0:	85aa                	mv	a1,a0
 8a2:	4505                	li	a0,1
 8a4:	00000097          	auipc	ra,0x0
 8a8:	de0080e7          	jalr	-544(ra) # 684 <vprintf>
}
 8ac:	60e2                	ld	ra,24(sp)
 8ae:	6442                	ld	s0,16(sp)
 8b0:	6125                	addi	sp,sp,96
 8b2:	8082                	ret

00000000000008b4 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 8b4:	1141                	addi	sp,sp,-16
 8b6:	e422                	sd	s0,8(sp)
 8b8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8ba:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8be:	00000797          	auipc	a5,0x0
 8c2:	74a7b783          	ld	a5,1866(a5) # 1008 <freep>
 8c6:	a02d                	j	8f0 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 8c8:	4618                	lw	a4,8(a2)
 8ca:	9f2d                	addw	a4,a4,a1
 8cc:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8d0:	6398                	ld	a4,0(a5)
 8d2:	6310                	ld	a2,0(a4)
 8d4:	a83d                	j	912 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 8d6:	ff852703          	lw	a4,-8(a0)
 8da:	9f31                	addw	a4,a4,a2
 8dc:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8de:	ff053683          	ld	a3,-16(a0)
 8e2:	a091                	j	926 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e4:	6398                	ld	a4,0(a5)
 8e6:	00e7e463          	bltu	a5,a4,8ee <free+0x3a>
 8ea:	00e6ea63          	bltu	a3,a4,8fe <free+0x4a>
{
 8ee:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	fed7fae3          	bgeu	a5,a3,8e4 <free+0x30>
 8f4:	6398                	ld	a4,0(a5)
 8f6:	00e6e463          	bltu	a3,a4,8fe <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fa:	fee7eae3          	bltu	a5,a4,8ee <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 8fe:	ff852583          	lw	a1,-8(a0)
 902:	6390                	ld	a2,0(a5)
 904:	02059813          	slli	a6,a1,0x20
 908:	01c85713          	srli	a4,a6,0x1c
 90c:	9736                	add	a4,a4,a3
 90e:	fae60de3          	beq	a2,a4,8c8 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 912:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 916:	4790                	lw	a2,8(a5)
 918:	02061593          	slli	a1,a2,0x20
 91c:	01c5d713          	srli	a4,a1,0x1c
 920:	973e                	add	a4,a4,a5
 922:	fae68ae3          	beq	a3,a4,8d6 <free+0x22>
        p->s.ptr = bp->s.ptr;
 926:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 928:	00000717          	auipc	a4,0x0
 92c:	6ef73023          	sd	a5,1760(a4) # 1008 <freep>
}
 930:	6422                	ld	s0,8(sp)
 932:	0141                	addi	sp,sp,16
 934:	8082                	ret

0000000000000936 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 936:	7139                	addi	sp,sp,-64
 938:	fc06                	sd	ra,56(sp)
 93a:	f822                	sd	s0,48(sp)
 93c:	f426                	sd	s1,40(sp)
 93e:	f04a                	sd	s2,32(sp)
 940:	ec4e                	sd	s3,24(sp)
 942:	e852                	sd	s4,16(sp)
 944:	e456                	sd	s5,8(sp)
 946:	e05a                	sd	s6,0(sp)
 948:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 94a:	02051493          	slli	s1,a0,0x20
 94e:	9081                	srli	s1,s1,0x20
 950:	04bd                	addi	s1,s1,15
 952:	8091                	srli	s1,s1,0x4
 954:	0014899b          	addiw	s3,s1,1
 958:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 95a:	00000517          	auipc	a0,0x0
 95e:	6ae53503          	ld	a0,1710(a0) # 1008 <freep>
 962:	c515                	beqz	a0,98e <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 964:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 966:	4798                	lw	a4,8(a5)
 968:	02977f63          	bgeu	a4,s1,9a6 <malloc+0x70>
    if (nu < 4096)
 96c:	8a4e                	mv	s4,s3
 96e:	0009871b          	sext.w	a4,s3
 972:	6685                	lui	a3,0x1
 974:	00d77363          	bgeu	a4,a3,97a <malloc+0x44>
 978:	6a05                	lui	s4,0x1
 97a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 97e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 982:	00000917          	auipc	s2,0x0
 986:	68690913          	addi	s2,s2,1670 # 1008 <freep>
    if (p == (char *)-1)
 98a:	5afd                	li	s5,-1
 98c:	a895                	j	a00 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 98e:	00000797          	auipc	a5,0x0
 992:	68278793          	addi	a5,a5,1666 # 1010 <base>
 996:	00000717          	auipc	a4,0x0
 99a:	66f73923          	sd	a5,1650(a4) # 1008 <freep>
 99e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9a0:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 9a4:	b7e1                	j	96c <malloc+0x36>
            if (p->s.size == nunits)
 9a6:	02e48c63          	beq	s1,a4,9de <malloc+0xa8>
                p->s.size -= nunits;
 9aa:	4137073b          	subw	a4,a4,s3
 9ae:	c798                	sw	a4,8(a5)
                p += p->s.size;
 9b0:	02071693          	slli	a3,a4,0x20
 9b4:	01c6d713          	srli	a4,a3,0x1c
 9b8:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 9ba:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 9be:	00000717          	auipc	a4,0x0
 9c2:	64a73523          	sd	a0,1610(a4) # 1008 <freep>
            return (void *)(p + 1);
 9c6:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9ca:	70e2                	ld	ra,56(sp)
 9cc:	7442                	ld	s0,48(sp)
 9ce:	74a2                	ld	s1,40(sp)
 9d0:	7902                	ld	s2,32(sp)
 9d2:	69e2                	ld	s3,24(sp)
 9d4:	6a42                	ld	s4,16(sp)
 9d6:	6aa2                	ld	s5,8(sp)
 9d8:	6b02                	ld	s6,0(sp)
 9da:	6121                	addi	sp,sp,64
 9dc:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 9de:	6398                	ld	a4,0(a5)
 9e0:	e118                	sd	a4,0(a0)
 9e2:	bff1                	j	9be <malloc+0x88>
    hp->s.size = nu;
 9e4:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 9e8:	0541                	addi	a0,a0,16
 9ea:	00000097          	auipc	ra,0x0
 9ee:	eca080e7          	jalr	-310(ra) # 8b4 <free>
    return freep;
 9f2:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 9f6:	d971                	beqz	a0,9ca <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 9f8:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 9fa:	4798                	lw	a4,8(a5)
 9fc:	fa9775e3          	bgeu	a4,s1,9a6 <malloc+0x70>
        if (p == freep)
 a00:	00093703          	ld	a4,0(s2)
 a04:	853e                	mv	a0,a5
 a06:	fef719e3          	bne	a4,a5,9f8 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a0a:	8552                	mv	a0,s4
 a0c:	00000097          	auipc	ra,0x0
 a10:	b7a080e7          	jalr	-1158(ra) # 586 <sbrk>
    if (p == (char *)-1)
 a14:	fd5518e3          	bne	a0,s5,9e4 <malloc+0xae>
                return 0;
 a18:	4501                	li	a0,0
 a1a:	bf45                	j	9ca <malloc+0x94>
