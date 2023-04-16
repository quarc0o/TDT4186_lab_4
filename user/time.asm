
user/_time:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
    if (argc < 2)
   c:	4785                	li	a5,1
   e:	02a7db63          	bge	a5,a0,44 <main+0x44>
  12:	84ae                	mv	s1,a1
        printf("Time took 0 ticks\n");
        printf("Usage: time [exec] [arg1 arg2 ...]\n");
        exit(1);
    }

    int startticks = uptime();
  14:	00000097          	auipc	ra,0x0
  18:	5f2080e7          	jalr	1522(ra) # 606 <uptime>
  1c:	892a                	mv	s2,a0

    // we now start the program in a separate process:
    int uutPid = fork();
  1e:	00000097          	auipc	ra,0x0
  22:	548080e7          	jalr	1352(ra) # 566 <fork>

    // check if fork worked:
    if (uutPid < 0)
  26:	04054463          	bltz	a0,6e <main+0x6e>
    {
        printf("fork failed... couldn't start %s", argv[1]);
        exit(1);
    }

    if (uutPid == 0)
  2a:	e125                	bnez	a0,8a <main+0x8a>
    {
        // we are the unit under test part of the program - execute the program immediately
        exec(argv[1], argv + 1); // pass rest of the command line to the executable as args
  2c:	00848593          	addi	a1,s1,8
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	574080e7          	jalr	1396(ra) # 5a6 <exec>
        // wait for the uut to finish
        wait(0);
        int endticks = uptime();
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
    }
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	532080e7          	jalr	1330(ra) # 56e <exit>
        printf("Time took 0 ticks\n");
  44:	00001517          	auipc	a0,0x1
  48:	a4c50513          	addi	a0,a0,-1460 # a90 <malloc+0xea>
  4c:	00001097          	auipc	ra,0x1
  50:	8a2080e7          	jalr	-1886(ra) # 8ee <printf>
        printf("Usage: time [exec] [arg1 arg2 ...]\n");
  54:	00001517          	auipc	a0,0x1
  58:	a5450513          	addi	a0,a0,-1452 # aa8 <malloc+0x102>
  5c:	00001097          	auipc	ra,0x1
  60:	892080e7          	jalr	-1902(ra) # 8ee <printf>
        exit(1);
  64:	4505                	li	a0,1
  66:	00000097          	auipc	ra,0x0
  6a:	508080e7          	jalr	1288(ra) # 56e <exit>
        printf("fork failed... couldn't start %s", argv[1]);
  6e:	648c                	ld	a1,8(s1)
  70:	00001517          	auipc	a0,0x1
  74:	a6050513          	addi	a0,a0,-1440 # ad0 <malloc+0x12a>
  78:	00001097          	auipc	ra,0x1
  7c:	876080e7          	jalr	-1930(ra) # 8ee <printf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	4ec080e7          	jalr	1260(ra) # 56e <exit>
        wait(0);
  8a:	4501                	li	a0,0
  8c:	00000097          	auipc	ra,0x0
  90:	4ea080e7          	jalr	1258(ra) # 576 <wait>
        int endticks = uptime();
  94:	00000097          	auipc	ra,0x0
  98:	572080e7          	jalr	1394(ra) # 606 <uptime>
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
  9c:	4125063b          	subw	a2,a0,s2
  a0:	648c                	ld	a1,8(s1)
  a2:	00001517          	auipc	a0,0x1
  a6:	a5650513          	addi	a0,a0,-1450 # af8 <malloc+0x152>
  aa:	00001097          	auipc	ra,0x1
  ae:	844080e7          	jalr	-1980(ra) # 8ee <printf>
  b2:	b761                	j	3a <main+0x3a>

00000000000000b4 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  b4:	1141                	addi	sp,sp,-16
  b6:	e422                	sd	s0,8(sp)
  b8:	0800                	addi	s0,sp,16
    lk->name = name;
  ba:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  bc:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  c0:	57fd                	li	a5,-1
  c2:	00f50823          	sb	a5,16(a0)
}
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret

00000000000000cc <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  cc:	00054783          	lbu	a5,0(a0)
  d0:	e399                	bnez	a5,d6 <holding+0xa>
  d2:	4501                	li	a0,0
}
  d4:	8082                	ret
{
  d6:	1101                	addi	sp,sp,-32
  d8:	ec06                	sd	ra,24(sp)
  da:	e822                	sd	s0,16(sp)
  dc:	e426                	sd	s1,8(sp)
  de:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  e0:	01054483          	lbu	s1,16(a0)
  e4:	00000097          	auipc	ra,0x0
  e8:	172080e7          	jalr	370(ra) # 256 <twhoami>
  ec:	2501                	sext.w	a0,a0
  ee:	40a48533          	sub	a0,s1,a0
  f2:	00153513          	seqz	a0,a0
}
  f6:	60e2                	ld	ra,24(sp)
  f8:	6442                	ld	s0,16(sp)
  fa:	64a2                	ld	s1,8(sp)
  fc:	6105                	addi	sp,sp,32
  fe:	8082                	ret

0000000000000100 <acquire>:

void acquire(struct lock *lk)
{
 100:	7179                	addi	sp,sp,-48
 102:	f406                	sd	ra,40(sp)
 104:	f022                	sd	s0,32(sp)
 106:	ec26                	sd	s1,24(sp)
 108:	e84a                	sd	s2,16(sp)
 10a:	e44e                	sd	s3,8(sp)
 10c:	e052                	sd	s4,0(sp)
 10e:	1800                	addi	s0,sp,48
 110:	8a2a                	mv	s4,a0
    if (holding(lk))
 112:	00000097          	auipc	ra,0x0
 116:	fba080e7          	jalr	-70(ra) # cc <holding>
 11a:	e919                	bnez	a0,130 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 11c:	ffca7493          	andi	s1,s4,-4
 120:	003a7913          	andi	s2,s4,3
 124:	0039191b          	slliw	s2,s2,0x3
 128:	4985                	li	s3,1
 12a:	012999bb          	sllw	s3,s3,s2
 12e:	a015                	j	152 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 130:	00001517          	auipc	a0,0x1
 134:	9e850513          	addi	a0,a0,-1560 # b18 <malloc+0x172>
 138:	00000097          	auipc	ra,0x0
 13c:	7b6080e7          	jalr	1974(ra) # 8ee <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	42c080e7          	jalr	1068(ra) # 56e <exit>
    {
        // give up the cpu for other threads
        tyield();
 14a:	00000097          	auipc	ra,0x0
 14e:	0f4080e7          	jalr	244(ra) # 23e <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 152:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 156:	0127d7bb          	srlw	a5,a5,s2
 15a:	0ff7f793          	zext.b	a5,a5
 15e:	f7f5                	bnez	a5,14a <acquire+0x4a>
    }

    __sync_synchronize();
 160:	0ff0000f          	fence

    lk->tid = twhoami();
 164:	00000097          	auipc	ra,0x0
 168:	0f2080e7          	jalr	242(ra) # 256 <twhoami>
 16c:	00aa0823          	sb	a0,16(s4)
}
 170:	70a2                	ld	ra,40(sp)
 172:	7402                	ld	s0,32(sp)
 174:	64e2                	ld	s1,24(sp)
 176:	6942                	ld	s2,16(sp)
 178:	69a2                	ld	s3,8(sp)
 17a:	6a02                	ld	s4,0(sp)
 17c:	6145                	addi	sp,sp,48
 17e:	8082                	ret

0000000000000180 <release>:

void release(struct lock *lk)
{
 180:	1101                	addi	sp,sp,-32
 182:	ec06                	sd	ra,24(sp)
 184:	e822                	sd	s0,16(sp)
 186:	e426                	sd	s1,8(sp)
 188:	1000                	addi	s0,sp,32
 18a:	84aa                	mv	s1,a0
    if (!holding(lk))
 18c:	00000097          	auipc	ra,0x0
 190:	f40080e7          	jalr	-192(ra) # cc <holding>
 194:	c11d                	beqz	a0,1ba <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 196:	57fd                	li	a5,-1
 198:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 19c:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1a0:	0ff0000f          	fence
 1a4:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1a8:	00000097          	auipc	ra,0x0
 1ac:	096080e7          	jalr	150(ra) # 23e <tyield>
}
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	64a2                	ld	s1,8(sp)
 1b6:	6105                	addi	sp,sp,32
 1b8:	8082                	ret
        printf("releasing lock we are not holding");
 1ba:	00001517          	auipc	a0,0x1
 1be:	98650513          	addi	a0,a0,-1658 # b40 <malloc+0x19a>
 1c2:	00000097          	auipc	ra,0x0
 1c6:	72c080e7          	jalr	1836(ra) # 8ee <printf>
        exit(-1);
 1ca:	557d                	li	a0,-1
 1cc:	00000097          	auipc	ra,0x0
 1d0:	3a2080e7          	jalr	930(ra) # 56e <exit>

00000000000001d4 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1da:	00001717          	auipc	a4,0x1
 1de:	e2673703          	ld	a4,-474(a4) # 1000 <current_thread>
 1e2:	47c1                	li	a5,16
 1e4:	c319                	beqz	a4,1ea <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 1e6:	37fd                	addiw	a5,a5,-1
 1e8:	fff5                	bnez	a5,1e4 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	addi	sp,sp,16
 1ee:	8082                	ret

00000000000001f0 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 1f0:	7179                	addi	sp,sp,-48
 1f2:	f406                	sd	ra,40(sp)
 1f4:	f022                	sd	s0,32(sp)
 1f6:	ec26                	sd	s1,24(sp)
 1f8:	e84a                	sd	s2,16(sp)
 1fa:	e44e                	sd	s3,8(sp)
 1fc:	1800                	addi	s0,sp,48
 1fe:	84aa                	mv	s1,a0
 200:	89b2                	mv	s3,a2
 202:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 204:	09000513          	li	a0,144
 208:	00000097          	auipc	ra,0x0
 20c:	79e080e7          	jalr	1950(ra) # 9a6 <malloc>
 210:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 212:	478d                	li	a5,3
 214:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 216:	609c                	ld	a5,0(s1)
 218:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 21c:	609c                	ld	a5,0(s1)
 21e:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 222:	70a2                	ld	ra,40(sp)
 224:	7402                	ld	s0,32(sp)
 226:	64e2                	ld	s1,24(sp)
 228:	6942                	ld	s2,16(sp)
 22a:	69a2                	ld	s3,8(sp)
 22c:	6145                	addi	sp,sp,48
 22e:	8082                	ret

0000000000000230 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 236:	4501                	li	a0,0
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret

000000000000023e <tyield>:

void tyield()
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 244:	00001797          	auipc	a5,0x1
 248:	dbc7b783          	ld	a5,-580(a5) # 1000 <current_thread>
 24c:	470d                	li	a4,3
 24e:	dfb8                	sw	a4,120(a5)
    tsched();
}
 250:	6422                	ld	s0,8(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret

0000000000000256 <twhoami>:

uint8 twhoami()
{
 256:	1141                	addi	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 25c:	4501                	li	a0,0
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret

0000000000000264 <tswtch>:
 264:	00153023          	sd	ra,0(a0)
 268:	00253423          	sd	sp,8(a0)
 26c:	e900                	sd	s0,16(a0)
 26e:	ed04                	sd	s1,24(a0)
 270:	03253023          	sd	s2,32(a0)
 274:	03353423          	sd	s3,40(a0)
 278:	03453823          	sd	s4,48(a0)
 27c:	03553c23          	sd	s5,56(a0)
 280:	05653023          	sd	s6,64(a0)
 284:	05753423          	sd	s7,72(a0)
 288:	05853823          	sd	s8,80(a0)
 28c:	05953c23          	sd	s9,88(a0)
 290:	07a53023          	sd	s10,96(a0)
 294:	07b53423          	sd	s11,104(a0)
 298:	0005b083          	ld	ra,0(a1)
 29c:	0085b103          	ld	sp,8(a1)
 2a0:	6980                	ld	s0,16(a1)
 2a2:	6d84                	ld	s1,24(a1)
 2a4:	0205b903          	ld	s2,32(a1)
 2a8:	0285b983          	ld	s3,40(a1)
 2ac:	0305ba03          	ld	s4,48(a1)
 2b0:	0385ba83          	ld	s5,56(a1)
 2b4:	0405bb03          	ld	s6,64(a1)
 2b8:	0485bb83          	ld	s7,72(a1)
 2bc:	0505bc03          	ld	s8,80(a1)
 2c0:	0585bc83          	ld	s9,88(a1)
 2c4:	0605bd03          	ld	s10,96(a1)
 2c8:	0685bd83          	ld	s11,104(a1)
 2cc:	8082                	ret

00000000000002ce <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 2ce:	1101                	addi	sp,sp,-32
 2d0:	ec06                	sd	ra,24(sp)
 2d2:	e822                	sd	s0,16(sp)
 2d4:	e426                	sd	s1,8(sp)
 2d6:	e04a                	sd	s2,0(sp)
 2d8:	1000                	addi	s0,sp,32
 2da:	84aa                	mv	s1,a0
 2dc:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 2de:	09000513          	li	a0,144
 2e2:	00000097          	auipc	ra,0x0
 2e6:	6c4080e7          	jalr	1732(ra) # 9a6 <malloc>

    main_thread->tid = 0;
 2ea:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 2ee:	85ca                	mv	a1,s2
 2f0:	8526                	mv	a0,s1
 2f2:	00000097          	auipc	ra,0x0
 2f6:	d0e080e7          	jalr	-754(ra) # 0 <main>
    exit(res);
 2fa:	00000097          	auipc	ra,0x0
 2fe:	274080e7          	jalr	628(ra) # 56e <exit>

0000000000000302 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 302:	1141                	addi	sp,sp,-16
 304:	e422                	sd	s0,8(sp)
 306:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 308:	87aa                	mv	a5,a0
 30a:	0585                	addi	a1,a1,1
 30c:	0785                	addi	a5,a5,1
 30e:	fff5c703          	lbu	a4,-1(a1)
 312:	fee78fa3          	sb	a4,-1(a5)
 316:	fb75                	bnez	a4,30a <strcpy+0x8>
        ;
    return os;
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	addi	sp,sp,16
 31c:	8082                	ret

000000000000031e <strcmp>:

int strcmp(const char *p, const char *q)
{
 31e:	1141                	addi	sp,sp,-16
 320:	e422                	sd	s0,8(sp)
 322:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 324:	00054783          	lbu	a5,0(a0)
 328:	cb91                	beqz	a5,33c <strcmp+0x1e>
 32a:	0005c703          	lbu	a4,0(a1)
 32e:	00f71763          	bne	a4,a5,33c <strcmp+0x1e>
        p++, q++;
 332:	0505                	addi	a0,a0,1
 334:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 336:	00054783          	lbu	a5,0(a0)
 33a:	fbe5                	bnez	a5,32a <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 33c:	0005c503          	lbu	a0,0(a1)
}
 340:	40a7853b          	subw	a0,a5,a0
 344:	6422                	ld	s0,8(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret

000000000000034a <strlen>:

uint strlen(const char *s)
{
 34a:	1141                	addi	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 350:	00054783          	lbu	a5,0(a0)
 354:	cf91                	beqz	a5,370 <strlen+0x26>
 356:	0505                	addi	a0,a0,1
 358:	87aa                	mv	a5,a0
 35a:	86be                	mv	a3,a5
 35c:	0785                	addi	a5,a5,1
 35e:	fff7c703          	lbu	a4,-1(a5)
 362:	ff65                	bnez	a4,35a <strlen+0x10>
 364:	40a6853b          	subw	a0,a3,a0
 368:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
    for (n = 0; s[n]; n++)
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <strlen+0x20>

0000000000000374 <memset>:

void *
memset(void *dst, int c, uint n)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 37a:	ca19                	beqz	a2,390 <memset+0x1c>
 37c:	87aa                	mv	a5,a0
 37e:	1602                	slli	a2,a2,0x20
 380:	9201                	srli	a2,a2,0x20
 382:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 386:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 38a:	0785                	addi	a5,a5,1
 38c:	fee79de3          	bne	a5,a4,386 <memset+0x12>
    }
    return dst;
}
 390:	6422                	ld	s0,8(sp)
 392:	0141                	addi	sp,sp,16
 394:	8082                	ret

0000000000000396 <strchr>:

char *
strchr(const char *s, char c)
{
 396:	1141                	addi	sp,sp,-16
 398:	e422                	sd	s0,8(sp)
 39a:	0800                	addi	s0,sp,16
    for (; *s; s++)
 39c:	00054783          	lbu	a5,0(a0)
 3a0:	cb99                	beqz	a5,3b6 <strchr+0x20>
        if (*s == c)
 3a2:	00f58763          	beq	a1,a5,3b0 <strchr+0x1a>
    for (; *s; s++)
 3a6:	0505                	addi	a0,a0,1
 3a8:	00054783          	lbu	a5,0(a0)
 3ac:	fbfd                	bnez	a5,3a2 <strchr+0xc>
            return (char *)s;
    return 0;
 3ae:	4501                	li	a0,0
}
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret
    return 0;
 3b6:	4501                	li	a0,0
 3b8:	bfe5                	j	3b0 <strchr+0x1a>

00000000000003ba <gets>:

char *
gets(char *buf, int max)
{
 3ba:	711d                	addi	sp,sp,-96
 3bc:	ec86                	sd	ra,88(sp)
 3be:	e8a2                	sd	s0,80(sp)
 3c0:	e4a6                	sd	s1,72(sp)
 3c2:	e0ca                	sd	s2,64(sp)
 3c4:	fc4e                	sd	s3,56(sp)
 3c6:	f852                	sd	s4,48(sp)
 3c8:	f456                	sd	s5,40(sp)
 3ca:	f05a                	sd	s6,32(sp)
 3cc:	ec5e                	sd	s7,24(sp)
 3ce:	1080                	addi	s0,sp,96
 3d0:	8baa                	mv	s7,a0
 3d2:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 3d4:	892a                	mv	s2,a0
 3d6:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 3d8:	4aa9                	li	s5,10
 3da:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 3dc:	89a6                	mv	s3,s1
 3de:	2485                	addiw	s1,s1,1
 3e0:	0344d863          	bge	s1,s4,410 <gets+0x56>
        cc = read(0, &c, 1);
 3e4:	4605                	li	a2,1
 3e6:	faf40593          	addi	a1,s0,-81
 3ea:	4501                	li	a0,0
 3ec:	00000097          	auipc	ra,0x0
 3f0:	19a080e7          	jalr	410(ra) # 586 <read>
        if (cc < 1)
 3f4:	00a05e63          	blez	a0,410 <gets+0x56>
        buf[i++] = c;
 3f8:	faf44783          	lbu	a5,-81(s0)
 3fc:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 400:	01578763          	beq	a5,s5,40e <gets+0x54>
 404:	0905                	addi	s2,s2,1
 406:	fd679be3          	bne	a5,s6,3dc <gets+0x22>
    for (i = 0; i + 1 < max;)
 40a:	89a6                	mv	s3,s1
 40c:	a011                	j	410 <gets+0x56>
 40e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 410:	99de                	add	s3,s3,s7
 412:	00098023          	sb	zero,0(s3)
    return buf;
}
 416:	855e                	mv	a0,s7
 418:	60e6                	ld	ra,88(sp)
 41a:	6446                	ld	s0,80(sp)
 41c:	64a6                	ld	s1,72(sp)
 41e:	6906                	ld	s2,64(sp)
 420:	79e2                	ld	s3,56(sp)
 422:	7a42                	ld	s4,48(sp)
 424:	7aa2                	ld	s5,40(sp)
 426:	7b02                	ld	s6,32(sp)
 428:	6be2                	ld	s7,24(sp)
 42a:	6125                	addi	sp,sp,96
 42c:	8082                	ret

000000000000042e <stat>:

int stat(const char *n, struct stat *st)
{
 42e:	1101                	addi	sp,sp,-32
 430:	ec06                	sd	ra,24(sp)
 432:	e822                	sd	s0,16(sp)
 434:	e426                	sd	s1,8(sp)
 436:	e04a                	sd	s2,0(sp)
 438:	1000                	addi	s0,sp,32
 43a:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 43c:	4581                	li	a1,0
 43e:	00000097          	auipc	ra,0x0
 442:	170080e7          	jalr	368(ra) # 5ae <open>
    if (fd < 0)
 446:	02054563          	bltz	a0,470 <stat+0x42>
 44a:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 44c:	85ca                	mv	a1,s2
 44e:	00000097          	auipc	ra,0x0
 452:	178080e7          	jalr	376(ra) # 5c6 <fstat>
 456:	892a                	mv	s2,a0
    close(fd);
 458:	8526                	mv	a0,s1
 45a:	00000097          	auipc	ra,0x0
 45e:	13c080e7          	jalr	316(ra) # 596 <close>
    return r;
}
 462:	854a                	mv	a0,s2
 464:	60e2                	ld	ra,24(sp)
 466:	6442                	ld	s0,16(sp)
 468:	64a2                	ld	s1,8(sp)
 46a:	6902                	ld	s2,0(sp)
 46c:	6105                	addi	sp,sp,32
 46e:	8082                	ret
        return -1;
 470:	597d                	li	s2,-1
 472:	bfc5                	j	462 <stat+0x34>

0000000000000474 <atoi>:

int atoi(const char *s)
{
 474:	1141                	addi	sp,sp,-16
 476:	e422                	sd	s0,8(sp)
 478:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 47a:	00054683          	lbu	a3,0(a0)
 47e:	fd06879b          	addiw	a5,a3,-48
 482:	0ff7f793          	zext.b	a5,a5
 486:	4625                	li	a2,9
 488:	02f66863          	bltu	a2,a5,4b8 <atoi+0x44>
 48c:	872a                	mv	a4,a0
    n = 0;
 48e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 490:	0705                	addi	a4,a4,1
 492:	0025179b          	slliw	a5,a0,0x2
 496:	9fa9                	addw	a5,a5,a0
 498:	0017979b          	slliw	a5,a5,0x1
 49c:	9fb5                	addw	a5,a5,a3
 49e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 4a2:	00074683          	lbu	a3,0(a4)
 4a6:	fd06879b          	addiw	a5,a3,-48
 4aa:	0ff7f793          	zext.b	a5,a5
 4ae:	fef671e3          	bgeu	a2,a5,490 <atoi+0x1c>
    return n;
}
 4b2:	6422                	ld	s0,8(sp)
 4b4:	0141                	addi	sp,sp,16
 4b6:	8082                	ret
    n = 0;
 4b8:	4501                	li	a0,0
 4ba:	bfe5                	j	4b2 <atoi+0x3e>

00000000000004bc <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 4bc:	1141                	addi	sp,sp,-16
 4be:	e422                	sd	s0,8(sp)
 4c0:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 4c2:	02b57463          	bgeu	a0,a1,4ea <memmove+0x2e>
    {
        while (n-- > 0)
 4c6:	00c05f63          	blez	a2,4e4 <memmove+0x28>
 4ca:	1602                	slli	a2,a2,0x20
 4cc:	9201                	srli	a2,a2,0x20
 4ce:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 4d2:	872a                	mv	a4,a0
            *dst++ = *src++;
 4d4:	0585                	addi	a1,a1,1
 4d6:	0705                	addi	a4,a4,1
 4d8:	fff5c683          	lbu	a3,-1(a1)
 4dc:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 4e0:	fee79ae3          	bne	a5,a4,4d4 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 4e4:	6422                	ld	s0,8(sp)
 4e6:	0141                	addi	sp,sp,16
 4e8:	8082                	ret
        dst += n;
 4ea:	00c50733          	add	a4,a0,a2
        src += n;
 4ee:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 4f0:	fec05ae3          	blez	a2,4e4 <memmove+0x28>
 4f4:	fff6079b          	addiw	a5,a2,-1
 4f8:	1782                	slli	a5,a5,0x20
 4fa:	9381                	srli	a5,a5,0x20
 4fc:	fff7c793          	not	a5,a5
 500:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 502:	15fd                	addi	a1,a1,-1
 504:	177d                	addi	a4,a4,-1
 506:	0005c683          	lbu	a3,0(a1)
 50a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 50e:	fee79ae3          	bne	a5,a4,502 <memmove+0x46>
 512:	bfc9                	j	4e4 <memmove+0x28>

0000000000000514 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 514:	1141                	addi	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 51a:	ca05                	beqz	a2,54a <memcmp+0x36>
 51c:	fff6069b          	addiw	a3,a2,-1
 520:	1682                	slli	a3,a3,0x20
 522:	9281                	srli	a3,a3,0x20
 524:	0685                	addi	a3,a3,1
 526:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 528:	00054783          	lbu	a5,0(a0)
 52c:	0005c703          	lbu	a4,0(a1)
 530:	00e79863          	bne	a5,a4,540 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 534:	0505                	addi	a0,a0,1
        p2++;
 536:	0585                	addi	a1,a1,1
    while (n-- > 0)
 538:	fed518e3          	bne	a0,a3,528 <memcmp+0x14>
    }
    return 0;
 53c:	4501                	li	a0,0
 53e:	a019                	j	544 <memcmp+0x30>
            return *p1 - *p2;
 540:	40e7853b          	subw	a0,a5,a4
}
 544:	6422                	ld	s0,8(sp)
 546:	0141                	addi	sp,sp,16
 548:	8082                	ret
    return 0;
 54a:	4501                	li	a0,0
 54c:	bfe5                	j	544 <memcmp+0x30>

000000000000054e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 54e:	1141                	addi	sp,sp,-16
 550:	e406                	sd	ra,8(sp)
 552:	e022                	sd	s0,0(sp)
 554:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 556:	00000097          	auipc	ra,0x0
 55a:	f66080e7          	jalr	-154(ra) # 4bc <memmove>
}
 55e:	60a2                	ld	ra,8(sp)
 560:	6402                	ld	s0,0(sp)
 562:	0141                	addi	sp,sp,16
 564:	8082                	ret

0000000000000566 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 566:	4885                	li	a7,1
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <exit>:
.global exit
exit:
 li a7, SYS_exit
 56e:	4889                	li	a7,2
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <wait>:
.global wait
wait:
 li a7, SYS_wait
 576:	488d                	li	a7,3
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 57e:	4891                	li	a7,4
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <read>:
.global read
read:
 li a7, SYS_read
 586:	4895                	li	a7,5
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <write>:
.global write
write:
 li a7, SYS_write
 58e:	48c1                	li	a7,16
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <close>:
.global close
close:
 li a7, SYS_close
 596:	48d5                	li	a7,21
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <kill>:
.global kill
kill:
 li a7, SYS_kill
 59e:	4899                	li	a7,6
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5a6:	489d                	li	a7,7
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <open>:
.global open
open:
 li a7, SYS_open
 5ae:	48bd                	li	a7,15
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5b6:	48c5                	li	a7,17
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5be:	48c9                	li	a7,18
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5c6:	48a1                	li	a7,8
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <link>:
.global link
link:
 li a7, SYS_link
 5ce:	48cd                	li	a7,19
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5d6:	48d1                	li	a7,20
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5de:	48a5                	li	a7,9
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5e6:	48a9                	li	a7,10
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ee:	48ad                	li	a7,11
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5f6:	48b1                	li	a7,12
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5fe:	48b5                	li	a7,13
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 606:	48b9                	li	a7,14
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <ps>:
.global ps
ps:
 li a7, SYS_ps
 60e:	48d9                	li	a7,22
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 616:	48dd                	li	a7,23
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 61e:	48e1                	li	a7,24
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 626:	1101                	addi	sp,sp,-32
 628:	ec06                	sd	ra,24(sp)
 62a:	e822                	sd	s0,16(sp)
 62c:	1000                	addi	s0,sp,32
 62e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 632:	4605                	li	a2,1
 634:	fef40593          	addi	a1,s0,-17
 638:	00000097          	auipc	ra,0x0
 63c:	f56080e7          	jalr	-170(ra) # 58e <write>
}
 640:	60e2                	ld	ra,24(sp)
 642:	6442                	ld	s0,16(sp)
 644:	6105                	addi	sp,sp,32
 646:	8082                	ret

0000000000000648 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 648:	7139                	addi	sp,sp,-64
 64a:	fc06                	sd	ra,56(sp)
 64c:	f822                	sd	s0,48(sp)
 64e:	f426                	sd	s1,40(sp)
 650:	f04a                	sd	s2,32(sp)
 652:	ec4e                	sd	s3,24(sp)
 654:	0080                	addi	s0,sp,64
 656:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 658:	c299                	beqz	a3,65e <printint+0x16>
 65a:	0805c963          	bltz	a1,6ec <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65e:	2581                	sext.w	a1,a1
  neg = 0;
 660:	4881                	li	a7,0
 662:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 666:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 668:	2601                	sext.w	a2,a2
 66a:	00000517          	auipc	a0,0x0
 66e:	55e50513          	addi	a0,a0,1374 # bc8 <digits>
 672:	883a                	mv	a6,a4
 674:	2705                	addiw	a4,a4,1
 676:	02c5f7bb          	remuw	a5,a1,a2
 67a:	1782                	slli	a5,a5,0x20
 67c:	9381                	srli	a5,a5,0x20
 67e:	97aa                	add	a5,a5,a0
 680:	0007c783          	lbu	a5,0(a5)
 684:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 688:	0005879b          	sext.w	a5,a1
 68c:	02c5d5bb          	divuw	a1,a1,a2
 690:	0685                	addi	a3,a3,1
 692:	fec7f0e3          	bgeu	a5,a2,672 <printint+0x2a>
  if(neg)
 696:	00088c63          	beqz	a7,6ae <printint+0x66>
    buf[i++] = '-';
 69a:	fd070793          	addi	a5,a4,-48
 69e:	00878733          	add	a4,a5,s0
 6a2:	02d00793          	li	a5,45
 6a6:	fef70823          	sb	a5,-16(a4)
 6aa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6ae:	02e05863          	blez	a4,6de <printint+0x96>
 6b2:	fc040793          	addi	a5,s0,-64
 6b6:	00e78933          	add	s2,a5,a4
 6ba:	fff78993          	addi	s3,a5,-1
 6be:	99ba                	add	s3,s3,a4
 6c0:	377d                	addiw	a4,a4,-1
 6c2:	1702                	slli	a4,a4,0x20
 6c4:	9301                	srli	a4,a4,0x20
 6c6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ca:	fff94583          	lbu	a1,-1(s2)
 6ce:	8526                	mv	a0,s1
 6d0:	00000097          	auipc	ra,0x0
 6d4:	f56080e7          	jalr	-170(ra) # 626 <putc>
  while(--i >= 0)
 6d8:	197d                	addi	s2,s2,-1
 6da:	ff3918e3          	bne	s2,s3,6ca <printint+0x82>
}
 6de:	70e2                	ld	ra,56(sp)
 6e0:	7442                	ld	s0,48(sp)
 6e2:	74a2                	ld	s1,40(sp)
 6e4:	7902                	ld	s2,32(sp)
 6e6:	69e2                	ld	s3,24(sp)
 6e8:	6121                	addi	sp,sp,64
 6ea:	8082                	ret
    x = -xx;
 6ec:	40b005bb          	negw	a1,a1
    neg = 1;
 6f0:	4885                	li	a7,1
    x = -xx;
 6f2:	bf85                	j	662 <printint+0x1a>

00000000000006f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6f4:	715d                	addi	sp,sp,-80
 6f6:	e486                	sd	ra,72(sp)
 6f8:	e0a2                	sd	s0,64(sp)
 6fa:	fc26                	sd	s1,56(sp)
 6fc:	f84a                	sd	s2,48(sp)
 6fe:	f44e                	sd	s3,40(sp)
 700:	f052                	sd	s4,32(sp)
 702:	ec56                	sd	s5,24(sp)
 704:	e85a                	sd	s6,16(sp)
 706:	e45e                	sd	s7,8(sp)
 708:	e062                	sd	s8,0(sp)
 70a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 70c:	0005c903          	lbu	s2,0(a1)
 710:	18090c63          	beqz	s2,8a8 <vprintf+0x1b4>
 714:	8aaa                	mv	s5,a0
 716:	8bb2                	mv	s7,a2
 718:	00158493          	addi	s1,a1,1
  state = 0;
 71c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 71e:	02500a13          	li	s4,37
 722:	4b55                	li	s6,21
 724:	a839                	j	742 <vprintf+0x4e>
        putc(fd, c);
 726:	85ca                	mv	a1,s2
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	efc080e7          	jalr	-260(ra) # 626 <putc>
 732:	a019                	j	738 <vprintf+0x44>
    } else if(state == '%'){
 734:	01498d63          	beq	s3,s4,74e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 738:	0485                	addi	s1,s1,1
 73a:	fff4c903          	lbu	s2,-1(s1)
 73e:	16090563          	beqz	s2,8a8 <vprintf+0x1b4>
    if(state == 0){
 742:	fe0999e3          	bnez	s3,734 <vprintf+0x40>
      if(c == '%'){
 746:	ff4910e3          	bne	s2,s4,726 <vprintf+0x32>
        state = '%';
 74a:	89d2                	mv	s3,s4
 74c:	b7f5                	j	738 <vprintf+0x44>
      if(c == 'd'){
 74e:	13490263          	beq	s2,s4,872 <vprintf+0x17e>
 752:	f9d9079b          	addiw	a5,s2,-99
 756:	0ff7f793          	zext.b	a5,a5
 75a:	12fb6563          	bltu	s6,a5,884 <vprintf+0x190>
 75e:	f9d9079b          	addiw	a5,s2,-99
 762:	0ff7f713          	zext.b	a4,a5
 766:	10eb6f63          	bltu	s6,a4,884 <vprintf+0x190>
 76a:	00271793          	slli	a5,a4,0x2
 76e:	00000717          	auipc	a4,0x0
 772:	40270713          	addi	a4,a4,1026 # b70 <malloc+0x1ca>
 776:	97ba                	add	a5,a5,a4
 778:	439c                	lw	a5,0(a5)
 77a:	97ba                	add	a5,a5,a4
 77c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 77e:	008b8913          	addi	s2,s7,8
 782:	4685                	li	a3,1
 784:	4629                	li	a2,10
 786:	000ba583          	lw	a1,0(s7)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	ebc080e7          	jalr	-324(ra) # 648 <printint>
 794:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 796:	4981                	li	s3,0
 798:	b745                	j	738 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 79a:	008b8913          	addi	s2,s7,8
 79e:	4681                	li	a3,0
 7a0:	4629                	li	a2,10
 7a2:	000ba583          	lw	a1,0(s7)
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	ea0080e7          	jalr	-352(ra) # 648 <printint>
 7b0:	8bca                	mv	s7,s2
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	b751                	j	738 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 7b6:	008b8913          	addi	s2,s7,8
 7ba:	4681                	li	a3,0
 7bc:	4641                	li	a2,16
 7be:	000ba583          	lw	a1,0(s7)
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e84080e7          	jalr	-380(ra) # 648 <printint>
 7cc:	8bca                	mv	s7,s2
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	b7a5                	j	738 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 7d2:	008b8c13          	addi	s8,s7,8
 7d6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7da:	03000593          	li	a1,48
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e46080e7          	jalr	-442(ra) # 626 <putc>
  putc(fd, 'x');
 7e8:	07800593          	li	a1,120
 7ec:	8556                	mv	a0,s5
 7ee:	00000097          	auipc	ra,0x0
 7f2:	e38080e7          	jalr	-456(ra) # 626 <putc>
 7f6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7f8:	00000b97          	auipc	s7,0x0
 7fc:	3d0b8b93          	addi	s7,s7,976 # bc8 <digits>
 800:	03c9d793          	srli	a5,s3,0x3c
 804:	97de                	add	a5,a5,s7
 806:	0007c583          	lbu	a1,0(a5)
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	e1a080e7          	jalr	-486(ra) # 626 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 814:	0992                	slli	s3,s3,0x4
 816:	397d                	addiw	s2,s2,-1
 818:	fe0914e3          	bnez	s2,800 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 81c:	8be2                	mv	s7,s8
      state = 0;
 81e:	4981                	li	s3,0
 820:	bf21                	j	738 <vprintf+0x44>
        s = va_arg(ap, char*);
 822:	008b8993          	addi	s3,s7,8
 826:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 82a:	02090163          	beqz	s2,84c <vprintf+0x158>
        while(*s != 0){
 82e:	00094583          	lbu	a1,0(s2)
 832:	c9a5                	beqz	a1,8a2 <vprintf+0x1ae>
          putc(fd, *s);
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	df0080e7          	jalr	-528(ra) # 626 <putc>
          s++;
 83e:	0905                	addi	s2,s2,1
        while(*s != 0){
 840:	00094583          	lbu	a1,0(s2)
 844:	f9e5                	bnez	a1,834 <vprintf+0x140>
        s = va_arg(ap, char*);
 846:	8bce                	mv	s7,s3
      state = 0;
 848:	4981                	li	s3,0
 84a:	b5fd                	j	738 <vprintf+0x44>
          s = "(null)";
 84c:	00000917          	auipc	s2,0x0
 850:	31c90913          	addi	s2,s2,796 # b68 <malloc+0x1c2>
        while(*s != 0){
 854:	02800593          	li	a1,40
 858:	bff1                	j	834 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 85a:	008b8913          	addi	s2,s7,8
 85e:	000bc583          	lbu	a1,0(s7)
 862:	8556                	mv	a0,s5
 864:	00000097          	auipc	ra,0x0
 868:	dc2080e7          	jalr	-574(ra) # 626 <putc>
 86c:	8bca                	mv	s7,s2
      state = 0;
 86e:	4981                	li	s3,0
 870:	b5e1                	j	738 <vprintf+0x44>
        putc(fd, c);
 872:	02500593          	li	a1,37
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	dae080e7          	jalr	-594(ra) # 626 <putc>
      state = 0;
 880:	4981                	li	s3,0
 882:	bd5d                	j	738 <vprintf+0x44>
        putc(fd, '%');
 884:	02500593          	li	a1,37
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	d9c080e7          	jalr	-612(ra) # 626 <putc>
        putc(fd, c);
 892:	85ca                	mv	a1,s2
 894:	8556                	mv	a0,s5
 896:	00000097          	auipc	ra,0x0
 89a:	d90080e7          	jalr	-624(ra) # 626 <putc>
      state = 0;
 89e:	4981                	li	s3,0
 8a0:	bd61                	j	738 <vprintf+0x44>
        s = va_arg(ap, char*);
 8a2:	8bce                	mv	s7,s3
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	bd49                	j	738 <vprintf+0x44>
    }
  }
}
 8a8:	60a6                	ld	ra,72(sp)
 8aa:	6406                	ld	s0,64(sp)
 8ac:	74e2                	ld	s1,56(sp)
 8ae:	7942                	ld	s2,48(sp)
 8b0:	79a2                	ld	s3,40(sp)
 8b2:	7a02                	ld	s4,32(sp)
 8b4:	6ae2                	ld	s5,24(sp)
 8b6:	6b42                	ld	s6,16(sp)
 8b8:	6ba2                	ld	s7,8(sp)
 8ba:	6c02                	ld	s8,0(sp)
 8bc:	6161                	addi	sp,sp,80
 8be:	8082                	ret

00000000000008c0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8c0:	715d                	addi	sp,sp,-80
 8c2:	ec06                	sd	ra,24(sp)
 8c4:	e822                	sd	s0,16(sp)
 8c6:	1000                	addi	s0,sp,32
 8c8:	e010                	sd	a2,0(s0)
 8ca:	e414                	sd	a3,8(s0)
 8cc:	e818                	sd	a4,16(s0)
 8ce:	ec1c                	sd	a5,24(s0)
 8d0:	03043023          	sd	a6,32(s0)
 8d4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8d8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8dc:	8622                	mv	a2,s0
 8de:	00000097          	auipc	ra,0x0
 8e2:	e16080e7          	jalr	-490(ra) # 6f4 <vprintf>
}
 8e6:	60e2                	ld	ra,24(sp)
 8e8:	6442                	ld	s0,16(sp)
 8ea:	6161                	addi	sp,sp,80
 8ec:	8082                	ret

00000000000008ee <printf>:

void
printf(const char *fmt, ...)
{
 8ee:	711d                	addi	sp,sp,-96
 8f0:	ec06                	sd	ra,24(sp)
 8f2:	e822                	sd	s0,16(sp)
 8f4:	1000                	addi	s0,sp,32
 8f6:	e40c                	sd	a1,8(s0)
 8f8:	e810                	sd	a2,16(s0)
 8fa:	ec14                	sd	a3,24(s0)
 8fc:	f018                	sd	a4,32(s0)
 8fe:	f41c                	sd	a5,40(s0)
 900:	03043823          	sd	a6,48(s0)
 904:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 908:	00840613          	addi	a2,s0,8
 90c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 910:	85aa                	mv	a1,a0
 912:	4505                	li	a0,1
 914:	00000097          	auipc	ra,0x0
 918:	de0080e7          	jalr	-544(ra) # 6f4 <vprintf>
}
 91c:	60e2                	ld	ra,24(sp)
 91e:	6442                	ld	s0,16(sp)
 920:	6125                	addi	sp,sp,96
 922:	8082                	ret

0000000000000924 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 924:	1141                	addi	sp,sp,-16
 926:	e422                	sd	s0,8(sp)
 928:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 92a:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92e:	00000797          	auipc	a5,0x0
 932:	6da7b783          	ld	a5,1754(a5) # 1008 <freep>
 936:	a02d                	j	960 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 938:	4618                	lw	a4,8(a2)
 93a:	9f2d                	addw	a4,a4,a1
 93c:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 940:	6398                	ld	a4,0(a5)
 942:	6310                	ld	a2,0(a4)
 944:	a83d                	j	982 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 946:	ff852703          	lw	a4,-8(a0)
 94a:	9f31                	addw	a4,a4,a2
 94c:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 94e:	ff053683          	ld	a3,-16(a0)
 952:	a091                	j	996 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 954:	6398                	ld	a4,0(a5)
 956:	00e7e463          	bltu	a5,a4,95e <free+0x3a>
 95a:	00e6ea63          	bltu	a3,a4,96e <free+0x4a>
{
 95e:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 960:	fed7fae3          	bgeu	a5,a3,954 <free+0x30>
 964:	6398                	ld	a4,0(a5)
 966:	00e6e463          	bltu	a3,a4,96e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96a:	fee7eae3          	bltu	a5,a4,95e <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 96e:	ff852583          	lw	a1,-8(a0)
 972:	6390                	ld	a2,0(a5)
 974:	02059813          	slli	a6,a1,0x20
 978:	01c85713          	srli	a4,a6,0x1c
 97c:	9736                	add	a4,a4,a3
 97e:	fae60de3          	beq	a2,a4,938 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 982:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 986:	4790                	lw	a2,8(a5)
 988:	02061593          	slli	a1,a2,0x20
 98c:	01c5d713          	srli	a4,a1,0x1c
 990:	973e                	add	a4,a4,a5
 992:	fae68ae3          	beq	a3,a4,946 <free+0x22>
        p->s.ptr = bp->s.ptr;
 996:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 998:	00000717          	auipc	a4,0x0
 99c:	66f73823          	sd	a5,1648(a4) # 1008 <freep>
}
 9a0:	6422                	ld	s0,8(sp)
 9a2:	0141                	addi	sp,sp,16
 9a4:	8082                	ret

00000000000009a6 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 9a6:	7139                	addi	sp,sp,-64
 9a8:	fc06                	sd	ra,56(sp)
 9aa:	f822                	sd	s0,48(sp)
 9ac:	f426                	sd	s1,40(sp)
 9ae:	f04a                	sd	s2,32(sp)
 9b0:	ec4e                	sd	s3,24(sp)
 9b2:	e852                	sd	s4,16(sp)
 9b4:	e456                	sd	s5,8(sp)
 9b6:	e05a                	sd	s6,0(sp)
 9b8:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 9ba:	02051493          	slli	s1,a0,0x20
 9be:	9081                	srli	s1,s1,0x20
 9c0:	04bd                	addi	s1,s1,15
 9c2:	8091                	srli	s1,s1,0x4
 9c4:	0014899b          	addiw	s3,s1,1
 9c8:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 9ca:	00000517          	auipc	a0,0x0
 9ce:	63e53503          	ld	a0,1598(a0) # 1008 <freep>
 9d2:	c515                	beqz	a0,9fe <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 9d4:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 9d6:	4798                	lw	a4,8(a5)
 9d8:	02977f63          	bgeu	a4,s1,a16 <malloc+0x70>
    if (nu < 4096)
 9dc:	8a4e                	mv	s4,s3
 9de:	0009871b          	sext.w	a4,s3
 9e2:	6685                	lui	a3,0x1
 9e4:	00d77363          	bgeu	a4,a3,9ea <malloc+0x44>
 9e8:	6a05                	lui	s4,0x1
 9ea:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 9ee:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 9f2:	00000917          	auipc	s2,0x0
 9f6:	61690913          	addi	s2,s2,1558 # 1008 <freep>
    if (p == (char *)-1)
 9fa:	5afd                	li	s5,-1
 9fc:	a895                	j	a70 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 9fe:	00000797          	auipc	a5,0x0
 a02:	61278793          	addi	a5,a5,1554 # 1010 <base>
 a06:	00000717          	auipc	a4,0x0
 a0a:	60f73123          	sd	a5,1538(a4) # 1008 <freep>
 a0e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 a10:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 a14:	b7e1                	j	9dc <malloc+0x36>
            if (p->s.size == nunits)
 a16:	02e48c63          	beq	s1,a4,a4e <malloc+0xa8>
                p->s.size -= nunits;
 a1a:	4137073b          	subw	a4,a4,s3
 a1e:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a20:	02071693          	slli	a3,a4,0x20
 a24:	01c6d713          	srli	a4,a3,0x1c
 a28:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a2a:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a2e:	00000717          	auipc	a4,0x0
 a32:	5ca73d23          	sd	a0,1498(a4) # 1008 <freep>
            return (void *)(p + 1);
 a36:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 a3a:	70e2                	ld	ra,56(sp)
 a3c:	7442                	ld	s0,48(sp)
 a3e:	74a2                	ld	s1,40(sp)
 a40:	7902                	ld	s2,32(sp)
 a42:	69e2                	ld	s3,24(sp)
 a44:	6a42                	ld	s4,16(sp)
 a46:	6aa2                	ld	s5,8(sp)
 a48:	6b02                	ld	s6,0(sp)
 a4a:	6121                	addi	sp,sp,64
 a4c:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 a4e:	6398                	ld	a4,0(a5)
 a50:	e118                	sd	a4,0(a0)
 a52:	bff1                	j	a2e <malloc+0x88>
    hp->s.size = nu;
 a54:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a58:	0541                	addi	a0,a0,16
 a5a:	00000097          	auipc	ra,0x0
 a5e:	eca080e7          	jalr	-310(ra) # 924 <free>
    return freep;
 a62:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a66:	d971                	beqz	a0,a3a <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a68:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a6a:	4798                	lw	a4,8(a5)
 a6c:	fa9775e3          	bgeu	a4,s1,a16 <malloc+0x70>
        if (p == freep)
 a70:	00093703          	ld	a4,0(s2)
 a74:	853e                	mv	a0,a5
 a76:	fef719e3          	bne	a4,a5,a68 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a7a:	8552                	mv	a0,s4
 a7c:	00000097          	auipc	ra,0x0
 a80:	b7a080e7          	jalr	-1158(ra) # 5f6 <sbrk>
    if (p == (char *)-1)
 a84:	fd5518e3          	bne	a0,s5,a54 <malloc+0xae>
                return 0;
 a88:	4501                	li	a0,0
 a8a:	bf45                	j	a3a <malloc+0x94>
