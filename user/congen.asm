
user/_congen:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:
#include "user/user.h"

#define N 5

void print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
    write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	370080e7          	jalr	880(ra) # 37c <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	5a4080e7          	jalr	1444(ra) # 5c0 <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void forktest(void)
{
  2e:	7139                	addi	sp,sp,-64
  30:	fc06                	sd	ra,56(sp)
  32:	f822                	sd	s0,48(sp)
  34:	f426                	sd	s1,40(sp)
  36:	f04a                	sd	s2,32(sp)
  38:	ec4e                	sd	s3,24(sp)
  3a:	e852                	sd	s4,16(sp)
  3c:	e456                	sd	s5,8(sp)
  3e:	e05a                	sd	s6,0(sp)
  40:	0080                	addi	s0,sp,64
    int n, pid;

    print("fork test\n");
  42:	00001517          	auipc	a0,0x1
  46:	a7e50513          	addi	a0,a0,-1410 # ac0 <malloc+0xe8>
  4a:	00000097          	auipc	ra,0x0
  4e:	fb6080e7          	jalr	-74(ra) # 0 <print>

    for (n = 0; n < N; n++)
  52:	4a01                	li	s4,0
  54:	4495                	li	s1,5
    {
        pid = fork();
  56:	00000097          	auipc	ra,0x0
  5a:	542080e7          	jalr	1346(ra) # 598 <fork>
  5e:	892a                	mv	s2,a0
        if (pid < 0)
            break;
        if (pid == 0)
  60:	00a05563          	blez	a0,6a <forktest+0x3c>
    for (n = 0; n < N; n++)
  64:	2a05                	addiw	s4,s4,1
  66:	fe9a18e3          	bne	s4,s1,56 <forktest+0x28>
            break;
    }

    for (unsigned long long i = 0; i < 1000; i++)
  6a:	4481                	li	s1,0
        {
            printf("CHILD %d: %d\n", n, i);
        }
        else
        {
            printf("PARENT: %d\n", i);
  6c:	00001b17          	auipc	s6,0x1
  70:	a74b0b13          	addi	s6,s6,-1420 # ae0 <malloc+0x108>
            printf("CHILD %d: %d\n", n, i);
  74:	00001a97          	auipc	s5,0x1
  78:	a5ca8a93          	addi	s5,s5,-1444 # ad0 <malloc+0xf8>
    for (unsigned long long i = 0; i < 1000; i++)
  7c:	3e800993          	li	s3,1000
  80:	a811                	j	94 <forktest+0x66>
            printf("PARENT: %d\n", i);
  82:	85a6                	mv	a1,s1
  84:	855a                	mv	a0,s6
  86:	00001097          	auipc	ra,0x1
  8a:	89a080e7          	jalr	-1894(ra) # 920 <printf>
    for (unsigned long long i = 0; i < 1000; i++)
  8e:	0485                	addi	s1,s1,1
  90:	01348c63          	beq	s1,s3,a8 <forktest+0x7a>
        if (pid == 0)
  94:	fe0917e3          	bnez	s2,82 <forktest+0x54>
            printf("CHILD %d: %d\n", n, i);
  98:	8626                	mv	a2,s1
  9a:	85d2                	mv	a1,s4
  9c:	8556                	mv	a0,s5
  9e:	00001097          	auipc	ra,0x1
  a2:	882080e7          	jalr	-1918(ra) # 920 <printf>
  a6:	b7e5                	j	8e <forktest+0x60>
        }
    }

    print("fork test OK\n");
  a8:	00001517          	auipc	a0,0x1
  ac:	a4850513          	addi	a0,a0,-1464 # af0 <malloc+0x118>
  b0:	00000097          	auipc	ra,0x0
  b4:	f50080e7          	jalr	-176(ra) # 0 <print>
}
  b8:	70e2                	ld	ra,56(sp)
  ba:	7442                	ld	s0,48(sp)
  bc:	74a2                	ld	s1,40(sp)
  be:	7902                	ld	s2,32(sp)
  c0:	69e2                	ld	s3,24(sp)
  c2:	6a42                	ld	s4,16(sp)
  c4:	6aa2                	ld	s5,8(sp)
  c6:	6b02                	ld	s6,0(sp)
  c8:	6121                	addi	sp,sp,64
  ca:	8082                	ret

00000000000000cc <main>:

int main(void)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e406                	sd	ra,8(sp)
  d0:	e022                	sd	s0,0(sp)
  d2:	0800                	addi	s0,sp,16
    forktest();
  d4:	00000097          	auipc	ra,0x0
  d8:	f5a080e7          	jalr	-166(ra) # 2e <forktest>
    exit(0);
  dc:	4501                	li	a0,0
  de:	00000097          	auipc	ra,0x0
  e2:	4c2080e7          	jalr	1218(ra) # 5a0 <exit>

00000000000000e6 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
    lk->name = name;
  ec:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  ee:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  f2:	57fd                	li	a5,-1
  f4:	00f50823          	sb	a5,16(a0)
}
  f8:	6422                	ld	s0,8(sp)
  fa:	0141                	addi	sp,sp,16
  fc:	8082                	ret

00000000000000fe <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  fe:	00054783          	lbu	a5,0(a0)
 102:	e399                	bnez	a5,108 <holding+0xa>
 104:	4501                	li	a0,0
}
 106:	8082                	ret
{
 108:	1101                	addi	sp,sp,-32
 10a:	ec06                	sd	ra,24(sp)
 10c:	e822                	sd	s0,16(sp)
 10e:	e426                	sd	s1,8(sp)
 110:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 112:	01054483          	lbu	s1,16(a0)
 116:	00000097          	auipc	ra,0x0
 11a:	172080e7          	jalr	370(ra) # 288 <twhoami>
 11e:	2501                	sext.w	a0,a0
 120:	40a48533          	sub	a0,s1,a0
 124:	00153513          	seqz	a0,a0
}
 128:	60e2                	ld	ra,24(sp)
 12a:	6442                	ld	s0,16(sp)
 12c:	64a2                	ld	s1,8(sp)
 12e:	6105                	addi	sp,sp,32
 130:	8082                	ret

0000000000000132 <acquire>:

void acquire(struct lock *lk)
{
 132:	7179                	addi	sp,sp,-48
 134:	f406                	sd	ra,40(sp)
 136:	f022                	sd	s0,32(sp)
 138:	ec26                	sd	s1,24(sp)
 13a:	e84a                	sd	s2,16(sp)
 13c:	e44e                	sd	s3,8(sp)
 13e:	e052                	sd	s4,0(sp)
 140:	1800                	addi	s0,sp,48
 142:	8a2a                	mv	s4,a0
    if (holding(lk))
 144:	00000097          	auipc	ra,0x0
 148:	fba080e7          	jalr	-70(ra) # fe <holding>
 14c:	e919                	bnez	a0,162 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 14e:	ffca7493          	andi	s1,s4,-4
 152:	003a7913          	andi	s2,s4,3
 156:	0039191b          	slliw	s2,s2,0x3
 15a:	4985                	li	s3,1
 15c:	012999bb          	sllw	s3,s3,s2
 160:	a015                	j	184 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 162:	00001517          	auipc	a0,0x1
 166:	99e50513          	addi	a0,a0,-1634 # b00 <malloc+0x128>
 16a:	00000097          	auipc	ra,0x0
 16e:	7b6080e7          	jalr	1974(ra) # 920 <printf>
        exit(-1);
 172:	557d                	li	a0,-1
 174:	00000097          	auipc	ra,0x0
 178:	42c080e7          	jalr	1068(ra) # 5a0 <exit>
    {
        // give up the cpu for other threads
        tyield();
 17c:	00000097          	auipc	ra,0x0
 180:	0f4080e7          	jalr	244(ra) # 270 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 184:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 188:	0127d7bb          	srlw	a5,a5,s2
 18c:	0ff7f793          	zext.b	a5,a5
 190:	f7f5                	bnez	a5,17c <acquire+0x4a>
    }

    __sync_synchronize();
 192:	0ff0000f          	fence

    lk->tid = twhoami();
 196:	00000097          	auipc	ra,0x0
 19a:	0f2080e7          	jalr	242(ra) # 288 <twhoami>
 19e:	00aa0823          	sb	a0,16(s4)
}
 1a2:	70a2                	ld	ra,40(sp)
 1a4:	7402                	ld	s0,32(sp)
 1a6:	64e2                	ld	s1,24(sp)
 1a8:	6942                	ld	s2,16(sp)
 1aa:	69a2                	ld	s3,8(sp)
 1ac:	6a02                	ld	s4,0(sp)
 1ae:	6145                	addi	sp,sp,48
 1b0:	8082                	ret

00000000000001b2 <release>:

void release(struct lock *lk)
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec06                	sd	ra,24(sp)
 1b6:	e822                	sd	s0,16(sp)
 1b8:	e426                	sd	s1,8(sp)
 1ba:	1000                	addi	s0,sp,32
 1bc:	84aa                	mv	s1,a0
    if (!holding(lk))
 1be:	00000097          	auipc	ra,0x0
 1c2:	f40080e7          	jalr	-192(ra) # fe <holding>
 1c6:	c11d                	beqz	a0,1ec <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1c8:	57fd                	li	a5,-1
 1ca:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1ce:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1d2:	0ff0000f          	fence
 1d6:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1da:	00000097          	auipc	ra,0x0
 1de:	096080e7          	jalr	150(ra) # 270 <tyield>
}
 1e2:	60e2                	ld	ra,24(sp)
 1e4:	6442                	ld	s0,16(sp)
 1e6:	64a2                	ld	s1,8(sp)
 1e8:	6105                	addi	sp,sp,32
 1ea:	8082                	ret
        printf("releasing lock we are not holding");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	93c50513          	addi	a0,a0,-1732 # b28 <malloc+0x150>
 1f4:	00000097          	auipc	ra,0x0
 1f8:	72c080e7          	jalr	1836(ra) # 920 <printf>
        exit(-1);
 1fc:	557d                	li	a0,-1
 1fe:	00000097          	auipc	ra,0x0
 202:	3a2080e7          	jalr	930(ra) # 5a0 <exit>

0000000000000206 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 206:	1141                	addi	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 20c:	00001717          	auipc	a4,0x1
 210:	df473703          	ld	a4,-524(a4) # 1000 <current_thread>
 214:	47c1                	li	a5,16
 216:	c319                	beqz	a4,21c <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 218:	37fd                	addiw	a5,a5,-1
 21a:	fff5                	bnez	a5,216 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 21c:	6422                	ld	s0,8(sp)
 21e:	0141                	addi	sp,sp,16
 220:	8082                	ret

0000000000000222 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 222:	7179                	addi	sp,sp,-48
 224:	f406                	sd	ra,40(sp)
 226:	f022                	sd	s0,32(sp)
 228:	ec26                	sd	s1,24(sp)
 22a:	e84a                	sd	s2,16(sp)
 22c:	e44e                	sd	s3,8(sp)
 22e:	1800                	addi	s0,sp,48
 230:	84aa                	mv	s1,a0
 232:	89b2                	mv	s3,a2
 234:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 236:	09000513          	li	a0,144
 23a:	00000097          	auipc	ra,0x0
 23e:	79e080e7          	jalr	1950(ra) # 9d8 <malloc>
 242:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 244:	478d                	li	a5,3
 246:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 248:	609c                	ld	a5,0(s1)
 24a:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 24e:	609c                	ld	a5,0(s1)
 250:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 254:	70a2                	ld	ra,40(sp)
 256:	7402                	ld	s0,32(sp)
 258:	64e2                	ld	s1,24(sp)
 25a:	6942                	ld	s2,16(sp)
 25c:	69a2                	ld	s3,8(sp)
 25e:	6145                	addi	sp,sp,48
 260:	8082                	ret

0000000000000262 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 268:	4501                	li	a0,0
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	addi	sp,sp,16
 26e:	8082                	ret

0000000000000270 <tyield>:

void tyield()
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 276:	00001797          	auipc	a5,0x1
 27a:	d8a7b783          	ld	a5,-630(a5) # 1000 <current_thread>
 27e:	470d                	li	a4,3
 280:	dfb8                	sw	a4,120(a5)
    tsched();
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <twhoami>:

uint8 twhoami()
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 28e:	4501                	li	a0,0
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret

0000000000000296 <tswtch>:
 296:	00153023          	sd	ra,0(a0)
 29a:	00253423          	sd	sp,8(a0)
 29e:	e900                	sd	s0,16(a0)
 2a0:	ed04                	sd	s1,24(a0)
 2a2:	03253023          	sd	s2,32(a0)
 2a6:	03353423          	sd	s3,40(a0)
 2aa:	03453823          	sd	s4,48(a0)
 2ae:	03553c23          	sd	s5,56(a0)
 2b2:	05653023          	sd	s6,64(a0)
 2b6:	05753423          	sd	s7,72(a0)
 2ba:	05853823          	sd	s8,80(a0)
 2be:	05953c23          	sd	s9,88(a0)
 2c2:	07a53023          	sd	s10,96(a0)
 2c6:	07b53423          	sd	s11,104(a0)
 2ca:	0005b083          	ld	ra,0(a1)
 2ce:	0085b103          	ld	sp,8(a1)
 2d2:	6980                	ld	s0,16(a1)
 2d4:	6d84                	ld	s1,24(a1)
 2d6:	0205b903          	ld	s2,32(a1)
 2da:	0285b983          	ld	s3,40(a1)
 2de:	0305ba03          	ld	s4,48(a1)
 2e2:	0385ba83          	ld	s5,56(a1)
 2e6:	0405bb03          	ld	s6,64(a1)
 2ea:	0485bb83          	ld	s7,72(a1)
 2ee:	0505bc03          	ld	s8,80(a1)
 2f2:	0585bc83          	ld	s9,88(a1)
 2f6:	0605bd03          	ld	s10,96(a1)
 2fa:	0685bd83          	ld	s11,104(a1)
 2fe:	8082                	ret

0000000000000300 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 300:	1101                	addi	sp,sp,-32
 302:	ec06                	sd	ra,24(sp)
 304:	e822                	sd	s0,16(sp)
 306:	e426                	sd	s1,8(sp)
 308:	e04a                	sd	s2,0(sp)
 30a:	1000                	addi	s0,sp,32
 30c:	84aa                	mv	s1,a0
 30e:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 310:	09000513          	li	a0,144
 314:	00000097          	auipc	ra,0x0
 318:	6c4080e7          	jalr	1732(ra) # 9d8 <malloc>

    main_thread->tid = 0;
 31c:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 320:	85ca                	mv	a1,s2
 322:	8526                	mv	a0,s1
 324:	00000097          	auipc	ra,0x0
 328:	da8080e7          	jalr	-600(ra) # cc <main>
    exit(res);
 32c:	00000097          	auipc	ra,0x0
 330:	274080e7          	jalr	628(ra) # 5a0 <exit>

0000000000000334 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 33a:	87aa                	mv	a5,a0
 33c:	0585                	addi	a1,a1,1
 33e:	0785                	addi	a5,a5,1
 340:	fff5c703          	lbu	a4,-1(a1)
 344:	fee78fa3          	sb	a4,-1(a5)
 348:	fb75                	bnez	a4,33c <strcpy+0x8>
        ;
    return os;
}
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <strcmp>:

int strcmp(const char *p, const char *q)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 356:	00054783          	lbu	a5,0(a0)
 35a:	cb91                	beqz	a5,36e <strcmp+0x1e>
 35c:	0005c703          	lbu	a4,0(a1)
 360:	00f71763          	bne	a4,a5,36e <strcmp+0x1e>
        p++, q++;
 364:	0505                	addi	a0,a0,1
 366:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 368:	00054783          	lbu	a5,0(a0)
 36c:	fbe5                	bnez	a5,35c <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 36e:	0005c503          	lbu	a0,0(a1)
}
 372:	40a7853b          	subw	a0,a5,a0
 376:	6422                	ld	s0,8(sp)
 378:	0141                	addi	sp,sp,16
 37a:	8082                	ret

000000000000037c <strlen>:

uint strlen(const char *s)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 382:	00054783          	lbu	a5,0(a0)
 386:	cf91                	beqz	a5,3a2 <strlen+0x26>
 388:	0505                	addi	a0,a0,1
 38a:	87aa                	mv	a5,a0
 38c:	86be                	mv	a3,a5
 38e:	0785                	addi	a5,a5,1
 390:	fff7c703          	lbu	a4,-1(a5)
 394:	ff65                	bnez	a4,38c <strlen+0x10>
 396:	40a6853b          	subw	a0,a3,a0
 39a:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret
    for (n = 0; s[n]; n++)
 3a2:	4501                	li	a0,0
 3a4:	bfe5                	j	39c <strlen+0x20>

00000000000003a6 <memset>:

void *
memset(void *dst, int c, uint n)
{
 3a6:	1141                	addi	sp,sp,-16
 3a8:	e422                	sd	s0,8(sp)
 3aa:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 3ac:	ca19                	beqz	a2,3c2 <memset+0x1c>
 3ae:	87aa                	mv	a5,a0
 3b0:	1602                	slli	a2,a2,0x20
 3b2:	9201                	srli	a2,a2,0x20
 3b4:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 3b8:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 3bc:	0785                	addi	a5,a5,1
 3be:	fee79de3          	bne	a5,a4,3b8 <memset+0x12>
    }
    return dst;
}
 3c2:	6422                	ld	s0,8(sp)
 3c4:	0141                	addi	sp,sp,16
 3c6:	8082                	ret

00000000000003c8 <strchr>:

char *
strchr(const char *s, char c)
{
 3c8:	1141                	addi	sp,sp,-16
 3ca:	e422                	sd	s0,8(sp)
 3cc:	0800                	addi	s0,sp,16
    for (; *s; s++)
 3ce:	00054783          	lbu	a5,0(a0)
 3d2:	cb99                	beqz	a5,3e8 <strchr+0x20>
        if (*s == c)
 3d4:	00f58763          	beq	a1,a5,3e2 <strchr+0x1a>
    for (; *s; s++)
 3d8:	0505                	addi	a0,a0,1
 3da:	00054783          	lbu	a5,0(a0)
 3de:	fbfd                	bnez	a5,3d4 <strchr+0xc>
            return (char *)s;
    return 0;
 3e0:	4501                	li	a0,0
}
 3e2:	6422                	ld	s0,8(sp)
 3e4:	0141                	addi	sp,sp,16
 3e6:	8082                	ret
    return 0;
 3e8:	4501                	li	a0,0
 3ea:	bfe5                	j	3e2 <strchr+0x1a>

00000000000003ec <gets>:

char *
gets(char *buf, int max)
{
 3ec:	711d                	addi	sp,sp,-96
 3ee:	ec86                	sd	ra,88(sp)
 3f0:	e8a2                	sd	s0,80(sp)
 3f2:	e4a6                	sd	s1,72(sp)
 3f4:	e0ca                	sd	s2,64(sp)
 3f6:	fc4e                	sd	s3,56(sp)
 3f8:	f852                	sd	s4,48(sp)
 3fa:	f456                	sd	s5,40(sp)
 3fc:	f05a                	sd	s6,32(sp)
 3fe:	ec5e                	sd	s7,24(sp)
 400:	1080                	addi	s0,sp,96
 402:	8baa                	mv	s7,a0
 404:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 406:	892a                	mv	s2,a0
 408:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 40a:	4aa9                	li	s5,10
 40c:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 40e:	89a6                	mv	s3,s1
 410:	2485                	addiw	s1,s1,1
 412:	0344d863          	bge	s1,s4,442 <gets+0x56>
        cc = read(0, &c, 1);
 416:	4605                	li	a2,1
 418:	faf40593          	addi	a1,s0,-81
 41c:	4501                	li	a0,0
 41e:	00000097          	auipc	ra,0x0
 422:	19a080e7          	jalr	410(ra) # 5b8 <read>
        if (cc < 1)
 426:	00a05e63          	blez	a0,442 <gets+0x56>
        buf[i++] = c;
 42a:	faf44783          	lbu	a5,-81(s0)
 42e:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 432:	01578763          	beq	a5,s5,440 <gets+0x54>
 436:	0905                	addi	s2,s2,1
 438:	fd679be3          	bne	a5,s6,40e <gets+0x22>
    for (i = 0; i + 1 < max;)
 43c:	89a6                	mv	s3,s1
 43e:	a011                	j	442 <gets+0x56>
 440:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 442:	99de                	add	s3,s3,s7
 444:	00098023          	sb	zero,0(s3)
    return buf;
}
 448:	855e                	mv	a0,s7
 44a:	60e6                	ld	ra,88(sp)
 44c:	6446                	ld	s0,80(sp)
 44e:	64a6                	ld	s1,72(sp)
 450:	6906                	ld	s2,64(sp)
 452:	79e2                	ld	s3,56(sp)
 454:	7a42                	ld	s4,48(sp)
 456:	7aa2                	ld	s5,40(sp)
 458:	7b02                	ld	s6,32(sp)
 45a:	6be2                	ld	s7,24(sp)
 45c:	6125                	addi	sp,sp,96
 45e:	8082                	ret

0000000000000460 <stat>:

int stat(const char *n, struct stat *st)
{
 460:	1101                	addi	sp,sp,-32
 462:	ec06                	sd	ra,24(sp)
 464:	e822                	sd	s0,16(sp)
 466:	e426                	sd	s1,8(sp)
 468:	e04a                	sd	s2,0(sp)
 46a:	1000                	addi	s0,sp,32
 46c:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 46e:	4581                	li	a1,0
 470:	00000097          	auipc	ra,0x0
 474:	170080e7          	jalr	368(ra) # 5e0 <open>
    if (fd < 0)
 478:	02054563          	bltz	a0,4a2 <stat+0x42>
 47c:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 47e:	85ca                	mv	a1,s2
 480:	00000097          	auipc	ra,0x0
 484:	178080e7          	jalr	376(ra) # 5f8 <fstat>
 488:	892a                	mv	s2,a0
    close(fd);
 48a:	8526                	mv	a0,s1
 48c:	00000097          	auipc	ra,0x0
 490:	13c080e7          	jalr	316(ra) # 5c8 <close>
    return r;
}
 494:	854a                	mv	a0,s2
 496:	60e2                	ld	ra,24(sp)
 498:	6442                	ld	s0,16(sp)
 49a:	64a2                	ld	s1,8(sp)
 49c:	6902                	ld	s2,0(sp)
 49e:	6105                	addi	sp,sp,32
 4a0:	8082                	ret
        return -1;
 4a2:	597d                	li	s2,-1
 4a4:	bfc5                	j	494 <stat+0x34>

00000000000004a6 <atoi>:

int atoi(const char *s)
{
 4a6:	1141                	addi	sp,sp,-16
 4a8:	e422                	sd	s0,8(sp)
 4aa:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 4ac:	00054683          	lbu	a3,0(a0)
 4b0:	fd06879b          	addiw	a5,a3,-48
 4b4:	0ff7f793          	zext.b	a5,a5
 4b8:	4625                	li	a2,9
 4ba:	02f66863          	bltu	a2,a5,4ea <atoi+0x44>
 4be:	872a                	mv	a4,a0
    n = 0;
 4c0:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 4c2:	0705                	addi	a4,a4,1
 4c4:	0025179b          	slliw	a5,a0,0x2
 4c8:	9fa9                	addw	a5,a5,a0
 4ca:	0017979b          	slliw	a5,a5,0x1
 4ce:	9fb5                	addw	a5,a5,a3
 4d0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 4d4:	00074683          	lbu	a3,0(a4)
 4d8:	fd06879b          	addiw	a5,a3,-48
 4dc:	0ff7f793          	zext.b	a5,a5
 4e0:	fef671e3          	bgeu	a2,a5,4c2 <atoi+0x1c>
    return n;
}
 4e4:	6422                	ld	s0,8(sp)
 4e6:	0141                	addi	sp,sp,16
 4e8:	8082                	ret
    n = 0;
 4ea:	4501                	li	a0,0
 4ec:	bfe5                	j	4e4 <atoi+0x3e>

00000000000004ee <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 4ee:	1141                	addi	sp,sp,-16
 4f0:	e422                	sd	s0,8(sp)
 4f2:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 4f4:	02b57463          	bgeu	a0,a1,51c <memmove+0x2e>
    {
        while (n-- > 0)
 4f8:	00c05f63          	blez	a2,516 <memmove+0x28>
 4fc:	1602                	slli	a2,a2,0x20
 4fe:	9201                	srli	a2,a2,0x20
 500:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 504:	872a                	mv	a4,a0
            *dst++ = *src++;
 506:	0585                	addi	a1,a1,1
 508:	0705                	addi	a4,a4,1
 50a:	fff5c683          	lbu	a3,-1(a1)
 50e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 512:	fee79ae3          	bne	a5,a4,506 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 516:	6422                	ld	s0,8(sp)
 518:	0141                	addi	sp,sp,16
 51a:	8082                	ret
        dst += n;
 51c:	00c50733          	add	a4,a0,a2
        src += n;
 520:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 522:	fec05ae3          	blez	a2,516 <memmove+0x28>
 526:	fff6079b          	addiw	a5,a2,-1
 52a:	1782                	slli	a5,a5,0x20
 52c:	9381                	srli	a5,a5,0x20
 52e:	fff7c793          	not	a5,a5
 532:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 534:	15fd                	addi	a1,a1,-1
 536:	177d                	addi	a4,a4,-1
 538:	0005c683          	lbu	a3,0(a1)
 53c:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 540:	fee79ae3          	bne	a5,a4,534 <memmove+0x46>
 544:	bfc9                	j	516 <memmove+0x28>

0000000000000546 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 546:	1141                	addi	sp,sp,-16
 548:	e422                	sd	s0,8(sp)
 54a:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 54c:	ca05                	beqz	a2,57c <memcmp+0x36>
 54e:	fff6069b          	addiw	a3,a2,-1
 552:	1682                	slli	a3,a3,0x20
 554:	9281                	srli	a3,a3,0x20
 556:	0685                	addi	a3,a3,1
 558:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 55a:	00054783          	lbu	a5,0(a0)
 55e:	0005c703          	lbu	a4,0(a1)
 562:	00e79863          	bne	a5,a4,572 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 566:	0505                	addi	a0,a0,1
        p2++;
 568:	0585                	addi	a1,a1,1
    while (n-- > 0)
 56a:	fed518e3          	bne	a0,a3,55a <memcmp+0x14>
    }
    return 0;
 56e:	4501                	li	a0,0
 570:	a019                	j	576 <memcmp+0x30>
            return *p1 - *p2;
 572:	40e7853b          	subw	a0,a5,a4
}
 576:	6422                	ld	s0,8(sp)
 578:	0141                	addi	sp,sp,16
 57a:	8082                	ret
    return 0;
 57c:	4501                	li	a0,0
 57e:	bfe5                	j	576 <memcmp+0x30>

0000000000000580 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 580:	1141                	addi	sp,sp,-16
 582:	e406                	sd	ra,8(sp)
 584:	e022                	sd	s0,0(sp)
 586:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 588:	00000097          	auipc	ra,0x0
 58c:	f66080e7          	jalr	-154(ra) # 4ee <memmove>
}
 590:	60a2                	ld	ra,8(sp)
 592:	6402                	ld	s0,0(sp)
 594:	0141                	addi	sp,sp,16
 596:	8082                	ret

0000000000000598 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 598:	4885                	li	a7,1
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a0:	4889                	li	a7,2
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5a8:	488d                	li	a7,3
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b0:	4891                	li	a7,4
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <read>:
.global read
read:
 li a7, SYS_read
 5b8:	4895                	li	a7,5
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <write>:
.global write
write:
 li a7, SYS_write
 5c0:	48c1                	li	a7,16
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <close>:
.global close
close:
 li a7, SYS_close
 5c8:	48d5                	li	a7,21
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d0:	4899                	li	a7,6
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5d8:	489d                	li	a7,7
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <open>:
.global open
open:
 li a7, SYS_open
 5e0:	48bd                	li	a7,15
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5e8:	48c5                	li	a7,17
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f0:	48c9                	li	a7,18
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f8:	48a1                	li	a7,8
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <link>:
.global link
link:
 li a7, SYS_link
 600:	48cd                	li	a7,19
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 608:	48d1                	li	a7,20
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 610:	48a5                	li	a7,9
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <dup>:
.global dup
dup:
 li a7, SYS_dup
 618:	48a9                	li	a7,10
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 620:	48ad                	li	a7,11
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 628:	48b1                	li	a7,12
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 630:	48b5                	li	a7,13
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 638:	48b9                	li	a7,14
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <ps>:
.global ps
ps:
 li a7, SYS_ps
 640:	48d9                	li	a7,22
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 648:	48dd                	li	a7,23
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 650:	48e1                	li	a7,24
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 658:	1101                	addi	sp,sp,-32
 65a:	ec06                	sd	ra,24(sp)
 65c:	e822                	sd	s0,16(sp)
 65e:	1000                	addi	s0,sp,32
 660:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 664:	4605                	li	a2,1
 666:	fef40593          	addi	a1,s0,-17
 66a:	00000097          	auipc	ra,0x0
 66e:	f56080e7          	jalr	-170(ra) # 5c0 <write>
}
 672:	60e2                	ld	ra,24(sp)
 674:	6442                	ld	s0,16(sp)
 676:	6105                	addi	sp,sp,32
 678:	8082                	ret

000000000000067a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 67a:	7139                	addi	sp,sp,-64
 67c:	fc06                	sd	ra,56(sp)
 67e:	f822                	sd	s0,48(sp)
 680:	f426                	sd	s1,40(sp)
 682:	f04a                	sd	s2,32(sp)
 684:	ec4e                	sd	s3,24(sp)
 686:	0080                	addi	s0,sp,64
 688:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 68a:	c299                	beqz	a3,690 <printint+0x16>
 68c:	0805c963          	bltz	a1,71e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 690:	2581                	sext.w	a1,a1
  neg = 0;
 692:	4881                	li	a7,0
 694:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 698:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 69a:	2601                	sext.w	a2,a2
 69c:	00000517          	auipc	a0,0x0
 6a0:	51450513          	addi	a0,a0,1300 # bb0 <digits>
 6a4:	883a                	mv	a6,a4
 6a6:	2705                	addiw	a4,a4,1
 6a8:	02c5f7bb          	remuw	a5,a1,a2
 6ac:	1782                	slli	a5,a5,0x20
 6ae:	9381                	srli	a5,a5,0x20
 6b0:	97aa                	add	a5,a5,a0
 6b2:	0007c783          	lbu	a5,0(a5)
 6b6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ba:	0005879b          	sext.w	a5,a1
 6be:	02c5d5bb          	divuw	a1,a1,a2
 6c2:	0685                	addi	a3,a3,1
 6c4:	fec7f0e3          	bgeu	a5,a2,6a4 <printint+0x2a>
  if(neg)
 6c8:	00088c63          	beqz	a7,6e0 <printint+0x66>
    buf[i++] = '-';
 6cc:	fd070793          	addi	a5,a4,-48
 6d0:	00878733          	add	a4,a5,s0
 6d4:	02d00793          	li	a5,45
 6d8:	fef70823          	sb	a5,-16(a4)
 6dc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6e0:	02e05863          	blez	a4,710 <printint+0x96>
 6e4:	fc040793          	addi	a5,s0,-64
 6e8:	00e78933          	add	s2,a5,a4
 6ec:	fff78993          	addi	s3,a5,-1
 6f0:	99ba                	add	s3,s3,a4
 6f2:	377d                	addiw	a4,a4,-1
 6f4:	1702                	slli	a4,a4,0x20
 6f6:	9301                	srli	a4,a4,0x20
 6f8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6fc:	fff94583          	lbu	a1,-1(s2)
 700:	8526                	mv	a0,s1
 702:	00000097          	auipc	ra,0x0
 706:	f56080e7          	jalr	-170(ra) # 658 <putc>
  while(--i >= 0)
 70a:	197d                	addi	s2,s2,-1
 70c:	ff3918e3          	bne	s2,s3,6fc <printint+0x82>
}
 710:	70e2                	ld	ra,56(sp)
 712:	7442                	ld	s0,48(sp)
 714:	74a2                	ld	s1,40(sp)
 716:	7902                	ld	s2,32(sp)
 718:	69e2                	ld	s3,24(sp)
 71a:	6121                	addi	sp,sp,64
 71c:	8082                	ret
    x = -xx;
 71e:	40b005bb          	negw	a1,a1
    neg = 1;
 722:	4885                	li	a7,1
    x = -xx;
 724:	bf85                	j	694 <printint+0x1a>

0000000000000726 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 726:	715d                	addi	sp,sp,-80
 728:	e486                	sd	ra,72(sp)
 72a:	e0a2                	sd	s0,64(sp)
 72c:	fc26                	sd	s1,56(sp)
 72e:	f84a                	sd	s2,48(sp)
 730:	f44e                	sd	s3,40(sp)
 732:	f052                	sd	s4,32(sp)
 734:	ec56                	sd	s5,24(sp)
 736:	e85a                	sd	s6,16(sp)
 738:	e45e                	sd	s7,8(sp)
 73a:	e062                	sd	s8,0(sp)
 73c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 73e:	0005c903          	lbu	s2,0(a1)
 742:	18090c63          	beqz	s2,8da <vprintf+0x1b4>
 746:	8aaa                	mv	s5,a0
 748:	8bb2                	mv	s7,a2
 74a:	00158493          	addi	s1,a1,1
  state = 0;
 74e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 750:	02500a13          	li	s4,37
 754:	4b55                	li	s6,21
 756:	a839                	j	774 <vprintf+0x4e>
        putc(fd, c);
 758:	85ca                	mv	a1,s2
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	efc080e7          	jalr	-260(ra) # 658 <putc>
 764:	a019                	j	76a <vprintf+0x44>
    } else if(state == '%'){
 766:	01498d63          	beq	s3,s4,780 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 76a:	0485                	addi	s1,s1,1
 76c:	fff4c903          	lbu	s2,-1(s1)
 770:	16090563          	beqz	s2,8da <vprintf+0x1b4>
    if(state == 0){
 774:	fe0999e3          	bnez	s3,766 <vprintf+0x40>
      if(c == '%'){
 778:	ff4910e3          	bne	s2,s4,758 <vprintf+0x32>
        state = '%';
 77c:	89d2                	mv	s3,s4
 77e:	b7f5                	j	76a <vprintf+0x44>
      if(c == 'd'){
 780:	13490263          	beq	s2,s4,8a4 <vprintf+0x17e>
 784:	f9d9079b          	addiw	a5,s2,-99
 788:	0ff7f793          	zext.b	a5,a5
 78c:	12fb6563          	bltu	s6,a5,8b6 <vprintf+0x190>
 790:	f9d9079b          	addiw	a5,s2,-99
 794:	0ff7f713          	zext.b	a4,a5
 798:	10eb6f63          	bltu	s6,a4,8b6 <vprintf+0x190>
 79c:	00271793          	slli	a5,a4,0x2
 7a0:	00000717          	auipc	a4,0x0
 7a4:	3b870713          	addi	a4,a4,952 # b58 <malloc+0x180>
 7a8:	97ba                	add	a5,a5,a4
 7aa:	439c                	lw	a5,0(a5)
 7ac:	97ba                	add	a5,a5,a4
 7ae:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7b0:	008b8913          	addi	s2,s7,8
 7b4:	4685                	li	a3,1
 7b6:	4629                	li	a2,10
 7b8:	000ba583          	lw	a1,0(s7)
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	ebc080e7          	jalr	-324(ra) # 67a <printint>
 7c6:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7c8:	4981                	li	s3,0
 7ca:	b745                	j	76a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7cc:	008b8913          	addi	s2,s7,8
 7d0:	4681                	li	a3,0
 7d2:	4629                	li	a2,10
 7d4:	000ba583          	lw	a1,0(s7)
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	ea0080e7          	jalr	-352(ra) # 67a <printint>
 7e2:	8bca                	mv	s7,s2
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	b751                	j	76a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 7e8:	008b8913          	addi	s2,s7,8
 7ec:	4681                	li	a3,0
 7ee:	4641                	li	a2,16
 7f0:	000ba583          	lw	a1,0(s7)
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	e84080e7          	jalr	-380(ra) # 67a <printint>
 7fe:	8bca                	mv	s7,s2
      state = 0;
 800:	4981                	li	s3,0
 802:	b7a5                	j	76a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 804:	008b8c13          	addi	s8,s7,8
 808:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 80c:	03000593          	li	a1,48
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	e46080e7          	jalr	-442(ra) # 658 <putc>
  putc(fd, 'x');
 81a:	07800593          	li	a1,120
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	e38080e7          	jalr	-456(ra) # 658 <putc>
 828:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 82a:	00000b97          	auipc	s7,0x0
 82e:	386b8b93          	addi	s7,s7,902 # bb0 <digits>
 832:	03c9d793          	srli	a5,s3,0x3c
 836:	97de                	add	a5,a5,s7
 838:	0007c583          	lbu	a1,0(a5)
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	e1a080e7          	jalr	-486(ra) # 658 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 846:	0992                	slli	s3,s3,0x4
 848:	397d                	addiw	s2,s2,-1
 84a:	fe0914e3          	bnez	s2,832 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 84e:	8be2                	mv	s7,s8
      state = 0;
 850:	4981                	li	s3,0
 852:	bf21                	j	76a <vprintf+0x44>
        s = va_arg(ap, char*);
 854:	008b8993          	addi	s3,s7,8
 858:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 85c:	02090163          	beqz	s2,87e <vprintf+0x158>
        while(*s != 0){
 860:	00094583          	lbu	a1,0(s2)
 864:	c9a5                	beqz	a1,8d4 <vprintf+0x1ae>
          putc(fd, *s);
 866:	8556                	mv	a0,s5
 868:	00000097          	auipc	ra,0x0
 86c:	df0080e7          	jalr	-528(ra) # 658 <putc>
          s++;
 870:	0905                	addi	s2,s2,1
        while(*s != 0){
 872:	00094583          	lbu	a1,0(s2)
 876:	f9e5                	bnez	a1,866 <vprintf+0x140>
        s = va_arg(ap, char*);
 878:	8bce                	mv	s7,s3
      state = 0;
 87a:	4981                	li	s3,0
 87c:	b5fd                	j	76a <vprintf+0x44>
          s = "(null)";
 87e:	00000917          	auipc	s2,0x0
 882:	2d290913          	addi	s2,s2,722 # b50 <malloc+0x178>
        while(*s != 0){
 886:	02800593          	li	a1,40
 88a:	bff1                	j	866 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 88c:	008b8913          	addi	s2,s7,8
 890:	000bc583          	lbu	a1,0(s7)
 894:	8556                	mv	a0,s5
 896:	00000097          	auipc	ra,0x0
 89a:	dc2080e7          	jalr	-574(ra) # 658 <putc>
 89e:	8bca                	mv	s7,s2
      state = 0;
 8a0:	4981                	li	s3,0
 8a2:	b5e1                	j	76a <vprintf+0x44>
        putc(fd, c);
 8a4:	02500593          	li	a1,37
 8a8:	8556                	mv	a0,s5
 8aa:	00000097          	auipc	ra,0x0
 8ae:	dae080e7          	jalr	-594(ra) # 658 <putc>
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	bd5d                	j	76a <vprintf+0x44>
        putc(fd, '%');
 8b6:	02500593          	li	a1,37
 8ba:	8556                	mv	a0,s5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	d9c080e7          	jalr	-612(ra) # 658 <putc>
        putc(fd, c);
 8c4:	85ca                	mv	a1,s2
 8c6:	8556                	mv	a0,s5
 8c8:	00000097          	auipc	ra,0x0
 8cc:	d90080e7          	jalr	-624(ra) # 658 <putc>
      state = 0;
 8d0:	4981                	li	s3,0
 8d2:	bd61                	j	76a <vprintf+0x44>
        s = va_arg(ap, char*);
 8d4:	8bce                	mv	s7,s3
      state = 0;
 8d6:	4981                	li	s3,0
 8d8:	bd49                	j	76a <vprintf+0x44>
    }
  }
}
 8da:	60a6                	ld	ra,72(sp)
 8dc:	6406                	ld	s0,64(sp)
 8de:	74e2                	ld	s1,56(sp)
 8e0:	7942                	ld	s2,48(sp)
 8e2:	79a2                	ld	s3,40(sp)
 8e4:	7a02                	ld	s4,32(sp)
 8e6:	6ae2                	ld	s5,24(sp)
 8e8:	6b42                	ld	s6,16(sp)
 8ea:	6ba2                	ld	s7,8(sp)
 8ec:	6c02                	ld	s8,0(sp)
 8ee:	6161                	addi	sp,sp,80
 8f0:	8082                	ret

00000000000008f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f2:	715d                	addi	sp,sp,-80
 8f4:	ec06                	sd	ra,24(sp)
 8f6:	e822                	sd	s0,16(sp)
 8f8:	1000                	addi	s0,sp,32
 8fa:	e010                	sd	a2,0(s0)
 8fc:	e414                	sd	a3,8(s0)
 8fe:	e818                	sd	a4,16(s0)
 900:	ec1c                	sd	a5,24(s0)
 902:	03043023          	sd	a6,32(s0)
 906:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 90e:	8622                	mv	a2,s0
 910:	00000097          	auipc	ra,0x0
 914:	e16080e7          	jalr	-490(ra) # 726 <vprintf>
}
 918:	60e2                	ld	ra,24(sp)
 91a:	6442                	ld	s0,16(sp)
 91c:	6161                	addi	sp,sp,80
 91e:	8082                	ret

0000000000000920 <printf>:

void
printf(const char *fmt, ...)
{
 920:	711d                	addi	sp,sp,-96
 922:	ec06                	sd	ra,24(sp)
 924:	e822                	sd	s0,16(sp)
 926:	1000                	addi	s0,sp,32
 928:	e40c                	sd	a1,8(s0)
 92a:	e810                	sd	a2,16(s0)
 92c:	ec14                	sd	a3,24(s0)
 92e:	f018                	sd	a4,32(s0)
 930:	f41c                	sd	a5,40(s0)
 932:	03043823          	sd	a6,48(s0)
 936:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 93a:	00840613          	addi	a2,s0,8
 93e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 942:	85aa                	mv	a1,a0
 944:	4505                	li	a0,1
 946:	00000097          	auipc	ra,0x0
 94a:	de0080e7          	jalr	-544(ra) # 726 <vprintf>
}
 94e:	60e2                	ld	ra,24(sp)
 950:	6442                	ld	s0,16(sp)
 952:	6125                	addi	sp,sp,96
 954:	8082                	ret

0000000000000956 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 956:	1141                	addi	sp,sp,-16
 958:	e422                	sd	s0,8(sp)
 95a:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 95c:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 960:	00000797          	auipc	a5,0x0
 964:	6a87b783          	ld	a5,1704(a5) # 1008 <freep>
 968:	a02d                	j	992 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 96a:	4618                	lw	a4,8(a2)
 96c:	9f2d                	addw	a4,a4,a1
 96e:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 972:	6398                	ld	a4,0(a5)
 974:	6310                	ld	a2,0(a4)
 976:	a83d                	j	9b4 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 978:	ff852703          	lw	a4,-8(a0)
 97c:	9f31                	addw	a4,a4,a2
 97e:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 980:	ff053683          	ld	a3,-16(a0)
 984:	a091                	j	9c8 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 986:	6398                	ld	a4,0(a5)
 988:	00e7e463          	bltu	a5,a4,990 <free+0x3a>
 98c:	00e6ea63          	bltu	a3,a4,9a0 <free+0x4a>
{
 990:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 992:	fed7fae3          	bgeu	a5,a3,986 <free+0x30>
 996:	6398                	ld	a4,0(a5)
 998:	00e6e463          	bltu	a3,a4,9a0 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 99c:	fee7eae3          	bltu	a5,a4,990 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 9a0:	ff852583          	lw	a1,-8(a0)
 9a4:	6390                	ld	a2,0(a5)
 9a6:	02059813          	slli	a6,a1,0x20
 9aa:	01c85713          	srli	a4,a6,0x1c
 9ae:	9736                	add	a4,a4,a3
 9b0:	fae60de3          	beq	a2,a4,96a <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 9b4:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 9b8:	4790                	lw	a2,8(a5)
 9ba:	02061593          	slli	a1,a2,0x20
 9be:	01c5d713          	srli	a4,a1,0x1c
 9c2:	973e                	add	a4,a4,a5
 9c4:	fae68ae3          	beq	a3,a4,978 <free+0x22>
        p->s.ptr = bp->s.ptr;
 9c8:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 9ca:	00000717          	auipc	a4,0x0
 9ce:	62f73f23          	sd	a5,1598(a4) # 1008 <freep>
}
 9d2:	6422                	ld	s0,8(sp)
 9d4:	0141                	addi	sp,sp,16
 9d6:	8082                	ret

00000000000009d8 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 9d8:	7139                	addi	sp,sp,-64
 9da:	fc06                	sd	ra,56(sp)
 9dc:	f822                	sd	s0,48(sp)
 9de:	f426                	sd	s1,40(sp)
 9e0:	f04a                	sd	s2,32(sp)
 9e2:	ec4e                	sd	s3,24(sp)
 9e4:	e852                	sd	s4,16(sp)
 9e6:	e456                	sd	s5,8(sp)
 9e8:	e05a                	sd	s6,0(sp)
 9ea:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 9ec:	02051493          	slli	s1,a0,0x20
 9f0:	9081                	srli	s1,s1,0x20
 9f2:	04bd                	addi	s1,s1,15
 9f4:	8091                	srli	s1,s1,0x4
 9f6:	0014899b          	addiw	s3,s1,1
 9fa:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 9fc:	00000517          	auipc	a0,0x0
 a00:	60c53503          	ld	a0,1548(a0) # 1008 <freep>
 a04:	c515                	beqz	a0,a30 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a06:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 a08:	4798                	lw	a4,8(a5)
 a0a:	02977f63          	bgeu	a4,s1,a48 <malloc+0x70>
    if (nu < 4096)
 a0e:	8a4e                	mv	s4,s3
 a10:	0009871b          	sext.w	a4,s3
 a14:	6685                	lui	a3,0x1
 a16:	00d77363          	bgeu	a4,a3,a1c <malloc+0x44>
 a1a:	6a05                	lui	s4,0x1
 a1c:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 a20:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 a24:	00000917          	auipc	s2,0x0
 a28:	5e490913          	addi	s2,s2,1508 # 1008 <freep>
    if (p == (char *)-1)
 a2c:	5afd                	li	s5,-1
 a2e:	a895                	j	aa2 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 a30:	00000797          	auipc	a5,0x0
 a34:	5e078793          	addi	a5,a5,1504 # 1010 <base>
 a38:	00000717          	auipc	a4,0x0
 a3c:	5cf73823          	sd	a5,1488(a4) # 1008 <freep>
 a40:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 a42:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 a46:	b7e1                	j	a0e <malloc+0x36>
            if (p->s.size == nunits)
 a48:	02e48c63          	beq	s1,a4,a80 <malloc+0xa8>
                p->s.size -= nunits;
 a4c:	4137073b          	subw	a4,a4,s3
 a50:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a52:	02071693          	slli	a3,a4,0x20
 a56:	01c6d713          	srli	a4,a3,0x1c
 a5a:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a5c:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a60:	00000717          	auipc	a4,0x0
 a64:	5aa73423          	sd	a0,1448(a4) # 1008 <freep>
            return (void *)(p + 1);
 a68:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 a6c:	70e2                	ld	ra,56(sp)
 a6e:	7442                	ld	s0,48(sp)
 a70:	74a2                	ld	s1,40(sp)
 a72:	7902                	ld	s2,32(sp)
 a74:	69e2                	ld	s3,24(sp)
 a76:	6a42                	ld	s4,16(sp)
 a78:	6aa2                	ld	s5,8(sp)
 a7a:	6b02                	ld	s6,0(sp)
 a7c:	6121                	addi	sp,sp,64
 a7e:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 a80:	6398                	ld	a4,0(a5)
 a82:	e118                	sd	a4,0(a0)
 a84:	bff1                	j	a60 <malloc+0x88>
    hp->s.size = nu;
 a86:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a8a:	0541                	addi	a0,a0,16
 a8c:	00000097          	auipc	ra,0x0
 a90:	eca080e7          	jalr	-310(ra) # 956 <free>
    return freep;
 a94:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a98:	d971                	beqz	a0,a6c <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a9a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a9c:	4798                	lw	a4,8(a5)
 a9e:	fa9775e3          	bgeu	a4,s1,a48 <malloc+0x70>
        if (p == freep)
 aa2:	00093703          	ld	a4,0(s2)
 aa6:	853e                	mv	a0,a5
 aa8:	fef719e3          	bne	a4,a5,a9a <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 aac:	8552                	mv	a0,s4
 aae:	00000097          	auipc	ra,0x0
 ab2:	b7a080e7          	jalr	-1158(ra) # 628 <sbrk>
    if (p == (char *)-1)
 ab6:	fd5518e3          	bne	a0,s5,a86 <malloc+0xae>
                return 0;
 aba:	4501                	li	a0,0
 abc:	bf45                	j	a6c <malloc+0x94>
