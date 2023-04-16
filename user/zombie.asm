
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	4d4080e7          	jalr	1236(ra) # 4dc <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	4ce080e7          	jalr	1230(ra) # 4e4 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	554080e7          	jalr	1364(ra) # 574 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e422                	sd	s0,8(sp)
  2e:	0800                	addi	s0,sp,16
    lk->name = name;
  30:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  32:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  36:	57fd                	li	a5,-1
  38:	00f50823          	sb	a5,16(a0)
}
  3c:	6422                	ld	s0,8(sp)
  3e:	0141                	addi	sp,sp,16
  40:	8082                	ret

0000000000000042 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  42:	00054783          	lbu	a5,0(a0)
  46:	e399                	bnez	a5,4c <holding+0xa>
  48:	4501                	li	a0,0
}
  4a:	8082                	ret
{
  4c:	1101                	addi	sp,sp,-32
  4e:	ec06                	sd	ra,24(sp)
  50:	e822                	sd	s0,16(sp)
  52:	e426                	sd	s1,8(sp)
  54:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  56:	01054483          	lbu	s1,16(a0)
  5a:	00000097          	auipc	ra,0x0
  5e:	172080e7          	jalr	370(ra) # 1cc <twhoami>
  62:	2501                	sext.w	a0,a0
  64:	40a48533          	sub	a0,s1,a0
  68:	00153513          	seqz	a0,a0
}
  6c:	60e2                	ld	ra,24(sp)
  6e:	6442                	ld	s0,16(sp)
  70:	64a2                	ld	s1,8(sp)
  72:	6105                	addi	sp,sp,32
  74:	8082                	ret

0000000000000076 <acquire>:

void acquire(struct lock *lk)
{
  76:	7179                	addi	sp,sp,-48
  78:	f406                	sd	ra,40(sp)
  7a:	f022                	sd	s0,32(sp)
  7c:	ec26                	sd	s1,24(sp)
  7e:	e84a                	sd	s2,16(sp)
  80:	e44e                	sd	s3,8(sp)
  82:	e052                	sd	s4,0(sp)
  84:	1800                	addi	s0,sp,48
  86:	8a2a                	mv	s4,a0
    if (holding(lk))
  88:	00000097          	auipc	ra,0x0
  8c:	fba080e7          	jalr	-70(ra) # 42 <holding>
  90:	e919                	bnez	a0,a6 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  92:	ffca7493          	andi	s1,s4,-4
  96:	003a7913          	andi	s2,s4,3
  9a:	0039191b          	slliw	s2,s2,0x3
  9e:	4985                	li	s3,1
  a0:	012999bb          	sllw	s3,s3,s2
  a4:	a015                	j	c8 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  a6:	00001517          	auipc	a0,0x1
  aa:	96a50513          	addi	a0,a0,-1686 # a10 <malloc+0xf4>
  ae:	00000097          	auipc	ra,0x0
  b2:	7b6080e7          	jalr	1974(ra) # 864 <printf>
        exit(-1);
  b6:	557d                	li	a0,-1
  b8:	00000097          	auipc	ra,0x0
  bc:	42c080e7          	jalr	1068(ra) # 4e4 <exit>
    {
        // give up the cpu for other threads
        tyield();
  c0:	00000097          	auipc	ra,0x0
  c4:	0f4080e7          	jalr	244(ra) # 1b4 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c8:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  cc:	0127d7bb          	srlw	a5,a5,s2
  d0:	0ff7f793          	zext.b	a5,a5
  d4:	f7f5                	bnez	a5,c0 <acquire+0x4a>
    }

    __sync_synchronize();
  d6:	0ff0000f          	fence

    lk->tid = twhoami();
  da:	00000097          	auipc	ra,0x0
  de:	0f2080e7          	jalr	242(ra) # 1cc <twhoami>
  e2:	00aa0823          	sb	a0,16(s4)
}
  e6:	70a2                	ld	ra,40(sp)
  e8:	7402                	ld	s0,32(sp)
  ea:	64e2                	ld	s1,24(sp)
  ec:	6942                	ld	s2,16(sp)
  ee:	69a2                	ld	s3,8(sp)
  f0:	6a02                	ld	s4,0(sp)
  f2:	6145                	addi	sp,sp,48
  f4:	8082                	ret

00000000000000f6 <release>:

void release(struct lock *lk)
{
  f6:	1101                	addi	sp,sp,-32
  f8:	ec06                	sd	ra,24(sp)
  fa:	e822                	sd	s0,16(sp)
  fc:	e426                	sd	s1,8(sp)
  fe:	1000                	addi	s0,sp,32
 100:	84aa                	mv	s1,a0
    if (!holding(lk))
 102:	00000097          	auipc	ra,0x0
 106:	f40080e7          	jalr	-192(ra) # 42 <holding>
 10a:	c11d                	beqz	a0,130 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 10c:	57fd                	li	a5,-1
 10e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 112:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 116:	0ff0000f          	fence
 11a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 11e:	00000097          	auipc	ra,0x0
 122:	096080e7          	jalr	150(ra) # 1b4 <tyield>
}
 126:	60e2                	ld	ra,24(sp)
 128:	6442                	ld	s0,16(sp)
 12a:	64a2                	ld	s1,8(sp)
 12c:	6105                	addi	sp,sp,32
 12e:	8082                	ret
        printf("releasing lock we are not holding");
 130:	00001517          	auipc	a0,0x1
 134:	90850513          	addi	a0,a0,-1784 # a38 <malloc+0x11c>
 138:	00000097          	auipc	ra,0x0
 13c:	72c080e7          	jalr	1836(ra) # 864 <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	3a2080e7          	jalr	930(ra) # 4e4 <exit>

000000000000014a <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e422                	sd	s0,8(sp)
 14e:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 150:	00001717          	auipc	a4,0x1
 154:	eb073703          	ld	a4,-336(a4) # 1000 <current_thread>
 158:	47c1                	li	a5,16
 15a:	c319                	beqz	a4,160 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 15c:	37fd                	addiw	a5,a5,-1
 15e:	fff5                	bnez	a5,15a <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret

0000000000000166 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 166:	7179                	addi	sp,sp,-48
 168:	f406                	sd	ra,40(sp)
 16a:	f022                	sd	s0,32(sp)
 16c:	ec26                	sd	s1,24(sp)
 16e:	e84a                	sd	s2,16(sp)
 170:	e44e                	sd	s3,8(sp)
 172:	1800                	addi	s0,sp,48
 174:	84aa                	mv	s1,a0
 176:	89b2                	mv	s3,a2
 178:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 17a:	09000513          	li	a0,144
 17e:	00000097          	auipc	ra,0x0
 182:	79e080e7          	jalr	1950(ra) # 91c <malloc>
 186:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 188:	478d                	li	a5,3
 18a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 18c:	609c                	ld	a5,0(s1)
 18e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 192:	609c                	ld	a5,0(s1)
 194:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 198:	70a2                	ld	ra,40(sp)
 19a:	7402                	ld	s0,32(sp)
 19c:	64e2                	ld	s1,24(sp)
 19e:	6942                	ld	s2,16(sp)
 1a0:	69a2                	ld	s3,8(sp)
 1a2:	6145                	addi	sp,sp,48
 1a4:	8082                	ret

00000000000001a6 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 1a6:	1141                	addi	sp,sp,-16
 1a8:	e422                	sd	s0,8(sp)
 1aa:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 1ac:	4501                	li	a0,0
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <tyield>:

void tyield()
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 1ba:	00001797          	auipc	a5,0x1
 1be:	e467b783          	ld	a5,-442(a5) # 1000 <current_thread>
 1c2:	470d                	li	a4,3
 1c4:	dfb8                	sw	a4,120(a5)
    tsched();
}
 1c6:	6422                	ld	s0,8(sp)
 1c8:	0141                	addi	sp,sp,16
 1ca:	8082                	ret

00000000000001cc <twhoami>:

uint8 twhoami()
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 1d2:	4501                	li	a0,0
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret

00000000000001da <tswtch>:
 1da:	00153023          	sd	ra,0(a0)
 1de:	00253423          	sd	sp,8(a0)
 1e2:	e900                	sd	s0,16(a0)
 1e4:	ed04                	sd	s1,24(a0)
 1e6:	03253023          	sd	s2,32(a0)
 1ea:	03353423          	sd	s3,40(a0)
 1ee:	03453823          	sd	s4,48(a0)
 1f2:	03553c23          	sd	s5,56(a0)
 1f6:	05653023          	sd	s6,64(a0)
 1fa:	05753423          	sd	s7,72(a0)
 1fe:	05853823          	sd	s8,80(a0)
 202:	05953c23          	sd	s9,88(a0)
 206:	07a53023          	sd	s10,96(a0)
 20a:	07b53423          	sd	s11,104(a0)
 20e:	0005b083          	ld	ra,0(a1)
 212:	0085b103          	ld	sp,8(a1)
 216:	6980                	ld	s0,16(a1)
 218:	6d84                	ld	s1,24(a1)
 21a:	0205b903          	ld	s2,32(a1)
 21e:	0285b983          	ld	s3,40(a1)
 222:	0305ba03          	ld	s4,48(a1)
 226:	0385ba83          	ld	s5,56(a1)
 22a:	0405bb03          	ld	s6,64(a1)
 22e:	0485bb83          	ld	s7,72(a1)
 232:	0505bc03          	ld	s8,80(a1)
 236:	0585bc83          	ld	s9,88(a1)
 23a:	0605bd03          	ld	s10,96(a1)
 23e:	0685bd83          	ld	s11,104(a1)
 242:	8082                	ret

0000000000000244 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 244:	1101                	addi	sp,sp,-32
 246:	ec06                	sd	ra,24(sp)
 248:	e822                	sd	s0,16(sp)
 24a:	e426                	sd	s1,8(sp)
 24c:	e04a                	sd	s2,0(sp)
 24e:	1000                	addi	s0,sp,32
 250:	84aa                	mv	s1,a0
 252:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 254:	09000513          	li	a0,144
 258:	00000097          	auipc	ra,0x0
 25c:	6c4080e7          	jalr	1732(ra) # 91c <malloc>

    main_thread->tid = 0;
 260:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 264:	85ca                	mv	a1,s2
 266:	8526                	mv	a0,s1
 268:	00000097          	auipc	ra,0x0
 26c:	d98080e7          	jalr	-616(ra) # 0 <main>
    exit(res);
 270:	00000097          	auipc	ra,0x0
 274:	274080e7          	jalr	628(ra) # 4e4 <exit>

0000000000000278 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 278:	1141                	addi	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 27e:	87aa                	mv	a5,a0
 280:	0585                	addi	a1,a1,1
 282:	0785                	addi	a5,a5,1
 284:	fff5c703          	lbu	a4,-1(a1)
 288:	fee78fa3          	sb	a4,-1(a5)
 28c:	fb75                	bnez	a4,280 <strcpy+0x8>
        ;
    return os;
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret

0000000000000294 <strcmp>:

int strcmp(const char *p, const char *q)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 29a:	00054783          	lbu	a5,0(a0)
 29e:	cb91                	beqz	a5,2b2 <strcmp+0x1e>
 2a0:	0005c703          	lbu	a4,0(a1)
 2a4:	00f71763          	bne	a4,a5,2b2 <strcmp+0x1e>
        p++, q++;
 2a8:	0505                	addi	a0,a0,1
 2aa:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	fbe5                	bnez	a5,2a0 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2b2:	0005c503          	lbu	a0,0(a1)
}
 2b6:	40a7853b          	subw	a0,a5,a0
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret

00000000000002c0 <strlen>:

uint strlen(const char *s)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e422                	sd	s0,8(sp)
 2c4:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	cf91                	beqz	a5,2e6 <strlen+0x26>
 2cc:	0505                	addi	a0,a0,1
 2ce:	87aa                	mv	a5,a0
 2d0:	86be                	mv	a3,a5
 2d2:	0785                	addi	a5,a5,1
 2d4:	fff7c703          	lbu	a4,-1(a5)
 2d8:	ff65                	bnez	a4,2d0 <strlen+0x10>
 2da:	40a6853b          	subw	a0,a3,a0
 2de:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
    for (n = 0; s[n]; n++)
 2e6:	4501                	li	a0,0
 2e8:	bfe5                	j	2e0 <strlen+0x20>

00000000000002ea <memset>:

void *
memset(void *dst, int c, uint n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 2f0:	ca19                	beqz	a2,306 <memset+0x1c>
 2f2:	87aa                	mv	a5,a0
 2f4:	1602                	slli	a2,a2,0x20
 2f6:	9201                	srli	a2,a2,0x20
 2f8:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 2fc:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 300:	0785                	addi	a5,a5,1
 302:	fee79de3          	bne	a5,a4,2fc <memset+0x12>
    }
    return dst;
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <strchr>:

char *
strchr(const char *s, char c)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	addi	s0,sp,16
    for (; *s; s++)
 312:	00054783          	lbu	a5,0(a0)
 316:	cb99                	beqz	a5,32c <strchr+0x20>
        if (*s == c)
 318:	00f58763          	beq	a1,a5,326 <strchr+0x1a>
    for (; *s; s++)
 31c:	0505                	addi	a0,a0,1
 31e:	00054783          	lbu	a5,0(a0)
 322:	fbfd                	bnez	a5,318 <strchr+0xc>
            return (char *)s;
    return 0;
 324:	4501                	li	a0,0
}
 326:	6422                	ld	s0,8(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret
    return 0;
 32c:	4501                	li	a0,0
 32e:	bfe5                	j	326 <strchr+0x1a>

0000000000000330 <gets>:

char *
gets(char *buf, int max)
{
 330:	711d                	addi	sp,sp,-96
 332:	ec86                	sd	ra,88(sp)
 334:	e8a2                	sd	s0,80(sp)
 336:	e4a6                	sd	s1,72(sp)
 338:	e0ca                	sd	s2,64(sp)
 33a:	fc4e                	sd	s3,56(sp)
 33c:	f852                	sd	s4,48(sp)
 33e:	f456                	sd	s5,40(sp)
 340:	f05a                	sd	s6,32(sp)
 342:	ec5e                	sd	s7,24(sp)
 344:	1080                	addi	s0,sp,96
 346:	8baa                	mv	s7,a0
 348:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 34a:	892a                	mv	s2,a0
 34c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 34e:	4aa9                	li	s5,10
 350:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 352:	89a6                	mv	s3,s1
 354:	2485                	addiw	s1,s1,1
 356:	0344d863          	bge	s1,s4,386 <gets+0x56>
        cc = read(0, &c, 1);
 35a:	4605                	li	a2,1
 35c:	faf40593          	addi	a1,s0,-81
 360:	4501                	li	a0,0
 362:	00000097          	auipc	ra,0x0
 366:	19a080e7          	jalr	410(ra) # 4fc <read>
        if (cc < 1)
 36a:	00a05e63          	blez	a0,386 <gets+0x56>
        buf[i++] = c;
 36e:	faf44783          	lbu	a5,-81(s0)
 372:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 376:	01578763          	beq	a5,s5,384 <gets+0x54>
 37a:	0905                	addi	s2,s2,1
 37c:	fd679be3          	bne	a5,s6,352 <gets+0x22>
    for (i = 0; i + 1 < max;)
 380:	89a6                	mv	s3,s1
 382:	a011                	j	386 <gets+0x56>
 384:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 386:	99de                	add	s3,s3,s7
 388:	00098023          	sb	zero,0(s3)
    return buf;
}
 38c:	855e                	mv	a0,s7
 38e:	60e6                	ld	ra,88(sp)
 390:	6446                	ld	s0,80(sp)
 392:	64a6                	ld	s1,72(sp)
 394:	6906                	ld	s2,64(sp)
 396:	79e2                	ld	s3,56(sp)
 398:	7a42                	ld	s4,48(sp)
 39a:	7aa2                	ld	s5,40(sp)
 39c:	7b02                	ld	s6,32(sp)
 39e:	6be2                	ld	s7,24(sp)
 3a0:	6125                	addi	sp,sp,96
 3a2:	8082                	ret

00000000000003a4 <stat>:

int stat(const char *n, struct stat *st)
{
 3a4:	1101                	addi	sp,sp,-32
 3a6:	ec06                	sd	ra,24(sp)
 3a8:	e822                	sd	s0,16(sp)
 3aa:	e426                	sd	s1,8(sp)
 3ac:	e04a                	sd	s2,0(sp)
 3ae:	1000                	addi	s0,sp,32
 3b0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3b2:	4581                	li	a1,0
 3b4:	00000097          	auipc	ra,0x0
 3b8:	170080e7          	jalr	368(ra) # 524 <open>
    if (fd < 0)
 3bc:	02054563          	bltz	a0,3e6 <stat+0x42>
 3c0:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3c2:	85ca                	mv	a1,s2
 3c4:	00000097          	auipc	ra,0x0
 3c8:	178080e7          	jalr	376(ra) # 53c <fstat>
 3cc:	892a                	mv	s2,a0
    close(fd);
 3ce:	8526                	mv	a0,s1
 3d0:	00000097          	auipc	ra,0x0
 3d4:	13c080e7          	jalr	316(ra) # 50c <close>
    return r;
}
 3d8:	854a                	mv	a0,s2
 3da:	60e2                	ld	ra,24(sp)
 3dc:	6442                	ld	s0,16(sp)
 3de:	64a2                	ld	s1,8(sp)
 3e0:	6902                	ld	s2,0(sp)
 3e2:	6105                	addi	sp,sp,32
 3e4:	8082                	ret
        return -1;
 3e6:	597d                	li	s2,-1
 3e8:	bfc5                	j	3d8 <stat+0x34>

00000000000003ea <atoi>:

int atoi(const char *s)
{
 3ea:	1141                	addi	sp,sp,-16
 3ec:	e422                	sd	s0,8(sp)
 3ee:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 3f0:	00054683          	lbu	a3,0(a0)
 3f4:	fd06879b          	addiw	a5,a3,-48
 3f8:	0ff7f793          	zext.b	a5,a5
 3fc:	4625                	li	a2,9
 3fe:	02f66863          	bltu	a2,a5,42e <atoi+0x44>
 402:	872a                	mv	a4,a0
    n = 0;
 404:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 406:	0705                	addi	a4,a4,1
 408:	0025179b          	slliw	a5,a0,0x2
 40c:	9fa9                	addw	a5,a5,a0
 40e:	0017979b          	slliw	a5,a5,0x1
 412:	9fb5                	addw	a5,a5,a3
 414:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 418:	00074683          	lbu	a3,0(a4)
 41c:	fd06879b          	addiw	a5,a3,-48
 420:	0ff7f793          	zext.b	a5,a5
 424:	fef671e3          	bgeu	a2,a5,406 <atoi+0x1c>
    return n;
}
 428:	6422                	ld	s0,8(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
    n = 0;
 42e:	4501                	li	a0,0
 430:	bfe5                	j	428 <atoi+0x3e>

0000000000000432 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 432:	1141                	addi	sp,sp,-16
 434:	e422                	sd	s0,8(sp)
 436:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 438:	02b57463          	bgeu	a0,a1,460 <memmove+0x2e>
    {
        while (n-- > 0)
 43c:	00c05f63          	blez	a2,45a <memmove+0x28>
 440:	1602                	slli	a2,a2,0x20
 442:	9201                	srli	a2,a2,0x20
 444:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 448:	872a                	mv	a4,a0
            *dst++ = *src++;
 44a:	0585                	addi	a1,a1,1
 44c:	0705                	addi	a4,a4,1
 44e:	fff5c683          	lbu	a3,-1(a1)
 452:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 456:	fee79ae3          	bne	a5,a4,44a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 45a:	6422                	ld	s0,8(sp)
 45c:	0141                	addi	sp,sp,16
 45e:	8082                	ret
        dst += n;
 460:	00c50733          	add	a4,a0,a2
        src += n;
 464:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 466:	fec05ae3          	blez	a2,45a <memmove+0x28>
 46a:	fff6079b          	addiw	a5,a2,-1
 46e:	1782                	slli	a5,a5,0x20
 470:	9381                	srli	a5,a5,0x20
 472:	fff7c793          	not	a5,a5
 476:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 478:	15fd                	addi	a1,a1,-1
 47a:	177d                	addi	a4,a4,-1
 47c:	0005c683          	lbu	a3,0(a1)
 480:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 484:	fee79ae3          	bne	a5,a4,478 <memmove+0x46>
 488:	bfc9                	j	45a <memmove+0x28>

000000000000048a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 48a:	1141                	addi	sp,sp,-16
 48c:	e422                	sd	s0,8(sp)
 48e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 490:	ca05                	beqz	a2,4c0 <memcmp+0x36>
 492:	fff6069b          	addiw	a3,a2,-1
 496:	1682                	slli	a3,a3,0x20
 498:	9281                	srli	a3,a3,0x20
 49a:	0685                	addi	a3,a3,1
 49c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	0005c703          	lbu	a4,0(a1)
 4a6:	00e79863          	bne	a5,a4,4b6 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 4aa:	0505                	addi	a0,a0,1
        p2++;
 4ac:	0585                	addi	a1,a1,1
    while (n-- > 0)
 4ae:	fed518e3          	bne	a0,a3,49e <memcmp+0x14>
    }
    return 0;
 4b2:	4501                	li	a0,0
 4b4:	a019                	j	4ba <memcmp+0x30>
            return *p1 - *p2;
 4b6:	40e7853b          	subw	a0,a5,a4
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret
    return 0;
 4c0:	4501                	li	a0,0
 4c2:	bfe5                	j	4ba <memcmp+0x30>

00000000000004c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4c4:	1141                	addi	sp,sp,-16
 4c6:	e406                	sd	ra,8(sp)
 4c8:	e022                	sd	s0,0(sp)
 4ca:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 4cc:	00000097          	auipc	ra,0x0
 4d0:	f66080e7          	jalr	-154(ra) # 432 <memmove>
}
 4d4:	60a2                	ld	ra,8(sp)
 4d6:	6402                	ld	s0,0(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret

00000000000004dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4dc:	4885                	li	a7,1
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e4:	4889                	li	a7,2
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ec:	488d                	li	a7,3
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f4:	4891                	li	a7,4
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <read>:
.global read
read:
 li a7, SYS_read
 4fc:	4895                	li	a7,5
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <write>:
.global write
write:
 li a7, SYS_write
 504:	48c1                	li	a7,16
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <close>:
.global close
close:
 li a7, SYS_close
 50c:	48d5                	li	a7,21
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <kill>:
.global kill
kill:
 li a7, SYS_kill
 514:	4899                	li	a7,6
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <exec>:
.global exec
exec:
 li a7, SYS_exec
 51c:	489d                	li	a7,7
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <open>:
.global open
open:
 li a7, SYS_open
 524:	48bd                	li	a7,15
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 52c:	48c5                	li	a7,17
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 534:	48c9                	li	a7,18
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 53c:	48a1                	li	a7,8
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <link>:
.global link
link:
 li a7, SYS_link
 544:	48cd                	li	a7,19
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 54c:	48d1                	li	a7,20
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 554:	48a5                	li	a7,9
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <dup>:
.global dup
dup:
 li a7, SYS_dup
 55c:	48a9                	li	a7,10
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 564:	48ad                	li	a7,11
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 56c:	48b1                	li	a7,12
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 574:	48b5                	li	a7,13
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 57c:	48b9                	li	a7,14
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <ps>:
.global ps
ps:
 li a7, SYS_ps
 584:	48d9                	li	a7,22
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 58c:	48dd                	li	a7,23
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 594:	48e1                	li	a7,24
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 59c:	1101                	addi	sp,sp,-32
 59e:	ec06                	sd	ra,24(sp)
 5a0:	e822                	sd	s0,16(sp)
 5a2:	1000                	addi	s0,sp,32
 5a4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5a8:	4605                	li	a2,1
 5aa:	fef40593          	addi	a1,s0,-17
 5ae:	00000097          	auipc	ra,0x0
 5b2:	f56080e7          	jalr	-170(ra) # 504 <write>
}
 5b6:	60e2                	ld	ra,24(sp)
 5b8:	6442                	ld	s0,16(sp)
 5ba:	6105                	addi	sp,sp,32
 5bc:	8082                	ret

00000000000005be <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5be:	7139                	addi	sp,sp,-64
 5c0:	fc06                	sd	ra,56(sp)
 5c2:	f822                	sd	s0,48(sp)
 5c4:	f426                	sd	s1,40(sp)
 5c6:	f04a                	sd	s2,32(sp)
 5c8:	ec4e                	sd	s3,24(sp)
 5ca:	0080                	addi	s0,sp,64
 5cc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ce:	c299                	beqz	a3,5d4 <printint+0x16>
 5d0:	0805c963          	bltz	a1,662 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5d4:	2581                	sext.w	a1,a1
  neg = 0;
 5d6:	4881                	li	a7,0
 5d8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5dc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5de:	2601                	sext.w	a2,a2
 5e0:	00000517          	auipc	a0,0x0
 5e4:	4e050513          	addi	a0,a0,1248 # ac0 <digits>
 5e8:	883a                	mv	a6,a4
 5ea:	2705                	addiw	a4,a4,1
 5ec:	02c5f7bb          	remuw	a5,a1,a2
 5f0:	1782                	slli	a5,a5,0x20
 5f2:	9381                	srli	a5,a5,0x20
 5f4:	97aa                	add	a5,a5,a0
 5f6:	0007c783          	lbu	a5,0(a5)
 5fa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5fe:	0005879b          	sext.w	a5,a1
 602:	02c5d5bb          	divuw	a1,a1,a2
 606:	0685                	addi	a3,a3,1
 608:	fec7f0e3          	bgeu	a5,a2,5e8 <printint+0x2a>
  if(neg)
 60c:	00088c63          	beqz	a7,624 <printint+0x66>
    buf[i++] = '-';
 610:	fd070793          	addi	a5,a4,-48
 614:	00878733          	add	a4,a5,s0
 618:	02d00793          	li	a5,45
 61c:	fef70823          	sb	a5,-16(a4)
 620:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 624:	02e05863          	blez	a4,654 <printint+0x96>
 628:	fc040793          	addi	a5,s0,-64
 62c:	00e78933          	add	s2,a5,a4
 630:	fff78993          	addi	s3,a5,-1
 634:	99ba                	add	s3,s3,a4
 636:	377d                	addiw	a4,a4,-1
 638:	1702                	slli	a4,a4,0x20
 63a:	9301                	srli	a4,a4,0x20
 63c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 640:	fff94583          	lbu	a1,-1(s2)
 644:	8526                	mv	a0,s1
 646:	00000097          	auipc	ra,0x0
 64a:	f56080e7          	jalr	-170(ra) # 59c <putc>
  while(--i >= 0)
 64e:	197d                	addi	s2,s2,-1
 650:	ff3918e3          	bne	s2,s3,640 <printint+0x82>
}
 654:	70e2                	ld	ra,56(sp)
 656:	7442                	ld	s0,48(sp)
 658:	74a2                	ld	s1,40(sp)
 65a:	7902                	ld	s2,32(sp)
 65c:	69e2                	ld	s3,24(sp)
 65e:	6121                	addi	sp,sp,64
 660:	8082                	ret
    x = -xx;
 662:	40b005bb          	negw	a1,a1
    neg = 1;
 666:	4885                	li	a7,1
    x = -xx;
 668:	bf85                	j	5d8 <printint+0x1a>

000000000000066a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 66a:	715d                	addi	sp,sp,-80
 66c:	e486                	sd	ra,72(sp)
 66e:	e0a2                	sd	s0,64(sp)
 670:	fc26                	sd	s1,56(sp)
 672:	f84a                	sd	s2,48(sp)
 674:	f44e                	sd	s3,40(sp)
 676:	f052                	sd	s4,32(sp)
 678:	ec56                	sd	s5,24(sp)
 67a:	e85a                	sd	s6,16(sp)
 67c:	e45e                	sd	s7,8(sp)
 67e:	e062                	sd	s8,0(sp)
 680:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 682:	0005c903          	lbu	s2,0(a1)
 686:	18090c63          	beqz	s2,81e <vprintf+0x1b4>
 68a:	8aaa                	mv	s5,a0
 68c:	8bb2                	mv	s7,a2
 68e:	00158493          	addi	s1,a1,1
  state = 0;
 692:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 694:	02500a13          	li	s4,37
 698:	4b55                	li	s6,21
 69a:	a839                	j	6b8 <vprintf+0x4e>
        putc(fd, c);
 69c:	85ca                	mv	a1,s2
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	efc080e7          	jalr	-260(ra) # 59c <putc>
 6a8:	a019                	j	6ae <vprintf+0x44>
    } else if(state == '%'){
 6aa:	01498d63          	beq	s3,s4,6c4 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6ae:	0485                	addi	s1,s1,1
 6b0:	fff4c903          	lbu	s2,-1(s1)
 6b4:	16090563          	beqz	s2,81e <vprintf+0x1b4>
    if(state == 0){
 6b8:	fe0999e3          	bnez	s3,6aa <vprintf+0x40>
      if(c == '%'){
 6bc:	ff4910e3          	bne	s2,s4,69c <vprintf+0x32>
        state = '%';
 6c0:	89d2                	mv	s3,s4
 6c2:	b7f5                	j	6ae <vprintf+0x44>
      if(c == 'd'){
 6c4:	13490263          	beq	s2,s4,7e8 <vprintf+0x17e>
 6c8:	f9d9079b          	addiw	a5,s2,-99
 6cc:	0ff7f793          	zext.b	a5,a5
 6d0:	12fb6563          	bltu	s6,a5,7fa <vprintf+0x190>
 6d4:	f9d9079b          	addiw	a5,s2,-99
 6d8:	0ff7f713          	zext.b	a4,a5
 6dc:	10eb6f63          	bltu	s6,a4,7fa <vprintf+0x190>
 6e0:	00271793          	slli	a5,a4,0x2
 6e4:	00000717          	auipc	a4,0x0
 6e8:	38470713          	addi	a4,a4,900 # a68 <malloc+0x14c>
 6ec:	97ba                	add	a5,a5,a4
 6ee:	439c                	lw	a5,0(a5)
 6f0:	97ba                	add	a5,a5,a4
 6f2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6f4:	008b8913          	addi	s2,s7,8
 6f8:	4685                	li	a3,1
 6fa:	4629                	li	a2,10
 6fc:	000ba583          	lw	a1,0(s7)
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	ebc080e7          	jalr	-324(ra) # 5be <printint>
 70a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 70c:	4981                	li	s3,0
 70e:	b745                	j	6ae <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 710:	008b8913          	addi	s2,s7,8
 714:	4681                	li	a3,0
 716:	4629                	li	a2,10
 718:	000ba583          	lw	a1,0(s7)
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	ea0080e7          	jalr	-352(ra) # 5be <printint>
 726:	8bca                	mv	s7,s2
      state = 0;
 728:	4981                	li	s3,0
 72a:	b751                	j	6ae <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 72c:	008b8913          	addi	s2,s7,8
 730:	4681                	li	a3,0
 732:	4641                	li	a2,16
 734:	000ba583          	lw	a1,0(s7)
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	e84080e7          	jalr	-380(ra) # 5be <printint>
 742:	8bca                	mv	s7,s2
      state = 0;
 744:	4981                	li	s3,0
 746:	b7a5                	j	6ae <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 748:	008b8c13          	addi	s8,s7,8
 74c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 750:	03000593          	li	a1,48
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	e46080e7          	jalr	-442(ra) # 59c <putc>
  putc(fd, 'x');
 75e:	07800593          	li	a1,120
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	e38080e7          	jalr	-456(ra) # 59c <putc>
 76c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76e:	00000b97          	auipc	s7,0x0
 772:	352b8b93          	addi	s7,s7,850 # ac0 <digits>
 776:	03c9d793          	srli	a5,s3,0x3c
 77a:	97de                	add	a5,a5,s7
 77c:	0007c583          	lbu	a1,0(a5)
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	e1a080e7          	jalr	-486(ra) # 59c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78a:	0992                	slli	s3,s3,0x4
 78c:	397d                	addiw	s2,s2,-1
 78e:	fe0914e3          	bnez	s2,776 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 792:	8be2                	mv	s7,s8
      state = 0;
 794:	4981                	li	s3,0
 796:	bf21                	j	6ae <vprintf+0x44>
        s = va_arg(ap, char*);
 798:	008b8993          	addi	s3,s7,8
 79c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7a0:	02090163          	beqz	s2,7c2 <vprintf+0x158>
        while(*s != 0){
 7a4:	00094583          	lbu	a1,0(s2)
 7a8:	c9a5                	beqz	a1,818 <vprintf+0x1ae>
          putc(fd, *s);
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	df0080e7          	jalr	-528(ra) # 59c <putc>
          s++;
 7b4:	0905                	addi	s2,s2,1
        while(*s != 0){
 7b6:	00094583          	lbu	a1,0(s2)
 7ba:	f9e5                	bnez	a1,7aa <vprintf+0x140>
        s = va_arg(ap, char*);
 7bc:	8bce                	mv	s7,s3
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	b5fd                	j	6ae <vprintf+0x44>
          s = "(null)";
 7c2:	00000917          	auipc	s2,0x0
 7c6:	29e90913          	addi	s2,s2,670 # a60 <malloc+0x144>
        while(*s != 0){
 7ca:	02800593          	li	a1,40
 7ce:	bff1                	j	7aa <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 7d0:	008b8913          	addi	s2,s7,8
 7d4:	000bc583          	lbu	a1,0(s7)
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	dc2080e7          	jalr	-574(ra) # 59c <putc>
 7e2:	8bca                	mv	s7,s2
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	b5e1                	j	6ae <vprintf+0x44>
        putc(fd, c);
 7e8:	02500593          	li	a1,37
 7ec:	8556                	mv	a0,s5
 7ee:	00000097          	auipc	ra,0x0
 7f2:	dae080e7          	jalr	-594(ra) # 59c <putc>
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	bd5d                	j	6ae <vprintf+0x44>
        putc(fd, '%');
 7fa:	02500593          	li	a1,37
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	d9c080e7          	jalr	-612(ra) # 59c <putc>
        putc(fd, c);
 808:	85ca                	mv	a1,s2
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	d90080e7          	jalr	-624(ra) # 59c <putc>
      state = 0;
 814:	4981                	li	s3,0
 816:	bd61                	j	6ae <vprintf+0x44>
        s = va_arg(ap, char*);
 818:	8bce                	mv	s7,s3
      state = 0;
 81a:	4981                	li	s3,0
 81c:	bd49                	j	6ae <vprintf+0x44>
    }
  }
}
 81e:	60a6                	ld	ra,72(sp)
 820:	6406                	ld	s0,64(sp)
 822:	74e2                	ld	s1,56(sp)
 824:	7942                	ld	s2,48(sp)
 826:	79a2                	ld	s3,40(sp)
 828:	7a02                	ld	s4,32(sp)
 82a:	6ae2                	ld	s5,24(sp)
 82c:	6b42                	ld	s6,16(sp)
 82e:	6ba2                	ld	s7,8(sp)
 830:	6c02                	ld	s8,0(sp)
 832:	6161                	addi	sp,sp,80
 834:	8082                	ret

0000000000000836 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 836:	715d                	addi	sp,sp,-80
 838:	ec06                	sd	ra,24(sp)
 83a:	e822                	sd	s0,16(sp)
 83c:	1000                	addi	s0,sp,32
 83e:	e010                	sd	a2,0(s0)
 840:	e414                	sd	a3,8(s0)
 842:	e818                	sd	a4,16(s0)
 844:	ec1c                	sd	a5,24(s0)
 846:	03043023          	sd	a6,32(s0)
 84a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 84e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 852:	8622                	mv	a2,s0
 854:	00000097          	auipc	ra,0x0
 858:	e16080e7          	jalr	-490(ra) # 66a <vprintf>
}
 85c:	60e2                	ld	ra,24(sp)
 85e:	6442                	ld	s0,16(sp)
 860:	6161                	addi	sp,sp,80
 862:	8082                	ret

0000000000000864 <printf>:

void
printf(const char *fmt, ...)
{
 864:	711d                	addi	sp,sp,-96
 866:	ec06                	sd	ra,24(sp)
 868:	e822                	sd	s0,16(sp)
 86a:	1000                	addi	s0,sp,32
 86c:	e40c                	sd	a1,8(s0)
 86e:	e810                	sd	a2,16(s0)
 870:	ec14                	sd	a3,24(s0)
 872:	f018                	sd	a4,32(s0)
 874:	f41c                	sd	a5,40(s0)
 876:	03043823          	sd	a6,48(s0)
 87a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 87e:	00840613          	addi	a2,s0,8
 882:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 886:	85aa                	mv	a1,a0
 888:	4505                	li	a0,1
 88a:	00000097          	auipc	ra,0x0
 88e:	de0080e7          	jalr	-544(ra) # 66a <vprintf>
}
 892:	60e2                	ld	ra,24(sp)
 894:	6442                	ld	s0,16(sp)
 896:	6125                	addi	sp,sp,96
 898:	8082                	ret

000000000000089a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 89a:	1141                	addi	sp,sp,-16
 89c:	e422                	sd	s0,8(sp)
 89e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8a0:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a4:	00000797          	auipc	a5,0x0
 8a8:	7647b783          	ld	a5,1892(a5) # 1008 <freep>
 8ac:	a02d                	j	8d6 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 8ae:	4618                	lw	a4,8(a2)
 8b0:	9f2d                	addw	a4,a4,a1
 8b2:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8b6:	6398                	ld	a4,0(a5)
 8b8:	6310                	ld	a2,0(a4)
 8ba:	a83d                	j	8f8 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 8bc:	ff852703          	lw	a4,-8(a0)
 8c0:	9f31                	addw	a4,a4,a2
 8c2:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8c4:	ff053683          	ld	a3,-16(a0)
 8c8:	a091                	j	90c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ca:	6398                	ld	a4,0(a5)
 8cc:	00e7e463          	bltu	a5,a4,8d4 <free+0x3a>
 8d0:	00e6ea63          	bltu	a3,a4,8e4 <free+0x4a>
{
 8d4:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d6:	fed7fae3          	bgeu	a5,a3,8ca <free+0x30>
 8da:	6398                	ld	a4,0(a5)
 8dc:	00e6e463          	bltu	a3,a4,8e4 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e0:	fee7eae3          	bltu	a5,a4,8d4 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 8e4:	ff852583          	lw	a1,-8(a0)
 8e8:	6390                	ld	a2,0(a5)
 8ea:	02059813          	slli	a6,a1,0x20
 8ee:	01c85713          	srli	a4,a6,0x1c
 8f2:	9736                	add	a4,a4,a3
 8f4:	fae60de3          	beq	a2,a4,8ae <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 8f8:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 8fc:	4790                	lw	a2,8(a5)
 8fe:	02061593          	slli	a1,a2,0x20
 902:	01c5d713          	srli	a4,a1,0x1c
 906:	973e                	add	a4,a4,a5
 908:	fae68ae3          	beq	a3,a4,8bc <free+0x22>
        p->s.ptr = bp->s.ptr;
 90c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 90e:	00000717          	auipc	a4,0x0
 912:	6ef73d23          	sd	a5,1786(a4) # 1008 <freep>
}
 916:	6422                	ld	s0,8(sp)
 918:	0141                	addi	sp,sp,16
 91a:	8082                	ret

000000000000091c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 91c:	7139                	addi	sp,sp,-64
 91e:	fc06                	sd	ra,56(sp)
 920:	f822                	sd	s0,48(sp)
 922:	f426                	sd	s1,40(sp)
 924:	f04a                	sd	s2,32(sp)
 926:	ec4e                	sd	s3,24(sp)
 928:	e852                	sd	s4,16(sp)
 92a:	e456                	sd	s5,8(sp)
 92c:	e05a                	sd	s6,0(sp)
 92e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 930:	02051493          	slli	s1,a0,0x20
 934:	9081                	srli	s1,s1,0x20
 936:	04bd                	addi	s1,s1,15
 938:	8091                	srli	s1,s1,0x4
 93a:	0014899b          	addiw	s3,s1,1
 93e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 940:	00000517          	auipc	a0,0x0
 944:	6c853503          	ld	a0,1736(a0) # 1008 <freep>
 948:	c515                	beqz	a0,974 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 94a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 94c:	4798                	lw	a4,8(a5)
 94e:	02977f63          	bgeu	a4,s1,98c <malloc+0x70>
    if (nu < 4096)
 952:	8a4e                	mv	s4,s3
 954:	0009871b          	sext.w	a4,s3
 958:	6685                	lui	a3,0x1
 95a:	00d77363          	bgeu	a4,a3,960 <malloc+0x44>
 95e:	6a05                	lui	s4,0x1
 960:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 964:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 968:	00000917          	auipc	s2,0x0
 96c:	6a090913          	addi	s2,s2,1696 # 1008 <freep>
    if (p == (char *)-1)
 970:	5afd                	li	s5,-1
 972:	a895                	j	9e6 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 974:	00000797          	auipc	a5,0x0
 978:	69c78793          	addi	a5,a5,1692 # 1010 <base>
 97c:	00000717          	auipc	a4,0x0
 980:	68f73623          	sd	a5,1676(a4) # 1008 <freep>
 984:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 986:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 98a:	b7e1                	j	952 <malloc+0x36>
            if (p->s.size == nunits)
 98c:	02e48c63          	beq	s1,a4,9c4 <malloc+0xa8>
                p->s.size -= nunits;
 990:	4137073b          	subw	a4,a4,s3
 994:	c798                	sw	a4,8(a5)
                p += p->s.size;
 996:	02071693          	slli	a3,a4,0x20
 99a:	01c6d713          	srli	a4,a3,0x1c
 99e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 9a0:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	66a73223          	sd	a0,1636(a4) # 1008 <freep>
            return (void *)(p + 1);
 9ac:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9b0:	70e2                	ld	ra,56(sp)
 9b2:	7442                	ld	s0,48(sp)
 9b4:	74a2                	ld	s1,40(sp)
 9b6:	7902                	ld	s2,32(sp)
 9b8:	69e2                	ld	s3,24(sp)
 9ba:	6a42                	ld	s4,16(sp)
 9bc:	6aa2                	ld	s5,8(sp)
 9be:	6b02                	ld	s6,0(sp)
 9c0:	6121                	addi	sp,sp,64
 9c2:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 9c4:	6398                	ld	a4,0(a5)
 9c6:	e118                	sd	a4,0(a0)
 9c8:	bff1                	j	9a4 <malloc+0x88>
    hp->s.size = nu;
 9ca:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 9ce:	0541                	addi	a0,a0,16
 9d0:	00000097          	auipc	ra,0x0
 9d4:	eca080e7          	jalr	-310(ra) # 89a <free>
    return freep;
 9d8:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 9dc:	d971                	beqz	a0,9b0 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 9de:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 9e0:	4798                	lw	a4,8(a5)
 9e2:	fa9775e3          	bgeu	a4,s1,98c <malloc+0x70>
        if (p == freep)
 9e6:	00093703          	ld	a4,0(s2)
 9ea:	853e                	mv	a0,a5
 9ec:	fef719e3          	bne	a4,a5,9de <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 9f0:	8552                	mv	a0,s4
 9f2:	00000097          	auipc	ra,0x0
 9f6:	b7a080e7          	jalr	-1158(ra) # 56c <sbrk>
    if (p == (char *)-1)
 9fa:	fd5518e3          	bne	a0,s5,9ca <malloc+0xae>
                return 0;
 9fe:	4501                	li	a0,0
 a00:	bf45                	j	9b0 <malloc+0x94>
