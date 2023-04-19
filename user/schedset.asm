
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
  12:	be250513          	addi	a0,a0,-1054 # bf0 <malloc+0xea>
  16:	00001097          	auipc	ra,0x1
  1a:	a38080e7          	jalr	-1480(ra) # a4e <printf>
        exit(1);
  1e:	4505                	li	a0,1
  20:	00000097          	auipc	ra,0x0
  24:	6ae080e7          	jalr	1710(ra) # 6ce <exit>
    }
    int schedid = (*argv[1]) - '0';
  28:	659c                	ld	a5,8(a1)
  2a:	0007c503          	lbu	a0,0(a5)
    schedset(schedid);
  2e:	fd05051b          	addiw	a0,a0,-48
  32:	00000097          	auipc	ra,0x0
  36:	74c080e7          	jalr	1868(ra) # 77e <schedset>
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	692080e7          	jalr	1682(ra) # 6ce <exit>

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
  78:	340080e7          	jalr	832(ra) # 3b4 <twhoami>
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
  c4:	b5050513          	addi	a0,a0,-1200 # c10 <malloc+0x10a>
  c8:	00001097          	auipc	ra,0x1
  cc:	986080e7          	jalr	-1658(ra) # a4e <printf>
        exit(-1);
  d0:	557d                	li	a0,-1
  d2:	00000097          	auipc	ra,0x0
  d6:	5fc080e7          	jalr	1532(ra) # 6ce <exit>
    {
        // give up the cpu for other threads
        tyield();
  da:	00000097          	auipc	ra,0x0
  de:	258080e7          	jalr	600(ra) # 332 <tyield>
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
  f8:	2c0080e7          	jalr	704(ra) # 3b4 <twhoami>
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
 13c:	1fa080e7          	jalr	506(ra) # 332 <tyield>
}
 140:	60e2                	ld	ra,24(sp)
 142:	6442                	ld	s0,16(sp)
 144:	64a2                	ld	s1,8(sp)
 146:	6105                	addi	sp,sp,32
 148:	8082                	ret
        printf("releasing lock we are not holding");
 14a:	00001517          	auipc	a0,0x1
 14e:	aee50513          	addi	a0,a0,-1298 # c38 <malloc+0x132>
 152:	00001097          	auipc	ra,0x1
 156:	8fc080e7          	jalr	-1796(ra) # a4e <printf>
        exit(-1);
 15a:	557d                	li	a0,-1
 15c:	00000097          	auipc	ra,0x0
 160:	572080e7          	jalr	1394(ra) # 6ce <exit>

0000000000000164 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 164:	1141                	addi	sp,sp,-16
 166:	e406                	sd	ra,8(sp)
 168:	e022                	sd	s0,0(sp)
 16a:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 16c:	09800513          	li	a0,152
 170:	00001097          	auipc	ra,0x1
 174:	996080e7          	jalr	-1642(ra) # b06 <malloc>

    main_thread->tid = next_tid;
 178:	00001797          	auipc	a5,0x1
 17c:	e8878793          	addi	a5,a5,-376 # 1000 <next_tid>
 180:	4398                	lw	a4,0(a5)
 182:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 186:	4398                	lw	a4,0(a5)
 188:	2705                	addiw	a4,a4,1
 18a:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 18c:	4791                	li	a5,4
 18e:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 190:	00001797          	auipc	a5,0x1
 194:	e8a7b023          	sd	a0,-384(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 198:	00001797          	auipc	a5,0x1
 19c:	e8878793          	addi	a5,a5,-376 # 1020 <threads>
 1a0:	00001717          	auipc	a4,0x1
 1a4:	f0070713          	addi	a4,a4,-256 # 10a0 <base>
        threads[i] = NULL;
 1a8:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 1ac:	07a1                	addi	a5,a5,8
 1ae:	fee79de3          	bne	a5,a4,1a8 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 1b2:	00001797          	auipc	a5,0x1
 1b6:	e6a7b723          	sd	a0,-402(a5) # 1020 <threads>
}
 1ba:	60a2                	ld	ra,8(sp)
 1bc:	6402                	ld	s0,0(sp)
 1be:	0141                	addi	sp,sp,16
 1c0:	8082                	ret

00000000000001c2 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1c2:	00001517          	auipc	a0,0x1
 1c6:	e4e53503          	ld	a0,-434(a0) # 1010 <current_thread>
 1ca:	00001717          	auipc	a4,0x1
 1ce:	e5670713          	addi	a4,a4,-426 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1d2:	4781                	li	a5,0
 1d4:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1d6:	6314                	ld	a3,0(a4)
 1d8:	00a68763          	beq	a3,a0,1e6 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1dc:	2785                	addiw	a5,a5,1
 1de:	0721                	addi	a4,a4,8
 1e0:	fec79be3          	bne	a5,a2,1d6 <tsched+0x14>
    int current_index = 0;
 1e4:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1e6:	0017869b          	addiw	a3,a5,1
 1ea:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1ee:	00001817          	auipc	a6,0x1
 1f2:	e3280813          	addi	a6,a6,-462 # 1020 <threads>
 1f6:	488d                	li	a7,3
 1f8:	a021                	j	200 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1fa:	2685                	addiw	a3,a3,1
 1fc:	04c68363          	beq	a3,a2,242 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 200:	41f6d71b          	sraiw	a4,a3,0x1f
 204:	01c7571b          	srliw	a4,a4,0x1c
 208:	00d707bb          	addw	a5,a4,a3
 20c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 20e:	9f99                	subw	a5,a5,a4
 210:	078e                	slli	a5,a5,0x3
 212:	97c2                	add	a5,a5,a6
 214:	638c                	ld	a1,0(a5)
 216:	d1f5                	beqz	a1,1fa <tsched+0x38>
 218:	5dbc                	lw	a5,120(a1)
 21a:	ff1790e3          	bne	a5,a7,1fa <tsched+0x38>
{
 21e:	1141                	addi	sp,sp,-16
 220:	e406                	sd	ra,8(sp)
 222:	e022                	sd	s0,0(sp)
 224:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 226:	00001797          	auipc	a5,0x1
 22a:	deb7b523          	sd	a1,-534(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 22e:	05a1                	addi	a1,a1,8
 230:	0521                	addi	a0,a0,8
 232:	00000097          	auipc	ra,0x0
 236:	19a080e7          	jalr	410(ra) # 3cc <tswtch>
        //printf("Thread switch complete\n");
    }
}
 23a:	60a2                	ld	ra,8(sp)
 23c:	6402                	ld	s0,0(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
 242:	8082                	ret

0000000000000244 <thread_wrapper>:
{
 244:	1101                	addi	sp,sp,-32
 246:	ec06                	sd	ra,24(sp)
 248:	e822                	sd	s0,16(sp)
 24a:	e426                	sd	s1,8(sp)
 24c:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 24e:	00001497          	auipc	s1,0x1
 252:	dc248493          	addi	s1,s1,-574 # 1010 <current_thread>
 256:	609c                	ld	a5,0(s1)
 258:	6b9c                	ld	a5,16(a5)
    func(arg);
 25a:	6398                	ld	a4,0(a5)
 25c:	6788                	ld	a0,8(a5)
 25e:	9702                	jalr	a4
    current_thread->state = EXITED;
 260:	609c                	ld	a5,0(s1)
 262:	4719                	li	a4,6
 264:	dfb8                	sw	a4,120(a5)
    tsched();
 266:	00000097          	auipc	ra,0x0
 26a:	f5c080e7          	jalr	-164(ra) # 1c2 <tsched>
}
 26e:	60e2                	ld	ra,24(sp)
 270:	6442                	ld	s0,16(sp)
 272:	64a2                	ld	s1,8(sp)
 274:	6105                	addi	sp,sp,32
 276:	8082                	ret

0000000000000278 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 278:	7179                	addi	sp,sp,-48
 27a:	f406                	sd	ra,40(sp)
 27c:	f022                	sd	s0,32(sp)
 27e:	ec26                	sd	s1,24(sp)
 280:	e84a                	sd	s2,16(sp)
 282:	e44e                	sd	s3,8(sp)
 284:	1800                	addi	s0,sp,48
 286:	84aa                	mv	s1,a0
 288:	8932                	mv	s2,a2
 28a:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 28c:	09800513          	li	a0,152
 290:	00001097          	auipc	ra,0x1
 294:	876080e7          	jalr	-1930(ra) # b06 <malloc>
 298:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 29a:	478d                	li	a5,3
 29c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 29e:	609c                	ld	a5,0(s1)
 2a0:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 2a4:	609c                	ld	a5,0(s1)
 2a6:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 2aa:	6098                	ld	a4,0(s1)
 2ac:	00001797          	auipc	a5,0x1
 2b0:	d5478793          	addi	a5,a5,-684 # 1000 <next_tid>
 2b4:	4394                	lw	a3,0(a5)
 2b6:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2ba:	4398                	lw	a4,0(a5)
 2bc:	2705                	addiw	a4,a4,1
 2be:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 2c0:	6505                	lui	a0,0x1
 2c2:	00001097          	auipc	ra,0x1
 2c6:	844080e7          	jalr	-1980(ra) # b06 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 2ca:	6785                	lui	a5,0x1
 2cc:	00a78733          	add	a4,a5,a0
 2d0:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 2d4:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x330>
 2d6:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 2d8:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 2dc:	609c                	ld	a5,0(s1)
 2de:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2e0:	609c                	ld	a5,0(s1)
 2e2:	00000717          	auipc	a4,0x0
 2e6:	f6270713          	addi	a4,a4,-158 # 244 <thread_wrapper>
 2ea:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 2ec:	00001717          	auipc	a4,0x1
 2f0:	d3470713          	addi	a4,a4,-716 # 1020 <threads>
 2f4:	4781                	li	a5,0
 2f6:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2f8:	6314                	ld	a3,0(a4)
 2fa:	c29d                	beqz	a3,320 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 2fc:	2785                	addiw	a5,a5,1
 2fe:	0721                	addi	a4,a4,8
 300:	fec79ce3          	bne	a5,a2,2f8 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 304:	6088                	ld	a0,0(s1)
 306:	00000097          	auipc	ra,0x0
 30a:	77e080e7          	jalr	1918(ra) # a84 <free>
        *thread = NULL;
 30e:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 312:	70a2                	ld	ra,40(sp)
 314:	7402                	ld	s0,32(sp)
 316:	64e2                	ld	s1,24(sp)
 318:	6942                	ld	s2,16(sp)
 31a:	69a2                	ld	s3,8(sp)
 31c:	6145                	addi	sp,sp,48
 31e:	8082                	ret
            threads[i] = *thread;
 320:	6094                	ld	a3,0(s1)
 322:	078e                	slli	a5,a5,0x3
 324:	00001717          	auipc	a4,0x1
 328:	cfc70713          	addi	a4,a4,-772 # 1020 <threads>
 32c:	97ba                	add	a5,a5,a4
 32e:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 330:	b7cd                	j	312 <tcreate+0x9a>

0000000000000332 <tyield>:
    return 0;
}


void tyield()
{
 332:	1141                	addi	sp,sp,-16
 334:	e406                	sd	ra,8(sp)
 336:	e022                	sd	s0,0(sp)
 338:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 33a:	00001797          	auipc	a5,0x1
 33e:	cd67b783          	ld	a5,-810(a5) # 1010 <current_thread>
 342:	470d                	li	a4,3
 344:	dfb8                	sw	a4,120(a5)
    tsched();
 346:	00000097          	auipc	ra,0x0
 34a:	e7c080e7          	jalr	-388(ra) # 1c2 <tsched>
}
 34e:	60a2                	ld	ra,8(sp)
 350:	6402                	ld	s0,0(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <tjoin>:
{
 356:	1101                	addi	sp,sp,-32
 358:	ec06                	sd	ra,24(sp)
 35a:	e822                	sd	s0,16(sp)
 35c:	e426                	sd	s1,8(sp)
 35e:	e04a                	sd	s2,0(sp)
 360:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 362:	00001797          	auipc	a5,0x1
 366:	cbe78793          	addi	a5,a5,-834 # 1020 <threads>
 36a:	00001697          	auipc	a3,0x1
 36e:	d3668693          	addi	a3,a3,-714 # 10a0 <base>
 372:	a021                	j	37a <tjoin+0x24>
 374:	07a1                	addi	a5,a5,8
 376:	02d78b63          	beq	a5,a3,3ac <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 37a:	6384                	ld	s1,0(a5)
 37c:	dce5                	beqz	s1,374 <tjoin+0x1e>
 37e:	0004c703          	lbu	a4,0(s1)
 382:	fea719e3          	bne	a4,a0,374 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 386:	5cb8                	lw	a4,120(s1)
 388:	4799                	li	a5,6
 38a:	4919                	li	s2,6
 38c:	02f70263          	beq	a4,a5,3b0 <tjoin+0x5a>
        tyield();
 390:	00000097          	auipc	ra,0x0
 394:	fa2080e7          	jalr	-94(ra) # 332 <tyield>
    while (target_thread->state != EXITED) {
 398:	5cbc                	lw	a5,120(s1)
 39a:	ff279be3          	bne	a5,s2,390 <tjoin+0x3a>
    return 0;
 39e:	4501                	li	a0,0
}
 3a0:	60e2                	ld	ra,24(sp)
 3a2:	6442                	ld	s0,16(sp)
 3a4:	64a2                	ld	s1,8(sp)
 3a6:	6902                	ld	s2,0(sp)
 3a8:	6105                	addi	sp,sp,32
 3aa:	8082                	ret
        return -1;
 3ac:	557d                	li	a0,-1
 3ae:	bfcd                	j	3a0 <tjoin+0x4a>
    return 0;
 3b0:	4501                	li	a0,0
 3b2:	b7fd                	j	3a0 <tjoin+0x4a>

00000000000003b4 <twhoami>:

uint8 twhoami()
{
 3b4:	1141                	addi	sp,sp,-16
 3b6:	e422                	sd	s0,8(sp)
 3b8:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3ba:	00001797          	auipc	a5,0x1
 3be:	c567b783          	ld	a5,-938(a5) # 1010 <current_thread>
 3c2:	0007c503          	lbu	a0,0(a5)
 3c6:	6422                	ld	s0,8(sp)
 3c8:	0141                	addi	sp,sp,16
 3ca:	8082                	ret

00000000000003cc <tswtch>:
 3cc:	00153023          	sd	ra,0(a0)
 3d0:	00253423          	sd	sp,8(a0)
 3d4:	e900                	sd	s0,16(a0)
 3d6:	ed04                	sd	s1,24(a0)
 3d8:	03253023          	sd	s2,32(a0)
 3dc:	03353423          	sd	s3,40(a0)
 3e0:	03453823          	sd	s4,48(a0)
 3e4:	03553c23          	sd	s5,56(a0)
 3e8:	05653023          	sd	s6,64(a0)
 3ec:	05753423          	sd	s7,72(a0)
 3f0:	05853823          	sd	s8,80(a0)
 3f4:	05953c23          	sd	s9,88(a0)
 3f8:	07a53023          	sd	s10,96(a0)
 3fc:	07b53423          	sd	s11,104(a0)
 400:	0005b083          	ld	ra,0(a1)
 404:	0085b103          	ld	sp,8(a1)
 408:	6980                	ld	s0,16(a1)
 40a:	6d84                	ld	s1,24(a1)
 40c:	0205b903          	ld	s2,32(a1)
 410:	0285b983          	ld	s3,40(a1)
 414:	0305ba03          	ld	s4,48(a1)
 418:	0385ba83          	ld	s5,56(a1)
 41c:	0405bb03          	ld	s6,64(a1)
 420:	0485bb83          	ld	s7,72(a1)
 424:	0505bc03          	ld	s8,80(a1)
 428:	0585bc83          	ld	s9,88(a1)
 42c:	0605bd03          	ld	s10,96(a1)
 430:	0685bd83          	ld	s11,104(a1)
 434:	8082                	ret

0000000000000436 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 436:	1101                	addi	sp,sp,-32
 438:	ec06                	sd	ra,24(sp)
 43a:	e822                	sd	s0,16(sp)
 43c:	e426                	sd	s1,8(sp)
 43e:	e04a                	sd	s2,0(sp)
 440:	1000                	addi	s0,sp,32
 442:	84aa                	mv	s1,a0
 444:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 446:	00000097          	auipc	ra,0x0
 44a:	d1e080e7          	jalr	-738(ra) # 164 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 44e:	85ca                	mv	a1,s2
 450:	8526                	mv	a0,s1
 452:	00000097          	auipc	ra,0x0
 456:	bae080e7          	jalr	-1106(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 45a:	00000097          	auipc	ra,0x0
 45e:	274080e7          	jalr	628(ra) # 6ce <exit>

0000000000000462 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 462:	1141                	addi	sp,sp,-16
 464:	e422                	sd	s0,8(sp)
 466:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 468:	87aa                	mv	a5,a0
 46a:	0585                	addi	a1,a1,1
 46c:	0785                	addi	a5,a5,1
 46e:	fff5c703          	lbu	a4,-1(a1)
 472:	fee78fa3          	sb	a4,-1(a5)
 476:	fb75                	bnez	a4,46a <strcpy+0x8>
        ;
    return os;
}
 478:	6422                	ld	s0,8(sp)
 47a:	0141                	addi	sp,sp,16
 47c:	8082                	ret

000000000000047e <strcmp>:

int strcmp(const char *p, const char *q)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 484:	00054783          	lbu	a5,0(a0)
 488:	cb91                	beqz	a5,49c <strcmp+0x1e>
 48a:	0005c703          	lbu	a4,0(a1)
 48e:	00f71763          	bne	a4,a5,49c <strcmp+0x1e>
        p++, q++;
 492:	0505                	addi	a0,a0,1
 494:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 496:	00054783          	lbu	a5,0(a0)
 49a:	fbe5                	bnez	a5,48a <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 49c:	0005c503          	lbu	a0,0(a1)
}
 4a0:	40a7853b          	subw	a0,a5,a0
 4a4:	6422                	ld	s0,8(sp)
 4a6:	0141                	addi	sp,sp,16
 4a8:	8082                	ret

00000000000004aa <strlen>:

uint strlen(const char *s)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e422                	sd	s0,8(sp)
 4ae:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4b0:	00054783          	lbu	a5,0(a0)
 4b4:	cf91                	beqz	a5,4d0 <strlen+0x26>
 4b6:	0505                	addi	a0,a0,1
 4b8:	87aa                	mv	a5,a0
 4ba:	86be                	mv	a3,a5
 4bc:	0785                	addi	a5,a5,1
 4be:	fff7c703          	lbu	a4,-1(a5)
 4c2:	ff65                	bnez	a4,4ba <strlen+0x10>
 4c4:	40a6853b          	subw	a0,a3,a0
 4c8:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4ca:	6422                	ld	s0,8(sp)
 4cc:	0141                	addi	sp,sp,16
 4ce:	8082                	ret
    for (n = 0; s[n]; n++)
 4d0:	4501                	li	a0,0
 4d2:	bfe5                	j	4ca <strlen+0x20>

00000000000004d4 <memset>:

void *
memset(void *dst, int c, uint n)
{
 4d4:	1141                	addi	sp,sp,-16
 4d6:	e422                	sd	s0,8(sp)
 4d8:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4da:	ca19                	beqz	a2,4f0 <memset+0x1c>
 4dc:	87aa                	mv	a5,a0
 4de:	1602                	slli	a2,a2,0x20
 4e0:	9201                	srli	a2,a2,0x20
 4e2:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4e6:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4ea:	0785                	addi	a5,a5,1
 4ec:	fee79de3          	bne	a5,a4,4e6 <memset+0x12>
    }
    return dst;
}
 4f0:	6422                	ld	s0,8(sp)
 4f2:	0141                	addi	sp,sp,16
 4f4:	8082                	ret

00000000000004f6 <strchr>:

char *
strchr(const char *s, char c)
{
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e422                	sd	s0,8(sp)
 4fa:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4fc:	00054783          	lbu	a5,0(a0)
 500:	cb99                	beqz	a5,516 <strchr+0x20>
        if (*s == c)
 502:	00f58763          	beq	a1,a5,510 <strchr+0x1a>
    for (; *s; s++)
 506:	0505                	addi	a0,a0,1
 508:	00054783          	lbu	a5,0(a0)
 50c:	fbfd                	bnez	a5,502 <strchr+0xc>
            return (char *)s;
    return 0;
 50e:	4501                	li	a0,0
}
 510:	6422                	ld	s0,8(sp)
 512:	0141                	addi	sp,sp,16
 514:	8082                	ret
    return 0;
 516:	4501                	li	a0,0
 518:	bfe5                	j	510 <strchr+0x1a>

000000000000051a <gets>:

char *
gets(char *buf, int max)
{
 51a:	711d                	addi	sp,sp,-96
 51c:	ec86                	sd	ra,88(sp)
 51e:	e8a2                	sd	s0,80(sp)
 520:	e4a6                	sd	s1,72(sp)
 522:	e0ca                	sd	s2,64(sp)
 524:	fc4e                	sd	s3,56(sp)
 526:	f852                	sd	s4,48(sp)
 528:	f456                	sd	s5,40(sp)
 52a:	f05a                	sd	s6,32(sp)
 52c:	ec5e                	sd	s7,24(sp)
 52e:	1080                	addi	s0,sp,96
 530:	8baa                	mv	s7,a0
 532:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 534:	892a                	mv	s2,a0
 536:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 538:	4aa9                	li	s5,10
 53a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 53c:	89a6                	mv	s3,s1
 53e:	2485                	addiw	s1,s1,1
 540:	0344d863          	bge	s1,s4,570 <gets+0x56>
        cc = read(0, &c, 1);
 544:	4605                	li	a2,1
 546:	faf40593          	addi	a1,s0,-81
 54a:	4501                	li	a0,0
 54c:	00000097          	auipc	ra,0x0
 550:	19a080e7          	jalr	410(ra) # 6e6 <read>
        if (cc < 1)
 554:	00a05e63          	blez	a0,570 <gets+0x56>
        buf[i++] = c;
 558:	faf44783          	lbu	a5,-81(s0)
 55c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 560:	01578763          	beq	a5,s5,56e <gets+0x54>
 564:	0905                	addi	s2,s2,1
 566:	fd679be3          	bne	a5,s6,53c <gets+0x22>
    for (i = 0; i + 1 < max;)
 56a:	89a6                	mv	s3,s1
 56c:	a011                	j	570 <gets+0x56>
 56e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 570:	99de                	add	s3,s3,s7
 572:	00098023          	sb	zero,0(s3)
    return buf;
}
 576:	855e                	mv	a0,s7
 578:	60e6                	ld	ra,88(sp)
 57a:	6446                	ld	s0,80(sp)
 57c:	64a6                	ld	s1,72(sp)
 57e:	6906                	ld	s2,64(sp)
 580:	79e2                	ld	s3,56(sp)
 582:	7a42                	ld	s4,48(sp)
 584:	7aa2                	ld	s5,40(sp)
 586:	7b02                	ld	s6,32(sp)
 588:	6be2                	ld	s7,24(sp)
 58a:	6125                	addi	sp,sp,96
 58c:	8082                	ret

000000000000058e <stat>:

int stat(const char *n, struct stat *st)
{
 58e:	1101                	addi	sp,sp,-32
 590:	ec06                	sd	ra,24(sp)
 592:	e822                	sd	s0,16(sp)
 594:	e426                	sd	s1,8(sp)
 596:	e04a                	sd	s2,0(sp)
 598:	1000                	addi	s0,sp,32
 59a:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 59c:	4581                	li	a1,0
 59e:	00000097          	auipc	ra,0x0
 5a2:	170080e7          	jalr	368(ra) # 70e <open>
    if (fd < 0)
 5a6:	02054563          	bltz	a0,5d0 <stat+0x42>
 5aa:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5ac:	85ca                	mv	a1,s2
 5ae:	00000097          	auipc	ra,0x0
 5b2:	178080e7          	jalr	376(ra) # 726 <fstat>
 5b6:	892a                	mv	s2,a0
    close(fd);
 5b8:	8526                	mv	a0,s1
 5ba:	00000097          	auipc	ra,0x0
 5be:	13c080e7          	jalr	316(ra) # 6f6 <close>
    return r;
}
 5c2:	854a                	mv	a0,s2
 5c4:	60e2                	ld	ra,24(sp)
 5c6:	6442                	ld	s0,16(sp)
 5c8:	64a2                	ld	s1,8(sp)
 5ca:	6902                	ld	s2,0(sp)
 5cc:	6105                	addi	sp,sp,32
 5ce:	8082                	ret
        return -1;
 5d0:	597d                	li	s2,-1
 5d2:	bfc5                	j	5c2 <stat+0x34>

00000000000005d4 <atoi>:

int atoi(const char *s)
{
 5d4:	1141                	addi	sp,sp,-16
 5d6:	e422                	sd	s0,8(sp)
 5d8:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5da:	00054683          	lbu	a3,0(a0)
 5de:	fd06879b          	addiw	a5,a3,-48
 5e2:	0ff7f793          	zext.b	a5,a5
 5e6:	4625                	li	a2,9
 5e8:	02f66863          	bltu	a2,a5,618 <atoi+0x44>
 5ec:	872a                	mv	a4,a0
    n = 0;
 5ee:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5f0:	0705                	addi	a4,a4,1
 5f2:	0025179b          	slliw	a5,a0,0x2
 5f6:	9fa9                	addw	a5,a5,a0
 5f8:	0017979b          	slliw	a5,a5,0x1
 5fc:	9fb5                	addw	a5,a5,a3
 5fe:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 602:	00074683          	lbu	a3,0(a4)
 606:	fd06879b          	addiw	a5,a3,-48
 60a:	0ff7f793          	zext.b	a5,a5
 60e:	fef671e3          	bgeu	a2,a5,5f0 <atoi+0x1c>
    return n;
}
 612:	6422                	ld	s0,8(sp)
 614:	0141                	addi	sp,sp,16
 616:	8082                	ret
    n = 0;
 618:	4501                	li	a0,0
 61a:	bfe5                	j	612 <atoi+0x3e>

000000000000061c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 61c:	1141                	addi	sp,sp,-16
 61e:	e422                	sd	s0,8(sp)
 620:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 622:	02b57463          	bgeu	a0,a1,64a <memmove+0x2e>
    {
        while (n-- > 0)
 626:	00c05f63          	blez	a2,644 <memmove+0x28>
 62a:	1602                	slli	a2,a2,0x20
 62c:	9201                	srli	a2,a2,0x20
 62e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 632:	872a                	mv	a4,a0
            *dst++ = *src++;
 634:	0585                	addi	a1,a1,1
 636:	0705                	addi	a4,a4,1
 638:	fff5c683          	lbu	a3,-1(a1)
 63c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 640:	fee79ae3          	bne	a5,a4,634 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 644:	6422                	ld	s0,8(sp)
 646:	0141                	addi	sp,sp,16
 648:	8082                	ret
        dst += n;
 64a:	00c50733          	add	a4,a0,a2
        src += n;
 64e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 650:	fec05ae3          	blez	a2,644 <memmove+0x28>
 654:	fff6079b          	addiw	a5,a2,-1
 658:	1782                	slli	a5,a5,0x20
 65a:	9381                	srli	a5,a5,0x20
 65c:	fff7c793          	not	a5,a5
 660:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 662:	15fd                	addi	a1,a1,-1
 664:	177d                	addi	a4,a4,-1
 666:	0005c683          	lbu	a3,0(a1)
 66a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 66e:	fee79ae3          	bne	a5,a4,662 <memmove+0x46>
 672:	bfc9                	j	644 <memmove+0x28>

0000000000000674 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 674:	1141                	addi	sp,sp,-16
 676:	e422                	sd	s0,8(sp)
 678:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 67a:	ca05                	beqz	a2,6aa <memcmp+0x36>
 67c:	fff6069b          	addiw	a3,a2,-1
 680:	1682                	slli	a3,a3,0x20
 682:	9281                	srli	a3,a3,0x20
 684:	0685                	addi	a3,a3,1
 686:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 688:	00054783          	lbu	a5,0(a0)
 68c:	0005c703          	lbu	a4,0(a1)
 690:	00e79863          	bne	a5,a4,6a0 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 694:	0505                	addi	a0,a0,1
        p2++;
 696:	0585                	addi	a1,a1,1
    while (n-- > 0)
 698:	fed518e3          	bne	a0,a3,688 <memcmp+0x14>
    }
    return 0;
 69c:	4501                	li	a0,0
 69e:	a019                	j	6a4 <memcmp+0x30>
            return *p1 - *p2;
 6a0:	40e7853b          	subw	a0,a5,a4
}
 6a4:	6422                	ld	s0,8(sp)
 6a6:	0141                	addi	sp,sp,16
 6a8:	8082                	ret
    return 0;
 6aa:	4501                	li	a0,0
 6ac:	bfe5                	j	6a4 <memcmp+0x30>

00000000000006ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6ae:	1141                	addi	sp,sp,-16
 6b0:	e406                	sd	ra,8(sp)
 6b2:	e022                	sd	s0,0(sp)
 6b4:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6b6:	00000097          	auipc	ra,0x0
 6ba:	f66080e7          	jalr	-154(ra) # 61c <memmove>
}
 6be:	60a2                	ld	ra,8(sp)
 6c0:	6402                	ld	s0,0(sp)
 6c2:	0141                	addi	sp,sp,16
 6c4:	8082                	ret

00000000000006c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6c6:	4885                	li	a7,1
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 6ce:	4889                	li	a7,2
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6d6:	488d                	li	a7,3
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6de:	4891                	li	a7,4
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <read>:
.global read
read:
 li a7, SYS_read
 6e6:	4895                	li	a7,5
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <write>:
.global write
write:
 li a7, SYS_write
 6ee:	48c1                	li	a7,16
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <close>:
.global close
close:
 li a7, SYS_close
 6f6:	48d5                	li	a7,21
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 6fe:	4899                	li	a7,6
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <exec>:
.global exec
exec:
 li a7, SYS_exec
 706:	489d                	li	a7,7
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <open>:
.global open
open:
 li a7, SYS_open
 70e:	48bd                	li	a7,15
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 716:	48c5                	li	a7,17
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 71e:	48c9                	li	a7,18
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 726:	48a1                	li	a7,8
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <link>:
.global link
link:
 li a7, SYS_link
 72e:	48cd                	li	a7,19
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 736:	48d1                	li	a7,20
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 73e:	48a5                	li	a7,9
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <dup>:
.global dup
dup:
 li a7, SYS_dup
 746:	48a9                	li	a7,10
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 74e:	48ad                	li	a7,11
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 756:	48b1                	li	a7,12
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 75e:	48b5                	li	a7,13
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 766:	48b9                	li	a7,14
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <ps>:
.global ps
ps:
 li a7, SYS_ps
 76e:	48d9                	li	a7,22
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 776:	48dd                	li	a7,23
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 77e:	48e1                	li	a7,24
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 786:	1101                	addi	sp,sp,-32
 788:	ec06                	sd	ra,24(sp)
 78a:	e822                	sd	s0,16(sp)
 78c:	1000                	addi	s0,sp,32
 78e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 792:	4605                	li	a2,1
 794:	fef40593          	addi	a1,s0,-17
 798:	00000097          	auipc	ra,0x0
 79c:	f56080e7          	jalr	-170(ra) # 6ee <write>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6105                	addi	sp,sp,32
 7a6:	8082                	ret

00000000000007a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7a8:	7139                	addi	sp,sp,-64
 7aa:	fc06                	sd	ra,56(sp)
 7ac:	f822                	sd	s0,48(sp)
 7ae:	f426                	sd	s1,40(sp)
 7b0:	f04a                	sd	s2,32(sp)
 7b2:	ec4e                	sd	s3,24(sp)
 7b4:	0080                	addi	s0,sp,64
 7b6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7b8:	c299                	beqz	a3,7be <printint+0x16>
 7ba:	0805c963          	bltz	a1,84c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7be:	2581                	sext.w	a1,a1
  neg = 0;
 7c0:	4881                	li	a7,0
 7c2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7c6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7c8:	2601                	sext.w	a2,a2
 7ca:	00000517          	auipc	a0,0x0
 7ce:	4f650513          	addi	a0,a0,1270 # cc0 <digits>
 7d2:	883a                	mv	a6,a4
 7d4:	2705                	addiw	a4,a4,1
 7d6:	02c5f7bb          	remuw	a5,a1,a2
 7da:	1782                	slli	a5,a5,0x20
 7dc:	9381                	srli	a5,a5,0x20
 7de:	97aa                	add	a5,a5,a0
 7e0:	0007c783          	lbu	a5,0(a5)
 7e4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7e8:	0005879b          	sext.w	a5,a1
 7ec:	02c5d5bb          	divuw	a1,a1,a2
 7f0:	0685                	addi	a3,a3,1
 7f2:	fec7f0e3          	bgeu	a5,a2,7d2 <printint+0x2a>
  if(neg)
 7f6:	00088c63          	beqz	a7,80e <printint+0x66>
    buf[i++] = '-';
 7fa:	fd070793          	addi	a5,a4,-48
 7fe:	00878733          	add	a4,a5,s0
 802:	02d00793          	li	a5,45
 806:	fef70823          	sb	a5,-16(a4)
 80a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 80e:	02e05863          	blez	a4,83e <printint+0x96>
 812:	fc040793          	addi	a5,s0,-64
 816:	00e78933          	add	s2,a5,a4
 81a:	fff78993          	addi	s3,a5,-1
 81e:	99ba                	add	s3,s3,a4
 820:	377d                	addiw	a4,a4,-1
 822:	1702                	slli	a4,a4,0x20
 824:	9301                	srli	a4,a4,0x20
 826:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 82a:	fff94583          	lbu	a1,-1(s2)
 82e:	8526                	mv	a0,s1
 830:	00000097          	auipc	ra,0x0
 834:	f56080e7          	jalr	-170(ra) # 786 <putc>
  while(--i >= 0)
 838:	197d                	addi	s2,s2,-1
 83a:	ff3918e3          	bne	s2,s3,82a <printint+0x82>
}
 83e:	70e2                	ld	ra,56(sp)
 840:	7442                	ld	s0,48(sp)
 842:	74a2                	ld	s1,40(sp)
 844:	7902                	ld	s2,32(sp)
 846:	69e2                	ld	s3,24(sp)
 848:	6121                	addi	sp,sp,64
 84a:	8082                	ret
    x = -xx;
 84c:	40b005bb          	negw	a1,a1
    neg = 1;
 850:	4885                	li	a7,1
    x = -xx;
 852:	bf85                	j	7c2 <printint+0x1a>

0000000000000854 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 854:	715d                	addi	sp,sp,-80
 856:	e486                	sd	ra,72(sp)
 858:	e0a2                	sd	s0,64(sp)
 85a:	fc26                	sd	s1,56(sp)
 85c:	f84a                	sd	s2,48(sp)
 85e:	f44e                	sd	s3,40(sp)
 860:	f052                	sd	s4,32(sp)
 862:	ec56                	sd	s5,24(sp)
 864:	e85a                	sd	s6,16(sp)
 866:	e45e                	sd	s7,8(sp)
 868:	e062                	sd	s8,0(sp)
 86a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 86c:	0005c903          	lbu	s2,0(a1)
 870:	18090c63          	beqz	s2,a08 <vprintf+0x1b4>
 874:	8aaa                	mv	s5,a0
 876:	8bb2                	mv	s7,a2
 878:	00158493          	addi	s1,a1,1
  state = 0;
 87c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 87e:	02500a13          	li	s4,37
 882:	4b55                	li	s6,21
 884:	a839                	j	8a2 <vprintf+0x4e>
        putc(fd, c);
 886:	85ca                	mv	a1,s2
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	efc080e7          	jalr	-260(ra) # 786 <putc>
 892:	a019                	j	898 <vprintf+0x44>
    } else if(state == '%'){
 894:	01498d63          	beq	s3,s4,8ae <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 898:	0485                	addi	s1,s1,1
 89a:	fff4c903          	lbu	s2,-1(s1)
 89e:	16090563          	beqz	s2,a08 <vprintf+0x1b4>
    if(state == 0){
 8a2:	fe0999e3          	bnez	s3,894 <vprintf+0x40>
      if(c == '%'){
 8a6:	ff4910e3          	bne	s2,s4,886 <vprintf+0x32>
        state = '%';
 8aa:	89d2                	mv	s3,s4
 8ac:	b7f5                	j	898 <vprintf+0x44>
      if(c == 'd'){
 8ae:	13490263          	beq	s2,s4,9d2 <vprintf+0x17e>
 8b2:	f9d9079b          	addiw	a5,s2,-99
 8b6:	0ff7f793          	zext.b	a5,a5
 8ba:	12fb6563          	bltu	s6,a5,9e4 <vprintf+0x190>
 8be:	f9d9079b          	addiw	a5,s2,-99
 8c2:	0ff7f713          	zext.b	a4,a5
 8c6:	10eb6f63          	bltu	s6,a4,9e4 <vprintf+0x190>
 8ca:	00271793          	slli	a5,a4,0x2
 8ce:	00000717          	auipc	a4,0x0
 8d2:	39a70713          	addi	a4,a4,922 # c68 <malloc+0x162>
 8d6:	97ba                	add	a5,a5,a4
 8d8:	439c                	lw	a5,0(a5)
 8da:	97ba                	add	a5,a5,a4
 8dc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8de:	008b8913          	addi	s2,s7,8
 8e2:	4685                	li	a3,1
 8e4:	4629                	li	a2,10
 8e6:	000ba583          	lw	a1,0(s7)
 8ea:	8556                	mv	a0,s5
 8ec:	00000097          	auipc	ra,0x0
 8f0:	ebc080e7          	jalr	-324(ra) # 7a8 <printint>
 8f4:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8f6:	4981                	li	s3,0
 8f8:	b745                	j	898 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8fa:	008b8913          	addi	s2,s7,8
 8fe:	4681                	li	a3,0
 900:	4629                	li	a2,10
 902:	000ba583          	lw	a1,0(s7)
 906:	8556                	mv	a0,s5
 908:	00000097          	auipc	ra,0x0
 90c:	ea0080e7          	jalr	-352(ra) # 7a8 <printint>
 910:	8bca                	mv	s7,s2
      state = 0;
 912:	4981                	li	s3,0
 914:	b751                	j	898 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 916:	008b8913          	addi	s2,s7,8
 91a:	4681                	li	a3,0
 91c:	4641                	li	a2,16
 91e:	000ba583          	lw	a1,0(s7)
 922:	8556                	mv	a0,s5
 924:	00000097          	auipc	ra,0x0
 928:	e84080e7          	jalr	-380(ra) # 7a8 <printint>
 92c:	8bca                	mv	s7,s2
      state = 0;
 92e:	4981                	li	s3,0
 930:	b7a5                	j	898 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 932:	008b8c13          	addi	s8,s7,8
 936:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 93a:	03000593          	li	a1,48
 93e:	8556                	mv	a0,s5
 940:	00000097          	auipc	ra,0x0
 944:	e46080e7          	jalr	-442(ra) # 786 <putc>
  putc(fd, 'x');
 948:	07800593          	li	a1,120
 94c:	8556                	mv	a0,s5
 94e:	00000097          	auipc	ra,0x0
 952:	e38080e7          	jalr	-456(ra) # 786 <putc>
 956:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 958:	00000b97          	auipc	s7,0x0
 95c:	368b8b93          	addi	s7,s7,872 # cc0 <digits>
 960:	03c9d793          	srli	a5,s3,0x3c
 964:	97de                	add	a5,a5,s7
 966:	0007c583          	lbu	a1,0(a5)
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	e1a080e7          	jalr	-486(ra) # 786 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 974:	0992                	slli	s3,s3,0x4
 976:	397d                	addiw	s2,s2,-1
 978:	fe0914e3          	bnez	s2,960 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 97c:	8be2                	mv	s7,s8
      state = 0;
 97e:	4981                	li	s3,0
 980:	bf21                	j	898 <vprintf+0x44>
        s = va_arg(ap, char*);
 982:	008b8993          	addi	s3,s7,8
 986:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 98a:	02090163          	beqz	s2,9ac <vprintf+0x158>
        while(*s != 0){
 98e:	00094583          	lbu	a1,0(s2)
 992:	c9a5                	beqz	a1,a02 <vprintf+0x1ae>
          putc(fd, *s);
 994:	8556                	mv	a0,s5
 996:	00000097          	auipc	ra,0x0
 99a:	df0080e7          	jalr	-528(ra) # 786 <putc>
          s++;
 99e:	0905                	addi	s2,s2,1
        while(*s != 0){
 9a0:	00094583          	lbu	a1,0(s2)
 9a4:	f9e5                	bnez	a1,994 <vprintf+0x140>
        s = va_arg(ap, char*);
 9a6:	8bce                	mv	s7,s3
      state = 0;
 9a8:	4981                	li	s3,0
 9aa:	b5fd                	j	898 <vprintf+0x44>
          s = "(null)";
 9ac:	00000917          	auipc	s2,0x0
 9b0:	2b490913          	addi	s2,s2,692 # c60 <malloc+0x15a>
        while(*s != 0){
 9b4:	02800593          	li	a1,40
 9b8:	bff1                	j	994 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9ba:	008b8913          	addi	s2,s7,8
 9be:	000bc583          	lbu	a1,0(s7)
 9c2:	8556                	mv	a0,s5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	dc2080e7          	jalr	-574(ra) # 786 <putc>
 9cc:	8bca                	mv	s7,s2
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	b5e1                	j	898 <vprintf+0x44>
        putc(fd, c);
 9d2:	02500593          	li	a1,37
 9d6:	8556                	mv	a0,s5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	dae080e7          	jalr	-594(ra) # 786 <putc>
      state = 0;
 9e0:	4981                	li	s3,0
 9e2:	bd5d                	j	898 <vprintf+0x44>
        putc(fd, '%');
 9e4:	02500593          	li	a1,37
 9e8:	8556                	mv	a0,s5
 9ea:	00000097          	auipc	ra,0x0
 9ee:	d9c080e7          	jalr	-612(ra) # 786 <putc>
        putc(fd, c);
 9f2:	85ca                	mv	a1,s2
 9f4:	8556                	mv	a0,s5
 9f6:	00000097          	auipc	ra,0x0
 9fa:	d90080e7          	jalr	-624(ra) # 786 <putc>
      state = 0;
 9fe:	4981                	li	s3,0
 a00:	bd61                	j	898 <vprintf+0x44>
        s = va_arg(ap, char*);
 a02:	8bce                	mv	s7,s3
      state = 0;
 a04:	4981                	li	s3,0
 a06:	bd49                	j	898 <vprintf+0x44>
    }
  }
}
 a08:	60a6                	ld	ra,72(sp)
 a0a:	6406                	ld	s0,64(sp)
 a0c:	74e2                	ld	s1,56(sp)
 a0e:	7942                	ld	s2,48(sp)
 a10:	79a2                	ld	s3,40(sp)
 a12:	7a02                	ld	s4,32(sp)
 a14:	6ae2                	ld	s5,24(sp)
 a16:	6b42                	ld	s6,16(sp)
 a18:	6ba2                	ld	s7,8(sp)
 a1a:	6c02                	ld	s8,0(sp)
 a1c:	6161                	addi	sp,sp,80
 a1e:	8082                	ret

0000000000000a20 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a20:	715d                	addi	sp,sp,-80
 a22:	ec06                	sd	ra,24(sp)
 a24:	e822                	sd	s0,16(sp)
 a26:	1000                	addi	s0,sp,32
 a28:	e010                	sd	a2,0(s0)
 a2a:	e414                	sd	a3,8(s0)
 a2c:	e818                	sd	a4,16(s0)
 a2e:	ec1c                	sd	a5,24(s0)
 a30:	03043023          	sd	a6,32(s0)
 a34:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a38:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a3c:	8622                	mv	a2,s0
 a3e:	00000097          	auipc	ra,0x0
 a42:	e16080e7          	jalr	-490(ra) # 854 <vprintf>
}
 a46:	60e2                	ld	ra,24(sp)
 a48:	6442                	ld	s0,16(sp)
 a4a:	6161                	addi	sp,sp,80
 a4c:	8082                	ret

0000000000000a4e <printf>:

void
printf(const char *fmt, ...)
{
 a4e:	711d                	addi	sp,sp,-96
 a50:	ec06                	sd	ra,24(sp)
 a52:	e822                	sd	s0,16(sp)
 a54:	1000                	addi	s0,sp,32
 a56:	e40c                	sd	a1,8(s0)
 a58:	e810                	sd	a2,16(s0)
 a5a:	ec14                	sd	a3,24(s0)
 a5c:	f018                	sd	a4,32(s0)
 a5e:	f41c                	sd	a5,40(s0)
 a60:	03043823          	sd	a6,48(s0)
 a64:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a68:	00840613          	addi	a2,s0,8
 a6c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a70:	85aa                	mv	a1,a0
 a72:	4505                	li	a0,1
 a74:	00000097          	auipc	ra,0x0
 a78:	de0080e7          	jalr	-544(ra) # 854 <vprintf>
}
 a7c:	60e2                	ld	ra,24(sp)
 a7e:	6442                	ld	s0,16(sp)
 a80:	6125                	addi	sp,sp,96
 a82:	8082                	ret

0000000000000a84 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a84:	1141                	addi	sp,sp,-16
 a86:	e422                	sd	s0,8(sp)
 a88:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a8a:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a8e:	00000797          	auipc	a5,0x0
 a92:	58a7b783          	ld	a5,1418(a5) # 1018 <freep>
 a96:	a02d                	j	ac0 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a98:	4618                	lw	a4,8(a2)
 a9a:	9f2d                	addw	a4,a4,a1
 a9c:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 aa0:	6398                	ld	a4,0(a5)
 aa2:	6310                	ld	a2,0(a4)
 aa4:	a83d                	j	ae2 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 aa6:	ff852703          	lw	a4,-8(a0)
 aaa:	9f31                	addw	a4,a4,a2
 aac:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 aae:	ff053683          	ld	a3,-16(a0)
 ab2:	a091                	j	af6 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab4:	6398                	ld	a4,0(a5)
 ab6:	00e7e463          	bltu	a5,a4,abe <free+0x3a>
 aba:	00e6ea63          	bltu	a3,a4,ace <free+0x4a>
{
 abe:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac0:	fed7fae3          	bgeu	a5,a3,ab4 <free+0x30>
 ac4:	6398                	ld	a4,0(a5)
 ac6:	00e6e463          	bltu	a3,a4,ace <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aca:	fee7eae3          	bltu	a5,a4,abe <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ace:	ff852583          	lw	a1,-8(a0)
 ad2:	6390                	ld	a2,0(a5)
 ad4:	02059813          	slli	a6,a1,0x20
 ad8:	01c85713          	srli	a4,a6,0x1c
 adc:	9736                	add	a4,a4,a3
 ade:	fae60de3          	beq	a2,a4,a98 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 ae2:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 ae6:	4790                	lw	a2,8(a5)
 ae8:	02061593          	slli	a1,a2,0x20
 aec:	01c5d713          	srli	a4,a1,0x1c
 af0:	973e                	add	a4,a4,a5
 af2:	fae68ae3          	beq	a3,a4,aa6 <free+0x22>
        p->s.ptr = bp->s.ptr;
 af6:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 af8:	00000717          	auipc	a4,0x0
 afc:	52f73023          	sd	a5,1312(a4) # 1018 <freep>
}
 b00:	6422                	ld	s0,8(sp)
 b02:	0141                	addi	sp,sp,16
 b04:	8082                	ret

0000000000000b06 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b06:	7139                	addi	sp,sp,-64
 b08:	fc06                	sd	ra,56(sp)
 b0a:	f822                	sd	s0,48(sp)
 b0c:	f426                	sd	s1,40(sp)
 b0e:	f04a                	sd	s2,32(sp)
 b10:	ec4e                	sd	s3,24(sp)
 b12:	e852                	sd	s4,16(sp)
 b14:	e456                	sd	s5,8(sp)
 b16:	e05a                	sd	s6,0(sp)
 b18:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b1a:	02051493          	slli	s1,a0,0x20
 b1e:	9081                	srli	s1,s1,0x20
 b20:	04bd                	addi	s1,s1,15
 b22:	8091                	srli	s1,s1,0x4
 b24:	0014899b          	addiw	s3,s1,1
 b28:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b2a:	00000517          	auipc	a0,0x0
 b2e:	4ee53503          	ld	a0,1262(a0) # 1018 <freep>
 b32:	c515                	beqz	a0,b5e <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b34:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b36:	4798                	lw	a4,8(a5)
 b38:	02977f63          	bgeu	a4,s1,b76 <malloc+0x70>
    if (nu < 4096)
 b3c:	8a4e                	mv	s4,s3
 b3e:	0009871b          	sext.w	a4,s3
 b42:	6685                	lui	a3,0x1
 b44:	00d77363          	bgeu	a4,a3,b4a <malloc+0x44>
 b48:	6a05                	lui	s4,0x1
 b4a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b4e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b52:	00000917          	auipc	s2,0x0
 b56:	4c690913          	addi	s2,s2,1222 # 1018 <freep>
    if (p == (char *)-1)
 b5a:	5afd                	li	s5,-1
 b5c:	a895                	j	bd0 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b5e:	00000797          	auipc	a5,0x0
 b62:	54278793          	addi	a5,a5,1346 # 10a0 <base>
 b66:	00000717          	auipc	a4,0x0
 b6a:	4af73923          	sd	a5,1202(a4) # 1018 <freep>
 b6e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b70:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b74:	b7e1                	j	b3c <malloc+0x36>
            if (p->s.size == nunits)
 b76:	02e48c63          	beq	s1,a4,bae <malloc+0xa8>
                p->s.size -= nunits;
 b7a:	4137073b          	subw	a4,a4,s3
 b7e:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b80:	02071693          	slli	a3,a4,0x20
 b84:	01c6d713          	srli	a4,a3,0x1c
 b88:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b8a:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b8e:	00000717          	auipc	a4,0x0
 b92:	48a73523          	sd	a0,1162(a4) # 1018 <freep>
            return (void *)(p + 1);
 b96:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b9a:	70e2                	ld	ra,56(sp)
 b9c:	7442                	ld	s0,48(sp)
 b9e:	74a2                	ld	s1,40(sp)
 ba0:	7902                	ld	s2,32(sp)
 ba2:	69e2                	ld	s3,24(sp)
 ba4:	6a42                	ld	s4,16(sp)
 ba6:	6aa2                	ld	s5,8(sp)
 ba8:	6b02                	ld	s6,0(sp)
 baa:	6121                	addi	sp,sp,64
 bac:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bae:	6398                	ld	a4,0(a5)
 bb0:	e118                	sd	a4,0(a0)
 bb2:	bff1                	j	b8e <malloc+0x88>
    hp->s.size = nu;
 bb4:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bb8:	0541                	addi	a0,a0,16
 bba:	00000097          	auipc	ra,0x0
 bbe:	eca080e7          	jalr	-310(ra) # a84 <free>
    return freep;
 bc2:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bc6:	d971                	beqz	a0,b9a <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bc8:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bca:	4798                	lw	a4,8(a5)
 bcc:	fa9775e3          	bgeu	a4,s1,b76 <malloc+0x70>
        if (p == freep)
 bd0:	00093703          	ld	a4,0(s2)
 bd4:	853e                	mv	a0,a5
 bd6:	fef719e3          	bne	a4,a5,bc8 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bda:	8552                	mv	a0,s4
 bdc:	00000097          	auipc	ra,0x0
 be0:	b7a080e7          	jalr	-1158(ra) # 756 <sbrk>
    if (p == (char *)-1)
 be4:	fd5518e3          	bne	a0,s5,bb4 <malloc+0xae>
                return 0;
 be8:	4501                	li	a0,0
 bea:	bf45                	j	b9a <malloc+0x94>
