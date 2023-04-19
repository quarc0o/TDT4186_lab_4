
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
  18:	7c2080e7          	jalr	1986(ra) # 7d6 <uptime>
  1c:	892a                	mv	s2,a0

    // we now start the program in a separate process:
    int uutPid = fork();
  1e:	00000097          	auipc	ra,0x0
  22:	718080e7          	jalr	1816(ra) # 736 <fork>

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
  36:	744080e7          	jalr	1860(ra) # 776 <exec>
        // wait for the uut to finish
        wait(0);
        int endticks = uptime();
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
    }
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	702080e7          	jalr	1794(ra) # 73e <exit>
        printf("Time took 0 ticks\n");
  44:	00001517          	auipc	a0,0x1
  48:	c1c50513          	addi	a0,a0,-996 # c60 <malloc+0xea>
  4c:	00001097          	auipc	ra,0x1
  50:	a72080e7          	jalr	-1422(ra) # abe <printf>
        printf("Usage: time [exec] [arg1 arg2 ...]\n");
  54:	00001517          	auipc	a0,0x1
  58:	c2450513          	addi	a0,a0,-988 # c78 <malloc+0x102>
  5c:	00001097          	auipc	ra,0x1
  60:	a62080e7          	jalr	-1438(ra) # abe <printf>
        exit(1);
  64:	4505                	li	a0,1
  66:	00000097          	auipc	ra,0x0
  6a:	6d8080e7          	jalr	1752(ra) # 73e <exit>
        printf("fork failed... couldn't start %s", argv[1]);
  6e:	648c                	ld	a1,8(s1)
  70:	00001517          	auipc	a0,0x1
  74:	c3050513          	addi	a0,a0,-976 # ca0 <malloc+0x12a>
  78:	00001097          	auipc	ra,0x1
  7c:	a46080e7          	jalr	-1466(ra) # abe <printf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	6bc080e7          	jalr	1724(ra) # 73e <exit>
        wait(0);
  8a:	4501                	li	a0,0
  8c:	00000097          	auipc	ra,0x0
  90:	6ba080e7          	jalr	1722(ra) # 746 <wait>
        int endticks = uptime();
  94:	00000097          	auipc	ra,0x0
  98:	742080e7          	jalr	1858(ra) # 7d6 <uptime>
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
  9c:	4125063b          	subw	a2,a0,s2
  a0:	648c                	ld	a1,8(s1)
  a2:	00001517          	auipc	a0,0x1
  a6:	c2650513          	addi	a0,a0,-986 # cc8 <malloc+0x152>
  aa:	00001097          	auipc	ra,0x1
  ae:	a14080e7          	jalr	-1516(ra) # abe <printf>
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
  e8:	340080e7          	jalr	832(ra) # 424 <twhoami>
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
 134:	bb850513          	addi	a0,a0,-1096 # ce8 <malloc+0x172>
 138:	00001097          	auipc	ra,0x1
 13c:	986080e7          	jalr	-1658(ra) # abe <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	5fc080e7          	jalr	1532(ra) # 73e <exit>
    {
        // give up the cpu for other threads
        tyield();
 14a:	00000097          	auipc	ra,0x0
 14e:	258080e7          	jalr	600(ra) # 3a2 <tyield>
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
 168:	2c0080e7          	jalr	704(ra) # 424 <twhoami>
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
 1ac:	1fa080e7          	jalr	506(ra) # 3a2 <tyield>
}
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	64a2                	ld	s1,8(sp)
 1b6:	6105                	addi	sp,sp,32
 1b8:	8082                	ret
        printf("releasing lock we are not holding");
 1ba:	00001517          	auipc	a0,0x1
 1be:	b5650513          	addi	a0,a0,-1194 # d10 <malloc+0x19a>
 1c2:	00001097          	auipc	ra,0x1
 1c6:	8fc080e7          	jalr	-1796(ra) # abe <printf>
        exit(-1);
 1ca:	557d                	li	a0,-1
 1cc:	00000097          	auipc	ra,0x0
 1d0:	572080e7          	jalr	1394(ra) # 73e <exit>

00000000000001d4 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e406                	sd	ra,8(sp)
 1d8:	e022                	sd	s0,0(sp)
 1da:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 1dc:	09800513          	li	a0,152
 1e0:	00001097          	auipc	ra,0x1
 1e4:	996080e7          	jalr	-1642(ra) # b76 <malloc>

    main_thread->tid = next_tid;
 1e8:	00001797          	auipc	a5,0x1
 1ec:	e1878793          	addi	a5,a5,-488 # 1000 <next_tid>
 1f0:	4398                	lw	a4,0(a5)
 1f2:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 1f6:	4398                	lw	a4,0(a5)
 1f8:	2705                	addiw	a4,a4,1
 1fa:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 1fc:	4791                	li	a5,4
 1fe:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 200:	00001797          	auipc	a5,0x1
 204:	e0a7b823          	sd	a0,-496(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 208:	00001797          	auipc	a5,0x1
 20c:	e1878793          	addi	a5,a5,-488 # 1020 <threads>
 210:	00001717          	auipc	a4,0x1
 214:	e9070713          	addi	a4,a4,-368 # 10a0 <base>
        threads[i] = NULL;
 218:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 21c:	07a1                	addi	a5,a5,8
 21e:	fee79de3          	bne	a5,a4,218 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 222:	00001797          	auipc	a5,0x1
 226:	dea7bf23          	sd	a0,-514(a5) # 1020 <threads>
}
 22a:	60a2                	ld	ra,8(sp)
 22c:	6402                	ld	s0,0(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret

0000000000000232 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 232:	00001517          	auipc	a0,0x1
 236:	dde53503          	ld	a0,-546(a0) # 1010 <current_thread>
 23a:	00001717          	auipc	a4,0x1
 23e:	de670713          	addi	a4,a4,-538 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 242:	4781                	li	a5,0
 244:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 246:	6314                	ld	a3,0(a4)
 248:	00a68763          	beq	a3,a0,256 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 24c:	2785                	addiw	a5,a5,1
 24e:	0721                	addi	a4,a4,8
 250:	fec79be3          	bne	a5,a2,246 <tsched+0x14>
    int current_index = 0;
 254:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 256:	0017869b          	addiw	a3,a5,1
 25a:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 25e:	00001817          	auipc	a6,0x1
 262:	dc280813          	addi	a6,a6,-574 # 1020 <threads>
 266:	488d                	li	a7,3
 268:	a021                	j	270 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 26a:	2685                	addiw	a3,a3,1
 26c:	04c68363          	beq	a3,a2,2b2 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 270:	41f6d71b          	sraiw	a4,a3,0x1f
 274:	01c7571b          	srliw	a4,a4,0x1c
 278:	00d707bb          	addw	a5,a4,a3
 27c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 27e:	9f99                	subw	a5,a5,a4
 280:	078e                	slli	a5,a5,0x3
 282:	97c2                	add	a5,a5,a6
 284:	638c                	ld	a1,0(a5)
 286:	d1f5                	beqz	a1,26a <tsched+0x38>
 288:	5dbc                	lw	a5,120(a1)
 28a:	ff1790e3          	bne	a5,a7,26a <tsched+0x38>
{
 28e:	1141                	addi	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 296:	00001797          	auipc	a5,0x1
 29a:	d6b7bd23          	sd	a1,-646(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 29e:	05a1                	addi	a1,a1,8
 2a0:	0521                	addi	a0,a0,8
 2a2:	00000097          	auipc	ra,0x0
 2a6:	19a080e7          	jalr	410(ra) # 43c <tswtch>
        //printf("Thread switch complete\n");
    }
}
 2aa:	60a2                	ld	ra,8(sp)
 2ac:	6402                	ld	s0,0(sp)
 2ae:	0141                	addi	sp,sp,16
 2b0:	8082                	ret
 2b2:	8082                	ret

00000000000002b4 <thread_wrapper>:
{
 2b4:	1101                	addi	sp,sp,-32
 2b6:	ec06                	sd	ra,24(sp)
 2b8:	e822                	sd	s0,16(sp)
 2ba:	e426                	sd	s1,8(sp)
 2bc:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 2be:	00001497          	auipc	s1,0x1
 2c2:	d5248493          	addi	s1,s1,-686 # 1010 <current_thread>
 2c6:	609c                	ld	a5,0(s1)
 2c8:	6b9c                	ld	a5,16(a5)
    func(arg);
 2ca:	6398                	ld	a4,0(a5)
 2cc:	6788                	ld	a0,8(a5)
 2ce:	9702                	jalr	a4
    current_thread->state = EXITED;
 2d0:	609c                	ld	a5,0(s1)
 2d2:	4719                	li	a4,6
 2d4:	dfb8                	sw	a4,120(a5)
    tsched();
 2d6:	00000097          	auipc	ra,0x0
 2da:	f5c080e7          	jalr	-164(ra) # 232 <tsched>
}
 2de:	60e2                	ld	ra,24(sp)
 2e0:	6442                	ld	s0,16(sp)
 2e2:	64a2                	ld	s1,8(sp)
 2e4:	6105                	addi	sp,sp,32
 2e6:	8082                	ret

00000000000002e8 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2e8:	7179                	addi	sp,sp,-48
 2ea:	f406                	sd	ra,40(sp)
 2ec:	f022                	sd	s0,32(sp)
 2ee:	ec26                	sd	s1,24(sp)
 2f0:	e84a                	sd	s2,16(sp)
 2f2:	e44e                	sd	s3,8(sp)
 2f4:	1800                	addi	s0,sp,48
 2f6:	84aa                	mv	s1,a0
 2f8:	8932                	mv	s2,a2
 2fa:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2fc:	09800513          	li	a0,152
 300:	00001097          	auipc	ra,0x1
 304:	876080e7          	jalr	-1930(ra) # b76 <malloc>
 308:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 30a:	478d                	li	a5,3
 30c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 30e:	609c                	ld	a5,0(s1)
 310:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 314:	609c                	ld	a5,0(s1)
 316:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 31a:	6098                	ld	a4,0(s1)
 31c:	00001797          	auipc	a5,0x1
 320:	ce478793          	addi	a5,a5,-796 # 1000 <next_tid>
 324:	4394                	lw	a3,0(a5)
 326:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 32a:	4398                	lw	a4,0(a5)
 32c:	2705                	addiw	a4,a4,1
 32e:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 330:	6505                	lui	a0,0x1
 332:	00001097          	auipc	ra,0x1
 336:	844080e7          	jalr	-1980(ra) # b76 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 33a:	6785                	lui	a5,0x1
 33c:	00a78733          	add	a4,a5,a0
 340:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 344:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x258>
 346:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 348:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 34c:	609c                	ld	a5,0(s1)
 34e:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 350:	609c                	ld	a5,0(s1)
 352:	00000717          	auipc	a4,0x0
 356:	f6270713          	addi	a4,a4,-158 # 2b4 <thread_wrapper>
 35a:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 35c:	00001717          	auipc	a4,0x1
 360:	cc470713          	addi	a4,a4,-828 # 1020 <threads>
 364:	4781                	li	a5,0
 366:	4641                	li	a2,16
        if (threads[i] == NULL) {
 368:	6314                	ld	a3,0(a4)
 36a:	c29d                	beqz	a3,390 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 36c:	2785                	addiw	a5,a5,1
 36e:	0721                	addi	a4,a4,8
 370:	fec79ce3          	bne	a5,a2,368 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 374:	6088                	ld	a0,0(s1)
 376:	00000097          	auipc	ra,0x0
 37a:	77e080e7          	jalr	1918(ra) # af4 <free>
        *thread = NULL;
 37e:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 382:	70a2                	ld	ra,40(sp)
 384:	7402                	ld	s0,32(sp)
 386:	64e2                	ld	s1,24(sp)
 388:	6942                	ld	s2,16(sp)
 38a:	69a2                	ld	s3,8(sp)
 38c:	6145                	addi	sp,sp,48
 38e:	8082                	ret
            threads[i] = *thread;
 390:	6094                	ld	a3,0(s1)
 392:	078e                	slli	a5,a5,0x3
 394:	00001717          	auipc	a4,0x1
 398:	c8c70713          	addi	a4,a4,-884 # 1020 <threads>
 39c:	97ba                	add	a5,a5,a4
 39e:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 3a0:	b7cd                	j	382 <tcreate+0x9a>

00000000000003a2 <tyield>:
    return 0;
}


void tyield()
{
 3a2:	1141                	addi	sp,sp,-16
 3a4:	e406                	sd	ra,8(sp)
 3a6:	e022                	sd	s0,0(sp)
 3a8:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 3aa:	00001797          	auipc	a5,0x1
 3ae:	c667b783          	ld	a5,-922(a5) # 1010 <current_thread>
 3b2:	470d                	li	a4,3
 3b4:	dfb8                	sw	a4,120(a5)
    tsched();
 3b6:	00000097          	auipc	ra,0x0
 3ba:	e7c080e7          	jalr	-388(ra) # 232 <tsched>
}
 3be:	60a2                	ld	ra,8(sp)
 3c0:	6402                	ld	s0,0(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <tjoin>:
{
 3c6:	1101                	addi	sp,sp,-32
 3c8:	ec06                	sd	ra,24(sp)
 3ca:	e822                	sd	s0,16(sp)
 3cc:	e426                	sd	s1,8(sp)
 3ce:	e04a                	sd	s2,0(sp)
 3d0:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 3d2:	00001797          	auipc	a5,0x1
 3d6:	c4e78793          	addi	a5,a5,-946 # 1020 <threads>
 3da:	00001697          	auipc	a3,0x1
 3de:	cc668693          	addi	a3,a3,-826 # 10a0 <base>
 3e2:	a021                	j	3ea <tjoin+0x24>
 3e4:	07a1                	addi	a5,a5,8
 3e6:	02d78b63          	beq	a5,a3,41c <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 3ea:	6384                	ld	s1,0(a5)
 3ec:	dce5                	beqz	s1,3e4 <tjoin+0x1e>
 3ee:	0004c703          	lbu	a4,0(s1)
 3f2:	fea719e3          	bne	a4,a0,3e4 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3f6:	5cb8                	lw	a4,120(s1)
 3f8:	4799                	li	a5,6
 3fa:	4919                	li	s2,6
 3fc:	02f70263          	beq	a4,a5,420 <tjoin+0x5a>
        tyield();
 400:	00000097          	auipc	ra,0x0
 404:	fa2080e7          	jalr	-94(ra) # 3a2 <tyield>
    while (target_thread->state != EXITED) {
 408:	5cbc                	lw	a5,120(s1)
 40a:	ff279be3          	bne	a5,s2,400 <tjoin+0x3a>
    return 0;
 40e:	4501                	li	a0,0
}
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	64a2                	ld	s1,8(sp)
 416:	6902                	ld	s2,0(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret
        return -1;
 41c:	557d                	li	a0,-1
 41e:	bfcd                	j	410 <tjoin+0x4a>
    return 0;
 420:	4501                	li	a0,0
 422:	b7fd                	j	410 <tjoin+0x4a>

0000000000000424 <twhoami>:

uint8 twhoami()
{
 424:	1141                	addi	sp,sp,-16
 426:	e422                	sd	s0,8(sp)
 428:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 42a:	00001797          	auipc	a5,0x1
 42e:	be67b783          	ld	a5,-1050(a5) # 1010 <current_thread>
 432:	0007c503          	lbu	a0,0(a5)
 436:	6422                	ld	s0,8(sp)
 438:	0141                	addi	sp,sp,16
 43a:	8082                	ret

000000000000043c <tswtch>:
 43c:	00153023          	sd	ra,0(a0)
 440:	00253423          	sd	sp,8(a0)
 444:	e900                	sd	s0,16(a0)
 446:	ed04                	sd	s1,24(a0)
 448:	03253023          	sd	s2,32(a0)
 44c:	03353423          	sd	s3,40(a0)
 450:	03453823          	sd	s4,48(a0)
 454:	03553c23          	sd	s5,56(a0)
 458:	05653023          	sd	s6,64(a0)
 45c:	05753423          	sd	s7,72(a0)
 460:	05853823          	sd	s8,80(a0)
 464:	05953c23          	sd	s9,88(a0)
 468:	07a53023          	sd	s10,96(a0)
 46c:	07b53423          	sd	s11,104(a0)
 470:	0005b083          	ld	ra,0(a1)
 474:	0085b103          	ld	sp,8(a1)
 478:	6980                	ld	s0,16(a1)
 47a:	6d84                	ld	s1,24(a1)
 47c:	0205b903          	ld	s2,32(a1)
 480:	0285b983          	ld	s3,40(a1)
 484:	0305ba03          	ld	s4,48(a1)
 488:	0385ba83          	ld	s5,56(a1)
 48c:	0405bb03          	ld	s6,64(a1)
 490:	0485bb83          	ld	s7,72(a1)
 494:	0505bc03          	ld	s8,80(a1)
 498:	0585bc83          	ld	s9,88(a1)
 49c:	0605bd03          	ld	s10,96(a1)
 4a0:	0685bd83          	ld	s11,104(a1)
 4a4:	8082                	ret

00000000000004a6 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 4a6:	1101                	addi	sp,sp,-32
 4a8:	ec06                	sd	ra,24(sp)
 4aa:	e822                	sd	s0,16(sp)
 4ac:	e426                	sd	s1,8(sp)
 4ae:	e04a                	sd	s2,0(sp)
 4b0:	1000                	addi	s0,sp,32
 4b2:	84aa                	mv	s1,a0
 4b4:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 4b6:	00000097          	auipc	ra,0x0
 4ba:	d1e080e7          	jalr	-738(ra) # 1d4 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4be:	85ca                	mv	a1,s2
 4c0:	8526                	mv	a0,s1
 4c2:	00000097          	auipc	ra,0x0
 4c6:	b3e080e7          	jalr	-1218(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 4ca:	00000097          	auipc	ra,0x0
 4ce:	274080e7          	jalr	628(ra) # 73e <exit>

00000000000004d2 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4d2:	1141                	addi	sp,sp,-16
 4d4:	e422                	sd	s0,8(sp)
 4d6:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4d8:	87aa                	mv	a5,a0
 4da:	0585                	addi	a1,a1,1
 4dc:	0785                	addi	a5,a5,1
 4de:	fff5c703          	lbu	a4,-1(a1)
 4e2:	fee78fa3          	sb	a4,-1(a5)
 4e6:	fb75                	bnez	a4,4da <strcpy+0x8>
        ;
    return os;
}
 4e8:	6422                	ld	s0,8(sp)
 4ea:	0141                	addi	sp,sp,16
 4ec:	8082                	ret

00000000000004ee <strcmp>:

int strcmp(const char *p, const char *q)
{
 4ee:	1141                	addi	sp,sp,-16
 4f0:	e422                	sd	s0,8(sp)
 4f2:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4f4:	00054783          	lbu	a5,0(a0)
 4f8:	cb91                	beqz	a5,50c <strcmp+0x1e>
 4fa:	0005c703          	lbu	a4,0(a1)
 4fe:	00f71763          	bne	a4,a5,50c <strcmp+0x1e>
        p++, q++;
 502:	0505                	addi	a0,a0,1
 504:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 506:	00054783          	lbu	a5,0(a0)
 50a:	fbe5                	bnez	a5,4fa <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 50c:	0005c503          	lbu	a0,0(a1)
}
 510:	40a7853b          	subw	a0,a5,a0
 514:	6422                	ld	s0,8(sp)
 516:	0141                	addi	sp,sp,16
 518:	8082                	ret

000000000000051a <strlen>:

uint strlen(const char *s)
{
 51a:	1141                	addi	sp,sp,-16
 51c:	e422                	sd	s0,8(sp)
 51e:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 520:	00054783          	lbu	a5,0(a0)
 524:	cf91                	beqz	a5,540 <strlen+0x26>
 526:	0505                	addi	a0,a0,1
 528:	87aa                	mv	a5,a0
 52a:	86be                	mv	a3,a5
 52c:	0785                	addi	a5,a5,1
 52e:	fff7c703          	lbu	a4,-1(a5)
 532:	ff65                	bnez	a4,52a <strlen+0x10>
 534:	40a6853b          	subw	a0,a3,a0
 538:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 53a:	6422                	ld	s0,8(sp)
 53c:	0141                	addi	sp,sp,16
 53e:	8082                	ret
    for (n = 0; s[n]; n++)
 540:	4501                	li	a0,0
 542:	bfe5                	j	53a <strlen+0x20>

0000000000000544 <memset>:

void *
memset(void *dst, int c, uint n)
{
 544:	1141                	addi	sp,sp,-16
 546:	e422                	sd	s0,8(sp)
 548:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 54a:	ca19                	beqz	a2,560 <memset+0x1c>
 54c:	87aa                	mv	a5,a0
 54e:	1602                	slli	a2,a2,0x20
 550:	9201                	srli	a2,a2,0x20
 552:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 556:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 55a:	0785                	addi	a5,a5,1
 55c:	fee79de3          	bne	a5,a4,556 <memset+0x12>
    }
    return dst;
}
 560:	6422                	ld	s0,8(sp)
 562:	0141                	addi	sp,sp,16
 564:	8082                	ret

0000000000000566 <strchr>:

char *
strchr(const char *s, char c)
{
 566:	1141                	addi	sp,sp,-16
 568:	e422                	sd	s0,8(sp)
 56a:	0800                	addi	s0,sp,16
    for (; *s; s++)
 56c:	00054783          	lbu	a5,0(a0)
 570:	cb99                	beqz	a5,586 <strchr+0x20>
        if (*s == c)
 572:	00f58763          	beq	a1,a5,580 <strchr+0x1a>
    for (; *s; s++)
 576:	0505                	addi	a0,a0,1
 578:	00054783          	lbu	a5,0(a0)
 57c:	fbfd                	bnez	a5,572 <strchr+0xc>
            return (char *)s;
    return 0;
 57e:	4501                	li	a0,0
}
 580:	6422                	ld	s0,8(sp)
 582:	0141                	addi	sp,sp,16
 584:	8082                	ret
    return 0;
 586:	4501                	li	a0,0
 588:	bfe5                	j	580 <strchr+0x1a>

000000000000058a <gets>:

char *
gets(char *buf, int max)
{
 58a:	711d                	addi	sp,sp,-96
 58c:	ec86                	sd	ra,88(sp)
 58e:	e8a2                	sd	s0,80(sp)
 590:	e4a6                	sd	s1,72(sp)
 592:	e0ca                	sd	s2,64(sp)
 594:	fc4e                	sd	s3,56(sp)
 596:	f852                	sd	s4,48(sp)
 598:	f456                	sd	s5,40(sp)
 59a:	f05a                	sd	s6,32(sp)
 59c:	ec5e                	sd	s7,24(sp)
 59e:	1080                	addi	s0,sp,96
 5a0:	8baa                	mv	s7,a0
 5a2:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5a4:	892a                	mv	s2,a0
 5a6:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5a8:	4aa9                	li	s5,10
 5aa:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5ac:	89a6                	mv	s3,s1
 5ae:	2485                	addiw	s1,s1,1
 5b0:	0344d863          	bge	s1,s4,5e0 <gets+0x56>
        cc = read(0, &c, 1);
 5b4:	4605                	li	a2,1
 5b6:	faf40593          	addi	a1,s0,-81
 5ba:	4501                	li	a0,0
 5bc:	00000097          	auipc	ra,0x0
 5c0:	19a080e7          	jalr	410(ra) # 756 <read>
        if (cc < 1)
 5c4:	00a05e63          	blez	a0,5e0 <gets+0x56>
        buf[i++] = c;
 5c8:	faf44783          	lbu	a5,-81(s0)
 5cc:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5d0:	01578763          	beq	a5,s5,5de <gets+0x54>
 5d4:	0905                	addi	s2,s2,1
 5d6:	fd679be3          	bne	a5,s6,5ac <gets+0x22>
    for (i = 0; i + 1 < max;)
 5da:	89a6                	mv	s3,s1
 5dc:	a011                	j	5e0 <gets+0x56>
 5de:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5e0:	99de                	add	s3,s3,s7
 5e2:	00098023          	sb	zero,0(s3)
    return buf;
}
 5e6:	855e                	mv	a0,s7
 5e8:	60e6                	ld	ra,88(sp)
 5ea:	6446                	ld	s0,80(sp)
 5ec:	64a6                	ld	s1,72(sp)
 5ee:	6906                	ld	s2,64(sp)
 5f0:	79e2                	ld	s3,56(sp)
 5f2:	7a42                	ld	s4,48(sp)
 5f4:	7aa2                	ld	s5,40(sp)
 5f6:	7b02                	ld	s6,32(sp)
 5f8:	6be2                	ld	s7,24(sp)
 5fa:	6125                	addi	sp,sp,96
 5fc:	8082                	ret

00000000000005fe <stat>:

int stat(const char *n, struct stat *st)
{
 5fe:	1101                	addi	sp,sp,-32
 600:	ec06                	sd	ra,24(sp)
 602:	e822                	sd	s0,16(sp)
 604:	e426                	sd	s1,8(sp)
 606:	e04a                	sd	s2,0(sp)
 608:	1000                	addi	s0,sp,32
 60a:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 60c:	4581                	li	a1,0
 60e:	00000097          	auipc	ra,0x0
 612:	170080e7          	jalr	368(ra) # 77e <open>
    if (fd < 0)
 616:	02054563          	bltz	a0,640 <stat+0x42>
 61a:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 61c:	85ca                	mv	a1,s2
 61e:	00000097          	auipc	ra,0x0
 622:	178080e7          	jalr	376(ra) # 796 <fstat>
 626:	892a                	mv	s2,a0
    close(fd);
 628:	8526                	mv	a0,s1
 62a:	00000097          	auipc	ra,0x0
 62e:	13c080e7          	jalr	316(ra) # 766 <close>
    return r;
}
 632:	854a                	mv	a0,s2
 634:	60e2                	ld	ra,24(sp)
 636:	6442                	ld	s0,16(sp)
 638:	64a2                	ld	s1,8(sp)
 63a:	6902                	ld	s2,0(sp)
 63c:	6105                	addi	sp,sp,32
 63e:	8082                	ret
        return -1;
 640:	597d                	li	s2,-1
 642:	bfc5                	j	632 <stat+0x34>

0000000000000644 <atoi>:

int atoi(const char *s)
{
 644:	1141                	addi	sp,sp,-16
 646:	e422                	sd	s0,8(sp)
 648:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 64a:	00054683          	lbu	a3,0(a0)
 64e:	fd06879b          	addiw	a5,a3,-48
 652:	0ff7f793          	zext.b	a5,a5
 656:	4625                	li	a2,9
 658:	02f66863          	bltu	a2,a5,688 <atoi+0x44>
 65c:	872a                	mv	a4,a0
    n = 0;
 65e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 660:	0705                	addi	a4,a4,1
 662:	0025179b          	slliw	a5,a0,0x2
 666:	9fa9                	addw	a5,a5,a0
 668:	0017979b          	slliw	a5,a5,0x1
 66c:	9fb5                	addw	a5,a5,a3
 66e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 672:	00074683          	lbu	a3,0(a4)
 676:	fd06879b          	addiw	a5,a3,-48
 67a:	0ff7f793          	zext.b	a5,a5
 67e:	fef671e3          	bgeu	a2,a5,660 <atoi+0x1c>
    return n;
}
 682:	6422                	ld	s0,8(sp)
 684:	0141                	addi	sp,sp,16
 686:	8082                	ret
    n = 0;
 688:	4501                	li	a0,0
 68a:	bfe5                	j	682 <atoi+0x3e>

000000000000068c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 68c:	1141                	addi	sp,sp,-16
 68e:	e422                	sd	s0,8(sp)
 690:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 692:	02b57463          	bgeu	a0,a1,6ba <memmove+0x2e>
    {
        while (n-- > 0)
 696:	00c05f63          	blez	a2,6b4 <memmove+0x28>
 69a:	1602                	slli	a2,a2,0x20
 69c:	9201                	srli	a2,a2,0x20
 69e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6a2:	872a                	mv	a4,a0
            *dst++ = *src++;
 6a4:	0585                	addi	a1,a1,1
 6a6:	0705                	addi	a4,a4,1
 6a8:	fff5c683          	lbu	a3,-1(a1)
 6ac:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6b0:	fee79ae3          	bne	a5,a4,6a4 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6b4:	6422                	ld	s0,8(sp)
 6b6:	0141                	addi	sp,sp,16
 6b8:	8082                	ret
        dst += n;
 6ba:	00c50733          	add	a4,a0,a2
        src += n;
 6be:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6c0:	fec05ae3          	blez	a2,6b4 <memmove+0x28>
 6c4:	fff6079b          	addiw	a5,a2,-1
 6c8:	1782                	slli	a5,a5,0x20
 6ca:	9381                	srli	a5,a5,0x20
 6cc:	fff7c793          	not	a5,a5
 6d0:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6d2:	15fd                	addi	a1,a1,-1
 6d4:	177d                	addi	a4,a4,-1
 6d6:	0005c683          	lbu	a3,0(a1)
 6da:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6de:	fee79ae3          	bne	a5,a4,6d2 <memmove+0x46>
 6e2:	bfc9                	j	6b4 <memmove+0x28>

00000000000006e4 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6e4:	1141                	addi	sp,sp,-16
 6e6:	e422                	sd	s0,8(sp)
 6e8:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6ea:	ca05                	beqz	a2,71a <memcmp+0x36>
 6ec:	fff6069b          	addiw	a3,a2,-1
 6f0:	1682                	slli	a3,a3,0x20
 6f2:	9281                	srli	a3,a3,0x20
 6f4:	0685                	addi	a3,a3,1
 6f6:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6f8:	00054783          	lbu	a5,0(a0)
 6fc:	0005c703          	lbu	a4,0(a1)
 700:	00e79863          	bne	a5,a4,710 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 704:	0505                	addi	a0,a0,1
        p2++;
 706:	0585                	addi	a1,a1,1
    while (n-- > 0)
 708:	fed518e3          	bne	a0,a3,6f8 <memcmp+0x14>
    }
    return 0;
 70c:	4501                	li	a0,0
 70e:	a019                	j	714 <memcmp+0x30>
            return *p1 - *p2;
 710:	40e7853b          	subw	a0,a5,a4
}
 714:	6422                	ld	s0,8(sp)
 716:	0141                	addi	sp,sp,16
 718:	8082                	ret
    return 0;
 71a:	4501                	li	a0,0
 71c:	bfe5                	j	714 <memcmp+0x30>

000000000000071e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 71e:	1141                	addi	sp,sp,-16
 720:	e406                	sd	ra,8(sp)
 722:	e022                	sd	s0,0(sp)
 724:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 726:	00000097          	auipc	ra,0x0
 72a:	f66080e7          	jalr	-154(ra) # 68c <memmove>
}
 72e:	60a2                	ld	ra,8(sp)
 730:	6402                	ld	s0,0(sp)
 732:	0141                	addi	sp,sp,16
 734:	8082                	ret

0000000000000736 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 736:	4885                	li	a7,1
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <exit>:
.global exit
exit:
 li a7, SYS_exit
 73e:	4889                	li	a7,2
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <wait>:
.global wait
wait:
 li a7, SYS_wait
 746:	488d                	li	a7,3
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 74e:	4891                	li	a7,4
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <read>:
.global read
read:
 li a7, SYS_read
 756:	4895                	li	a7,5
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <write>:
.global write
write:
 li a7, SYS_write
 75e:	48c1                	li	a7,16
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <close>:
.global close
close:
 li a7, SYS_close
 766:	48d5                	li	a7,21
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <kill>:
.global kill
kill:
 li a7, SYS_kill
 76e:	4899                	li	a7,6
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <exec>:
.global exec
exec:
 li a7, SYS_exec
 776:	489d                	li	a7,7
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <open>:
.global open
open:
 li a7, SYS_open
 77e:	48bd                	li	a7,15
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 786:	48c5                	li	a7,17
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 78e:	48c9                	li	a7,18
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 796:	48a1                	li	a7,8
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <link>:
.global link
link:
 li a7, SYS_link
 79e:	48cd                	li	a7,19
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7a6:	48d1                	li	a7,20
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7ae:	48a5                	li	a7,9
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7b6:	48a9                	li	a7,10
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7be:	48ad                	li	a7,11
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7c6:	48b1                	li	a7,12
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7ce:	48b5                	li	a7,13
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7d6:	48b9                	li	a7,14
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <ps>:
.global ps
ps:
 li a7, SYS_ps
 7de:	48d9                	li	a7,22
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7e6:	48dd                	li	a7,23
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7ee:	48e1                	li	a7,24
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7f6:	1101                	addi	sp,sp,-32
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 802:	4605                	li	a2,1
 804:	fef40593          	addi	a1,s0,-17
 808:	00000097          	auipc	ra,0x0
 80c:	f56080e7          	jalr	-170(ra) # 75e <write>
}
 810:	60e2                	ld	ra,24(sp)
 812:	6442                	ld	s0,16(sp)
 814:	6105                	addi	sp,sp,32
 816:	8082                	ret

0000000000000818 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 818:	7139                	addi	sp,sp,-64
 81a:	fc06                	sd	ra,56(sp)
 81c:	f822                	sd	s0,48(sp)
 81e:	f426                	sd	s1,40(sp)
 820:	f04a                	sd	s2,32(sp)
 822:	ec4e                	sd	s3,24(sp)
 824:	0080                	addi	s0,sp,64
 826:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 828:	c299                	beqz	a3,82e <printint+0x16>
 82a:	0805c963          	bltz	a1,8bc <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 82e:	2581                	sext.w	a1,a1
  neg = 0;
 830:	4881                	li	a7,0
 832:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 836:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 838:	2601                	sext.w	a2,a2
 83a:	00000517          	auipc	a0,0x0
 83e:	55e50513          	addi	a0,a0,1374 # d98 <digits>
 842:	883a                	mv	a6,a4
 844:	2705                	addiw	a4,a4,1
 846:	02c5f7bb          	remuw	a5,a1,a2
 84a:	1782                	slli	a5,a5,0x20
 84c:	9381                	srli	a5,a5,0x20
 84e:	97aa                	add	a5,a5,a0
 850:	0007c783          	lbu	a5,0(a5)
 854:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 858:	0005879b          	sext.w	a5,a1
 85c:	02c5d5bb          	divuw	a1,a1,a2
 860:	0685                	addi	a3,a3,1
 862:	fec7f0e3          	bgeu	a5,a2,842 <printint+0x2a>
  if(neg)
 866:	00088c63          	beqz	a7,87e <printint+0x66>
    buf[i++] = '-';
 86a:	fd070793          	addi	a5,a4,-48
 86e:	00878733          	add	a4,a5,s0
 872:	02d00793          	li	a5,45
 876:	fef70823          	sb	a5,-16(a4)
 87a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 87e:	02e05863          	blez	a4,8ae <printint+0x96>
 882:	fc040793          	addi	a5,s0,-64
 886:	00e78933          	add	s2,a5,a4
 88a:	fff78993          	addi	s3,a5,-1
 88e:	99ba                	add	s3,s3,a4
 890:	377d                	addiw	a4,a4,-1
 892:	1702                	slli	a4,a4,0x20
 894:	9301                	srli	a4,a4,0x20
 896:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 89a:	fff94583          	lbu	a1,-1(s2)
 89e:	8526                	mv	a0,s1
 8a0:	00000097          	auipc	ra,0x0
 8a4:	f56080e7          	jalr	-170(ra) # 7f6 <putc>
  while(--i >= 0)
 8a8:	197d                	addi	s2,s2,-1
 8aa:	ff3918e3          	bne	s2,s3,89a <printint+0x82>
}
 8ae:	70e2                	ld	ra,56(sp)
 8b0:	7442                	ld	s0,48(sp)
 8b2:	74a2                	ld	s1,40(sp)
 8b4:	7902                	ld	s2,32(sp)
 8b6:	69e2                	ld	s3,24(sp)
 8b8:	6121                	addi	sp,sp,64
 8ba:	8082                	ret
    x = -xx;
 8bc:	40b005bb          	negw	a1,a1
    neg = 1;
 8c0:	4885                	li	a7,1
    x = -xx;
 8c2:	bf85                	j	832 <printint+0x1a>

00000000000008c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8c4:	715d                	addi	sp,sp,-80
 8c6:	e486                	sd	ra,72(sp)
 8c8:	e0a2                	sd	s0,64(sp)
 8ca:	fc26                	sd	s1,56(sp)
 8cc:	f84a                	sd	s2,48(sp)
 8ce:	f44e                	sd	s3,40(sp)
 8d0:	f052                	sd	s4,32(sp)
 8d2:	ec56                	sd	s5,24(sp)
 8d4:	e85a                	sd	s6,16(sp)
 8d6:	e45e                	sd	s7,8(sp)
 8d8:	e062                	sd	s8,0(sp)
 8da:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8dc:	0005c903          	lbu	s2,0(a1)
 8e0:	18090c63          	beqz	s2,a78 <vprintf+0x1b4>
 8e4:	8aaa                	mv	s5,a0
 8e6:	8bb2                	mv	s7,a2
 8e8:	00158493          	addi	s1,a1,1
  state = 0;
 8ec:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8ee:	02500a13          	li	s4,37
 8f2:	4b55                	li	s6,21
 8f4:	a839                	j	912 <vprintf+0x4e>
        putc(fd, c);
 8f6:	85ca                	mv	a1,s2
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	efc080e7          	jalr	-260(ra) # 7f6 <putc>
 902:	a019                	j	908 <vprintf+0x44>
    } else if(state == '%'){
 904:	01498d63          	beq	s3,s4,91e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 908:	0485                	addi	s1,s1,1
 90a:	fff4c903          	lbu	s2,-1(s1)
 90e:	16090563          	beqz	s2,a78 <vprintf+0x1b4>
    if(state == 0){
 912:	fe0999e3          	bnez	s3,904 <vprintf+0x40>
      if(c == '%'){
 916:	ff4910e3          	bne	s2,s4,8f6 <vprintf+0x32>
        state = '%';
 91a:	89d2                	mv	s3,s4
 91c:	b7f5                	j	908 <vprintf+0x44>
      if(c == 'd'){
 91e:	13490263          	beq	s2,s4,a42 <vprintf+0x17e>
 922:	f9d9079b          	addiw	a5,s2,-99
 926:	0ff7f793          	zext.b	a5,a5
 92a:	12fb6563          	bltu	s6,a5,a54 <vprintf+0x190>
 92e:	f9d9079b          	addiw	a5,s2,-99
 932:	0ff7f713          	zext.b	a4,a5
 936:	10eb6f63          	bltu	s6,a4,a54 <vprintf+0x190>
 93a:	00271793          	slli	a5,a4,0x2
 93e:	00000717          	auipc	a4,0x0
 942:	40270713          	addi	a4,a4,1026 # d40 <malloc+0x1ca>
 946:	97ba                	add	a5,a5,a4
 948:	439c                	lw	a5,0(a5)
 94a:	97ba                	add	a5,a5,a4
 94c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 94e:	008b8913          	addi	s2,s7,8
 952:	4685                	li	a3,1
 954:	4629                	li	a2,10
 956:	000ba583          	lw	a1,0(s7)
 95a:	8556                	mv	a0,s5
 95c:	00000097          	auipc	ra,0x0
 960:	ebc080e7          	jalr	-324(ra) # 818 <printint>
 964:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 966:	4981                	li	s3,0
 968:	b745                	j	908 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 96a:	008b8913          	addi	s2,s7,8
 96e:	4681                	li	a3,0
 970:	4629                	li	a2,10
 972:	000ba583          	lw	a1,0(s7)
 976:	8556                	mv	a0,s5
 978:	00000097          	auipc	ra,0x0
 97c:	ea0080e7          	jalr	-352(ra) # 818 <printint>
 980:	8bca                	mv	s7,s2
      state = 0;
 982:	4981                	li	s3,0
 984:	b751                	j	908 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 986:	008b8913          	addi	s2,s7,8
 98a:	4681                	li	a3,0
 98c:	4641                	li	a2,16
 98e:	000ba583          	lw	a1,0(s7)
 992:	8556                	mv	a0,s5
 994:	00000097          	auipc	ra,0x0
 998:	e84080e7          	jalr	-380(ra) # 818 <printint>
 99c:	8bca                	mv	s7,s2
      state = 0;
 99e:	4981                	li	s3,0
 9a0:	b7a5                	j	908 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9a2:	008b8c13          	addi	s8,s7,8
 9a6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9aa:	03000593          	li	a1,48
 9ae:	8556                	mv	a0,s5
 9b0:	00000097          	auipc	ra,0x0
 9b4:	e46080e7          	jalr	-442(ra) # 7f6 <putc>
  putc(fd, 'x');
 9b8:	07800593          	li	a1,120
 9bc:	8556                	mv	a0,s5
 9be:	00000097          	auipc	ra,0x0
 9c2:	e38080e7          	jalr	-456(ra) # 7f6 <putc>
 9c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9c8:	00000b97          	auipc	s7,0x0
 9cc:	3d0b8b93          	addi	s7,s7,976 # d98 <digits>
 9d0:	03c9d793          	srli	a5,s3,0x3c
 9d4:	97de                	add	a5,a5,s7
 9d6:	0007c583          	lbu	a1,0(a5)
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	e1a080e7          	jalr	-486(ra) # 7f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9e4:	0992                	slli	s3,s3,0x4
 9e6:	397d                	addiw	s2,s2,-1
 9e8:	fe0914e3          	bnez	s2,9d0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9ec:	8be2                	mv	s7,s8
      state = 0;
 9ee:	4981                	li	s3,0
 9f0:	bf21                	j	908 <vprintf+0x44>
        s = va_arg(ap, char*);
 9f2:	008b8993          	addi	s3,s7,8
 9f6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9fa:	02090163          	beqz	s2,a1c <vprintf+0x158>
        while(*s != 0){
 9fe:	00094583          	lbu	a1,0(s2)
 a02:	c9a5                	beqz	a1,a72 <vprintf+0x1ae>
          putc(fd, *s);
 a04:	8556                	mv	a0,s5
 a06:	00000097          	auipc	ra,0x0
 a0a:	df0080e7          	jalr	-528(ra) # 7f6 <putc>
          s++;
 a0e:	0905                	addi	s2,s2,1
        while(*s != 0){
 a10:	00094583          	lbu	a1,0(s2)
 a14:	f9e5                	bnez	a1,a04 <vprintf+0x140>
        s = va_arg(ap, char*);
 a16:	8bce                	mv	s7,s3
      state = 0;
 a18:	4981                	li	s3,0
 a1a:	b5fd                	j	908 <vprintf+0x44>
          s = "(null)";
 a1c:	00000917          	auipc	s2,0x0
 a20:	31c90913          	addi	s2,s2,796 # d38 <malloc+0x1c2>
        while(*s != 0){
 a24:	02800593          	li	a1,40
 a28:	bff1                	j	a04 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a2a:	008b8913          	addi	s2,s7,8
 a2e:	000bc583          	lbu	a1,0(s7)
 a32:	8556                	mv	a0,s5
 a34:	00000097          	auipc	ra,0x0
 a38:	dc2080e7          	jalr	-574(ra) # 7f6 <putc>
 a3c:	8bca                	mv	s7,s2
      state = 0;
 a3e:	4981                	li	s3,0
 a40:	b5e1                	j	908 <vprintf+0x44>
        putc(fd, c);
 a42:	02500593          	li	a1,37
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	dae080e7          	jalr	-594(ra) # 7f6 <putc>
      state = 0;
 a50:	4981                	li	s3,0
 a52:	bd5d                	j	908 <vprintf+0x44>
        putc(fd, '%');
 a54:	02500593          	li	a1,37
 a58:	8556                	mv	a0,s5
 a5a:	00000097          	auipc	ra,0x0
 a5e:	d9c080e7          	jalr	-612(ra) # 7f6 <putc>
        putc(fd, c);
 a62:	85ca                	mv	a1,s2
 a64:	8556                	mv	a0,s5
 a66:	00000097          	auipc	ra,0x0
 a6a:	d90080e7          	jalr	-624(ra) # 7f6 <putc>
      state = 0;
 a6e:	4981                	li	s3,0
 a70:	bd61                	j	908 <vprintf+0x44>
        s = va_arg(ap, char*);
 a72:	8bce                	mv	s7,s3
      state = 0;
 a74:	4981                	li	s3,0
 a76:	bd49                	j	908 <vprintf+0x44>
    }
  }
}
 a78:	60a6                	ld	ra,72(sp)
 a7a:	6406                	ld	s0,64(sp)
 a7c:	74e2                	ld	s1,56(sp)
 a7e:	7942                	ld	s2,48(sp)
 a80:	79a2                	ld	s3,40(sp)
 a82:	7a02                	ld	s4,32(sp)
 a84:	6ae2                	ld	s5,24(sp)
 a86:	6b42                	ld	s6,16(sp)
 a88:	6ba2                	ld	s7,8(sp)
 a8a:	6c02                	ld	s8,0(sp)
 a8c:	6161                	addi	sp,sp,80
 a8e:	8082                	ret

0000000000000a90 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a90:	715d                	addi	sp,sp,-80
 a92:	ec06                	sd	ra,24(sp)
 a94:	e822                	sd	s0,16(sp)
 a96:	1000                	addi	s0,sp,32
 a98:	e010                	sd	a2,0(s0)
 a9a:	e414                	sd	a3,8(s0)
 a9c:	e818                	sd	a4,16(s0)
 a9e:	ec1c                	sd	a5,24(s0)
 aa0:	03043023          	sd	a6,32(s0)
 aa4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aa8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aac:	8622                	mv	a2,s0
 aae:	00000097          	auipc	ra,0x0
 ab2:	e16080e7          	jalr	-490(ra) # 8c4 <vprintf>
}
 ab6:	60e2                	ld	ra,24(sp)
 ab8:	6442                	ld	s0,16(sp)
 aba:	6161                	addi	sp,sp,80
 abc:	8082                	ret

0000000000000abe <printf>:

void
printf(const char *fmt, ...)
{
 abe:	711d                	addi	sp,sp,-96
 ac0:	ec06                	sd	ra,24(sp)
 ac2:	e822                	sd	s0,16(sp)
 ac4:	1000                	addi	s0,sp,32
 ac6:	e40c                	sd	a1,8(s0)
 ac8:	e810                	sd	a2,16(s0)
 aca:	ec14                	sd	a3,24(s0)
 acc:	f018                	sd	a4,32(s0)
 ace:	f41c                	sd	a5,40(s0)
 ad0:	03043823          	sd	a6,48(s0)
 ad4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ad8:	00840613          	addi	a2,s0,8
 adc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ae0:	85aa                	mv	a1,a0
 ae2:	4505                	li	a0,1
 ae4:	00000097          	auipc	ra,0x0
 ae8:	de0080e7          	jalr	-544(ra) # 8c4 <vprintf>
}
 aec:	60e2                	ld	ra,24(sp)
 aee:	6442                	ld	s0,16(sp)
 af0:	6125                	addi	sp,sp,96
 af2:	8082                	ret

0000000000000af4 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 af4:	1141                	addi	sp,sp,-16
 af6:	e422                	sd	s0,8(sp)
 af8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 afa:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 afe:	00000797          	auipc	a5,0x0
 b02:	51a7b783          	ld	a5,1306(a5) # 1018 <freep>
 b06:	a02d                	j	b30 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b08:	4618                	lw	a4,8(a2)
 b0a:	9f2d                	addw	a4,a4,a1
 b0c:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b10:	6398                	ld	a4,0(a5)
 b12:	6310                	ld	a2,0(a4)
 b14:	a83d                	j	b52 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b16:	ff852703          	lw	a4,-8(a0)
 b1a:	9f31                	addw	a4,a4,a2
 b1c:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b1e:	ff053683          	ld	a3,-16(a0)
 b22:	a091                	j	b66 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b24:	6398                	ld	a4,0(a5)
 b26:	00e7e463          	bltu	a5,a4,b2e <free+0x3a>
 b2a:	00e6ea63          	bltu	a3,a4,b3e <free+0x4a>
{
 b2e:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b30:	fed7fae3          	bgeu	a5,a3,b24 <free+0x30>
 b34:	6398                	ld	a4,0(a5)
 b36:	00e6e463          	bltu	a3,a4,b3e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b3a:	fee7eae3          	bltu	a5,a4,b2e <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b3e:	ff852583          	lw	a1,-8(a0)
 b42:	6390                	ld	a2,0(a5)
 b44:	02059813          	slli	a6,a1,0x20
 b48:	01c85713          	srli	a4,a6,0x1c
 b4c:	9736                	add	a4,a4,a3
 b4e:	fae60de3          	beq	a2,a4,b08 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b52:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b56:	4790                	lw	a2,8(a5)
 b58:	02061593          	slli	a1,a2,0x20
 b5c:	01c5d713          	srli	a4,a1,0x1c
 b60:	973e                	add	a4,a4,a5
 b62:	fae68ae3          	beq	a3,a4,b16 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b66:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b68:	00000717          	auipc	a4,0x0
 b6c:	4af73823          	sd	a5,1200(a4) # 1018 <freep>
}
 b70:	6422                	ld	s0,8(sp)
 b72:	0141                	addi	sp,sp,16
 b74:	8082                	ret

0000000000000b76 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b76:	7139                	addi	sp,sp,-64
 b78:	fc06                	sd	ra,56(sp)
 b7a:	f822                	sd	s0,48(sp)
 b7c:	f426                	sd	s1,40(sp)
 b7e:	f04a                	sd	s2,32(sp)
 b80:	ec4e                	sd	s3,24(sp)
 b82:	e852                	sd	s4,16(sp)
 b84:	e456                	sd	s5,8(sp)
 b86:	e05a                	sd	s6,0(sp)
 b88:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b8a:	02051493          	slli	s1,a0,0x20
 b8e:	9081                	srli	s1,s1,0x20
 b90:	04bd                	addi	s1,s1,15
 b92:	8091                	srli	s1,s1,0x4
 b94:	0014899b          	addiw	s3,s1,1
 b98:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b9a:	00000517          	auipc	a0,0x0
 b9e:	47e53503          	ld	a0,1150(a0) # 1018 <freep>
 ba2:	c515                	beqz	a0,bce <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ba4:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 ba6:	4798                	lw	a4,8(a5)
 ba8:	02977f63          	bgeu	a4,s1,be6 <malloc+0x70>
    if (nu < 4096)
 bac:	8a4e                	mv	s4,s3
 bae:	0009871b          	sext.w	a4,s3
 bb2:	6685                	lui	a3,0x1
 bb4:	00d77363          	bgeu	a4,a3,bba <malloc+0x44>
 bb8:	6a05                	lui	s4,0x1
 bba:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 bbe:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 bc2:	00000917          	auipc	s2,0x0
 bc6:	45690913          	addi	s2,s2,1110 # 1018 <freep>
    if (p == (char *)-1)
 bca:	5afd                	li	s5,-1
 bcc:	a895                	j	c40 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bce:	00000797          	auipc	a5,0x0
 bd2:	4d278793          	addi	a5,a5,1234 # 10a0 <base>
 bd6:	00000717          	auipc	a4,0x0
 bda:	44f73123          	sd	a5,1090(a4) # 1018 <freep>
 bde:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 be0:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 be4:	b7e1                	j	bac <malloc+0x36>
            if (p->s.size == nunits)
 be6:	02e48c63          	beq	s1,a4,c1e <malloc+0xa8>
                p->s.size -= nunits;
 bea:	4137073b          	subw	a4,a4,s3
 bee:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bf0:	02071693          	slli	a3,a4,0x20
 bf4:	01c6d713          	srli	a4,a3,0x1c
 bf8:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bfa:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bfe:	00000717          	auipc	a4,0x0
 c02:	40a73d23          	sd	a0,1050(a4) # 1018 <freep>
            return (void *)(p + 1);
 c06:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c0a:	70e2                	ld	ra,56(sp)
 c0c:	7442                	ld	s0,48(sp)
 c0e:	74a2                	ld	s1,40(sp)
 c10:	7902                	ld	s2,32(sp)
 c12:	69e2                	ld	s3,24(sp)
 c14:	6a42                	ld	s4,16(sp)
 c16:	6aa2                	ld	s5,8(sp)
 c18:	6b02                	ld	s6,0(sp)
 c1a:	6121                	addi	sp,sp,64
 c1c:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c1e:	6398                	ld	a4,0(a5)
 c20:	e118                	sd	a4,0(a0)
 c22:	bff1                	j	bfe <malloc+0x88>
    hp->s.size = nu;
 c24:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c28:	0541                	addi	a0,a0,16
 c2a:	00000097          	auipc	ra,0x0
 c2e:	eca080e7          	jalr	-310(ra) # af4 <free>
    return freep;
 c32:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c36:	d971                	beqz	a0,c0a <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c38:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c3a:	4798                	lw	a4,8(a5)
 c3c:	fa9775e3          	bgeu	a4,s1,be6 <malloc+0x70>
        if (p == freep)
 c40:	00093703          	ld	a4,0(s2)
 c44:	853e                	mv	a0,a5
 c46:	fef719e3          	bne	a4,a5,c38 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c4a:	8552                	mv	a0,s4
 c4c:	00000097          	auipc	ra,0x0
 c50:	b7a080e7          	jalr	-1158(ra) # 7c6 <sbrk>
    if (p == (char *)-1)
 c54:	fd5518e3          	bne	a0,s5,c24 <malloc+0xae>
                return 0;
 c58:	4501                	li	a0,0
 c5a:	bf45                	j	c0a <malloc+0x94>
