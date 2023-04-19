
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
   c:	6a4080e7          	jalr	1700(ra) # 6ac <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	69e080e7          	jalr	1694(ra) # 6b4 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	724080e7          	jalr	1828(ra) # 744 <sleep>
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
  5e:	340080e7          	jalr	832(ra) # 39a <twhoami>
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
  aa:	b3a50513          	addi	a0,a0,-1222 # be0 <malloc+0xf4>
  ae:	00001097          	auipc	ra,0x1
  b2:	986080e7          	jalr	-1658(ra) # a34 <printf>
        exit(-1);
  b6:	557d                	li	a0,-1
  b8:	00000097          	auipc	ra,0x0
  bc:	5fc080e7          	jalr	1532(ra) # 6b4 <exit>
    {
        // give up the cpu for other threads
        tyield();
  c0:	00000097          	auipc	ra,0x0
  c4:	258080e7          	jalr	600(ra) # 318 <tyield>
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
  de:	2c0080e7          	jalr	704(ra) # 39a <twhoami>
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
 122:	1fa080e7          	jalr	506(ra) # 318 <tyield>
}
 126:	60e2                	ld	ra,24(sp)
 128:	6442                	ld	s0,16(sp)
 12a:	64a2                	ld	s1,8(sp)
 12c:	6105                	addi	sp,sp,32
 12e:	8082                	ret
        printf("releasing lock we are not holding");
 130:	00001517          	auipc	a0,0x1
 134:	ad850513          	addi	a0,a0,-1320 # c08 <malloc+0x11c>
 138:	00001097          	auipc	ra,0x1
 13c:	8fc080e7          	jalr	-1796(ra) # a34 <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	572080e7          	jalr	1394(ra) # 6b4 <exit>

000000000000014a <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 14a:	1141                	addi	sp,sp,-16
 14c:	e406                	sd	ra,8(sp)
 14e:	e022                	sd	s0,0(sp)
 150:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 152:	09800513          	li	a0,152
 156:	00001097          	auipc	ra,0x1
 15a:	996080e7          	jalr	-1642(ra) # aec <malloc>

    main_thread->tid = next_tid;
 15e:	00001797          	auipc	a5,0x1
 162:	ea278793          	addi	a5,a5,-350 # 1000 <next_tid>
 166:	4398                	lw	a4,0(a5)
 168:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 16c:	4398                	lw	a4,0(a5)
 16e:	2705                	addiw	a4,a4,1
 170:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 172:	4791                	li	a5,4
 174:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 176:	00001797          	auipc	a5,0x1
 17a:	e8a7bd23          	sd	a0,-358(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 17e:	00001797          	auipc	a5,0x1
 182:	ea278793          	addi	a5,a5,-350 # 1020 <threads>
 186:	00001717          	auipc	a4,0x1
 18a:	f1a70713          	addi	a4,a4,-230 # 10a0 <base>
        threads[i] = NULL;
 18e:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 192:	07a1                	addi	a5,a5,8
 194:	fee79de3          	bne	a5,a4,18e <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 198:	00001797          	auipc	a5,0x1
 19c:	e8a7b423          	sd	a0,-376(a5) # 1020 <threads>
}
 1a0:	60a2                	ld	ra,8(sp)
 1a2:	6402                	ld	s0,0(sp)
 1a4:	0141                	addi	sp,sp,16
 1a6:	8082                	ret

00000000000001a8 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1a8:	00001517          	auipc	a0,0x1
 1ac:	e6853503          	ld	a0,-408(a0) # 1010 <current_thread>
 1b0:	00001717          	auipc	a4,0x1
 1b4:	e7070713          	addi	a4,a4,-400 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1b8:	4781                	li	a5,0
 1ba:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1bc:	6314                	ld	a3,0(a4)
 1be:	00a68763          	beq	a3,a0,1cc <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1c2:	2785                	addiw	a5,a5,1
 1c4:	0721                	addi	a4,a4,8
 1c6:	fec79be3          	bne	a5,a2,1bc <tsched+0x14>
    int current_index = 0;
 1ca:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1cc:	0017869b          	addiw	a3,a5,1
 1d0:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1d4:	00001817          	auipc	a6,0x1
 1d8:	e4c80813          	addi	a6,a6,-436 # 1020 <threads>
 1dc:	488d                	li	a7,3
 1de:	a021                	j	1e6 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1e0:	2685                	addiw	a3,a3,1
 1e2:	04c68363          	beq	a3,a2,228 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1e6:	41f6d71b          	sraiw	a4,a3,0x1f
 1ea:	01c7571b          	srliw	a4,a4,0x1c
 1ee:	00d707bb          	addw	a5,a4,a3
 1f2:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1f4:	9f99                	subw	a5,a5,a4
 1f6:	078e                	slli	a5,a5,0x3
 1f8:	97c2                	add	a5,a5,a6
 1fa:	638c                	ld	a1,0(a5)
 1fc:	d1f5                	beqz	a1,1e0 <tsched+0x38>
 1fe:	5dbc                	lw	a5,120(a1)
 200:	ff1790e3          	bne	a5,a7,1e0 <tsched+0x38>
{
 204:	1141                	addi	sp,sp,-16
 206:	e406                	sd	ra,8(sp)
 208:	e022                	sd	s0,0(sp)
 20a:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 20c:	00001797          	auipc	a5,0x1
 210:	e0b7b223          	sd	a1,-508(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 214:	05a1                	addi	a1,a1,8
 216:	0521                	addi	a0,a0,8
 218:	00000097          	auipc	ra,0x0
 21c:	19a080e7          	jalr	410(ra) # 3b2 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 220:	60a2                	ld	ra,8(sp)
 222:	6402                	ld	s0,0(sp)
 224:	0141                	addi	sp,sp,16
 226:	8082                	ret
 228:	8082                	ret

000000000000022a <thread_wrapper>:
{
 22a:	1101                	addi	sp,sp,-32
 22c:	ec06                	sd	ra,24(sp)
 22e:	e822                	sd	s0,16(sp)
 230:	e426                	sd	s1,8(sp)
 232:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 234:	00001497          	auipc	s1,0x1
 238:	ddc48493          	addi	s1,s1,-548 # 1010 <current_thread>
 23c:	609c                	ld	a5,0(s1)
 23e:	6b9c                	ld	a5,16(a5)
    func(arg);
 240:	6398                	ld	a4,0(a5)
 242:	6788                	ld	a0,8(a5)
 244:	9702                	jalr	a4
    current_thread->state = EXITED;
 246:	609c                	ld	a5,0(s1)
 248:	4719                	li	a4,6
 24a:	dfb8                	sw	a4,120(a5)
    tsched();
 24c:	00000097          	auipc	ra,0x0
 250:	f5c080e7          	jalr	-164(ra) # 1a8 <tsched>
}
 254:	60e2                	ld	ra,24(sp)
 256:	6442                	ld	s0,16(sp)
 258:	64a2                	ld	s1,8(sp)
 25a:	6105                	addi	sp,sp,32
 25c:	8082                	ret

000000000000025e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 25e:	7179                	addi	sp,sp,-48
 260:	f406                	sd	ra,40(sp)
 262:	f022                	sd	s0,32(sp)
 264:	ec26                	sd	s1,24(sp)
 266:	e84a                	sd	s2,16(sp)
 268:	e44e                	sd	s3,8(sp)
 26a:	1800                	addi	s0,sp,48
 26c:	84aa                	mv	s1,a0
 26e:	8932                	mv	s2,a2
 270:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 272:	09800513          	li	a0,152
 276:	00001097          	auipc	ra,0x1
 27a:	876080e7          	jalr	-1930(ra) # aec <malloc>
 27e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 280:	478d                	li	a5,3
 282:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 284:	609c                	ld	a5,0(s1)
 286:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 28a:	609c                	ld	a5,0(s1)
 28c:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 290:	6098                	ld	a4,0(s1)
 292:	00001797          	auipc	a5,0x1
 296:	d6e78793          	addi	a5,a5,-658 # 1000 <next_tid>
 29a:	4394                	lw	a3,0(a5)
 29c:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2a0:	4398                	lw	a4,0(a5)
 2a2:	2705                	addiw	a4,a4,1
 2a4:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 2a6:	6505                	lui	a0,0x1
 2a8:	00001097          	auipc	ra,0x1
 2ac:	844080e7          	jalr	-1980(ra) # aec <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 2b0:	6785                	lui	a5,0x1
 2b2:	00a78733          	add	a4,a5,a0
 2b6:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 2ba:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x360>
 2bc:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 2be:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 2c2:	609c                	ld	a5,0(s1)
 2c4:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2c6:	609c                	ld	a5,0(s1)
 2c8:	00000717          	auipc	a4,0x0
 2cc:	f6270713          	addi	a4,a4,-158 # 22a <thread_wrapper>
 2d0:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 2d2:	00001717          	auipc	a4,0x1
 2d6:	d4e70713          	addi	a4,a4,-690 # 1020 <threads>
 2da:	4781                	li	a5,0
 2dc:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2de:	6314                	ld	a3,0(a4)
 2e0:	c29d                	beqz	a3,306 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 2e2:	2785                	addiw	a5,a5,1
 2e4:	0721                	addi	a4,a4,8
 2e6:	fec79ce3          	bne	a5,a2,2de <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 2ea:	6088                	ld	a0,0(s1)
 2ec:	00000097          	auipc	ra,0x0
 2f0:	77e080e7          	jalr	1918(ra) # a6a <free>
        *thread = NULL;
 2f4:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 2f8:	70a2                	ld	ra,40(sp)
 2fa:	7402                	ld	s0,32(sp)
 2fc:	64e2                	ld	s1,24(sp)
 2fe:	6942                	ld	s2,16(sp)
 300:	69a2                	ld	s3,8(sp)
 302:	6145                	addi	sp,sp,48
 304:	8082                	ret
            threads[i] = *thread;
 306:	6094                	ld	a3,0(s1)
 308:	078e                	slli	a5,a5,0x3
 30a:	00001717          	auipc	a4,0x1
 30e:	d1670713          	addi	a4,a4,-746 # 1020 <threads>
 312:	97ba                	add	a5,a5,a4
 314:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 316:	b7cd                	j	2f8 <tcreate+0x9a>

0000000000000318 <tyield>:
    return 0;
}


void tyield()
{
 318:	1141                	addi	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 320:	00001797          	auipc	a5,0x1
 324:	cf07b783          	ld	a5,-784(a5) # 1010 <current_thread>
 328:	470d                	li	a4,3
 32a:	dfb8                	sw	a4,120(a5)
    tsched();
 32c:	00000097          	auipc	ra,0x0
 330:	e7c080e7          	jalr	-388(ra) # 1a8 <tsched>
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret

000000000000033c <tjoin>:
{
 33c:	1101                	addi	sp,sp,-32
 33e:	ec06                	sd	ra,24(sp)
 340:	e822                	sd	s0,16(sp)
 342:	e426                	sd	s1,8(sp)
 344:	e04a                	sd	s2,0(sp)
 346:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 348:	00001797          	auipc	a5,0x1
 34c:	cd878793          	addi	a5,a5,-808 # 1020 <threads>
 350:	00001697          	auipc	a3,0x1
 354:	d5068693          	addi	a3,a3,-688 # 10a0 <base>
 358:	a021                	j	360 <tjoin+0x24>
 35a:	07a1                	addi	a5,a5,8
 35c:	02d78b63          	beq	a5,a3,392 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 360:	6384                	ld	s1,0(a5)
 362:	dce5                	beqz	s1,35a <tjoin+0x1e>
 364:	0004c703          	lbu	a4,0(s1)
 368:	fea719e3          	bne	a4,a0,35a <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 36c:	5cb8                	lw	a4,120(s1)
 36e:	4799                	li	a5,6
 370:	4919                	li	s2,6
 372:	02f70263          	beq	a4,a5,396 <tjoin+0x5a>
        tyield();
 376:	00000097          	auipc	ra,0x0
 37a:	fa2080e7          	jalr	-94(ra) # 318 <tyield>
    while (target_thread->state != EXITED) {
 37e:	5cbc                	lw	a5,120(s1)
 380:	ff279be3          	bne	a5,s2,376 <tjoin+0x3a>
    return 0;
 384:	4501                	li	a0,0
}
 386:	60e2                	ld	ra,24(sp)
 388:	6442                	ld	s0,16(sp)
 38a:	64a2                	ld	s1,8(sp)
 38c:	6902                	ld	s2,0(sp)
 38e:	6105                	addi	sp,sp,32
 390:	8082                	ret
        return -1;
 392:	557d                	li	a0,-1
 394:	bfcd                	j	386 <tjoin+0x4a>
    return 0;
 396:	4501                	li	a0,0
 398:	b7fd                	j	386 <tjoin+0x4a>

000000000000039a <twhoami>:

uint8 twhoami()
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3a0:	00001797          	auipc	a5,0x1
 3a4:	c707b783          	ld	a5,-912(a5) # 1010 <current_thread>
 3a8:	0007c503          	lbu	a0,0(a5)
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	addi	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <tswtch>:
 3b2:	00153023          	sd	ra,0(a0)
 3b6:	00253423          	sd	sp,8(a0)
 3ba:	e900                	sd	s0,16(a0)
 3bc:	ed04                	sd	s1,24(a0)
 3be:	03253023          	sd	s2,32(a0)
 3c2:	03353423          	sd	s3,40(a0)
 3c6:	03453823          	sd	s4,48(a0)
 3ca:	03553c23          	sd	s5,56(a0)
 3ce:	05653023          	sd	s6,64(a0)
 3d2:	05753423          	sd	s7,72(a0)
 3d6:	05853823          	sd	s8,80(a0)
 3da:	05953c23          	sd	s9,88(a0)
 3de:	07a53023          	sd	s10,96(a0)
 3e2:	07b53423          	sd	s11,104(a0)
 3e6:	0005b083          	ld	ra,0(a1)
 3ea:	0085b103          	ld	sp,8(a1)
 3ee:	6980                	ld	s0,16(a1)
 3f0:	6d84                	ld	s1,24(a1)
 3f2:	0205b903          	ld	s2,32(a1)
 3f6:	0285b983          	ld	s3,40(a1)
 3fa:	0305ba03          	ld	s4,48(a1)
 3fe:	0385ba83          	ld	s5,56(a1)
 402:	0405bb03          	ld	s6,64(a1)
 406:	0485bb83          	ld	s7,72(a1)
 40a:	0505bc03          	ld	s8,80(a1)
 40e:	0585bc83          	ld	s9,88(a1)
 412:	0605bd03          	ld	s10,96(a1)
 416:	0685bd83          	ld	s11,104(a1)
 41a:	8082                	ret

000000000000041c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 41c:	1101                	addi	sp,sp,-32
 41e:	ec06                	sd	ra,24(sp)
 420:	e822                	sd	s0,16(sp)
 422:	e426                	sd	s1,8(sp)
 424:	e04a                	sd	s2,0(sp)
 426:	1000                	addi	s0,sp,32
 428:	84aa                	mv	s1,a0
 42a:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 42c:	00000097          	auipc	ra,0x0
 430:	d1e080e7          	jalr	-738(ra) # 14a <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 434:	85ca                	mv	a1,s2
 436:	8526                	mv	a0,s1
 438:	00000097          	auipc	ra,0x0
 43c:	bc8080e7          	jalr	-1080(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 440:	00000097          	auipc	ra,0x0
 444:	274080e7          	jalr	628(ra) # 6b4 <exit>

0000000000000448 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 448:	1141                	addi	sp,sp,-16
 44a:	e422                	sd	s0,8(sp)
 44c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 44e:	87aa                	mv	a5,a0
 450:	0585                	addi	a1,a1,1
 452:	0785                	addi	a5,a5,1
 454:	fff5c703          	lbu	a4,-1(a1)
 458:	fee78fa3          	sb	a4,-1(a5)
 45c:	fb75                	bnez	a4,450 <strcpy+0x8>
        ;
    return os;
}
 45e:	6422                	ld	s0,8(sp)
 460:	0141                	addi	sp,sp,16
 462:	8082                	ret

0000000000000464 <strcmp>:

int strcmp(const char *p, const char *q)
{
 464:	1141                	addi	sp,sp,-16
 466:	e422                	sd	s0,8(sp)
 468:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 46a:	00054783          	lbu	a5,0(a0)
 46e:	cb91                	beqz	a5,482 <strcmp+0x1e>
 470:	0005c703          	lbu	a4,0(a1)
 474:	00f71763          	bne	a4,a5,482 <strcmp+0x1e>
        p++, q++;
 478:	0505                	addi	a0,a0,1
 47a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 47c:	00054783          	lbu	a5,0(a0)
 480:	fbe5                	bnez	a5,470 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 482:	0005c503          	lbu	a0,0(a1)
}
 486:	40a7853b          	subw	a0,a5,a0
 48a:	6422                	ld	s0,8(sp)
 48c:	0141                	addi	sp,sp,16
 48e:	8082                	ret

0000000000000490 <strlen>:

uint strlen(const char *s)
{
 490:	1141                	addi	sp,sp,-16
 492:	e422                	sd	s0,8(sp)
 494:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 496:	00054783          	lbu	a5,0(a0)
 49a:	cf91                	beqz	a5,4b6 <strlen+0x26>
 49c:	0505                	addi	a0,a0,1
 49e:	87aa                	mv	a5,a0
 4a0:	86be                	mv	a3,a5
 4a2:	0785                	addi	a5,a5,1
 4a4:	fff7c703          	lbu	a4,-1(a5)
 4a8:	ff65                	bnez	a4,4a0 <strlen+0x10>
 4aa:	40a6853b          	subw	a0,a3,a0
 4ae:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4b0:	6422                	ld	s0,8(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret
    for (n = 0; s[n]; n++)
 4b6:	4501                	li	a0,0
 4b8:	bfe5                	j	4b0 <strlen+0x20>

00000000000004ba <memset>:

void *
memset(void *dst, int c, uint n)
{
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e422                	sd	s0,8(sp)
 4be:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4c0:	ca19                	beqz	a2,4d6 <memset+0x1c>
 4c2:	87aa                	mv	a5,a0
 4c4:	1602                	slli	a2,a2,0x20
 4c6:	9201                	srli	a2,a2,0x20
 4c8:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4cc:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4d0:	0785                	addi	a5,a5,1
 4d2:	fee79de3          	bne	a5,a4,4cc <memset+0x12>
    }
    return dst;
}
 4d6:	6422                	ld	s0,8(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret

00000000000004dc <strchr>:

char *
strchr(const char *s, char c)
{
 4dc:	1141                	addi	sp,sp,-16
 4de:	e422                	sd	s0,8(sp)
 4e0:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4e2:	00054783          	lbu	a5,0(a0)
 4e6:	cb99                	beqz	a5,4fc <strchr+0x20>
        if (*s == c)
 4e8:	00f58763          	beq	a1,a5,4f6 <strchr+0x1a>
    for (; *s; s++)
 4ec:	0505                	addi	a0,a0,1
 4ee:	00054783          	lbu	a5,0(a0)
 4f2:	fbfd                	bnez	a5,4e8 <strchr+0xc>
            return (char *)s;
    return 0;
 4f4:	4501                	li	a0,0
}
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret
    return 0;
 4fc:	4501                	li	a0,0
 4fe:	bfe5                	j	4f6 <strchr+0x1a>

0000000000000500 <gets>:

char *
gets(char *buf, int max)
{
 500:	711d                	addi	sp,sp,-96
 502:	ec86                	sd	ra,88(sp)
 504:	e8a2                	sd	s0,80(sp)
 506:	e4a6                	sd	s1,72(sp)
 508:	e0ca                	sd	s2,64(sp)
 50a:	fc4e                	sd	s3,56(sp)
 50c:	f852                	sd	s4,48(sp)
 50e:	f456                	sd	s5,40(sp)
 510:	f05a                	sd	s6,32(sp)
 512:	ec5e                	sd	s7,24(sp)
 514:	1080                	addi	s0,sp,96
 516:	8baa                	mv	s7,a0
 518:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 51a:	892a                	mv	s2,a0
 51c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 51e:	4aa9                	li	s5,10
 520:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 522:	89a6                	mv	s3,s1
 524:	2485                	addiw	s1,s1,1
 526:	0344d863          	bge	s1,s4,556 <gets+0x56>
        cc = read(0, &c, 1);
 52a:	4605                	li	a2,1
 52c:	faf40593          	addi	a1,s0,-81
 530:	4501                	li	a0,0
 532:	00000097          	auipc	ra,0x0
 536:	19a080e7          	jalr	410(ra) # 6cc <read>
        if (cc < 1)
 53a:	00a05e63          	blez	a0,556 <gets+0x56>
        buf[i++] = c;
 53e:	faf44783          	lbu	a5,-81(s0)
 542:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 546:	01578763          	beq	a5,s5,554 <gets+0x54>
 54a:	0905                	addi	s2,s2,1
 54c:	fd679be3          	bne	a5,s6,522 <gets+0x22>
    for (i = 0; i + 1 < max;)
 550:	89a6                	mv	s3,s1
 552:	a011                	j	556 <gets+0x56>
 554:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 556:	99de                	add	s3,s3,s7
 558:	00098023          	sb	zero,0(s3)
    return buf;
}
 55c:	855e                	mv	a0,s7
 55e:	60e6                	ld	ra,88(sp)
 560:	6446                	ld	s0,80(sp)
 562:	64a6                	ld	s1,72(sp)
 564:	6906                	ld	s2,64(sp)
 566:	79e2                	ld	s3,56(sp)
 568:	7a42                	ld	s4,48(sp)
 56a:	7aa2                	ld	s5,40(sp)
 56c:	7b02                	ld	s6,32(sp)
 56e:	6be2                	ld	s7,24(sp)
 570:	6125                	addi	sp,sp,96
 572:	8082                	ret

0000000000000574 <stat>:

int stat(const char *n, struct stat *st)
{
 574:	1101                	addi	sp,sp,-32
 576:	ec06                	sd	ra,24(sp)
 578:	e822                	sd	s0,16(sp)
 57a:	e426                	sd	s1,8(sp)
 57c:	e04a                	sd	s2,0(sp)
 57e:	1000                	addi	s0,sp,32
 580:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 582:	4581                	li	a1,0
 584:	00000097          	auipc	ra,0x0
 588:	170080e7          	jalr	368(ra) # 6f4 <open>
    if (fd < 0)
 58c:	02054563          	bltz	a0,5b6 <stat+0x42>
 590:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 592:	85ca                	mv	a1,s2
 594:	00000097          	auipc	ra,0x0
 598:	178080e7          	jalr	376(ra) # 70c <fstat>
 59c:	892a                	mv	s2,a0
    close(fd);
 59e:	8526                	mv	a0,s1
 5a0:	00000097          	auipc	ra,0x0
 5a4:	13c080e7          	jalr	316(ra) # 6dc <close>
    return r;
}
 5a8:	854a                	mv	a0,s2
 5aa:	60e2                	ld	ra,24(sp)
 5ac:	6442                	ld	s0,16(sp)
 5ae:	64a2                	ld	s1,8(sp)
 5b0:	6902                	ld	s2,0(sp)
 5b2:	6105                	addi	sp,sp,32
 5b4:	8082                	ret
        return -1;
 5b6:	597d                	li	s2,-1
 5b8:	bfc5                	j	5a8 <stat+0x34>

00000000000005ba <atoi>:

int atoi(const char *s)
{
 5ba:	1141                	addi	sp,sp,-16
 5bc:	e422                	sd	s0,8(sp)
 5be:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5c0:	00054683          	lbu	a3,0(a0)
 5c4:	fd06879b          	addiw	a5,a3,-48
 5c8:	0ff7f793          	zext.b	a5,a5
 5cc:	4625                	li	a2,9
 5ce:	02f66863          	bltu	a2,a5,5fe <atoi+0x44>
 5d2:	872a                	mv	a4,a0
    n = 0;
 5d4:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5d6:	0705                	addi	a4,a4,1
 5d8:	0025179b          	slliw	a5,a0,0x2
 5dc:	9fa9                	addw	a5,a5,a0
 5de:	0017979b          	slliw	a5,a5,0x1
 5e2:	9fb5                	addw	a5,a5,a3
 5e4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5e8:	00074683          	lbu	a3,0(a4)
 5ec:	fd06879b          	addiw	a5,a3,-48
 5f0:	0ff7f793          	zext.b	a5,a5
 5f4:	fef671e3          	bgeu	a2,a5,5d6 <atoi+0x1c>
    return n;
}
 5f8:	6422                	ld	s0,8(sp)
 5fa:	0141                	addi	sp,sp,16
 5fc:	8082                	ret
    n = 0;
 5fe:	4501                	li	a0,0
 600:	bfe5                	j	5f8 <atoi+0x3e>

0000000000000602 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 602:	1141                	addi	sp,sp,-16
 604:	e422                	sd	s0,8(sp)
 606:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 608:	02b57463          	bgeu	a0,a1,630 <memmove+0x2e>
    {
        while (n-- > 0)
 60c:	00c05f63          	blez	a2,62a <memmove+0x28>
 610:	1602                	slli	a2,a2,0x20
 612:	9201                	srli	a2,a2,0x20
 614:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 618:	872a                	mv	a4,a0
            *dst++ = *src++;
 61a:	0585                	addi	a1,a1,1
 61c:	0705                	addi	a4,a4,1
 61e:	fff5c683          	lbu	a3,-1(a1)
 622:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 626:	fee79ae3          	bne	a5,a4,61a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 62a:	6422                	ld	s0,8(sp)
 62c:	0141                	addi	sp,sp,16
 62e:	8082                	ret
        dst += n;
 630:	00c50733          	add	a4,a0,a2
        src += n;
 634:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 636:	fec05ae3          	blez	a2,62a <memmove+0x28>
 63a:	fff6079b          	addiw	a5,a2,-1
 63e:	1782                	slli	a5,a5,0x20
 640:	9381                	srli	a5,a5,0x20
 642:	fff7c793          	not	a5,a5
 646:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 648:	15fd                	addi	a1,a1,-1
 64a:	177d                	addi	a4,a4,-1
 64c:	0005c683          	lbu	a3,0(a1)
 650:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 654:	fee79ae3          	bne	a5,a4,648 <memmove+0x46>
 658:	bfc9                	j	62a <memmove+0x28>

000000000000065a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 65a:	1141                	addi	sp,sp,-16
 65c:	e422                	sd	s0,8(sp)
 65e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 660:	ca05                	beqz	a2,690 <memcmp+0x36>
 662:	fff6069b          	addiw	a3,a2,-1
 666:	1682                	slli	a3,a3,0x20
 668:	9281                	srli	a3,a3,0x20
 66a:	0685                	addi	a3,a3,1
 66c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 66e:	00054783          	lbu	a5,0(a0)
 672:	0005c703          	lbu	a4,0(a1)
 676:	00e79863          	bne	a5,a4,686 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 67a:	0505                	addi	a0,a0,1
        p2++;
 67c:	0585                	addi	a1,a1,1
    while (n-- > 0)
 67e:	fed518e3          	bne	a0,a3,66e <memcmp+0x14>
    }
    return 0;
 682:	4501                	li	a0,0
 684:	a019                	j	68a <memcmp+0x30>
            return *p1 - *p2;
 686:	40e7853b          	subw	a0,a5,a4
}
 68a:	6422                	ld	s0,8(sp)
 68c:	0141                	addi	sp,sp,16
 68e:	8082                	ret
    return 0;
 690:	4501                	li	a0,0
 692:	bfe5                	j	68a <memcmp+0x30>

0000000000000694 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 694:	1141                	addi	sp,sp,-16
 696:	e406                	sd	ra,8(sp)
 698:	e022                	sd	s0,0(sp)
 69a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 69c:	00000097          	auipc	ra,0x0
 6a0:	f66080e7          	jalr	-154(ra) # 602 <memmove>
}
 6a4:	60a2                	ld	ra,8(sp)
 6a6:	6402                	ld	s0,0(sp)
 6a8:	0141                	addi	sp,sp,16
 6aa:	8082                	ret

00000000000006ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6ac:	4885                	li	a7,1
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6b4:	4889                	li	a7,2
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 6bc:	488d                	li	a7,3
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6c4:	4891                	li	a7,4
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <read>:
.global read
read:
 li a7, SYS_read
 6cc:	4895                	li	a7,5
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <write>:
.global write
write:
 li a7, SYS_write
 6d4:	48c1                	li	a7,16
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <close>:
.global close
close:
 li a7, SYS_close
 6dc:	48d5                	li	a7,21
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6e4:	4899                	li	a7,6
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 6ec:	489d                	li	a7,7
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <open>:
.global open
open:
 li a7, SYS_open
 6f4:	48bd                	li	a7,15
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6fc:	48c5                	li	a7,17
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 704:	48c9                	li	a7,18
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 70c:	48a1                	li	a7,8
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <link>:
.global link
link:
 li a7, SYS_link
 714:	48cd                	li	a7,19
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 71c:	48d1                	li	a7,20
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 724:	48a5                	li	a7,9
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <dup>:
.global dup
dup:
 li a7, SYS_dup
 72c:	48a9                	li	a7,10
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 734:	48ad                	li	a7,11
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 73c:	48b1                	li	a7,12
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 744:	48b5                	li	a7,13
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 74c:	48b9                	li	a7,14
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <ps>:
.global ps
ps:
 li a7, SYS_ps
 754:	48d9                	li	a7,22
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 75c:	48dd                	li	a7,23
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 764:	48e1                	li	a7,24
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 76c:	1101                	addi	sp,sp,-32
 76e:	ec06                	sd	ra,24(sp)
 770:	e822                	sd	s0,16(sp)
 772:	1000                	addi	s0,sp,32
 774:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 778:	4605                	li	a2,1
 77a:	fef40593          	addi	a1,s0,-17
 77e:	00000097          	auipc	ra,0x0
 782:	f56080e7          	jalr	-170(ra) # 6d4 <write>
}
 786:	60e2                	ld	ra,24(sp)
 788:	6442                	ld	s0,16(sp)
 78a:	6105                	addi	sp,sp,32
 78c:	8082                	ret

000000000000078e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 78e:	7139                	addi	sp,sp,-64
 790:	fc06                	sd	ra,56(sp)
 792:	f822                	sd	s0,48(sp)
 794:	f426                	sd	s1,40(sp)
 796:	f04a                	sd	s2,32(sp)
 798:	ec4e                	sd	s3,24(sp)
 79a:	0080                	addi	s0,sp,64
 79c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 79e:	c299                	beqz	a3,7a4 <printint+0x16>
 7a0:	0805c963          	bltz	a1,832 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7a4:	2581                	sext.w	a1,a1
  neg = 0;
 7a6:	4881                	li	a7,0
 7a8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7ac:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7ae:	2601                	sext.w	a2,a2
 7b0:	00000517          	auipc	a0,0x0
 7b4:	4e050513          	addi	a0,a0,1248 # c90 <digits>
 7b8:	883a                	mv	a6,a4
 7ba:	2705                	addiw	a4,a4,1
 7bc:	02c5f7bb          	remuw	a5,a1,a2
 7c0:	1782                	slli	a5,a5,0x20
 7c2:	9381                	srli	a5,a5,0x20
 7c4:	97aa                	add	a5,a5,a0
 7c6:	0007c783          	lbu	a5,0(a5)
 7ca:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7ce:	0005879b          	sext.w	a5,a1
 7d2:	02c5d5bb          	divuw	a1,a1,a2
 7d6:	0685                	addi	a3,a3,1
 7d8:	fec7f0e3          	bgeu	a5,a2,7b8 <printint+0x2a>
  if(neg)
 7dc:	00088c63          	beqz	a7,7f4 <printint+0x66>
    buf[i++] = '-';
 7e0:	fd070793          	addi	a5,a4,-48
 7e4:	00878733          	add	a4,a5,s0
 7e8:	02d00793          	li	a5,45
 7ec:	fef70823          	sb	a5,-16(a4)
 7f0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7f4:	02e05863          	blez	a4,824 <printint+0x96>
 7f8:	fc040793          	addi	a5,s0,-64
 7fc:	00e78933          	add	s2,a5,a4
 800:	fff78993          	addi	s3,a5,-1
 804:	99ba                	add	s3,s3,a4
 806:	377d                	addiw	a4,a4,-1
 808:	1702                	slli	a4,a4,0x20
 80a:	9301                	srli	a4,a4,0x20
 80c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 810:	fff94583          	lbu	a1,-1(s2)
 814:	8526                	mv	a0,s1
 816:	00000097          	auipc	ra,0x0
 81a:	f56080e7          	jalr	-170(ra) # 76c <putc>
  while(--i >= 0)
 81e:	197d                	addi	s2,s2,-1
 820:	ff3918e3          	bne	s2,s3,810 <printint+0x82>
}
 824:	70e2                	ld	ra,56(sp)
 826:	7442                	ld	s0,48(sp)
 828:	74a2                	ld	s1,40(sp)
 82a:	7902                	ld	s2,32(sp)
 82c:	69e2                	ld	s3,24(sp)
 82e:	6121                	addi	sp,sp,64
 830:	8082                	ret
    x = -xx;
 832:	40b005bb          	negw	a1,a1
    neg = 1;
 836:	4885                	li	a7,1
    x = -xx;
 838:	bf85                	j	7a8 <printint+0x1a>

000000000000083a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 83a:	715d                	addi	sp,sp,-80
 83c:	e486                	sd	ra,72(sp)
 83e:	e0a2                	sd	s0,64(sp)
 840:	fc26                	sd	s1,56(sp)
 842:	f84a                	sd	s2,48(sp)
 844:	f44e                	sd	s3,40(sp)
 846:	f052                	sd	s4,32(sp)
 848:	ec56                	sd	s5,24(sp)
 84a:	e85a                	sd	s6,16(sp)
 84c:	e45e                	sd	s7,8(sp)
 84e:	e062                	sd	s8,0(sp)
 850:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 852:	0005c903          	lbu	s2,0(a1)
 856:	18090c63          	beqz	s2,9ee <vprintf+0x1b4>
 85a:	8aaa                	mv	s5,a0
 85c:	8bb2                	mv	s7,a2
 85e:	00158493          	addi	s1,a1,1
  state = 0;
 862:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 864:	02500a13          	li	s4,37
 868:	4b55                	li	s6,21
 86a:	a839                	j	888 <vprintf+0x4e>
        putc(fd, c);
 86c:	85ca                	mv	a1,s2
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	efc080e7          	jalr	-260(ra) # 76c <putc>
 878:	a019                	j	87e <vprintf+0x44>
    } else if(state == '%'){
 87a:	01498d63          	beq	s3,s4,894 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 87e:	0485                	addi	s1,s1,1
 880:	fff4c903          	lbu	s2,-1(s1)
 884:	16090563          	beqz	s2,9ee <vprintf+0x1b4>
    if(state == 0){
 888:	fe0999e3          	bnez	s3,87a <vprintf+0x40>
      if(c == '%'){
 88c:	ff4910e3          	bne	s2,s4,86c <vprintf+0x32>
        state = '%';
 890:	89d2                	mv	s3,s4
 892:	b7f5                	j	87e <vprintf+0x44>
      if(c == 'd'){
 894:	13490263          	beq	s2,s4,9b8 <vprintf+0x17e>
 898:	f9d9079b          	addiw	a5,s2,-99
 89c:	0ff7f793          	zext.b	a5,a5
 8a0:	12fb6563          	bltu	s6,a5,9ca <vprintf+0x190>
 8a4:	f9d9079b          	addiw	a5,s2,-99
 8a8:	0ff7f713          	zext.b	a4,a5
 8ac:	10eb6f63          	bltu	s6,a4,9ca <vprintf+0x190>
 8b0:	00271793          	slli	a5,a4,0x2
 8b4:	00000717          	auipc	a4,0x0
 8b8:	38470713          	addi	a4,a4,900 # c38 <malloc+0x14c>
 8bc:	97ba                	add	a5,a5,a4
 8be:	439c                	lw	a5,0(a5)
 8c0:	97ba                	add	a5,a5,a4
 8c2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8c4:	008b8913          	addi	s2,s7,8
 8c8:	4685                	li	a3,1
 8ca:	4629                	li	a2,10
 8cc:	000ba583          	lw	a1,0(s7)
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	ebc080e7          	jalr	-324(ra) # 78e <printint>
 8da:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8dc:	4981                	li	s3,0
 8de:	b745                	j	87e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e0:	008b8913          	addi	s2,s7,8
 8e4:	4681                	li	a3,0
 8e6:	4629                	li	a2,10
 8e8:	000ba583          	lw	a1,0(s7)
 8ec:	8556                	mv	a0,s5
 8ee:	00000097          	auipc	ra,0x0
 8f2:	ea0080e7          	jalr	-352(ra) # 78e <printint>
 8f6:	8bca                	mv	s7,s2
      state = 0;
 8f8:	4981                	li	s3,0
 8fa:	b751                	j	87e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8fc:	008b8913          	addi	s2,s7,8
 900:	4681                	li	a3,0
 902:	4641                	li	a2,16
 904:	000ba583          	lw	a1,0(s7)
 908:	8556                	mv	a0,s5
 90a:	00000097          	auipc	ra,0x0
 90e:	e84080e7          	jalr	-380(ra) # 78e <printint>
 912:	8bca                	mv	s7,s2
      state = 0;
 914:	4981                	li	s3,0
 916:	b7a5                	j	87e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 918:	008b8c13          	addi	s8,s7,8
 91c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 920:	03000593          	li	a1,48
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	e46080e7          	jalr	-442(ra) # 76c <putc>
  putc(fd, 'x');
 92e:	07800593          	li	a1,120
 932:	8556                	mv	a0,s5
 934:	00000097          	auipc	ra,0x0
 938:	e38080e7          	jalr	-456(ra) # 76c <putc>
 93c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 93e:	00000b97          	auipc	s7,0x0
 942:	352b8b93          	addi	s7,s7,850 # c90 <digits>
 946:	03c9d793          	srli	a5,s3,0x3c
 94a:	97de                	add	a5,a5,s7
 94c:	0007c583          	lbu	a1,0(a5)
 950:	8556                	mv	a0,s5
 952:	00000097          	auipc	ra,0x0
 956:	e1a080e7          	jalr	-486(ra) # 76c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 95a:	0992                	slli	s3,s3,0x4
 95c:	397d                	addiw	s2,s2,-1
 95e:	fe0914e3          	bnez	s2,946 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 962:	8be2                	mv	s7,s8
      state = 0;
 964:	4981                	li	s3,0
 966:	bf21                	j	87e <vprintf+0x44>
        s = va_arg(ap, char*);
 968:	008b8993          	addi	s3,s7,8
 96c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 970:	02090163          	beqz	s2,992 <vprintf+0x158>
        while(*s != 0){
 974:	00094583          	lbu	a1,0(s2)
 978:	c9a5                	beqz	a1,9e8 <vprintf+0x1ae>
          putc(fd, *s);
 97a:	8556                	mv	a0,s5
 97c:	00000097          	auipc	ra,0x0
 980:	df0080e7          	jalr	-528(ra) # 76c <putc>
          s++;
 984:	0905                	addi	s2,s2,1
        while(*s != 0){
 986:	00094583          	lbu	a1,0(s2)
 98a:	f9e5                	bnez	a1,97a <vprintf+0x140>
        s = va_arg(ap, char*);
 98c:	8bce                	mv	s7,s3
      state = 0;
 98e:	4981                	li	s3,0
 990:	b5fd                	j	87e <vprintf+0x44>
          s = "(null)";
 992:	00000917          	auipc	s2,0x0
 996:	29e90913          	addi	s2,s2,670 # c30 <malloc+0x144>
        while(*s != 0){
 99a:	02800593          	li	a1,40
 99e:	bff1                	j	97a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9a0:	008b8913          	addi	s2,s7,8
 9a4:	000bc583          	lbu	a1,0(s7)
 9a8:	8556                	mv	a0,s5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	dc2080e7          	jalr	-574(ra) # 76c <putc>
 9b2:	8bca                	mv	s7,s2
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	b5e1                	j	87e <vprintf+0x44>
        putc(fd, c);
 9b8:	02500593          	li	a1,37
 9bc:	8556                	mv	a0,s5
 9be:	00000097          	auipc	ra,0x0
 9c2:	dae080e7          	jalr	-594(ra) # 76c <putc>
      state = 0;
 9c6:	4981                	li	s3,0
 9c8:	bd5d                	j	87e <vprintf+0x44>
        putc(fd, '%');
 9ca:	02500593          	li	a1,37
 9ce:	8556                	mv	a0,s5
 9d0:	00000097          	auipc	ra,0x0
 9d4:	d9c080e7          	jalr	-612(ra) # 76c <putc>
        putc(fd, c);
 9d8:	85ca                	mv	a1,s2
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	d90080e7          	jalr	-624(ra) # 76c <putc>
      state = 0;
 9e4:	4981                	li	s3,0
 9e6:	bd61                	j	87e <vprintf+0x44>
        s = va_arg(ap, char*);
 9e8:	8bce                	mv	s7,s3
      state = 0;
 9ea:	4981                	li	s3,0
 9ec:	bd49                	j	87e <vprintf+0x44>
    }
  }
}
 9ee:	60a6                	ld	ra,72(sp)
 9f0:	6406                	ld	s0,64(sp)
 9f2:	74e2                	ld	s1,56(sp)
 9f4:	7942                	ld	s2,48(sp)
 9f6:	79a2                	ld	s3,40(sp)
 9f8:	7a02                	ld	s4,32(sp)
 9fa:	6ae2                	ld	s5,24(sp)
 9fc:	6b42                	ld	s6,16(sp)
 9fe:	6ba2                	ld	s7,8(sp)
 a00:	6c02                	ld	s8,0(sp)
 a02:	6161                	addi	sp,sp,80
 a04:	8082                	ret

0000000000000a06 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a06:	715d                	addi	sp,sp,-80
 a08:	ec06                	sd	ra,24(sp)
 a0a:	e822                	sd	s0,16(sp)
 a0c:	1000                	addi	s0,sp,32
 a0e:	e010                	sd	a2,0(s0)
 a10:	e414                	sd	a3,8(s0)
 a12:	e818                	sd	a4,16(s0)
 a14:	ec1c                	sd	a5,24(s0)
 a16:	03043023          	sd	a6,32(s0)
 a1a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a1e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a22:	8622                	mv	a2,s0
 a24:	00000097          	auipc	ra,0x0
 a28:	e16080e7          	jalr	-490(ra) # 83a <vprintf>
}
 a2c:	60e2                	ld	ra,24(sp)
 a2e:	6442                	ld	s0,16(sp)
 a30:	6161                	addi	sp,sp,80
 a32:	8082                	ret

0000000000000a34 <printf>:

void
printf(const char *fmt, ...)
{
 a34:	711d                	addi	sp,sp,-96
 a36:	ec06                	sd	ra,24(sp)
 a38:	e822                	sd	s0,16(sp)
 a3a:	1000                	addi	s0,sp,32
 a3c:	e40c                	sd	a1,8(s0)
 a3e:	e810                	sd	a2,16(s0)
 a40:	ec14                	sd	a3,24(s0)
 a42:	f018                	sd	a4,32(s0)
 a44:	f41c                	sd	a5,40(s0)
 a46:	03043823          	sd	a6,48(s0)
 a4a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a4e:	00840613          	addi	a2,s0,8
 a52:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a56:	85aa                	mv	a1,a0
 a58:	4505                	li	a0,1
 a5a:	00000097          	auipc	ra,0x0
 a5e:	de0080e7          	jalr	-544(ra) # 83a <vprintf>
}
 a62:	60e2                	ld	ra,24(sp)
 a64:	6442                	ld	s0,16(sp)
 a66:	6125                	addi	sp,sp,96
 a68:	8082                	ret

0000000000000a6a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a6a:	1141                	addi	sp,sp,-16
 a6c:	e422                	sd	s0,8(sp)
 a6e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a70:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a74:	00000797          	auipc	a5,0x0
 a78:	5a47b783          	ld	a5,1444(a5) # 1018 <freep>
 a7c:	a02d                	j	aa6 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a7e:	4618                	lw	a4,8(a2)
 a80:	9f2d                	addw	a4,a4,a1
 a82:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a86:	6398                	ld	a4,0(a5)
 a88:	6310                	ld	a2,0(a4)
 a8a:	a83d                	j	ac8 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a8c:	ff852703          	lw	a4,-8(a0)
 a90:	9f31                	addw	a4,a4,a2
 a92:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a94:	ff053683          	ld	a3,-16(a0)
 a98:	a091                	j	adc <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a9a:	6398                	ld	a4,0(a5)
 a9c:	00e7e463          	bltu	a5,a4,aa4 <free+0x3a>
 aa0:	00e6ea63          	bltu	a3,a4,ab4 <free+0x4a>
{
 aa4:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa6:	fed7fae3          	bgeu	a5,a3,a9a <free+0x30>
 aaa:	6398                	ld	a4,0(a5)
 aac:	00e6e463          	bltu	a3,a4,ab4 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab0:	fee7eae3          	bltu	a5,a4,aa4 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ab4:	ff852583          	lw	a1,-8(a0)
 ab8:	6390                	ld	a2,0(a5)
 aba:	02059813          	slli	a6,a1,0x20
 abe:	01c85713          	srli	a4,a6,0x1c
 ac2:	9736                	add	a4,a4,a3
 ac4:	fae60de3          	beq	a2,a4,a7e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 ac8:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 acc:	4790                	lw	a2,8(a5)
 ace:	02061593          	slli	a1,a2,0x20
 ad2:	01c5d713          	srli	a4,a1,0x1c
 ad6:	973e                	add	a4,a4,a5
 ad8:	fae68ae3          	beq	a3,a4,a8c <free+0x22>
        p->s.ptr = bp->s.ptr;
 adc:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 ade:	00000717          	auipc	a4,0x0
 ae2:	52f73d23          	sd	a5,1338(a4) # 1018 <freep>
}
 ae6:	6422                	ld	s0,8(sp)
 ae8:	0141                	addi	sp,sp,16
 aea:	8082                	ret

0000000000000aec <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 aec:	7139                	addi	sp,sp,-64
 aee:	fc06                	sd	ra,56(sp)
 af0:	f822                	sd	s0,48(sp)
 af2:	f426                	sd	s1,40(sp)
 af4:	f04a                	sd	s2,32(sp)
 af6:	ec4e                	sd	s3,24(sp)
 af8:	e852                	sd	s4,16(sp)
 afa:	e456                	sd	s5,8(sp)
 afc:	e05a                	sd	s6,0(sp)
 afe:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b00:	02051493          	slli	s1,a0,0x20
 b04:	9081                	srli	s1,s1,0x20
 b06:	04bd                	addi	s1,s1,15
 b08:	8091                	srli	s1,s1,0x4
 b0a:	0014899b          	addiw	s3,s1,1
 b0e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b10:	00000517          	auipc	a0,0x0
 b14:	50853503          	ld	a0,1288(a0) # 1018 <freep>
 b18:	c515                	beqz	a0,b44 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b1a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b1c:	4798                	lw	a4,8(a5)
 b1e:	02977f63          	bgeu	a4,s1,b5c <malloc+0x70>
    if (nu < 4096)
 b22:	8a4e                	mv	s4,s3
 b24:	0009871b          	sext.w	a4,s3
 b28:	6685                	lui	a3,0x1
 b2a:	00d77363          	bgeu	a4,a3,b30 <malloc+0x44>
 b2e:	6a05                	lui	s4,0x1
 b30:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b34:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b38:	00000917          	auipc	s2,0x0
 b3c:	4e090913          	addi	s2,s2,1248 # 1018 <freep>
    if (p == (char *)-1)
 b40:	5afd                	li	s5,-1
 b42:	a895                	j	bb6 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b44:	00000797          	auipc	a5,0x0
 b48:	55c78793          	addi	a5,a5,1372 # 10a0 <base>
 b4c:	00000717          	auipc	a4,0x0
 b50:	4cf73623          	sd	a5,1228(a4) # 1018 <freep>
 b54:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b56:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b5a:	b7e1                	j	b22 <malloc+0x36>
            if (p->s.size == nunits)
 b5c:	02e48c63          	beq	s1,a4,b94 <malloc+0xa8>
                p->s.size -= nunits;
 b60:	4137073b          	subw	a4,a4,s3
 b64:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b66:	02071693          	slli	a3,a4,0x20
 b6a:	01c6d713          	srli	a4,a3,0x1c
 b6e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b70:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b74:	00000717          	auipc	a4,0x0
 b78:	4aa73223          	sd	a0,1188(a4) # 1018 <freep>
            return (void *)(p + 1);
 b7c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b80:	70e2                	ld	ra,56(sp)
 b82:	7442                	ld	s0,48(sp)
 b84:	74a2                	ld	s1,40(sp)
 b86:	7902                	ld	s2,32(sp)
 b88:	69e2                	ld	s3,24(sp)
 b8a:	6a42                	ld	s4,16(sp)
 b8c:	6aa2                	ld	s5,8(sp)
 b8e:	6b02                	ld	s6,0(sp)
 b90:	6121                	addi	sp,sp,64
 b92:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b94:	6398                	ld	a4,0(a5)
 b96:	e118                	sd	a4,0(a0)
 b98:	bff1                	j	b74 <malloc+0x88>
    hp->s.size = nu;
 b9a:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b9e:	0541                	addi	a0,a0,16
 ba0:	00000097          	auipc	ra,0x0
 ba4:	eca080e7          	jalr	-310(ra) # a6a <free>
    return freep;
 ba8:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bac:	d971                	beqz	a0,b80 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bae:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bb0:	4798                	lw	a4,8(a5)
 bb2:	fa9775e3          	bgeu	a4,s1,b5c <malloc+0x70>
        if (p == freep)
 bb6:	00093703          	ld	a4,0(s2)
 bba:	853e                	mv	a0,a5
 bbc:	fef719e3          	bne	a4,a5,bae <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bc0:	8552                	mv	a0,s4
 bc2:	00000097          	auipc	ra,0x0
 bc6:	b7a080e7          	jalr	-1158(ra) # 73c <sbrk>
    if (p == (char *)-1)
 bca:	fd5518e3          	bne	a0,s5,b9a <malloc+0xae>
                return 0;
 bce:	4501                	li	a0,0
 bd0:	bf45                	j	b80 <malloc+0x94>
