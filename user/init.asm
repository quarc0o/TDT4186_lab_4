
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"

char *argv[] = {"sh", 0};

int main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
    int pid, wpid;

    if (open("console", O_RDWR) < 0)
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	c9250513          	addi	a0,a0,-878 # ca0 <malloc+0xe6>
  16:	00000097          	auipc	ra,0x0
  1a:	7ac080e7          	jalr	1964(ra) # 7c2 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    {
        mknod("console", CONSOLE, 0);
        open("console", O_RDWR);
    }
    dup(0); // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	7d6080e7          	jalr	2006(ra) # 7fa <dup>
    dup(0); // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	7cc080e7          	jalr	1996(ra) # 7fa <dup>

    for (;;)
    {
        printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	c7290913          	addi	s2,s2,-910 # ca8 <malloc+0xee>
  3e:	854a                	mv	a0,s2
  40:	00001097          	auipc	ra,0x1
  44:	ac2080e7          	jalr	-1342(ra) # b02 <printf>
        pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	732080e7          	jalr	1842(ra) # 77a <fork>
  50:	84aa                	mv	s1,a0
        if (pid < 0)
  52:	04054d63          	bltz	a0,ac <main+0xac>
        {
            printf("init: fork failed\n");
            exit(1);
        }
        if (pid == 0)
  56:	c925                	beqz	a0,c6 <main+0xc6>

        for (;;)
        {
            // this call to wait() returns if the shell exits,
            // or if a parentless process exits.
            wpid = wait((int *)0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	730080e7          	jalr	1840(ra) # 78a <wait>
            if (wpid == pid)
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
            {
                // the shell exited; restart it.
                break;
            }
            else if (wpid < 0)
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
            {
                printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	c8e50513          	addi	a0,a0,-882 # cf8 <malloc+0x13e>
  72:	00001097          	auipc	ra,0x1
  76:	a90080e7          	jalr	-1392(ra) # b02 <printf>
                exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	706080e7          	jalr	1798(ra) # 782 <exit>
        mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	c1850513          	addi	a0,a0,-1000 # ca0 <malloc+0xe6>
  90:	00000097          	auipc	ra,0x0
  94:	73a080e7          	jalr	1850(ra) # 7ca <mknod>
        open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	c0650513          	addi	a0,a0,-1018 # ca0 <malloc+0xe6>
  a2:	00000097          	auipc	ra,0x0
  a6:	720080e7          	jalr	1824(ra) # 7c2 <open>
  aa:	bfa5                	j	22 <main+0x22>
            printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	c1450513          	addi	a0,a0,-1004 # cc0 <malloc+0x106>
  b4:	00001097          	auipc	ra,0x1
  b8:	a4e080e7          	jalr	-1458(ra) # b02 <printf>
            exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	6c4080e7          	jalr	1732(ra) # 782 <exit>
            exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f4a58593          	addi	a1,a1,-182 # 1010 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	c0a50513          	addi	a0,a0,-1014 # cd8 <malloc+0x11e>
  d6:	00000097          	auipc	ra,0x0
  da:	6e4080e7          	jalr	1764(ra) # 7ba <exec>
            printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	c0250513          	addi	a0,a0,-1022 # ce0 <malloc+0x126>
  e6:	00001097          	auipc	ra,0x1
  ea:	a1c080e7          	jalr	-1508(ra) # b02 <printf>
            exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	692080e7          	jalr	1682(ra) # 782 <exit>

00000000000000f8 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
    lk->name = name;
  fe:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 100:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 104:	57fd                	li	a5,-1
 106:	00f50823          	sb	a5,16(a0)
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret

0000000000000110 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 110:	00054783          	lbu	a5,0(a0)
 114:	e399                	bnez	a5,11a <holding+0xa>
 116:	4501                	li	a0,0
}
 118:	8082                	ret
{
 11a:	1101                	addi	sp,sp,-32
 11c:	ec06                	sd	ra,24(sp)
 11e:	e822                	sd	s0,16(sp)
 120:	e426                	sd	s1,8(sp)
 122:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 124:	01054483          	lbu	s1,16(a0)
 128:	00000097          	auipc	ra,0x0
 12c:	340080e7          	jalr	832(ra) # 468 <twhoami>
 130:	2501                	sext.w	a0,a0
 132:	40a48533          	sub	a0,s1,a0
 136:	00153513          	seqz	a0,a0
}
 13a:	60e2                	ld	ra,24(sp)
 13c:	6442                	ld	s0,16(sp)
 13e:	64a2                	ld	s1,8(sp)
 140:	6105                	addi	sp,sp,32
 142:	8082                	ret

0000000000000144 <acquire>:

void acquire(struct lock *lk)
{
 144:	7179                	addi	sp,sp,-48
 146:	f406                	sd	ra,40(sp)
 148:	f022                	sd	s0,32(sp)
 14a:	ec26                	sd	s1,24(sp)
 14c:	e84a                	sd	s2,16(sp)
 14e:	e44e                	sd	s3,8(sp)
 150:	e052                	sd	s4,0(sp)
 152:	1800                	addi	s0,sp,48
 154:	8a2a                	mv	s4,a0
    if (holding(lk))
 156:	00000097          	auipc	ra,0x0
 15a:	fba080e7          	jalr	-70(ra) # 110 <holding>
 15e:	e919                	bnez	a0,174 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 160:	ffca7493          	andi	s1,s4,-4
 164:	003a7913          	andi	s2,s4,3
 168:	0039191b          	slliw	s2,s2,0x3
 16c:	4985                	li	s3,1
 16e:	012999bb          	sllw	s3,s3,s2
 172:	a015                	j	196 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 174:	00001517          	auipc	a0,0x1
 178:	ba450513          	addi	a0,a0,-1116 # d18 <malloc+0x15e>
 17c:	00001097          	auipc	ra,0x1
 180:	986080e7          	jalr	-1658(ra) # b02 <printf>
        exit(-1);
 184:	557d                	li	a0,-1
 186:	00000097          	auipc	ra,0x0
 18a:	5fc080e7          	jalr	1532(ra) # 782 <exit>
    {
        // give up the cpu for other threads
        tyield();
 18e:	00000097          	auipc	ra,0x0
 192:	258080e7          	jalr	600(ra) # 3e6 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 196:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 19a:	0127d7bb          	srlw	a5,a5,s2
 19e:	0ff7f793          	zext.b	a5,a5
 1a2:	f7f5                	bnez	a5,18e <acquire+0x4a>
    }

    __sync_synchronize();
 1a4:	0ff0000f          	fence

    lk->tid = twhoami();
 1a8:	00000097          	auipc	ra,0x0
 1ac:	2c0080e7          	jalr	704(ra) # 468 <twhoami>
 1b0:	00aa0823          	sb	a0,16(s4)
}
 1b4:	70a2                	ld	ra,40(sp)
 1b6:	7402                	ld	s0,32(sp)
 1b8:	64e2                	ld	s1,24(sp)
 1ba:	6942                	ld	s2,16(sp)
 1bc:	69a2                	ld	s3,8(sp)
 1be:	6a02                	ld	s4,0(sp)
 1c0:	6145                	addi	sp,sp,48
 1c2:	8082                	ret

00000000000001c4 <release>:

void release(struct lock *lk)
{
 1c4:	1101                	addi	sp,sp,-32
 1c6:	ec06                	sd	ra,24(sp)
 1c8:	e822                	sd	s0,16(sp)
 1ca:	e426                	sd	s1,8(sp)
 1cc:	1000                	addi	s0,sp,32
 1ce:	84aa                	mv	s1,a0
    if (!holding(lk))
 1d0:	00000097          	auipc	ra,0x0
 1d4:	f40080e7          	jalr	-192(ra) # 110 <holding>
 1d8:	c11d                	beqz	a0,1fe <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1da:	57fd                	li	a5,-1
 1dc:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1e0:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1e4:	0ff0000f          	fence
 1e8:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1ec:	00000097          	auipc	ra,0x0
 1f0:	1fa080e7          	jalr	506(ra) # 3e6 <tyield>
}
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	64a2                	ld	s1,8(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret
        printf("releasing lock we are not holding");
 1fe:	00001517          	auipc	a0,0x1
 202:	b4250513          	addi	a0,a0,-1214 # d40 <malloc+0x186>
 206:	00001097          	auipc	ra,0x1
 20a:	8fc080e7          	jalr	-1796(ra) # b02 <printf>
        exit(-1);
 20e:	557d                	li	a0,-1
 210:	00000097          	auipc	ra,0x0
 214:	572080e7          	jalr	1394(ra) # 782 <exit>

0000000000000218 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 218:	1141                	addi	sp,sp,-16
 21a:	e406                	sd	ra,8(sp)
 21c:	e022                	sd	s0,0(sp)
 21e:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 220:	09800513          	li	a0,152
 224:	00001097          	auipc	ra,0x1
 228:	996080e7          	jalr	-1642(ra) # bba <malloc>

    main_thread->tid = next_tid;
 22c:	00001797          	auipc	a5,0x1
 230:	dd478793          	addi	a5,a5,-556 # 1000 <next_tid>
 234:	4398                	lw	a4,0(a5)
 236:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 23a:	4398                	lw	a4,0(a5)
 23c:	2705                	addiw	a4,a4,1
 23e:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 240:	4791                	li	a5,4
 242:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 244:	00001797          	auipc	a5,0x1
 248:	dca7be23          	sd	a0,-548(a5) # 1020 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 24c:	00001797          	auipc	a5,0x1
 250:	de478793          	addi	a5,a5,-540 # 1030 <threads>
 254:	00001717          	auipc	a4,0x1
 258:	e5c70713          	addi	a4,a4,-420 # 10b0 <base>
        threads[i] = NULL;
 25c:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 260:	07a1                	addi	a5,a5,8
 262:	fee79de3          	bne	a5,a4,25c <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 266:	00001797          	auipc	a5,0x1
 26a:	dca7b523          	sd	a0,-566(a5) # 1030 <threads>
}
 26e:	60a2                	ld	ra,8(sp)
 270:	6402                	ld	s0,0(sp)
 272:	0141                	addi	sp,sp,16
 274:	8082                	ret

0000000000000276 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 276:	00001517          	auipc	a0,0x1
 27a:	daa53503          	ld	a0,-598(a0) # 1020 <current_thread>
 27e:	00001717          	auipc	a4,0x1
 282:	db270713          	addi	a4,a4,-590 # 1030 <threads>
    for (int i = 0; i < 16; i++) {
 286:	4781                	li	a5,0
 288:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 28a:	6314                	ld	a3,0(a4)
 28c:	00a68763          	beq	a3,a0,29a <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 290:	2785                	addiw	a5,a5,1
 292:	0721                	addi	a4,a4,8
 294:	fec79be3          	bne	a5,a2,28a <tsched+0x14>
    int current_index = 0;
 298:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 29a:	0017869b          	addiw	a3,a5,1
 29e:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2a2:	00001817          	auipc	a6,0x1
 2a6:	d8e80813          	addi	a6,a6,-626 # 1030 <threads>
 2aa:	488d                	li	a7,3
 2ac:	a021                	j	2b4 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 2ae:	2685                	addiw	a3,a3,1
 2b0:	04c68363          	beq	a3,a2,2f6 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 2b4:	41f6d71b          	sraiw	a4,a3,0x1f
 2b8:	01c7571b          	srliw	a4,a4,0x1c
 2bc:	00d707bb          	addw	a5,a4,a3
 2c0:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2c2:	9f99                	subw	a5,a5,a4
 2c4:	078e                	slli	a5,a5,0x3
 2c6:	97c2                	add	a5,a5,a6
 2c8:	638c                	ld	a1,0(a5)
 2ca:	d1f5                	beqz	a1,2ae <tsched+0x38>
 2cc:	5dbc                	lw	a5,120(a1)
 2ce:	ff1790e3          	bne	a5,a7,2ae <tsched+0x38>
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 2da:	00001797          	auipc	a5,0x1
 2de:	d4b7b323          	sd	a1,-698(a5) # 1020 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 2e2:	05a1                	addi	a1,a1,8
 2e4:	0521                	addi	a0,a0,8
 2e6:	00000097          	auipc	ra,0x0
 2ea:	19a080e7          	jalr	410(ra) # 480 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
 2f6:	8082                	ret

00000000000002f8 <thread_wrapper>:
{
 2f8:	1101                	addi	sp,sp,-32
 2fa:	ec06                	sd	ra,24(sp)
 2fc:	e822                	sd	s0,16(sp)
 2fe:	e426                	sd	s1,8(sp)
 300:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 302:	00001497          	auipc	s1,0x1
 306:	d1e48493          	addi	s1,s1,-738 # 1020 <current_thread>
 30a:	609c                	ld	a5,0(s1)
 30c:	6b9c                	ld	a5,16(a5)
    func(arg);
 30e:	6398                	ld	a4,0(a5)
 310:	6788                	ld	a0,8(a5)
 312:	9702                	jalr	a4
    current_thread->state = EXITED;
 314:	609c                	ld	a5,0(s1)
 316:	4719                	li	a4,6
 318:	dfb8                	sw	a4,120(a5)
    tsched();
 31a:	00000097          	auipc	ra,0x0
 31e:	f5c080e7          	jalr	-164(ra) # 276 <tsched>
}
 322:	60e2                	ld	ra,24(sp)
 324:	6442                	ld	s0,16(sp)
 326:	64a2                	ld	s1,8(sp)
 328:	6105                	addi	sp,sp,32
 32a:	8082                	ret

000000000000032c <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 32c:	7179                	addi	sp,sp,-48
 32e:	f406                	sd	ra,40(sp)
 330:	f022                	sd	s0,32(sp)
 332:	ec26                	sd	s1,24(sp)
 334:	e84a                	sd	s2,16(sp)
 336:	e44e                	sd	s3,8(sp)
 338:	1800                	addi	s0,sp,48
 33a:	84aa                	mv	s1,a0
 33c:	8932                	mv	s2,a2
 33e:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 340:	09800513          	li	a0,152
 344:	00001097          	auipc	ra,0x1
 348:	876080e7          	jalr	-1930(ra) # bba <malloc>
 34c:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 34e:	478d                	li	a5,3
 350:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 352:	609c                	ld	a5,0(s1)
 354:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 358:	609c                	ld	a5,0(s1)
 35a:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 35e:	6098                	ld	a4,0(s1)
 360:	00001797          	auipc	a5,0x1
 364:	ca078793          	addi	a5,a5,-864 # 1000 <next_tid>
 368:	4394                	lw	a3,0(a5)
 36a:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 36e:	4398                	lw	a4,0(a5)
 370:	2705                	addiw	a4,a4,1
 372:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 374:	6505                	lui	a0,0x1
 376:	00001097          	auipc	ra,0x1
 37a:	844080e7          	jalr	-1980(ra) # bba <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 37e:	6785                	lui	a5,0x1
 380:	00a78733          	add	a4,a5,a0
 384:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 388:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x228>
 38a:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 38c:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 390:	609c                	ld	a5,0(s1)
 392:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 394:	609c                	ld	a5,0(s1)
 396:	00000717          	auipc	a4,0x0
 39a:	f6270713          	addi	a4,a4,-158 # 2f8 <thread_wrapper>
 39e:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 3a0:	00001717          	auipc	a4,0x1
 3a4:	c9070713          	addi	a4,a4,-880 # 1030 <threads>
 3a8:	4781                	li	a5,0
 3aa:	4641                	li	a2,16
        if (threads[i] == NULL) {
 3ac:	6314                	ld	a3,0(a4)
 3ae:	c29d                	beqz	a3,3d4 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 3b0:	2785                	addiw	a5,a5,1
 3b2:	0721                	addi	a4,a4,8
 3b4:	fec79ce3          	bne	a5,a2,3ac <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 3b8:	6088                	ld	a0,0(s1)
 3ba:	00000097          	auipc	ra,0x0
 3be:	77e080e7          	jalr	1918(ra) # b38 <free>
        *thread = NULL;
 3c2:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 3c6:	70a2                	ld	ra,40(sp)
 3c8:	7402                	ld	s0,32(sp)
 3ca:	64e2                	ld	s1,24(sp)
 3cc:	6942                	ld	s2,16(sp)
 3ce:	69a2                	ld	s3,8(sp)
 3d0:	6145                	addi	sp,sp,48
 3d2:	8082                	ret
            threads[i] = *thread;
 3d4:	6094                	ld	a3,0(s1)
 3d6:	078e                	slli	a5,a5,0x3
 3d8:	00001717          	auipc	a4,0x1
 3dc:	c5870713          	addi	a4,a4,-936 # 1030 <threads>
 3e0:	97ba                	add	a5,a5,a4
 3e2:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 3e4:	b7cd                	j	3c6 <tcreate+0x9a>

00000000000003e6 <tyield>:
    return 0;
}


void tyield()
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 3ee:	00001797          	auipc	a5,0x1
 3f2:	c327b783          	ld	a5,-974(a5) # 1020 <current_thread>
 3f6:	470d                	li	a4,3
 3f8:	dfb8                	sw	a4,120(a5)
    tsched();
 3fa:	00000097          	auipc	ra,0x0
 3fe:	e7c080e7          	jalr	-388(ra) # 276 <tsched>
}
 402:	60a2                	ld	ra,8(sp)
 404:	6402                	ld	s0,0(sp)
 406:	0141                	addi	sp,sp,16
 408:	8082                	ret

000000000000040a <tjoin>:
{
 40a:	1101                	addi	sp,sp,-32
 40c:	ec06                	sd	ra,24(sp)
 40e:	e822                	sd	s0,16(sp)
 410:	e426                	sd	s1,8(sp)
 412:	e04a                	sd	s2,0(sp)
 414:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 416:	00001797          	auipc	a5,0x1
 41a:	c1a78793          	addi	a5,a5,-998 # 1030 <threads>
 41e:	00001697          	auipc	a3,0x1
 422:	c9268693          	addi	a3,a3,-878 # 10b0 <base>
 426:	a021                	j	42e <tjoin+0x24>
 428:	07a1                	addi	a5,a5,8
 42a:	02d78b63          	beq	a5,a3,460 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 42e:	6384                	ld	s1,0(a5)
 430:	dce5                	beqz	s1,428 <tjoin+0x1e>
 432:	0004c703          	lbu	a4,0(s1)
 436:	fea719e3          	bne	a4,a0,428 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 43a:	5cb8                	lw	a4,120(s1)
 43c:	4799                	li	a5,6
 43e:	4919                	li	s2,6
 440:	02f70263          	beq	a4,a5,464 <tjoin+0x5a>
        tyield();
 444:	00000097          	auipc	ra,0x0
 448:	fa2080e7          	jalr	-94(ra) # 3e6 <tyield>
    while (target_thread->state != EXITED) {
 44c:	5cbc                	lw	a5,120(s1)
 44e:	ff279be3          	bne	a5,s2,444 <tjoin+0x3a>
    return 0;
 452:	4501                	li	a0,0
}
 454:	60e2                	ld	ra,24(sp)
 456:	6442                	ld	s0,16(sp)
 458:	64a2                	ld	s1,8(sp)
 45a:	6902                	ld	s2,0(sp)
 45c:	6105                	addi	sp,sp,32
 45e:	8082                	ret
        return -1;
 460:	557d                	li	a0,-1
 462:	bfcd                	j	454 <tjoin+0x4a>
    return 0;
 464:	4501                	li	a0,0
 466:	b7fd                	j	454 <tjoin+0x4a>

0000000000000468 <twhoami>:

uint8 twhoami()
{
 468:	1141                	addi	sp,sp,-16
 46a:	e422                	sd	s0,8(sp)
 46c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 46e:	00001797          	auipc	a5,0x1
 472:	bb27b783          	ld	a5,-1102(a5) # 1020 <current_thread>
 476:	0007c503          	lbu	a0,0(a5)
 47a:	6422                	ld	s0,8(sp)
 47c:	0141                	addi	sp,sp,16
 47e:	8082                	ret

0000000000000480 <tswtch>:
 480:	00153023          	sd	ra,0(a0)
 484:	00253423          	sd	sp,8(a0)
 488:	e900                	sd	s0,16(a0)
 48a:	ed04                	sd	s1,24(a0)
 48c:	03253023          	sd	s2,32(a0)
 490:	03353423          	sd	s3,40(a0)
 494:	03453823          	sd	s4,48(a0)
 498:	03553c23          	sd	s5,56(a0)
 49c:	05653023          	sd	s6,64(a0)
 4a0:	05753423          	sd	s7,72(a0)
 4a4:	05853823          	sd	s8,80(a0)
 4a8:	05953c23          	sd	s9,88(a0)
 4ac:	07a53023          	sd	s10,96(a0)
 4b0:	07b53423          	sd	s11,104(a0)
 4b4:	0005b083          	ld	ra,0(a1)
 4b8:	0085b103          	ld	sp,8(a1)
 4bc:	6980                	ld	s0,16(a1)
 4be:	6d84                	ld	s1,24(a1)
 4c0:	0205b903          	ld	s2,32(a1)
 4c4:	0285b983          	ld	s3,40(a1)
 4c8:	0305ba03          	ld	s4,48(a1)
 4cc:	0385ba83          	ld	s5,56(a1)
 4d0:	0405bb03          	ld	s6,64(a1)
 4d4:	0485bb83          	ld	s7,72(a1)
 4d8:	0505bc03          	ld	s8,80(a1)
 4dc:	0585bc83          	ld	s9,88(a1)
 4e0:	0605bd03          	ld	s10,96(a1)
 4e4:	0685bd83          	ld	s11,104(a1)
 4e8:	8082                	ret

00000000000004ea <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 4ea:	1101                	addi	sp,sp,-32
 4ec:	ec06                	sd	ra,24(sp)
 4ee:	e822                	sd	s0,16(sp)
 4f0:	e426                	sd	s1,8(sp)
 4f2:	e04a                	sd	s2,0(sp)
 4f4:	1000                	addi	s0,sp,32
 4f6:	84aa                	mv	s1,a0
 4f8:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 4fa:	00000097          	auipc	ra,0x0
 4fe:	d1e080e7          	jalr	-738(ra) # 218 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 502:	85ca                	mv	a1,s2
 504:	8526                	mv	a0,s1
 506:	00000097          	auipc	ra,0x0
 50a:	afa080e7          	jalr	-1286(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 50e:	00000097          	auipc	ra,0x0
 512:	274080e7          	jalr	628(ra) # 782 <exit>

0000000000000516 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 516:	1141                	addi	sp,sp,-16
 518:	e422                	sd	s0,8(sp)
 51a:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 51c:	87aa                	mv	a5,a0
 51e:	0585                	addi	a1,a1,1
 520:	0785                	addi	a5,a5,1
 522:	fff5c703          	lbu	a4,-1(a1)
 526:	fee78fa3          	sb	a4,-1(a5)
 52a:	fb75                	bnez	a4,51e <strcpy+0x8>
        ;
    return os;
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret

0000000000000532 <strcmp>:

int strcmp(const char *p, const char *q)
{
 532:	1141                	addi	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 538:	00054783          	lbu	a5,0(a0)
 53c:	cb91                	beqz	a5,550 <strcmp+0x1e>
 53e:	0005c703          	lbu	a4,0(a1)
 542:	00f71763          	bne	a4,a5,550 <strcmp+0x1e>
        p++, q++;
 546:	0505                	addi	a0,a0,1
 548:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 54a:	00054783          	lbu	a5,0(a0)
 54e:	fbe5                	bnez	a5,53e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 550:	0005c503          	lbu	a0,0(a1)
}
 554:	40a7853b          	subw	a0,a5,a0
 558:	6422                	ld	s0,8(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret

000000000000055e <strlen>:

uint strlen(const char *s)
{
 55e:	1141                	addi	sp,sp,-16
 560:	e422                	sd	s0,8(sp)
 562:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 564:	00054783          	lbu	a5,0(a0)
 568:	cf91                	beqz	a5,584 <strlen+0x26>
 56a:	0505                	addi	a0,a0,1
 56c:	87aa                	mv	a5,a0
 56e:	86be                	mv	a3,a5
 570:	0785                	addi	a5,a5,1
 572:	fff7c703          	lbu	a4,-1(a5)
 576:	ff65                	bnez	a4,56e <strlen+0x10>
 578:	40a6853b          	subw	a0,a3,a0
 57c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 57e:	6422                	ld	s0,8(sp)
 580:	0141                	addi	sp,sp,16
 582:	8082                	ret
    for (n = 0; s[n]; n++)
 584:	4501                	li	a0,0
 586:	bfe5                	j	57e <strlen+0x20>

0000000000000588 <memset>:

void *
memset(void *dst, int c, uint n)
{
 588:	1141                	addi	sp,sp,-16
 58a:	e422                	sd	s0,8(sp)
 58c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 58e:	ca19                	beqz	a2,5a4 <memset+0x1c>
 590:	87aa                	mv	a5,a0
 592:	1602                	slli	a2,a2,0x20
 594:	9201                	srli	a2,a2,0x20
 596:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 59a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 59e:	0785                	addi	a5,a5,1
 5a0:	fee79de3          	bne	a5,a4,59a <memset+0x12>
    }
    return dst;
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret

00000000000005aa <strchr>:

char *
strchr(const char *s, char c)
{
 5aa:	1141                	addi	sp,sp,-16
 5ac:	e422                	sd	s0,8(sp)
 5ae:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5b0:	00054783          	lbu	a5,0(a0)
 5b4:	cb99                	beqz	a5,5ca <strchr+0x20>
        if (*s == c)
 5b6:	00f58763          	beq	a1,a5,5c4 <strchr+0x1a>
    for (; *s; s++)
 5ba:	0505                	addi	a0,a0,1
 5bc:	00054783          	lbu	a5,0(a0)
 5c0:	fbfd                	bnez	a5,5b6 <strchr+0xc>
            return (char *)s;
    return 0;
 5c2:	4501                	li	a0,0
}
 5c4:	6422                	ld	s0,8(sp)
 5c6:	0141                	addi	sp,sp,16
 5c8:	8082                	ret
    return 0;
 5ca:	4501                	li	a0,0
 5cc:	bfe5                	j	5c4 <strchr+0x1a>

00000000000005ce <gets>:

char *
gets(char *buf, int max)
{
 5ce:	711d                	addi	sp,sp,-96
 5d0:	ec86                	sd	ra,88(sp)
 5d2:	e8a2                	sd	s0,80(sp)
 5d4:	e4a6                	sd	s1,72(sp)
 5d6:	e0ca                	sd	s2,64(sp)
 5d8:	fc4e                	sd	s3,56(sp)
 5da:	f852                	sd	s4,48(sp)
 5dc:	f456                	sd	s5,40(sp)
 5de:	f05a                	sd	s6,32(sp)
 5e0:	ec5e                	sd	s7,24(sp)
 5e2:	1080                	addi	s0,sp,96
 5e4:	8baa                	mv	s7,a0
 5e6:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5e8:	892a                	mv	s2,a0
 5ea:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5ec:	4aa9                	li	s5,10
 5ee:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5f0:	89a6                	mv	s3,s1
 5f2:	2485                	addiw	s1,s1,1
 5f4:	0344d863          	bge	s1,s4,624 <gets+0x56>
        cc = read(0, &c, 1);
 5f8:	4605                	li	a2,1
 5fa:	faf40593          	addi	a1,s0,-81
 5fe:	4501                	li	a0,0
 600:	00000097          	auipc	ra,0x0
 604:	19a080e7          	jalr	410(ra) # 79a <read>
        if (cc < 1)
 608:	00a05e63          	blez	a0,624 <gets+0x56>
        buf[i++] = c;
 60c:	faf44783          	lbu	a5,-81(s0)
 610:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 614:	01578763          	beq	a5,s5,622 <gets+0x54>
 618:	0905                	addi	s2,s2,1
 61a:	fd679be3          	bne	a5,s6,5f0 <gets+0x22>
    for (i = 0; i + 1 < max;)
 61e:	89a6                	mv	s3,s1
 620:	a011                	j	624 <gets+0x56>
 622:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 624:	99de                	add	s3,s3,s7
 626:	00098023          	sb	zero,0(s3)
    return buf;
}
 62a:	855e                	mv	a0,s7
 62c:	60e6                	ld	ra,88(sp)
 62e:	6446                	ld	s0,80(sp)
 630:	64a6                	ld	s1,72(sp)
 632:	6906                	ld	s2,64(sp)
 634:	79e2                	ld	s3,56(sp)
 636:	7a42                	ld	s4,48(sp)
 638:	7aa2                	ld	s5,40(sp)
 63a:	7b02                	ld	s6,32(sp)
 63c:	6be2                	ld	s7,24(sp)
 63e:	6125                	addi	sp,sp,96
 640:	8082                	ret

0000000000000642 <stat>:

int stat(const char *n, struct stat *st)
{
 642:	1101                	addi	sp,sp,-32
 644:	ec06                	sd	ra,24(sp)
 646:	e822                	sd	s0,16(sp)
 648:	e426                	sd	s1,8(sp)
 64a:	e04a                	sd	s2,0(sp)
 64c:	1000                	addi	s0,sp,32
 64e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 650:	4581                	li	a1,0
 652:	00000097          	auipc	ra,0x0
 656:	170080e7          	jalr	368(ra) # 7c2 <open>
    if (fd < 0)
 65a:	02054563          	bltz	a0,684 <stat+0x42>
 65e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 660:	85ca                	mv	a1,s2
 662:	00000097          	auipc	ra,0x0
 666:	178080e7          	jalr	376(ra) # 7da <fstat>
 66a:	892a                	mv	s2,a0
    close(fd);
 66c:	8526                	mv	a0,s1
 66e:	00000097          	auipc	ra,0x0
 672:	13c080e7          	jalr	316(ra) # 7aa <close>
    return r;
}
 676:	854a                	mv	a0,s2
 678:	60e2                	ld	ra,24(sp)
 67a:	6442                	ld	s0,16(sp)
 67c:	64a2                	ld	s1,8(sp)
 67e:	6902                	ld	s2,0(sp)
 680:	6105                	addi	sp,sp,32
 682:	8082                	ret
        return -1;
 684:	597d                	li	s2,-1
 686:	bfc5                	j	676 <stat+0x34>

0000000000000688 <atoi>:

int atoi(const char *s)
{
 688:	1141                	addi	sp,sp,-16
 68a:	e422                	sd	s0,8(sp)
 68c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 68e:	00054683          	lbu	a3,0(a0)
 692:	fd06879b          	addiw	a5,a3,-48
 696:	0ff7f793          	zext.b	a5,a5
 69a:	4625                	li	a2,9
 69c:	02f66863          	bltu	a2,a5,6cc <atoi+0x44>
 6a0:	872a                	mv	a4,a0
    n = 0;
 6a2:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6a4:	0705                	addi	a4,a4,1
 6a6:	0025179b          	slliw	a5,a0,0x2
 6aa:	9fa9                	addw	a5,a5,a0
 6ac:	0017979b          	slliw	a5,a5,0x1
 6b0:	9fb5                	addw	a5,a5,a3
 6b2:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6b6:	00074683          	lbu	a3,0(a4)
 6ba:	fd06879b          	addiw	a5,a3,-48
 6be:	0ff7f793          	zext.b	a5,a5
 6c2:	fef671e3          	bgeu	a2,a5,6a4 <atoi+0x1c>
    return n;
}
 6c6:	6422                	ld	s0,8(sp)
 6c8:	0141                	addi	sp,sp,16
 6ca:	8082                	ret
    n = 0;
 6cc:	4501                	li	a0,0
 6ce:	bfe5                	j	6c6 <atoi+0x3e>

00000000000006d0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6d0:	1141                	addi	sp,sp,-16
 6d2:	e422                	sd	s0,8(sp)
 6d4:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6d6:	02b57463          	bgeu	a0,a1,6fe <memmove+0x2e>
    {
        while (n-- > 0)
 6da:	00c05f63          	blez	a2,6f8 <memmove+0x28>
 6de:	1602                	slli	a2,a2,0x20
 6e0:	9201                	srli	a2,a2,0x20
 6e2:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6e6:	872a                	mv	a4,a0
            *dst++ = *src++;
 6e8:	0585                	addi	a1,a1,1
 6ea:	0705                	addi	a4,a4,1
 6ec:	fff5c683          	lbu	a3,-1(a1)
 6f0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6f4:	fee79ae3          	bne	a5,a4,6e8 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6f8:	6422                	ld	s0,8(sp)
 6fa:	0141                	addi	sp,sp,16
 6fc:	8082                	ret
        dst += n;
 6fe:	00c50733          	add	a4,a0,a2
        src += n;
 702:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 704:	fec05ae3          	blez	a2,6f8 <memmove+0x28>
 708:	fff6079b          	addiw	a5,a2,-1
 70c:	1782                	slli	a5,a5,0x20
 70e:	9381                	srli	a5,a5,0x20
 710:	fff7c793          	not	a5,a5
 714:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 716:	15fd                	addi	a1,a1,-1
 718:	177d                	addi	a4,a4,-1
 71a:	0005c683          	lbu	a3,0(a1)
 71e:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 722:	fee79ae3          	bne	a5,a4,716 <memmove+0x46>
 726:	bfc9                	j	6f8 <memmove+0x28>

0000000000000728 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 728:	1141                	addi	sp,sp,-16
 72a:	e422                	sd	s0,8(sp)
 72c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 72e:	ca05                	beqz	a2,75e <memcmp+0x36>
 730:	fff6069b          	addiw	a3,a2,-1
 734:	1682                	slli	a3,a3,0x20
 736:	9281                	srli	a3,a3,0x20
 738:	0685                	addi	a3,a3,1
 73a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 73c:	00054783          	lbu	a5,0(a0)
 740:	0005c703          	lbu	a4,0(a1)
 744:	00e79863          	bne	a5,a4,754 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 748:	0505                	addi	a0,a0,1
        p2++;
 74a:	0585                	addi	a1,a1,1
    while (n-- > 0)
 74c:	fed518e3          	bne	a0,a3,73c <memcmp+0x14>
    }
    return 0;
 750:	4501                	li	a0,0
 752:	a019                	j	758 <memcmp+0x30>
            return *p1 - *p2;
 754:	40e7853b          	subw	a0,a5,a4
}
 758:	6422                	ld	s0,8(sp)
 75a:	0141                	addi	sp,sp,16
 75c:	8082                	ret
    return 0;
 75e:	4501                	li	a0,0
 760:	bfe5                	j	758 <memcmp+0x30>

0000000000000762 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 762:	1141                	addi	sp,sp,-16
 764:	e406                	sd	ra,8(sp)
 766:	e022                	sd	s0,0(sp)
 768:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 76a:	00000097          	auipc	ra,0x0
 76e:	f66080e7          	jalr	-154(ra) # 6d0 <memmove>
}
 772:	60a2                	ld	ra,8(sp)
 774:	6402                	ld	s0,0(sp)
 776:	0141                	addi	sp,sp,16
 778:	8082                	ret

000000000000077a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 77a:	4885                	li	a7,1
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <exit>:
.global exit
exit:
 li a7, SYS_exit
 782:	4889                	li	a7,2
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <wait>:
.global wait
wait:
 li a7, SYS_wait
 78a:	488d                	li	a7,3
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 792:	4891                	li	a7,4
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <read>:
.global read
read:
 li a7, SYS_read
 79a:	4895                	li	a7,5
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <write>:
.global write
write:
 li a7, SYS_write
 7a2:	48c1                	li	a7,16
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <close>:
.global close
close:
 li a7, SYS_close
 7aa:	48d5                	li	a7,21
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7b2:	4899                	li	a7,6
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 7ba:	489d                	li	a7,7
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <open>:
.global open
open:
 li a7, SYS_open
 7c2:	48bd                	li	a7,15
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7ca:	48c5                	li	a7,17
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7d2:	48c9                	li	a7,18
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7da:	48a1                	li	a7,8
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <link>:
.global link
link:
 li a7, SYS_link
 7e2:	48cd                	li	a7,19
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7ea:	48d1                	li	a7,20
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7f2:	48a5                	li	a7,9
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 7fa:	48a9                	li	a7,10
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 802:	48ad                	li	a7,11
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 80a:	48b1                	li	a7,12
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 812:	48b5                	li	a7,13
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 81a:	48b9                	li	a7,14
 ecall
 81c:	00000073          	ecall
 ret
 820:	8082                	ret

0000000000000822 <ps>:
.global ps
ps:
 li a7, SYS_ps
 822:	48d9                	li	a7,22
 ecall
 824:	00000073          	ecall
 ret
 828:	8082                	ret

000000000000082a <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 82a:	48dd                	li	a7,23
 ecall
 82c:	00000073          	ecall
 ret
 830:	8082                	ret

0000000000000832 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 832:	48e1                	li	a7,24
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 83a:	1101                	addi	sp,sp,-32
 83c:	ec06                	sd	ra,24(sp)
 83e:	e822                	sd	s0,16(sp)
 840:	1000                	addi	s0,sp,32
 842:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 846:	4605                	li	a2,1
 848:	fef40593          	addi	a1,s0,-17
 84c:	00000097          	auipc	ra,0x0
 850:	f56080e7          	jalr	-170(ra) # 7a2 <write>
}
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	6105                	addi	sp,sp,32
 85a:	8082                	ret

000000000000085c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 85c:	7139                	addi	sp,sp,-64
 85e:	fc06                	sd	ra,56(sp)
 860:	f822                	sd	s0,48(sp)
 862:	f426                	sd	s1,40(sp)
 864:	f04a                	sd	s2,32(sp)
 866:	ec4e                	sd	s3,24(sp)
 868:	0080                	addi	s0,sp,64
 86a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 86c:	c299                	beqz	a3,872 <printint+0x16>
 86e:	0805c963          	bltz	a1,900 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 872:	2581                	sext.w	a1,a1
  neg = 0;
 874:	4881                	li	a7,0
 876:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 87a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 87c:	2601                	sext.w	a2,a2
 87e:	00000517          	auipc	a0,0x0
 882:	54a50513          	addi	a0,a0,1354 # dc8 <digits>
 886:	883a                	mv	a6,a4
 888:	2705                	addiw	a4,a4,1
 88a:	02c5f7bb          	remuw	a5,a1,a2
 88e:	1782                	slli	a5,a5,0x20
 890:	9381                	srli	a5,a5,0x20
 892:	97aa                	add	a5,a5,a0
 894:	0007c783          	lbu	a5,0(a5)
 898:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 89c:	0005879b          	sext.w	a5,a1
 8a0:	02c5d5bb          	divuw	a1,a1,a2
 8a4:	0685                	addi	a3,a3,1
 8a6:	fec7f0e3          	bgeu	a5,a2,886 <printint+0x2a>
  if(neg)
 8aa:	00088c63          	beqz	a7,8c2 <printint+0x66>
    buf[i++] = '-';
 8ae:	fd070793          	addi	a5,a4,-48
 8b2:	00878733          	add	a4,a5,s0
 8b6:	02d00793          	li	a5,45
 8ba:	fef70823          	sb	a5,-16(a4)
 8be:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8c2:	02e05863          	blez	a4,8f2 <printint+0x96>
 8c6:	fc040793          	addi	a5,s0,-64
 8ca:	00e78933          	add	s2,a5,a4
 8ce:	fff78993          	addi	s3,a5,-1
 8d2:	99ba                	add	s3,s3,a4
 8d4:	377d                	addiw	a4,a4,-1
 8d6:	1702                	slli	a4,a4,0x20
 8d8:	9301                	srli	a4,a4,0x20
 8da:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8de:	fff94583          	lbu	a1,-1(s2)
 8e2:	8526                	mv	a0,s1
 8e4:	00000097          	auipc	ra,0x0
 8e8:	f56080e7          	jalr	-170(ra) # 83a <putc>
  while(--i >= 0)
 8ec:	197d                	addi	s2,s2,-1
 8ee:	ff3918e3          	bne	s2,s3,8de <printint+0x82>
}
 8f2:	70e2                	ld	ra,56(sp)
 8f4:	7442                	ld	s0,48(sp)
 8f6:	74a2                	ld	s1,40(sp)
 8f8:	7902                	ld	s2,32(sp)
 8fa:	69e2                	ld	s3,24(sp)
 8fc:	6121                	addi	sp,sp,64
 8fe:	8082                	ret
    x = -xx;
 900:	40b005bb          	negw	a1,a1
    neg = 1;
 904:	4885                	li	a7,1
    x = -xx;
 906:	bf85                	j	876 <printint+0x1a>

0000000000000908 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 908:	715d                	addi	sp,sp,-80
 90a:	e486                	sd	ra,72(sp)
 90c:	e0a2                	sd	s0,64(sp)
 90e:	fc26                	sd	s1,56(sp)
 910:	f84a                	sd	s2,48(sp)
 912:	f44e                	sd	s3,40(sp)
 914:	f052                	sd	s4,32(sp)
 916:	ec56                	sd	s5,24(sp)
 918:	e85a                	sd	s6,16(sp)
 91a:	e45e                	sd	s7,8(sp)
 91c:	e062                	sd	s8,0(sp)
 91e:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 920:	0005c903          	lbu	s2,0(a1)
 924:	18090c63          	beqz	s2,abc <vprintf+0x1b4>
 928:	8aaa                	mv	s5,a0
 92a:	8bb2                	mv	s7,a2
 92c:	00158493          	addi	s1,a1,1
  state = 0;
 930:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 932:	02500a13          	li	s4,37
 936:	4b55                	li	s6,21
 938:	a839                	j	956 <vprintf+0x4e>
        putc(fd, c);
 93a:	85ca                	mv	a1,s2
 93c:	8556                	mv	a0,s5
 93e:	00000097          	auipc	ra,0x0
 942:	efc080e7          	jalr	-260(ra) # 83a <putc>
 946:	a019                	j	94c <vprintf+0x44>
    } else if(state == '%'){
 948:	01498d63          	beq	s3,s4,962 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 94c:	0485                	addi	s1,s1,1
 94e:	fff4c903          	lbu	s2,-1(s1)
 952:	16090563          	beqz	s2,abc <vprintf+0x1b4>
    if(state == 0){
 956:	fe0999e3          	bnez	s3,948 <vprintf+0x40>
      if(c == '%'){
 95a:	ff4910e3          	bne	s2,s4,93a <vprintf+0x32>
        state = '%';
 95e:	89d2                	mv	s3,s4
 960:	b7f5                	j	94c <vprintf+0x44>
      if(c == 'd'){
 962:	13490263          	beq	s2,s4,a86 <vprintf+0x17e>
 966:	f9d9079b          	addiw	a5,s2,-99
 96a:	0ff7f793          	zext.b	a5,a5
 96e:	12fb6563          	bltu	s6,a5,a98 <vprintf+0x190>
 972:	f9d9079b          	addiw	a5,s2,-99
 976:	0ff7f713          	zext.b	a4,a5
 97a:	10eb6f63          	bltu	s6,a4,a98 <vprintf+0x190>
 97e:	00271793          	slli	a5,a4,0x2
 982:	00000717          	auipc	a4,0x0
 986:	3ee70713          	addi	a4,a4,1006 # d70 <malloc+0x1b6>
 98a:	97ba                	add	a5,a5,a4
 98c:	439c                	lw	a5,0(a5)
 98e:	97ba                	add	a5,a5,a4
 990:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 992:	008b8913          	addi	s2,s7,8
 996:	4685                	li	a3,1
 998:	4629                	li	a2,10
 99a:	000ba583          	lw	a1,0(s7)
 99e:	8556                	mv	a0,s5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	ebc080e7          	jalr	-324(ra) # 85c <printint>
 9a8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b745                	j	94c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ae:	008b8913          	addi	s2,s7,8
 9b2:	4681                	li	a3,0
 9b4:	4629                	li	a2,10
 9b6:	000ba583          	lw	a1,0(s7)
 9ba:	8556                	mv	a0,s5
 9bc:	00000097          	auipc	ra,0x0
 9c0:	ea0080e7          	jalr	-352(ra) # 85c <printint>
 9c4:	8bca                	mv	s7,s2
      state = 0;
 9c6:	4981                	li	s3,0
 9c8:	b751                	j	94c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9ca:	008b8913          	addi	s2,s7,8
 9ce:	4681                	li	a3,0
 9d0:	4641                	li	a2,16
 9d2:	000ba583          	lw	a1,0(s7)
 9d6:	8556                	mv	a0,s5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	e84080e7          	jalr	-380(ra) # 85c <printint>
 9e0:	8bca                	mv	s7,s2
      state = 0;
 9e2:	4981                	li	s3,0
 9e4:	b7a5                	j	94c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9e6:	008b8c13          	addi	s8,s7,8
 9ea:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9ee:	03000593          	li	a1,48
 9f2:	8556                	mv	a0,s5
 9f4:	00000097          	auipc	ra,0x0
 9f8:	e46080e7          	jalr	-442(ra) # 83a <putc>
  putc(fd, 'x');
 9fc:	07800593          	li	a1,120
 a00:	8556                	mv	a0,s5
 a02:	00000097          	auipc	ra,0x0
 a06:	e38080e7          	jalr	-456(ra) # 83a <putc>
 a0a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a0c:	00000b97          	auipc	s7,0x0
 a10:	3bcb8b93          	addi	s7,s7,956 # dc8 <digits>
 a14:	03c9d793          	srli	a5,s3,0x3c
 a18:	97de                	add	a5,a5,s7
 a1a:	0007c583          	lbu	a1,0(a5)
 a1e:	8556                	mv	a0,s5
 a20:	00000097          	auipc	ra,0x0
 a24:	e1a080e7          	jalr	-486(ra) # 83a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a28:	0992                	slli	s3,s3,0x4
 a2a:	397d                	addiw	s2,s2,-1
 a2c:	fe0914e3          	bnez	s2,a14 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a30:	8be2                	mv	s7,s8
      state = 0;
 a32:	4981                	li	s3,0
 a34:	bf21                	j	94c <vprintf+0x44>
        s = va_arg(ap, char*);
 a36:	008b8993          	addi	s3,s7,8
 a3a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a3e:	02090163          	beqz	s2,a60 <vprintf+0x158>
        while(*s != 0){
 a42:	00094583          	lbu	a1,0(s2)
 a46:	c9a5                	beqz	a1,ab6 <vprintf+0x1ae>
          putc(fd, *s);
 a48:	8556                	mv	a0,s5
 a4a:	00000097          	auipc	ra,0x0
 a4e:	df0080e7          	jalr	-528(ra) # 83a <putc>
          s++;
 a52:	0905                	addi	s2,s2,1
        while(*s != 0){
 a54:	00094583          	lbu	a1,0(s2)
 a58:	f9e5                	bnez	a1,a48 <vprintf+0x140>
        s = va_arg(ap, char*);
 a5a:	8bce                	mv	s7,s3
      state = 0;
 a5c:	4981                	li	s3,0
 a5e:	b5fd                	j	94c <vprintf+0x44>
          s = "(null)";
 a60:	00000917          	auipc	s2,0x0
 a64:	30890913          	addi	s2,s2,776 # d68 <malloc+0x1ae>
        while(*s != 0){
 a68:	02800593          	li	a1,40
 a6c:	bff1                	j	a48 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a6e:	008b8913          	addi	s2,s7,8
 a72:	000bc583          	lbu	a1,0(s7)
 a76:	8556                	mv	a0,s5
 a78:	00000097          	auipc	ra,0x0
 a7c:	dc2080e7          	jalr	-574(ra) # 83a <putc>
 a80:	8bca                	mv	s7,s2
      state = 0;
 a82:	4981                	li	s3,0
 a84:	b5e1                	j	94c <vprintf+0x44>
        putc(fd, c);
 a86:	02500593          	li	a1,37
 a8a:	8556                	mv	a0,s5
 a8c:	00000097          	auipc	ra,0x0
 a90:	dae080e7          	jalr	-594(ra) # 83a <putc>
      state = 0;
 a94:	4981                	li	s3,0
 a96:	bd5d                	j	94c <vprintf+0x44>
        putc(fd, '%');
 a98:	02500593          	li	a1,37
 a9c:	8556                	mv	a0,s5
 a9e:	00000097          	auipc	ra,0x0
 aa2:	d9c080e7          	jalr	-612(ra) # 83a <putc>
        putc(fd, c);
 aa6:	85ca                	mv	a1,s2
 aa8:	8556                	mv	a0,s5
 aaa:	00000097          	auipc	ra,0x0
 aae:	d90080e7          	jalr	-624(ra) # 83a <putc>
      state = 0;
 ab2:	4981                	li	s3,0
 ab4:	bd61                	j	94c <vprintf+0x44>
        s = va_arg(ap, char*);
 ab6:	8bce                	mv	s7,s3
      state = 0;
 ab8:	4981                	li	s3,0
 aba:	bd49                	j	94c <vprintf+0x44>
    }
  }
}
 abc:	60a6                	ld	ra,72(sp)
 abe:	6406                	ld	s0,64(sp)
 ac0:	74e2                	ld	s1,56(sp)
 ac2:	7942                	ld	s2,48(sp)
 ac4:	79a2                	ld	s3,40(sp)
 ac6:	7a02                	ld	s4,32(sp)
 ac8:	6ae2                	ld	s5,24(sp)
 aca:	6b42                	ld	s6,16(sp)
 acc:	6ba2                	ld	s7,8(sp)
 ace:	6c02                	ld	s8,0(sp)
 ad0:	6161                	addi	sp,sp,80
 ad2:	8082                	ret

0000000000000ad4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ad4:	715d                	addi	sp,sp,-80
 ad6:	ec06                	sd	ra,24(sp)
 ad8:	e822                	sd	s0,16(sp)
 ada:	1000                	addi	s0,sp,32
 adc:	e010                	sd	a2,0(s0)
 ade:	e414                	sd	a3,8(s0)
 ae0:	e818                	sd	a4,16(s0)
 ae2:	ec1c                	sd	a5,24(s0)
 ae4:	03043023          	sd	a6,32(s0)
 ae8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aec:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 af0:	8622                	mv	a2,s0
 af2:	00000097          	auipc	ra,0x0
 af6:	e16080e7          	jalr	-490(ra) # 908 <vprintf>
}
 afa:	60e2                	ld	ra,24(sp)
 afc:	6442                	ld	s0,16(sp)
 afe:	6161                	addi	sp,sp,80
 b00:	8082                	ret

0000000000000b02 <printf>:

void
printf(const char *fmt, ...)
{
 b02:	711d                	addi	sp,sp,-96
 b04:	ec06                	sd	ra,24(sp)
 b06:	e822                	sd	s0,16(sp)
 b08:	1000                	addi	s0,sp,32
 b0a:	e40c                	sd	a1,8(s0)
 b0c:	e810                	sd	a2,16(s0)
 b0e:	ec14                	sd	a3,24(s0)
 b10:	f018                	sd	a4,32(s0)
 b12:	f41c                	sd	a5,40(s0)
 b14:	03043823          	sd	a6,48(s0)
 b18:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b1c:	00840613          	addi	a2,s0,8
 b20:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b24:	85aa                	mv	a1,a0
 b26:	4505                	li	a0,1
 b28:	00000097          	auipc	ra,0x0
 b2c:	de0080e7          	jalr	-544(ra) # 908 <vprintf>
}
 b30:	60e2                	ld	ra,24(sp)
 b32:	6442                	ld	s0,16(sp)
 b34:	6125                	addi	sp,sp,96
 b36:	8082                	ret

0000000000000b38 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b38:	1141                	addi	sp,sp,-16
 b3a:	e422                	sd	s0,8(sp)
 b3c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b3e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b42:	00000797          	auipc	a5,0x0
 b46:	4e67b783          	ld	a5,1254(a5) # 1028 <freep>
 b4a:	a02d                	j	b74 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b4c:	4618                	lw	a4,8(a2)
 b4e:	9f2d                	addw	a4,a4,a1
 b50:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b54:	6398                	ld	a4,0(a5)
 b56:	6310                	ld	a2,0(a4)
 b58:	a83d                	j	b96 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b5a:	ff852703          	lw	a4,-8(a0)
 b5e:	9f31                	addw	a4,a4,a2
 b60:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b62:	ff053683          	ld	a3,-16(a0)
 b66:	a091                	j	baa <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b68:	6398                	ld	a4,0(a5)
 b6a:	00e7e463          	bltu	a5,a4,b72 <free+0x3a>
 b6e:	00e6ea63          	bltu	a3,a4,b82 <free+0x4a>
{
 b72:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b74:	fed7fae3          	bgeu	a5,a3,b68 <free+0x30>
 b78:	6398                	ld	a4,0(a5)
 b7a:	00e6e463          	bltu	a3,a4,b82 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b7e:	fee7eae3          	bltu	a5,a4,b72 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b82:	ff852583          	lw	a1,-8(a0)
 b86:	6390                	ld	a2,0(a5)
 b88:	02059813          	slli	a6,a1,0x20
 b8c:	01c85713          	srli	a4,a6,0x1c
 b90:	9736                	add	a4,a4,a3
 b92:	fae60de3          	beq	a2,a4,b4c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b96:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b9a:	4790                	lw	a2,8(a5)
 b9c:	02061593          	slli	a1,a2,0x20
 ba0:	01c5d713          	srli	a4,a1,0x1c
 ba4:	973e                	add	a4,a4,a5
 ba6:	fae68ae3          	beq	a3,a4,b5a <free+0x22>
        p->s.ptr = bp->s.ptr;
 baa:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bac:	00000717          	auipc	a4,0x0
 bb0:	46f73e23          	sd	a5,1148(a4) # 1028 <freep>
}
 bb4:	6422                	ld	s0,8(sp)
 bb6:	0141                	addi	sp,sp,16
 bb8:	8082                	ret

0000000000000bba <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 bba:	7139                	addi	sp,sp,-64
 bbc:	fc06                	sd	ra,56(sp)
 bbe:	f822                	sd	s0,48(sp)
 bc0:	f426                	sd	s1,40(sp)
 bc2:	f04a                	sd	s2,32(sp)
 bc4:	ec4e                	sd	s3,24(sp)
 bc6:	e852                	sd	s4,16(sp)
 bc8:	e456                	sd	s5,8(sp)
 bca:	e05a                	sd	s6,0(sp)
 bcc:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bce:	02051493          	slli	s1,a0,0x20
 bd2:	9081                	srli	s1,s1,0x20
 bd4:	04bd                	addi	s1,s1,15
 bd6:	8091                	srli	s1,s1,0x4
 bd8:	0014899b          	addiw	s3,s1,1
 bdc:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 bde:	00000517          	auipc	a0,0x0
 be2:	44a53503          	ld	a0,1098(a0) # 1028 <freep>
 be6:	c515                	beqz	a0,c12 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 be8:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bea:	4798                	lw	a4,8(a5)
 bec:	02977f63          	bgeu	a4,s1,c2a <malloc+0x70>
    if (nu < 4096)
 bf0:	8a4e                	mv	s4,s3
 bf2:	0009871b          	sext.w	a4,s3
 bf6:	6685                	lui	a3,0x1
 bf8:	00d77363          	bgeu	a4,a3,bfe <malloc+0x44>
 bfc:	6a05                	lui	s4,0x1
 bfe:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c02:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c06:	00000917          	auipc	s2,0x0
 c0a:	42290913          	addi	s2,s2,1058 # 1028 <freep>
    if (p == (char *)-1)
 c0e:	5afd                	li	s5,-1
 c10:	a895                	j	c84 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c12:	00000797          	auipc	a5,0x0
 c16:	49e78793          	addi	a5,a5,1182 # 10b0 <base>
 c1a:	00000717          	auipc	a4,0x0
 c1e:	40f73723          	sd	a5,1038(a4) # 1028 <freep>
 c22:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c24:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c28:	b7e1                	j	bf0 <malloc+0x36>
            if (p->s.size == nunits)
 c2a:	02e48c63          	beq	s1,a4,c62 <malloc+0xa8>
                p->s.size -= nunits;
 c2e:	4137073b          	subw	a4,a4,s3
 c32:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c34:	02071693          	slli	a3,a4,0x20
 c38:	01c6d713          	srli	a4,a3,0x1c
 c3c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c3e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c42:	00000717          	auipc	a4,0x0
 c46:	3ea73323          	sd	a0,998(a4) # 1028 <freep>
            return (void *)(p + 1);
 c4a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c4e:	70e2                	ld	ra,56(sp)
 c50:	7442                	ld	s0,48(sp)
 c52:	74a2                	ld	s1,40(sp)
 c54:	7902                	ld	s2,32(sp)
 c56:	69e2                	ld	s3,24(sp)
 c58:	6a42                	ld	s4,16(sp)
 c5a:	6aa2                	ld	s5,8(sp)
 c5c:	6b02                	ld	s6,0(sp)
 c5e:	6121                	addi	sp,sp,64
 c60:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c62:	6398                	ld	a4,0(a5)
 c64:	e118                	sd	a4,0(a0)
 c66:	bff1                	j	c42 <malloc+0x88>
    hp->s.size = nu;
 c68:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c6c:	0541                	addi	a0,a0,16
 c6e:	00000097          	auipc	ra,0x0
 c72:	eca080e7          	jalr	-310(ra) # b38 <free>
    return freep;
 c76:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c7a:	d971                	beqz	a0,c4e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c7c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c7e:	4798                	lw	a4,8(a5)
 c80:	fa9775e3          	bgeu	a4,s1,c2a <malloc+0x70>
        if (p == freep)
 c84:	00093703          	ld	a4,0(s2)
 c88:	853e                	mv	a0,a5
 c8a:	fef719e3          	bne	a4,a5,c7c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c8e:	8552                	mv	a0,s4
 c90:	00000097          	auipc	ra,0x0
 c94:	b7a080e7          	jalr	-1158(ra) # 80a <sbrk>
    if (p == (char *)-1)
 c98:	fd5518e3          	bne	a0,s5,c68 <malloc+0xae>
                return 0;
 c9c:	4501                	li	a0,0
 c9e:	bf45                	j	c4e <malloc+0x94>
