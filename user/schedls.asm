
user/_schedls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    schedls();
   8:	00000097          	auipc	ra,0x0
   c:	574080e7          	jalr	1396(ra) # 57c <schedls>
    exit(0);
  10:	4501                	li	a0,0
  12:	00000097          	auipc	ra,0x0
  16:	4c2080e7          	jalr	1218(ra) # 4d4 <exit>

000000000000001a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  1a:	1141                	addi	sp,sp,-16
  1c:	e422                	sd	s0,8(sp)
  1e:	0800                	addi	s0,sp,16
    lk->name = name;
  20:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  22:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  26:	57fd                	li	a5,-1
  28:	00f50823          	sb	a5,16(a0)
}
  2c:	6422                	ld	s0,8(sp)
  2e:	0141                	addi	sp,sp,16
  30:	8082                	ret

0000000000000032 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  32:	00054783          	lbu	a5,0(a0)
  36:	e399                	bnez	a5,3c <holding+0xa>
  38:	4501                	li	a0,0
}
  3a:	8082                	ret
{
  3c:	1101                	addi	sp,sp,-32
  3e:	ec06                	sd	ra,24(sp)
  40:	e822                	sd	s0,16(sp)
  42:	e426                	sd	s1,8(sp)
  44:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  46:	01054483          	lbu	s1,16(a0)
  4a:	00000097          	auipc	ra,0x0
  4e:	172080e7          	jalr	370(ra) # 1bc <twhoami>
  52:	2501                	sext.w	a0,a0
  54:	40a48533          	sub	a0,s1,a0
  58:	00153513          	seqz	a0,a0
}
  5c:	60e2                	ld	ra,24(sp)
  5e:	6442                	ld	s0,16(sp)
  60:	64a2                	ld	s1,8(sp)
  62:	6105                	addi	sp,sp,32
  64:	8082                	ret

0000000000000066 <acquire>:

void acquire(struct lock *lk)
{
  66:	7179                	addi	sp,sp,-48
  68:	f406                	sd	ra,40(sp)
  6a:	f022                	sd	s0,32(sp)
  6c:	ec26                	sd	s1,24(sp)
  6e:	e84a                	sd	s2,16(sp)
  70:	e44e                	sd	s3,8(sp)
  72:	e052                	sd	s4,0(sp)
  74:	1800                	addi	s0,sp,48
  76:	8a2a                	mv	s4,a0
    if (holding(lk))
  78:	00000097          	auipc	ra,0x0
  7c:	fba080e7          	jalr	-70(ra) # 32 <holding>
  80:	e919                	bnez	a0,96 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  82:	ffca7493          	andi	s1,s4,-4
  86:	003a7913          	andi	s2,s4,3
  8a:	0039191b          	slliw	s2,s2,0x3
  8e:	4985                	li	s3,1
  90:	012999bb          	sllw	s3,s3,s2
  94:	a015                	j	b8 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  96:	00001517          	auipc	a0,0x1
  9a:	96a50513          	addi	a0,a0,-1686 # a00 <malloc+0xf4>
  9e:	00000097          	auipc	ra,0x0
  a2:	7b6080e7          	jalr	1974(ra) # 854 <printf>
        exit(-1);
  a6:	557d                	li	a0,-1
  a8:	00000097          	auipc	ra,0x0
  ac:	42c080e7          	jalr	1068(ra) # 4d4 <exit>
    {
        // give up the cpu for other threads
        tyield();
  b0:	00000097          	auipc	ra,0x0
  b4:	0f4080e7          	jalr	244(ra) # 1a4 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  b8:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  bc:	0127d7bb          	srlw	a5,a5,s2
  c0:	0ff7f793          	zext.b	a5,a5
  c4:	f7f5                	bnez	a5,b0 <acquire+0x4a>
    }

    __sync_synchronize();
  c6:	0ff0000f          	fence

    lk->tid = twhoami();
  ca:	00000097          	auipc	ra,0x0
  ce:	0f2080e7          	jalr	242(ra) # 1bc <twhoami>
  d2:	00aa0823          	sb	a0,16(s4)
}
  d6:	70a2                	ld	ra,40(sp)
  d8:	7402                	ld	s0,32(sp)
  da:	64e2                	ld	s1,24(sp)
  dc:	6942                	ld	s2,16(sp)
  de:	69a2                	ld	s3,8(sp)
  e0:	6a02                	ld	s4,0(sp)
  e2:	6145                	addi	sp,sp,48
  e4:	8082                	ret

00000000000000e6 <release>:

void release(struct lock *lk)
{
  e6:	1101                	addi	sp,sp,-32
  e8:	ec06                	sd	ra,24(sp)
  ea:	e822                	sd	s0,16(sp)
  ec:	e426                	sd	s1,8(sp)
  ee:	1000                	addi	s0,sp,32
  f0:	84aa                	mv	s1,a0
    if (!holding(lk))
  f2:	00000097          	auipc	ra,0x0
  f6:	f40080e7          	jalr	-192(ra) # 32 <holding>
  fa:	c11d                	beqz	a0,120 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
  fc:	57fd                	li	a5,-1
  fe:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 102:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 106:	0ff0000f          	fence
 10a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 10e:	00000097          	auipc	ra,0x0
 112:	096080e7          	jalr	150(ra) # 1a4 <tyield>
}
 116:	60e2                	ld	ra,24(sp)
 118:	6442                	ld	s0,16(sp)
 11a:	64a2                	ld	s1,8(sp)
 11c:	6105                	addi	sp,sp,32
 11e:	8082                	ret
        printf("releasing lock we are not holding");
 120:	00001517          	auipc	a0,0x1
 124:	90850513          	addi	a0,a0,-1784 # a28 <malloc+0x11c>
 128:	00000097          	auipc	ra,0x0
 12c:	72c080e7          	jalr	1836(ra) # 854 <printf>
        exit(-1);
 130:	557d                	li	a0,-1
 132:	00000097          	auipc	ra,0x0
 136:	3a2080e7          	jalr	930(ra) # 4d4 <exit>

000000000000013a <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 13a:	1141                	addi	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 140:	00001717          	auipc	a4,0x1
 144:	ec073703          	ld	a4,-320(a4) # 1000 <current_thread>
 148:	47c1                	li	a5,16
 14a:	c319                	beqz	a4,150 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 14c:	37fd                	addiw	a5,a5,-1
 14e:	fff5                	bnez	a5,14a <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret

0000000000000156 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 156:	7179                	addi	sp,sp,-48
 158:	f406                	sd	ra,40(sp)
 15a:	f022                	sd	s0,32(sp)
 15c:	ec26                	sd	s1,24(sp)
 15e:	e84a                	sd	s2,16(sp)
 160:	e44e                	sd	s3,8(sp)
 162:	1800                	addi	s0,sp,48
 164:	84aa                	mv	s1,a0
 166:	89b2                	mv	s3,a2
 168:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 16a:	09000513          	li	a0,144
 16e:	00000097          	auipc	ra,0x0
 172:	79e080e7          	jalr	1950(ra) # 90c <malloc>
 176:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 178:	478d                	li	a5,3
 17a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 17c:	609c                	ld	a5,0(s1)
 17e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 182:	609c                	ld	a5,0(s1)
 184:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 188:	70a2                	ld	ra,40(sp)
 18a:	7402                	ld	s0,32(sp)
 18c:	64e2                	ld	s1,24(sp)
 18e:	6942                	ld	s2,16(sp)
 190:	69a2                	ld	s3,8(sp)
 192:	6145                	addi	sp,sp,48
 194:	8082                	ret

0000000000000196 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 196:	1141                	addi	sp,sp,-16
 198:	e422                	sd	s0,8(sp)
 19a:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 19c:	4501                	li	a0,0
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	addi	sp,sp,16
 1a2:	8082                	ret

00000000000001a4 <tyield>:

void tyield()
{
 1a4:	1141                	addi	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 1aa:	00001797          	auipc	a5,0x1
 1ae:	e567b783          	ld	a5,-426(a5) # 1000 <current_thread>
 1b2:	470d                	li	a4,3
 1b4:	dfb8                	sw	a4,120(a5)
    tsched();
}
 1b6:	6422                	ld	s0,8(sp)
 1b8:	0141                	addi	sp,sp,16
 1ba:	8082                	ret

00000000000001bc <twhoami>:

uint8 twhoami()
{
 1bc:	1141                	addi	sp,sp,-16
 1be:	e422                	sd	s0,8(sp)
 1c0:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 1c2:	4501                	li	a0,0
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <tswtch>:
 1ca:	00153023          	sd	ra,0(a0)
 1ce:	00253423          	sd	sp,8(a0)
 1d2:	e900                	sd	s0,16(a0)
 1d4:	ed04                	sd	s1,24(a0)
 1d6:	03253023          	sd	s2,32(a0)
 1da:	03353423          	sd	s3,40(a0)
 1de:	03453823          	sd	s4,48(a0)
 1e2:	03553c23          	sd	s5,56(a0)
 1e6:	05653023          	sd	s6,64(a0)
 1ea:	05753423          	sd	s7,72(a0)
 1ee:	05853823          	sd	s8,80(a0)
 1f2:	05953c23          	sd	s9,88(a0)
 1f6:	07a53023          	sd	s10,96(a0)
 1fa:	07b53423          	sd	s11,104(a0)
 1fe:	0005b083          	ld	ra,0(a1)
 202:	0085b103          	ld	sp,8(a1)
 206:	6980                	ld	s0,16(a1)
 208:	6d84                	ld	s1,24(a1)
 20a:	0205b903          	ld	s2,32(a1)
 20e:	0285b983          	ld	s3,40(a1)
 212:	0305ba03          	ld	s4,48(a1)
 216:	0385ba83          	ld	s5,56(a1)
 21a:	0405bb03          	ld	s6,64(a1)
 21e:	0485bb83          	ld	s7,72(a1)
 222:	0505bc03          	ld	s8,80(a1)
 226:	0585bc83          	ld	s9,88(a1)
 22a:	0605bd03          	ld	s10,96(a1)
 22e:	0685bd83          	ld	s11,104(a1)
 232:	8082                	ret

0000000000000234 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 234:	1101                	addi	sp,sp,-32
 236:	ec06                	sd	ra,24(sp)
 238:	e822                	sd	s0,16(sp)
 23a:	e426                	sd	s1,8(sp)
 23c:	e04a                	sd	s2,0(sp)
 23e:	1000                	addi	s0,sp,32
 240:	84aa                	mv	s1,a0
 242:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 244:	09000513          	li	a0,144
 248:	00000097          	auipc	ra,0x0
 24c:	6c4080e7          	jalr	1732(ra) # 90c <malloc>

    main_thread->tid = 0;
 250:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 254:	85ca                	mv	a1,s2
 256:	8526                	mv	a0,s1
 258:	00000097          	auipc	ra,0x0
 25c:	da8080e7          	jalr	-600(ra) # 0 <main>
    exit(res);
 260:	00000097          	auipc	ra,0x0
 264:	274080e7          	jalr	628(ra) # 4d4 <exit>

0000000000000268 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 26e:	87aa                	mv	a5,a0
 270:	0585                	addi	a1,a1,1
 272:	0785                	addi	a5,a5,1
 274:	fff5c703          	lbu	a4,-1(a1)
 278:	fee78fa3          	sb	a4,-1(a5)
 27c:	fb75                	bnez	a4,270 <strcpy+0x8>
        ;
    return os;
}
 27e:	6422                	ld	s0,8(sp)
 280:	0141                	addi	sp,sp,16
 282:	8082                	ret

0000000000000284 <strcmp>:

int strcmp(const char *p, const char *q)
{
 284:	1141                	addi	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 28a:	00054783          	lbu	a5,0(a0)
 28e:	cb91                	beqz	a5,2a2 <strcmp+0x1e>
 290:	0005c703          	lbu	a4,0(a1)
 294:	00f71763          	bne	a4,a5,2a2 <strcmp+0x1e>
        p++, q++;
 298:	0505                	addi	a0,a0,1
 29a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	fbe5                	bnez	a5,290 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2a2:	0005c503          	lbu	a0,0(a1)
}
 2a6:	40a7853b          	subw	a0,a5,a0
 2aa:	6422                	ld	s0,8(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <strlen>:

uint strlen(const char *s)
{
 2b0:	1141                	addi	sp,sp,-16
 2b2:	e422                	sd	s0,8(sp)
 2b4:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	cf91                	beqz	a5,2d6 <strlen+0x26>
 2bc:	0505                	addi	a0,a0,1
 2be:	87aa                	mv	a5,a0
 2c0:	86be                	mv	a3,a5
 2c2:	0785                	addi	a5,a5,1
 2c4:	fff7c703          	lbu	a4,-1(a5)
 2c8:	ff65                	bnez	a4,2c0 <strlen+0x10>
 2ca:	40a6853b          	subw	a0,a3,a0
 2ce:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret
    for (n = 0; s[n]; n++)
 2d6:	4501                	li	a0,0
 2d8:	bfe5                	j	2d0 <strlen+0x20>

00000000000002da <memset>:

void *
memset(void *dst, int c, uint n)
{
 2da:	1141                	addi	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 2e0:	ca19                	beqz	a2,2f6 <memset+0x1c>
 2e2:	87aa                	mv	a5,a0
 2e4:	1602                	slli	a2,a2,0x20
 2e6:	9201                	srli	a2,a2,0x20
 2e8:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 2ec:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 2f0:	0785                	addi	a5,a5,1
 2f2:	fee79de3          	bne	a5,a4,2ec <memset+0x12>
    }
    return dst;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret

00000000000002fc <strchr>:

char *
strchr(const char *s, char c)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
    for (; *s; s++)
 302:	00054783          	lbu	a5,0(a0)
 306:	cb99                	beqz	a5,31c <strchr+0x20>
        if (*s == c)
 308:	00f58763          	beq	a1,a5,316 <strchr+0x1a>
    for (; *s; s++)
 30c:	0505                	addi	a0,a0,1
 30e:	00054783          	lbu	a5,0(a0)
 312:	fbfd                	bnez	a5,308 <strchr+0xc>
            return (char *)s;
    return 0;
 314:	4501                	li	a0,0
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
    return 0;
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <strchr+0x1a>

0000000000000320 <gets>:

char *
gets(char *buf, int max)
{
 320:	711d                	addi	sp,sp,-96
 322:	ec86                	sd	ra,88(sp)
 324:	e8a2                	sd	s0,80(sp)
 326:	e4a6                	sd	s1,72(sp)
 328:	e0ca                	sd	s2,64(sp)
 32a:	fc4e                	sd	s3,56(sp)
 32c:	f852                	sd	s4,48(sp)
 32e:	f456                	sd	s5,40(sp)
 330:	f05a                	sd	s6,32(sp)
 332:	ec5e                	sd	s7,24(sp)
 334:	1080                	addi	s0,sp,96
 336:	8baa                	mv	s7,a0
 338:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 33a:	892a                	mv	s2,a0
 33c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 33e:	4aa9                	li	s5,10
 340:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 342:	89a6                	mv	s3,s1
 344:	2485                	addiw	s1,s1,1
 346:	0344d863          	bge	s1,s4,376 <gets+0x56>
        cc = read(0, &c, 1);
 34a:	4605                	li	a2,1
 34c:	faf40593          	addi	a1,s0,-81
 350:	4501                	li	a0,0
 352:	00000097          	auipc	ra,0x0
 356:	19a080e7          	jalr	410(ra) # 4ec <read>
        if (cc < 1)
 35a:	00a05e63          	blez	a0,376 <gets+0x56>
        buf[i++] = c;
 35e:	faf44783          	lbu	a5,-81(s0)
 362:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 366:	01578763          	beq	a5,s5,374 <gets+0x54>
 36a:	0905                	addi	s2,s2,1
 36c:	fd679be3          	bne	a5,s6,342 <gets+0x22>
    for (i = 0; i + 1 < max;)
 370:	89a6                	mv	s3,s1
 372:	a011                	j	376 <gets+0x56>
 374:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 376:	99de                	add	s3,s3,s7
 378:	00098023          	sb	zero,0(s3)
    return buf;
}
 37c:	855e                	mv	a0,s7
 37e:	60e6                	ld	ra,88(sp)
 380:	6446                	ld	s0,80(sp)
 382:	64a6                	ld	s1,72(sp)
 384:	6906                	ld	s2,64(sp)
 386:	79e2                	ld	s3,56(sp)
 388:	7a42                	ld	s4,48(sp)
 38a:	7aa2                	ld	s5,40(sp)
 38c:	7b02                	ld	s6,32(sp)
 38e:	6be2                	ld	s7,24(sp)
 390:	6125                	addi	sp,sp,96
 392:	8082                	ret

0000000000000394 <stat>:

int stat(const char *n, struct stat *st)
{
 394:	1101                	addi	sp,sp,-32
 396:	ec06                	sd	ra,24(sp)
 398:	e822                	sd	s0,16(sp)
 39a:	e426                	sd	s1,8(sp)
 39c:	e04a                	sd	s2,0(sp)
 39e:	1000                	addi	s0,sp,32
 3a0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3a2:	4581                	li	a1,0
 3a4:	00000097          	auipc	ra,0x0
 3a8:	170080e7          	jalr	368(ra) # 514 <open>
    if (fd < 0)
 3ac:	02054563          	bltz	a0,3d6 <stat+0x42>
 3b0:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3b2:	85ca                	mv	a1,s2
 3b4:	00000097          	auipc	ra,0x0
 3b8:	178080e7          	jalr	376(ra) # 52c <fstat>
 3bc:	892a                	mv	s2,a0
    close(fd);
 3be:	8526                	mv	a0,s1
 3c0:	00000097          	auipc	ra,0x0
 3c4:	13c080e7          	jalr	316(ra) # 4fc <close>
    return r;
}
 3c8:	854a                	mv	a0,s2
 3ca:	60e2                	ld	ra,24(sp)
 3cc:	6442                	ld	s0,16(sp)
 3ce:	64a2                	ld	s1,8(sp)
 3d0:	6902                	ld	s2,0(sp)
 3d2:	6105                	addi	sp,sp,32
 3d4:	8082                	ret
        return -1;
 3d6:	597d                	li	s2,-1
 3d8:	bfc5                	j	3c8 <stat+0x34>

00000000000003da <atoi>:

int atoi(const char *s)
{
 3da:	1141                	addi	sp,sp,-16
 3dc:	e422                	sd	s0,8(sp)
 3de:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 3e0:	00054683          	lbu	a3,0(a0)
 3e4:	fd06879b          	addiw	a5,a3,-48
 3e8:	0ff7f793          	zext.b	a5,a5
 3ec:	4625                	li	a2,9
 3ee:	02f66863          	bltu	a2,a5,41e <atoi+0x44>
 3f2:	872a                	mv	a4,a0
    n = 0;
 3f4:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 3f6:	0705                	addi	a4,a4,1
 3f8:	0025179b          	slliw	a5,a0,0x2
 3fc:	9fa9                	addw	a5,a5,a0
 3fe:	0017979b          	slliw	a5,a5,0x1
 402:	9fb5                	addw	a5,a5,a3
 404:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 408:	00074683          	lbu	a3,0(a4)
 40c:	fd06879b          	addiw	a5,a3,-48
 410:	0ff7f793          	zext.b	a5,a5
 414:	fef671e3          	bgeu	a2,a5,3f6 <atoi+0x1c>
    return n;
}
 418:	6422                	ld	s0,8(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret
    n = 0;
 41e:	4501                	li	a0,0
 420:	bfe5                	j	418 <atoi+0x3e>

0000000000000422 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 422:	1141                	addi	sp,sp,-16
 424:	e422                	sd	s0,8(sp)
 426:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 428:	02b57463          	bgeu	a0,a1,450 <memmove+0x2e>
    {
        while (n-- > 0)
 42c:	00c05f63          	blez	a2,44a <memmove+0x28>
 430:	1602                	slli	a2,a2,0x20
 432:	9201                	srli	a2,a2,0x20
 434:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 438:	872a                	mv	a4,a0
            *dst++ = *src++;
 43a:	0585                	addi	a1,a1,1
 43c:	0705                	addi	a4,a4,1
 43e:	fff5c683          	lbu	a3,-1(a1)
 442:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 446:	fee79ae3          	bne	a5,a4,43a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 44a:	6422                	ld	s0,8(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret
        dst += n;
 450:	00c50733          	add	a4,a0,a2
        src += n;
 454:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 456:	fec05ae3          	blez	a2,44a <memmove+0x28>
 45a:	fff6079b          	addiw	a5,a2,-1
 45e:	1782                	slli	a5,a5,0x20
 460:	9381                	srli	a5,a5,0x20
 462:	fff7c793          	not	a5,a5
 466:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 468:	15fd                	addi	a1,a1,-1
 46a:	177d                	addi	a4,a4,-1
 46c:	0005c683          	lbu	a3,0(a1)
 470:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 474:	fee79ae3          	bne	a5,a4,468 <memmove+0x46>
 478:	bfc9                	j	44a <memmove+0x28>

000000000000047a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 480:	ca05                	beqz	a2,4b0 <memcmp+0x36>
 482:	fff6069b          	addiw	a3,a2,-1
 486:	1682                	slli	a3,a3,0x20
 488:	9281                	srli	a3,a3,0x20
 48a:	0685                	addi	a3,a3,1
 48c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 48e:	00054783          	lbu	a5,0(a0)
 492:	0005c703          	lbu	a4,0(a1)
 496:	00e79863          	bne	a5,a4,4a6 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 49a:	0505                	addi	a0,a0,1
        p2++;
 49c:	0585                	addi	a1,a1,1
    while (n-- > 0)
 49e:	fed518e3          	bne	a0,a3,48e <memcmp+0x14>
    }
    return 0;
 4a2:	4501                	li	a0,0
 4a4:	a019                	j	4aa <memcmp+0x30>
            return *p1 - *p2;
 4a6:	40e7853b          	subw	a0,a5,a4
}
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret
    return 0;
 4b0:	4501                	li	a0,0
 4b2:	bfe5                	j	4aa <memcmp+0x30>

00000000000004b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b4:	1141                	addi	sp,sp,-16
 4b6:	e406                	sd	ra,8(sp)
 4b8:	e022                	sd	s0,0(sp)
 4ba:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 4bc:	00000097          	auipc	ra,0x0
 4c0:	f66080e7          	jalr	-154(ra) # 422 <memmove>
}
 4c4:	60a2                	ld	ra,8(sp)
 4c6:	6402                	ld	s0,0(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret

00000000000004cc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4cc:	4885                	li	a7,1
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4d4:	4889                	li	a7,2
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <wait>:
.global wait
wait:
 li a7, SYS_wait
 4dc:	488d                	li	a7,3
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4e4:	4891                	li	a7,4
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <read>:
.global read
read:
 li a7, SYS_read
 4ec:	4895                	li	a7,5
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <write>:
.global write
write:
 li a7, SYS_write
 4f4:	48c1                	li	a7,16
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <close>:
.global close
close:
 li a7, SYS_close
 4fc:	48d5                	li	a7,21
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <kill>:
.global kill
kill:
 li a7, SYS_kill
 504:	4899                	li	a7,6
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <exec>:
.global exec
exec:
 li a7, SYS_exec
 50c:	489d                	li	a7,7
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <open>:
.global open
open:
 li a7, SYS_open
 514:	48bd                	li	a7,15
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 51c:	48c5                	li	a7,17
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 524:	48c9                	li	a7,18
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 52c:	48a1                	li	a7,8
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <link>:
.global link
link:
 li a7, SYS_link
 534:	48cd                	li	a7,19
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 53c:	48d1                	li	a7,20
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 544:	48a5                	li	a7,9
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <dup>:
.global dup
dup:
 li a7, SYS_dup
 54c:	48a9                	li	a7,10
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 554:	48ad                	li	a7,11
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 55c:	48b1                	li	a7,12
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 564:	48b5                	li	a7,13
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 56c:	48b9                	li	a7,14
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <ps>:
.global ps
ps:
 li a7, SYS_ps
 574:	48d9                	li	a7,22
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 57c:	48dd                	li	a7,23
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 584:	48e1                	li	a7,24
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 58c:	1101                	addi	sp,sp,-32
 58e:	ec06                	sd	ra,24(sp)
 590:	e822                	sd	s0,16(sp)
 592:	1000                	addi	s0,sp,32
 594:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 598:	4605                	li	a2,1
 59a:	fef40593          	addi	a1,s0,-17
 59e:	00000097          	auipc	ra,0x0
 5a2:	f56080e7          	jalr	-170(ra) # 4f4 <write>
}
 5a6:	60e2                	ld	ra,24(sp)
 5a8:	6442                	ld	s0,16(sp)
 5aa:	6105                	addi	sp,sp,32
 5ac:	8082                	ret

00000000000005ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ae:	7139                	addi	sp,sp,-64
 5b0:	fc06                	sd	ra,56(sp)
 5b2:	f822                	sd	s0,48(sp)
 5b4:	f426                	sd	s1,40(sp)
 5b6:	f04a                	sd	s2,32(sp)
 5b8:	ec4e                	sd	s3,24(sp)
 5ba:	0080                	addi	s0,sp,64
 5bc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5be:	c299                	beqz	a3,5c4 <printint+0x16>
 5c0:	0805c963          	bltz	a1,652 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c4:	2581                	sext.w	a1,a1
  neg = 0;
 5c6:	4881                	li	a7,0
 5c8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5cc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ce:	2601                	sext.w	a2,a2
 5d0:	00000517          	auipc	a0,0x0
 5d4:	4e050513          	addi	a0,a0,1248 # ab0 <digits>
 5d8:	883a                	mv	a6,a4
 5da:	2705                	addiw	a4,a4,1
 5dc:	02c5f7bb          	remuw	a5,a1,a2
 5e0:	1782                	slli	a5,a5,0x20
 5e2:	9381                	srli	a5,a5,0x20
 5e4:	97aa                	add	a5,a5,a0
 5e6:	0007c783          	lbu	a5,0(a5)
 5ea:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ee:	0005879b          	sext.w	a5,a1
 5f2:	02c5d5bb          	divuw	a1,a1,a2
 5f6:	0685                	addi	a3,a3,1
 5f8:	fec7f0e3          	bgeu	a5,a2,5d8 <printint+0x2a>
  if(neg)
 5fc:	00088c63          	beqz	a7,614 <printint+0x66>
    buf[i++] = '-';
 600:	fd070793          	addi	a5,a4,-48
 604:	00878733          	add	a4,a5,s0
 608:	02d00793          	li	a5,45
 60c:	fef70823          	sb	a5,-16(a4)
 610:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 614:	02e05863          	blez	a4,644 <printint+0x96>
 618:	fc040793          	addi	a5,s0,-64
 61c:	00e78933          	add	s2,a5,a4
 620:	fff78993          	addi	s3,a5,-1
 624:	99ba                	add	s3,s3,a4
 626:	377d                	addiw	a4,a4,-1
 628:	1702                	slli	a4,a4,0x20
 62a:	9301                	srli	a4,a4,0x20
 62c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 630:	fff94583          	lbu	a1,-1(s2)
 634:	8526                	mv	a0,s1
 636:	00000097          	auipc	ra,0x0
 63a:	f56080e7          	jalr	-170(ra) # 58c <putc>
  while(--i >= 0)
 63e:	197d                	addi	s2,s2,-1
 640:	ff3918e3          	bne	s2,s3,630 <printint+0x82>
}
 644:	70e2                	ld	ra,56(sp)
 646:	7442                	ld	s0,48(sp)
 648:	74a2                	ld	s1,40(sp)
 64a:	7902                	ld	s2,32(sp)
 64c:	69e2                	ld	s3,24(sp)
 64e:	6121                	addi	sp,sp,64
 650:	8082                	ret
    x = -xx;
 652:	40b005bb          	negw	a1,a1
    neg = 1;
 656:	4885                	li	a7,1
    x = -xx;
 658:	bf85                	j	5c8 <printint+0x1a>

000000000000065a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 65a:	715d                	addi	sp,sp,-80
 65c:	e486                	sd	ra,72(sp)
 65e:	e0a2                	sd	s0,64(sp)
 660:	fc26                	sd	s1,56(sp)
 662:	f84a                	sd	s2,48(sp)
 664:	f44e                	sd	s3,40(sp)
 666:	f052                	sd	s4,32(sp)
 668:	ec56                	sd	s5,24(sp)
 66a:	e85a                	sd	s6,16(sp)
 66c:	e45e                	sd	s7,8(sp)
 66e:	e062                	sd	s8,0(sp)
 670:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 672:	0005c903          	lbu	s2,0(a1)
 676:	18090c63          	beqz	s2,80e <vprintf+0x1b4>
 67a:	8aaa                	mv	s5,a0
 67c:	8bb2                	mv	s7,a2
 67e:	00158493          	addi	s1,a1,1
  state = 0;
 682:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 684:	02500a13          	li	s4,37
 688:	4b55                	li	s6,21
 68a:	a839                	j	6a8 <vprintf+0x4e>
        putc(fd, c);
 68c:	85ca                	mv	a1,s2
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	efc080e7          	jalr	-260(ra) # 58c <putc>
 698:	a019                	j	69e <vprintf+0x44>
    } else if(state == '%'){
 69a:	01498d63          	beq	s3,s4,6b4 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 69e:	0485                	addi	s1,s1,1
 6a0:	fff4c903          	lbu	s2,-1(s1)
 6a4:	16090563          	beqz	s2,80e <vprintf+0x1b4>
    if(state == 0){
 6a8:	fe0999e3          	bnez	s3,69a <vprintf+0x40>
      if(c == '%'){
 6ac:	ff4910e3          	bne	s2,s4,68c <vprintf+0x32>
        state = '%';
 6b0:	89d2                	mv	s3,s4
 6b2:	b7f5                	j	69e <vprintf+0x44>
      if(c == 'd'){
 6b4:	13490263          	beq	s2,s4,7d8 <vprintf+0x17e>
 6b8:	f9d9079b          	addiw	a5,s2,-99
 6bc:	0ff7f793          	zext.b	a5,a5
 6c0:	12fb6563          	bltu	s6,a5,7ea <vprintf+0x190>
 6c4:	f9d9079b          	addiw	a5,s2,-99
 6c8:	0ff7f713          	zext.b	a4,a5
 6cc:	10eb6f63          	bltu	s6,a4,7ea <vprintf+0x190>
 6d0:	00271793          	slli	a5,a4,0x2
 6d4:	00000717          	auipc	a4,0x0
 6d8:	38470713          	addi	a4,a4,900 # a58 <malloc+0x14c>
 6dc:	97ba                	add	a5,a5,a4
 6de:	439c                	lw	a5,0(a5)
 6e0:	97ba                	add	a5,a5,a4
 6e2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6e4:	008b8913          	addi	s2,s7,8
 6e8:	4685                	li	a3,1
 6ea:	4629                	li	a2,10
 6ec:	000ba583          	lw	a1,0(s7)
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	ebc080e7          	jalr	-324(ra) # 5ae <printint>
 6fa:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	b745                	j	69e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 700:	008b8913          	addi	s2,s7,8
 704:	4681                	li	a3,0
 706:	4629                	li	a2,10
 708:	000ba583          	lw	a1,0(s7)
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	ea0080e7          	jalr	-352(ra) # 5ae <printint>
 716:	8bca                	mv	s7,s2
      state = 0;
 718:	4981                	li	s3,0
 71a:	b751                	j	69e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 71c:	008b8913          	addi	s2,s7,8
 720:	4681                	li	a3,0
 722:	4641                	li	a2,16
 724:	000ba583          	lw	a1,0(s7)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e84080e7          	jalr	-380(ra) # 5ae <printint>
 732:	8bca                	mv	s7,s2
      state = 0;
 734:	4981                	li	s3,0
 736:	b7a5                	j	69e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 738:	008b8c13          	addi	s8,s7,8
 73c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 740:	03000593          	li	a1,48
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	e46080e7          	jalr	-442(ra) # 58c <putc>
  putc(fd, 'x');
 74e:	07800593          	li	a1,120
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	e38080e7          	jalr	-456(ra) # 58c <putc>
 75c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 75e:	00000b97          	auipc	s7,0x0
 762:	352b8b93          	addi	s7,s7,850 # ab0 <digits>
 766:	03c9d793          	srli	a5,s3,0x3c
 76a:	97de                	add	a5,a5,s7
 76c:	0007c583          	lbu	a1,0(a5)
 770:	8556                	mv	a0,s5
 772:	00000097          	auipc	ra,0x0
 776:	e1a080e7          	jalr	-486(ra) # 58c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 77a:	0992                	slli	s3,s3,0x4
 77c:	397d                	addiw	s2,s2,-1
 77e:	fe0914e3          	bnez	s2,766 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 782:	8be2                	mv	s7,s8
      state = 0;
 784:	4981                	li	s3,0
 786:	bf21                	j	69e <vprintf+0x44>
        s = va_arg(ap, char*);
 788:	008b8993          	addi	s3,s7,8
 78c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 790:	02090163          	beqz	s2,7b2 <vprintf+0x158>
        while(*s != 0){
 794:	00094583          	lbu	a1,0(s2)
 798:	c9a5                	beqz	a1,808 <vprintf+0x1ae>
          putc(fd, *s);
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	df0080e7          	jalr	-528(ra) # 58c <putc>
          s++;
 7a4:	0905                	addi	s2,s2,1
        while(*s != 0){
 7a6:	00094583          	lbu	a1,0(s2)
 7aa:	f9e5                	bnez	a1,79a <vprintf+0x140>
        s = va_arg(ap, char*);
 7ac:	8bce                	mv	s7,s3
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b5fd                	j	69e <vprintf+0x44>
          s = "(null)";
 7b2:	00000917          	auipc	s2,0x0
 7b6:	29e90913          	addi	s2,s2,670 # a50 <malloc+0x144>
        while(*s != 0){
 7ba:	02800593          	li	a1,40
 7be:	bff1                	j	79a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 7c0:	008b8913          	addi	s2,s7,8
 7c4:	000bc583          	lbu	a1,0(s7)
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	dc2080e7          	jalr	-574(ra) # 58c <putc>
 7d2:	8bca                	mv	s7,s2
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b5e1                	j	69e <vprintf+0x44>
        putc(fd, c);
 7d8:	02500593          	li	a1,37
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	dae080e7          	jalr	-594(ra) # 58c <putc>
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	bd5d                	j	69e <vprintf+0x44>
        putc(fd, '%');
 7ea:	02500593          	li	a1,37
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	d9c080e7          	jalr	-612(ra) # 58c <putc>
        putc(fd, c);
 7f8:	85ca                	mv	a1,s2
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	d90080e7          	jalr	-624(ra) # 58c <putc>
      state = 0;
 804:	4981                	li	s3,0
 806:	bd61                	j	69e <vprintf+0x44>
        s = va_arg(ap, char*);
 808:	8bce                	mv	s7,s3
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bd49                	j	69e <vprintf+0x44>
    }
  }
}
 80e:	60a6                	ld	ra,72(sp)
 810:	6406                	ld	s0,64(sp)
 812:	74e2                	ld	s1,56(sp)
 814:	7942                	ld	s2,48(sp)
 816:	79a2                	ld	s3,40(sp)
 818:	7a02                	ld	s4,32(sp)
 81a:	6ae2                	ld	s5,24(sp)
 81c:	6b42                	ld	s6,16(sp)
 81e:	6ba2                	ld	s7,8(sp)
 820:	6c02                	ld	s8,0(sp)
 822:	6161                	addi	sp,sp,80
 824:	8082                	ret

0000000000000826 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 826:	715d                	addi	sp,sp,-80
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	1000                	addi	s0,sp,32
 82e:	e010                	sd	a2,0(s0)
 830:	e414                	sd	a3,8(s0)
 832:	e818                	sd	a4,16(s0)
 834:	ec1c                	sd	a5,24(s0)
 836:	03043023          	sd	a6,32(s0)
 83a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 83e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 842:	8622                	mv	a2,s0
 844:	00000097          	auipc	ra,0x0
 848:	e16080e7          	jalr	-490(ra) # 65a <vprintf>
}
 84c:	60e2                	ld	ra,24(sp)
 84e:	6442                	ld	s0,16(sp)
 850:	6161                	addi	sp,sp,80
 852:	8082                	ret

0000000000000854 <printf>:

void
printf(const char *fmt, ...)
{
 854:	711d                	addi	sp,sp,-96
 856:	ec06                	sd	ra,24(sp)
 858:	e822                	sd	s0,16(sp)
 85a:	1000                	addi	s0,sp,32
 85c:	e40c                	sd	a1,8(s0)
 85e:	e810                	sd	a2,16(s0)
 860:	ec14                	sd	a3,24(s0)
 862:	f018                	sd	a4,32(s0)
 864:	f41c                	sd	a5,40(s0)
 866:	03043823          	sd	a6,48(s0)
 86a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 86e:	00840613          	addi	a2,s0,8
 872:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 876:	85aa                	mv	a1,a0
 878:	4505                	li	a0,1
 87a:	00000097          	auipc	ra,0x0
 87e:	de0080e7          	jalr	-544(ra) # 65a <vprintf>
}
 882:	60e2                	ld	ra,24(sp)
 884:	6442                	ld	s0,16(sp)
 886:	6125                	addi	sp,sp,96
 888:	8082                	ret

000000000000088a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 88a:	1141                	addi	sp,sp,-16
 88c:	e422                	sd	s0,8(sp)
 88e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 890:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 894:	00000797          	auipc	a5,0x0
 898:	7747b783          	ld	a5,1908(a5) # 1008 <freep>
 89c:	a02d                	j	8c6 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 89e:	4618                	lw	a4,8(a2)
 8a0:	9f2d                	addw	a4,a4,a1
 8a2:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8a6:	6398                	ld	a4,0(a5)
 8a8:	6310                	ld	a2,0(a4)
 8aa:	a83d                	j	8e8 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 8ac:	ff852703          	lw	a4,-8(a0)
 8b0:	9f31                	addw	a4,a4,a2
 8b2:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8b4:	ff053683          	ld	a3,-16(a0)
 8b8:	a091                	j	8fc <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ba:	6398                	ld	a4,0(a5)
 8bc:	00e7e463          	bltu	a5,a4,8c4 <free+0x3a>
 8c0:	00e6ea63          	bltu	a3,a4,8d4 <free+0x4a>
{
 8c4:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c6:	fed7fae3          	bgeu	a5,a3,8ba <free+0x30>
 8ca:	6398                	ld	a4,0(a5)
 8cc:	00e6e463          	bltu	a3,a4,8d4 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d0:	fee7eae3          	bltu	a5,a4,8c4 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 8d4:	ff852583          	lw	a1,-8(a0)
 8d8:	6390                	ld	a2,0(a5)
 8da:	02059813          	slli	a6,a1,0x20
 8de:	01c85713          	srli	a4,a6,0x1c
 8e2:	9736                	add	a4,a4,a3
 8e4:	fae60de3          	beq	a2,a4,89e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 8e8:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 8ec:	4790                	lw	a2,8(a5)
 8ee:	02061593          	slli	a1,a2,0x20
 8f2:	01c5d713          	srli	a4,a1,0x1c
 8f6:	973e                	add	a4,a4,a5
 8f8:	fae68ae3          	beq	a3,a4,8ac <free+0x22>
        p->s.ptr = bp->s.ptr;
 8fc:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 8fe:	00000717          	auipc	a4,0x0
 902:	70f73523          	sd	a5,1802(a4) # 1008 <freep>
}
 906:	6422                	ld	s0,8(sp)
 908:	0141                	addi	sp,sp,16
 90a:	8082                	ret

000000000000090c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 90c:	7139                	addi	sp,sp,-64
 90e:	fc06                	sd	ra,56(sp)
 910:	f822                	sd	s0,48(sp)
 912:	f426                	sd	s1,40(sp)
 914:	f04a                	sd	s2,32(sp)
 916:	ec4e                	sd	s3,24(sp)
 918:	e852                	sd	s4,16(sp)
 91a:	e456                	sd	s5,8(sp)
 91c:	e05a                	sd	s6,0(sp)
 91e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 920:	02051493          	slli	s1,a0,0x20
 924:	9081                	srli	s1,s1,0x20
 926:	04bd                	addi	s1,s1,15
 928:	8091                	srli	s1,s1,0x4
 92a:	0014899b          	addiw	s3,s1,1
 92e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 930:	00000517          	auipc	a0,0x0
 934:	6d853503          	ld	a0,1752(a0) # 1008 <freep>
 938:	c515                	beqz	a0,964 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 93a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 93c:	4798                	lw	a4,8(a5)
 93e:	02977f63          	bgeu	a4,s1,97c <malloc+0x70>
    if (nu < 4096)
 942:	8a4e                	mv	s4,s3
 944:	0009871b          	sext.w	a4,s3
 948:	6685                	lui	a3,0x1
 94a:	00d77363          	bgeu	a4,a3,950 <malloc+0x44>
 94e:	6a05                	lui	s4,0x1
 950:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 954:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 958:	00000917          	auipc	s2,0x0
 95c:	6b090913          	addi	s2,s2,1712 # 1008 <freep>
    if (p == (char *)-1)
 960:	5afd                	li	s5,-1
 962:	a895                	j	9d6 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 964:	00000797          	auipc	a5,0x0
 968:	6ac78793          	addi	a5,a5,1708 # 1010 <base>
 96c:	00000717          	auipc	a4,0x0
 970:	68f73e23          	sd	a5,1692(a4) # 1008 <freep>
 974:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 976:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 97a:	b7e1                	j	942 <malloc+0x36>
            if (p->s.size == nunits)
 97c:	02e48c63          	beq	s1,a4,9b4 <malloc+0xa8>
                p->s.size -= nunits;
 980:	4137073b          	subw	a4,a4,s3
 984:	c798                	sw	a4,8(a5)
                p += p->s.size;
 986:	02071693          	slli	a3,a4,0x20
 98a:	01c6d713          	srli	a4,a3,0x1c
 98e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 990:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 994:	00000717          	auipc	a4,0x0
 998:	66a73a23          	sd	a0,1652(a4) # 1008 <freep>
            return (void *)(p + 1);
 99c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9a0:	70e2                	ld	ra,56(sp)
 9a2:	7442                	ld	s0,48(sp)
 9a4:	74a2                	ld	s1,40(sp)
 9a6:	7902                	ld	s2,32(sp)
 9a8:	69e2                	ld	s3,24(sp)
 9aa:	6a42                	ld	s4,16(sp)
 9ac:	6aa2                	ld	s5,8(sp)
 9ae:	6b02                	ld	s6,0(sp)
 9b0:	6121                	addi	sp,sp,64
 9b2:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 9b4:	6398                	ld	a4,0(a5)
 9b6:	e118                	sd	a4,0(a0)
 9b8:	bff1                	j	994 <malloc+0x88>
    hp->s.size = nu;
 9ba:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 9be:	0541                	addi	a0,a0,16
 9c0:	00000097          	auipc	ra,0x0
 9c4:	eca080e7          	jalr	-310(ra) # 88a <free>
    return freep;
 9c8:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 9cc:	d971                	beqz	a0,9a0 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 9ce:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 9d0:	4798                	lw	a4,8(a5)
 9d2:	fa9775e3          	bgeu	a4,s1,97c <malloc+0x70>
        if (p == freep)
 9d6:	00093703          	ld	a4,0(s2)
 9da:	853e                	mv	a0,a5
 9dc:	fef719e3          	bne	a4,a5,9ce <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 9e0:	8552                	mv	a0,s4
 9e2:	00000097          	auipc	ra,0x0
 9e6:	b7a080e7          	jalr	-1158(ra) # 55c <sbrk>
    if (p == (char *)-1)
 9ea:	fd5518e3          	bne	a0,s5,9ba <malloc+0xae>
                return 0;
 9ee:	4501                	li	a0,0
 9f0:	bf45                	j	9a0 <malloc+0x94>
