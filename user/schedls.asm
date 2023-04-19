
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
   c:	744080e7          	jalr	1860(ra) # 74c <schedls>
    exit(0);
  10:	4501                	li	a0,0
  12:	00000097          	auipc	ra,0x0
  16:	692080e7          	jalr	1682(ra) # 6a4 <exit>

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
  4e:	340080e7          	jalr	832(ra) # 38a <twhoami>
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
  9a:	b3a50513          	addi	a0,a0,-1222 # bd0 <malloc+0xf4>
  9e:	00001097          	auipc	ra,0x1
  a2:	986080e7          	jalr	-1658(ra) # a24 <printf>
        exit(-1);
  a6:	557d                	li	a0,-1
  a8:	00000097          	auipc	ra,0x0
  ac:	5fc080e7          	jalr	1532(ra) # 6a4 <exit>
    {
        // give up the cpu for other threads
        tyield();
  b0:	00000097          	auipc	ra,0x0
  b4:	258080e7          	jalr	600(ra) # 308 <tyield>
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
  ce:	2c0080e7          	jalr	704(ra) # 38a <twhoami>
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
 112:	1fa080e7          	jalr	506(ra) # 308 <tyield>
}
 116:	60e2                	ld	ra,24(sp)
 118:	6442                	ld	s0,16(sp)
 11a:	64a2                	ld	s1,8(sp)
 11c:	6105                	addi	sp,sp,32
 11e:	8082                	ret
        printf("releasing lock we are not holding");
 120:	00001517          	auipc	a0,0x1
 124:	ad850513          	addi	a0,a0,-1320 # bf8 <malloc+0x11c>
 128:	00001097          	auipc	ra,0x1
 12c:	8fc080e7          	jalr	-1796(ra) # a24 <printf>
        exit(-1);
 130:	557d                	li	a0,-1
 132:	00000097          	auipc	ra,0x0
 136:	572080e7          	jalr	1394(ra) # 6a4 <exit>

000000000000013a <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 13a:	1141                	addi	sp,sp,-16
 13c:	e406                	sd	ra,8(sp)
 13e:	e022                	sd	s0,0(sp)
 140:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 142:	09800513          	li	a0,152
 146:	00001097          	auipc	ra,0x1
 14a:	996080e7          	jalr	-1642(ra) # adc <malloc>

    main_thread->tid = next_tid;
 14e:	00001797          	auipc	a5,0x1
 152:	eb278793          	addi	a5,a5,-334 # 1000 <next_tid>
 156:	4398                	lw	a4,0(a5)
 158:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 15c:	4398                	lw	a4,0(a5)
 15e:	2705                	addiw	a4,a4,1
 160:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 162:	4791                	li	a5,4
 164:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 166:	00001797          	auipc	a5,0x1
 16a:	eaa7b523          	sd	a0,-342(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 16e:	00001797          	auipc	a5,0x1
 172:	eb278793          	addi	a5,a5,-334 # 1020 <threads>
 176:	00001717          	auipc	a4,0x1
 17a:	f2a70713          	addi	a4,a4,-214 # 10a0 <base>
        threads[i] = NULL;
 17e:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 182:	07a1                	addi	a5,a5,8
 184:	fee79de3          	bne	a5,a4,17e <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 188:	00001797          	auipc	a5,0x1
 18c:	e8a7bc23          	sd	a0,-360(a5) # 1020 <threads>
}
 190:	60a2                	ld	ra,8(sp)
 192:	6402                	ld	s0,0(sp)
 194:	0141                	addi	sp,sp,16
 196:	8082                	ret

0000000000000198 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 198:	00001517          	auipc	a0,0x1
 19c:	e7853503          	ld	a0,-392(a0) # 1010 <current_thread>
 1a0:	00001717          	auipc	a4,0x1
 1a4:	e8070713          	addi	a4,a4,-384 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1a8:	4781                	li	a5,0
 1aa:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1ac:	6314                	ld	a3,0(a4)
 1ae:	00a68763          	beq	a3,a0,1bc <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1b2:	2785                	addiw	a5,a5,1
 1b4:	0721                	addi	a4,a4,8
 1b6:	fec79be3          	bne	a5,a2,1ac <tsched+0x14>
    int current_index = 0;
 1ba:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1bc:	0017869b          	addiw	a3,a5,1
 1c0:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1c4:	00001817          	auipc	a6,0x1
 1c8:	e5c80813          	addi	a6,a6,-420 # 1020 <threads>
 1cc:	488d                	li	a7,3
 1ce:	a021                	j	1d6 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1d0:	2685                	addiw	a3,a3,1
 1d2:	04c68363          	beq	a3,a2,218 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1d6:	41f6d71b          	sraiw	a4,a3,0x1f
 1da:	01c7571b          	srliw	a4,a4,0x1c
 1de:	00d707bb          	addw	a5,a4,a3
 1e2:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1e4:	9f99                	subw	a5,a5,a4
 1e6:	078e                	slli	a5,a5,0x3
 1e8:	97c2                	add	a5,a5,a6
 1ea:	638c                	ld	a1,0(a5)
 1ec:	d1f5                	beqz	a1,1d0 <tsched+0x38>
 1ee:	5dbc                	lw	a5,120(a1)
 1f0:	ff1790e3          	bne	a5,a7,1d0 <tsched+0x38>
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e406                	sd	ra,8(sp)
 1f8:	e022                	sd	s0,0(sp)
 1fa:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1fc:	00001797          	auipc	a5,0x1
 200:	e0b7ba23          	sd	a1,-492(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 204:	05a1                	addi	a1,a1,8
 206:	0521                	addi	a0,a0,8
 208:	00000097          	auipc	ra,0x0
 20c:	19a080e7          	jalr	410(ra) # 3a2 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 210:	60a2                	ld	ra,8(sp)
 212:	6402                	ld	s0,0(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret
 218:	8082                	ret

000000000000021a <thread_wrapper>:
{
 21a:	1101                	addi	sp,sp,-32
 21c:	ec06                	sd	ra,24(sp)
 21e:	e822                	sd	s0,16(sp)
 220:	e426                	sd	s1,8(sp)
 222:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 224:	00001497          	auipc	s1,0x1
 228:	dec48493          	addi	s1,s1,-532 # 1010 <current_thread>
 22c:	609c                	ld	a5,0(s1)
 22e:	6b9c                	ld	a5,16(a5)
    func(arg);
 230:	6398                	ld	a4,0(a5)
 232:	6788                	ld	a0,8(a5)
 234:	9702                	jalr	a4
    current_thread->state = EXITED;
 236:	609c                	ld	a5,0(s1)
 238:	4719                	li	a4,6
 23a:	dfb8                	sw	a4,120(a5)
    tsched();
 23c:	00000097          	auipc	ra,0x0
 240:	f5c080e7          	jalr	-164(ra) # 198 <tsched>
}
 244:	60e2                	ld	ra,24(sp)
 246:	6442                	ld	s0,16(sp)
 248:	64a2                	ld	s1,8(sp)
 24a:	6105                	addi	sp,sp,32
 24c:	8082                	ret

000000000000024e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 24e:	7179                	addi	sp,sp,-48
 250:	f406                	sd	ra,40(sp)
 252:	f022                	sd	s0,32(sp)
 254:	ec26                	sd	s1,24(sp)
 256:	e84a                	sd	s2,16(sp)
 258:	e44e                	sd	s3,8(sp)
 25a:	1800                	addi	s0,sp,48
 25c:	84aa                	mv	s1,a0
 25e:	8932                	mv	s2,a2
 260:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 262:	09800513          	li	a0,152
 266:	00001097          	auipc	ra,0x1
 26a:	876080e7          	jalr	-1930(ra) # adc <malloc>
 26e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 270:	478d                	li	a5,3
 272:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 274:	609c                	ld	a5,0(s1)
 276:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 27a:	609c                	ld	a5,0(s1)
 27c:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 280:	6098                	ld	a4,0(s1)
 282:	00001797          	auipc	a5,0x1
 286:	d7e78793          	addi	a5,a5,-642 # 1000 <next_tid>
 28a:	4394                	lw	a3,0(a5)
 28c:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 290:	4398                	lw	a4,0(a5)
 292:	2705                	addiw	a4,a4,1
 294:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 296:	6505                	lui	a0,0x1
 298:	00001097          	auipc	ra,0x1
 29c:	844080e7          	jalr	-1980(ra) # adc <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 2a0:	6785                	lui	a5,0x1
 2a2:	00a78733          	add	a4,a5,a0
 2a6:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 2aa:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x370>
 2ac:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 2ae:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 2b2:	609c                	ld	a5,0(s1)
 2b4:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2b6:	609c                	ld	a5,0(s1)
 2b8:	00000717          	auipc	a4,0x0
 2bc:	f6270713          	addi	a4,a4,-158 # 21a <thread_wrapper>
 2c0:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 2c2:	00001717          	auipc	a4,0x1
 2c6:	d5e70713          	addi	a4,a4,-674 # 1020 <threads>
 2ca:	4781                	li	a5,0
 2cc:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2ce:	6314                	ld	a3,0(a4)
 2d0:	c29d                	beqz	a3,2f6 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 2d2:	2785                	addiw	a5,a5,1
 2d4:	0721                	addi	a4,a4,8
 2d6:	fec79ce3          	bne	a5,a2,2ce <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 2da:	6088                	ld	a0,0(s1)
 2dc:	00000097          	auipc	ra,0x0
 2e0:	77e080e7          	jalr	1918(ra) # a5a <free>
        *thread = NULL;
 2e4:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 2e8:	70a2                	ld	ra,40(sp)
 2ea:	7402                	ld	s0,32(sp)
 2ec:	64e2                	ld	s1,24(sp)
 2ee:	6942                	ld	s2,16(sp)
 2f0:	69a2                	ld	s3,8(sp)
 2f2:	6145                	addi	sp,sp,48
 2f4:	8082                	ret
            threads[i] = *thread;
 2f6:	6094                	ld	a3,0(s1)
 2f8:	078e                	slli	a5,a5,0x3
 2fa:	00001717          	auipc	a4,0x1
 2fe:	d2670713          	addi	a4,a4,-730 # 1020 <threads>
 302:	97ba                	add	a5,a5,a4
 304:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 306:	b7cd                	j	2e8 <tcreate+0x9a>

0000000000000308 <tyield>:
    return 0;
}


void tyield()
{
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 310:	00001797          	auipc	a5,0x1
 314:	d007b783          	ld	a5,-768(a5) # 1010 <current_thread>
 318:	470d                	li	a4,3
 31a:	dfb8                	sw	a4,120(a5)
    tsched();
 31c:	00000097          	auipc	ra,0x0
 320:	e7c080e7          	jalr	-388(ra) # 198 <tsched>
}
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <tjoin>:
{
 32c:	1101                	addi	sp,sp,-32
 32e:	ec06                	sd	ra,24(sp)
 330:	e822                	sd	s0,16(sp)
 332:	e426                	sd	s1,8(sp)
 334:	e04a                	sd	s2,0(sp)
 336:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 338:	00001797          	auipc	a5,0x1
 33c:	ce878793          	addi	a5,a5,-792 # 1020 <threads>
 340:	00001697          	auipc	a3,0x1
 344:	d6068693          	addi	a3,a3,-672 # 10a0 <base>
 348:	a021                	j	350 <tjoin+0x24>
 34a:	07a1                	addi	a5,a5,8
 34c:	02d78b63          	beq	a5,a3,382 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 350:	6384                	ld	s1,0(a5)
 352:	dce5                	beqz	s1,34a <tjoin+0x1e>
 354:	0004c703          	lbu	a4,0(s1)
 358:	fea719e3          	bne	a4,a0,34a <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 35c:	5cb8                	lw	a4,120(s1)
 35e:	4799                	li	a5,6
 360:	4919                	li	s2,6
 362:	02f70263          	beq	a4,a5,386 <tjoin+0x5a>
        tyield();
 366:	00000097          	auipc	ra,0x0
 36a:	fa2080e7          	jalr	-94(ra) # 308 <tyield>
    while (target_thread->state != EXITED) {
 36e:	5cbc                	lw	a5,120(s1)
 370:	ff279be3          	bne	a5,s2,366 <tjoin+0x3a>
    return 0;
 374:	4501                	li	a0,0
}
 376:	60e2                	ld	ra,24(sp)
 378:	6442                	ld	s0,16(sp)
 37a:	64a2                	ld	s1,8(sp)
 37c:	6902                	ld	s2,0(sp)
 37e:	6105                	addi	sp,sp,32
 380:	8082                	ret
        return -1;
 382:	557d                	li	a0,-1
 384:	bfcd                	j	376 <tjoin+0x4a>
    return 0;
 386:	4501                	li	a0,0
 388:	b7fd                	j	376 <tjoin+0x4a>

000000000000038a <twhoami>:

uint8 twhoami()
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 390:	00001797          	auipc	a5,0x1
 394:	c807b783          	ld	a5,-896(a5) # 1010 <current_thread>
 398:	0007c503          	lbu	a0,0(a5)
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret

00000000000003a2 <tswtch>:
 3a2:	00153023          	sd	ra,0(a0)
 3a6:	00253423          	sd	sp,8(a0)
 3aa:	e900                	sd	s0,16(a0)
 3ac:	ed04                	sd	s1,24(a0)
 3ae:	03253023          	sd	s2,32(a0)
 3b2:	03353423          	sd	s3,40(a0)
 3b6:	03453823          	sd	s4,48(a0)
 3ba:	03553c23          	sd	s5,56(a0)
 3be:	05653023          	sd	s6,64(a0)
 3c2:	05753423          	sd	s7,72(a0)
 3c6:	05853823          	sd	s8,80(a0)
 3ca:	05953c23          	sd	s9,88(a0)
 3ce:	07a53023          	sd	s10,96(a0)
 3d2:	07b53423          	sd	s11,104(a0)
 3d6:	0005b083          	ld	ra,0(a1)
 3da:	0085b103          	ld	sp,8(a1)
 3de:	6980                	ld	s0,16(a1)
 3e0:	6d84                	ld	s1,24(a1)
 3e2:	0205b903          	ld	s2,32(a1)
 3e6:	0285b983          	ld	s3,40(a1)
 3ea:	0305ba03          	ld	s4,48(a1)
 3ee:	0385ba83          	ld	s5,56(a1)
 3f2:	0405bb03          	ld	s6,64(a1)
 3f6:	0485bb83          	ld	s7,72(a1)
 3fa:	0505bc03          	ld	s8,80(a1)
 3fe:	0585bc83          	ld	s9,88(a1)
 402:	0605bd03          	ld	s10,96(a1)
 406:	0685bd83          	ld	s11,104(a1)
 40a:	8082                	ret

000000000000040c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 40c:	1101                	addi	sp,sp,-32
 40e:	ec06                	sd	ra,24(sp)
 410:	e822                	sd	s0,16(sp)
 412:	e426                	sd	s1,8(sp)
 414:	e04a                	sd	s2,0(sp)
 416:	1000                	addi	s0,sp,32
 418:	84aa                	mv	s1,a0
 41a:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 41c:	00000097          	auipc	ra,0x0
 420:	d1e080e7          	jalr	-738(ra) # 13a <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 424:	85ca                	mv	a1,s2
 426:	8526                	mv	a0,s1
 428:	00000097          	auipc	ra,0x0
 42c:	bd8080e7          	jalr	-1064(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 430:	00000097          	auipc	ra,0x0
 434:	274080e7          	jalr	628(ra) # 6a4 <exit>

0000000000000438 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e422                	sd	s0,8(sp)
 43c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 43e:	87aa                	mv	a5,a0
 440:	0585                	addi	a1,a1,1
 442:	0785                	addi	a5,a5,1
 444:	fff5c703          	lbu	a4,-1(a1)
 448:	fee78fa3          	sb	a4,-1(a5)
 44c:	fb75                	bnez	a4,440 <strcpy+0x8>
        ;
    return os;
}
 44e:	6422                	ld	s0,8(sp)
 450:	0141                	addi	sp,sp,16
 452:	8082                	ret

0000000000000454 <strcmp>:

int strcmp(const char *p, const char *q)
{
 454:	1141                	addi	sp,sp,-16
 456:	e422                	sd	s0,8(sp)
 458:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 45a:	00054783          	lbu	a5,0(a0)
 45e:	cb91                	beqz	a5,472 <strcmp+0x1e>
 460:	0005c703          	lbu	a4,0(a1)
 464:	00f71763          	bne	a4,a5,472 <strcmp+0x1e>
        p++, q++;
 468:	0505                	addi	a0,a0,1
 46a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 46c:	00054783          	lbu	a5,0(a0)
 470:	fbe5                	bnez	a5,460 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 472:	0005c503          	lbu	a0,0(a1)
}
 476:	40a7853b          	subw	a0,a5,a0
 47a:	6422                	ld	s0,8(sp)
 47c:	0141                	addi	sp,sp,16
 47e:	8082                	ret

0000000000000480 <strlen>:

uint strlen(const char *s)
{
 480:	1141                	addi	sp,sp,-16
 482:	e422                	sd	s0,8(sp)
 484:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 486:	00054783          	lbu	a5,0(a0)
 48a:	cf91                	beqz	a5,4a6 <strlen+0x26>
 48c:	0505                	addi	a0,a0,1
 48e:	87aa                	mv	a5,a0
 490:	86be                	mv	a3,a5
 492:	0785                	addi	a5,a5,1
 494:	fff7c703          	lbu	a4,-1(a5)
 498:	ff65                	bnez	a4,490 <strlen+0x10>
 49a:	40a6853b          	subw	a0,a3,a0
 49e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4a0:	6422                	ld	s0,8(sp)
 4a2:	0141                	addi	sp,sp,16
 4a4:	8082                	ret
    for (n = 0; s[n]; n++)
 4a6:	4501                	li	a0,0
 4a8:	bfe5                	j	4a0 <strlen+0x20>

00000000000004aa <memset>:

void *
memset(void *dst, int c, uint n)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e422                	sd	s0,8(sp)
 4ae:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4b0:	ca19                	beqz	a2,4c6 <memset+0x1c>
 4b2:	87aa                	mv	a5,a0
 4b4:	1602                	slli	a2,a2,0x20
 4b6:	9201                	srli	a2,a2,0x20
 4b8:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4bc:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4c0:	0785                	addi	a5,a5,1
 4c2:	fee79de3          	bne	a5,a4,4bc <memset+0x12>
    }
    return dst;
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret

00000000000004cc <strchr>:

char *
strchr(const char *s, char c)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e422                	sd	s0,8(sp)
 4d0:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4d2:	00054783          	lbu	a5,0(a0)
 4d6:	cb99                	beqz	a5,4ec <strchr+0x20>
        if (*s == c)
 4d8:	00f58763          	beq	a1,a5,4e6 <strchr+0x1a>
    for (; *s; s++)
 4dc:	0505                	addi	a0,a0,1
 4de:	00054783          	lbu	a5,0(a0)
 4e2:	fbfd                	bnez	a5,4d8 <strchr+0xc>
            return (char *)s;
    return 0;
 4e4:	4501                	li	a0,0
}
 4e6:	6422                	ld	s0,8(sp)
 4e8:	0141                	addi	sp,sp,16
 4ea:	8082                	ret
    return 0;
 4ec:	4501                	li	a0,0
 4ee:	bfe5                	j	4e6 <strchr+0x1a>

00000000000004f0 <gets>:

char *
gets(char *buf, int max)
{
 4f0:	711d                	addi	sp,sp,-96
 4f2:	ec86                	sd	ra,88(sp)
 4f4:	e8a2                	sd	s0,80(sp)
 4f6:	e4a6                	sd	s1,72(sp)
 4f8:	e0ca                	sd	s2,64(sp)
 4fa:	fc4e                	sd	s3,56(sp)
 4fc:	f852                	sd	s4,48(sp)
 4fe:	f456                	sd	s5,40(sp)
 500:	f05a                	sd	s6,32(sp)
 502:	ec5e                	sd	s7,24(sp)
 504:	1080                	addi	s0,sp,96
 506:	8baa                	mv	s7,a0
 508:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 50a:	892a                	mv	s2,a0
 50c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 50e:	4aa9                	li	s5,10
 510:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 512:	89a6                	mv	s3,s1
 514:	2485                	addiw	s1,s1,1
 516:	0344d863          	bge	s1,s4,546 <gets+0x56>
        cc = read(0, &c, 1);
 51a:	4605                	li	a2,1
 51c:	faf40593          	addi	a1,s0,-81
 520:	4501                	li	a0,0
 522:	00000097          	auipc	ra,0x0
 526:	19a080e7          	jalr	410(ra) # 6bc <read>
        if (cc < 1)
 52a:	00a05e63          	blez	a0,546 <gets+0x56>
        buf[i++] = c;
 52e:	faf44783          	lbu	a5,-81(s0)
 532:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 536:	01578763          	beq	a5,s5,544 <gets+0x54>
 53a:	0905                	addi	s2,s2,1
 53c:	fd679be3          	bne	a5,s6,512 <gets+0x22>
    for (i = 0; i + 1 < max;)
 540:	89a6                	mv	s3,s1
 542:	a011                	j	546 <gets+0x56>
 544:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 546:	99de                	add	s3,s3,s7
 548:	00098023          	sb	zero,0(s3)
    return buf;
}
 54c:	855e                	mv	a0,s7
 54e:	60e6                	ld	ra,88(sp)
 550:	6446                	ld	s0,80(sp)
 552:	64a6                	ld	s1,72(sp)
 554:	6906                	ld	s2,64(sp)
 556:	79e2                	ld	s3,56(sp)
 558:	7a42                	ld	s4,48(sp)
 55a:	7aa2                	ld	s5,40(sp)
 55c:	7b02                	ld	s6,32(sp)
 55e:	6be2                	ld	s7,24(sp)
 560:	6125                	addi	sp,sp,96
 562:	8082                	ret

0000000000000564 <stat>:

int stat(const char *n, struct stat *st)
{
 564:	1101                	addi	sp,sp,-32
 566:	ec06                	sd	ra,24(sp)
 568:	e822                	sd	s0,16(sp)
 56a:	e426                	sd	s1,8(sp)
 56c:	e04a                	sd	s2,0(sp)
 56e:	1000                	addi	s0,sp,32
 570:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 572:	4581                	li	a1,0
 574:	00000097          	auipc	ra,0x0
 578:	170080e7          	jalr	368(ra) # 6e4 <open>
    if (fd < 0)
 57c:	02054563          	bltz	a0,5a6 <stat+0x42>
 580:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 582:	85ca                	mv	a1,s2
 584:	00000097          	auipc	ra,0x0
 588:	178080e7          	jalr	376(ra) # 6fc <fstat>
 58c:	892a                	mv	s2,a0
    close(fd);
 58e:	8526                	mv	a0,s1
 590:	00000097          	auipc	ra,0x0
 594:	13c080e7          	jalr	316(ra) # 6cc <close>
    return r;
}
 598:	854a                	mv	a0,s2
 59a:	60e2                	ld	ra,24(sp)
 59c:	6442                	ld	s0,16(sp)
 59e:	64a2                	ld	s1,8(sp)
 5a0:	6902                	ld	s2,0(sp)
 5a2:	6105                	addi	sp,sp,32
 5a4:	8082                	ret
        return -1;
 5a6:	597d                	li	s2,-1
 5a8:	bfc5                	j	598 <stat+0x34>

00000000000005aa <atoi>:

int atoi(const char *s)
{
 5aa:	1141                	addi	sp,sp,-16
 5ac:	e422                	sd	s0,8(sp)
 5ae:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5b0:	00054683          	lbu	a3,0(a0)
 5b4:	fd06879b          	addiw	a5,a3,-48
 5b8:	0ff7f793          	zext.b	a5,a5
 5bc:	4625                	li	a2,9
 5be:	02f66863          	bltu	a2,a5,5ee <atoi+0x44>
 5c2:	872a                	mv	a4,a0
    n = 0;
 5c4:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5c6:	0705                	addi	a4,a4,1
 5c8:	0025179b          	slliw	a5,a0,0x2
 5cc:	9fa9                	addw	a5,a5,a0
 5ce:	0017979b          	slliw	a5,a5,0x1
 5d2:	9fb5                	addw	a5,a5,a3
 5d4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5d8:	00074683          	lbu	a3,0(a4)
 5dc:	fd06879b          	addiw	a5,a3,-48
 5e0:	0ff7f793          	zext.b	a5,a5
 5e4:	fef671e3          	bgeu	a2,a5,5c6 <atoi+0x1c>
    return n;
}
 5e8:	6422                	ld	s0,8(sp)
 5ea:	0141                	addi	sp,sp,16
 5ec:	8082                	ret
    n = 0;
 5ee:	4501                	li	a0,0
 5f0:	bfe5                	j	5e8 <atoi+0x3e>

00000000000005f2 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5f2:	1141                	addi	sp,sp,-16
 5f4:	e422                	sd	s0,8(sp)
 5f6:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5f8:	02b57463          	bgeu	a0,a1,620 <memmove+0x2e>
    {
        while (n-- > 0)
 5fc:	00c05f63          	blez	a2,61a <memmove+0x28>
 600:	1602                	slli	a2,a2,0x20
 602:	9201                	srli	a2,a2,0x20
 604:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 608:	872a                	mv	a4,a0
            *dst++ = *src++;
 60a:	0585                	addi	a1,a1,1
 60c:	0705                	addi	a4,a4,1
 60e:	fff5c683          	lbu	a3,-1(a1)
 612:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 616:	fee79ae3          	bne	a5,a4,60a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 61a:	6422                	ld	s0,8(sp)
 61c:	0141                	addi	sp,sp,16
 61e:	8082                	ret
        dst += n;
 620:	00c50733          	add	a4,a0,a2
        src += n;
 624:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 626:	fec05ae3          	blez	a2,61a <memmove+0x28>
 62a:	fff6079b          	addiw	a5,a2,-1
 62e:	1782                	slli	a5,a5,0x20
 630:	9381                	srli	a5,a5,0x20
 632:	fff7c793          	not	a5,a5
 636:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 638:	15fd                	addi	a1,a1,-1
 63a:	177d                	addi	a4,a4,-1
 63c:	0005c683          	lbu	a3,0(a1)
 640:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 644:	fee79ae3          	bne	a5,a4,638 <memmove+0x46>
 648:	bfc9                	j	61a <memmove+0x28>

000000000000064a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 64a:	1141                	addi	sp,sp,-16
 64c:	e422                	sd	s0,8(sp)
 64e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 650:	ca05                	beqz	a2,680 <memcmp+0x36>
 652:	fff6069b          	addiw	a3,a2,-1
 656:	1682                	slli	a3,a3,0x20
 658:	9281                	srli	a3,a3,0x20
 65a:	0685                	addi	a3,a3,1
 65c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 65e:	00054783          	lbu	a5,0(a0)
 662:	0005c703          	lbu	a4,0(a1)
 666:	00e79863          	bne	a5,a4,676 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 66a:	0505                	addi	a0,a0,1
        p2++;
 66c:	0585                	addi	a1,a1,1
    while (n-- > 0)
 66e:	fed518e3          	bne	a0,a3,65e <memcmp+0x14>
    }
    return 0;
 672:	4501                	li	a0,0
 674:	a019                	j	67a <memcmp+0x30>
            return *p1 - *p2;
 676:	40e7853b          	subw	a0,a5,a4
}
 67a:	6422                	ld	s0,8(sp)
 67c:	0141                	addi	sp,sp,16
 67e:	8082                	ret
    return 0;
 680:	4501                	li	a0,0
 682:	bfe5                	j	67a <memcmp+0x30>

0000000000000684 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 684:	1141                	addi	sp,sp,-16
 686:	e406                	sd	ra,8(sp)
 688:	e022                	sd	s0,0(sp)
 68a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 68c:	00000097          	auipc	ra,0x0
 690:	f66080e7          	jalr	-154(ra) # 5f2 <memmove>
}
 694:	60a2                	ld	ra,8(sp)
 696:	6402                	ld	s0,0(sp)
 698:	0141                	addi	sp,sp,16
 69a:	8082                	ret

000000000000069c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 69c:	4885                	li	a7,1
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6a4:	4889                	li	a7,2
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <wait>:
.global wait
wait:
 li a7, SYS_wait
 6ac:	488d                	li	a7,3
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6b4:	4891                	li	a7,4
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <read>:
.global read
read:
 li a7, SYS_read
 6bc:	4895                	li	a7,5
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <write>:
.global write
write:
 li a7, SYS_write
 6c4:	48c1                	li	a7,16
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <close>:
.global close
close:
 li a7, SYS_close
 6cc:	48d5                	li	a7,21
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6d4:	4899                	li	a7,6
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <exec>:
.global exec
exec:
 li a7, SYS_exec
 6dc:	489d                	li	a7,7
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <open>:
.global open
open:
 li a7, SYS_open
 6e4:	48bd                	li	a7,15
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6ec:	48c5                	li	a7,17
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6f4:	48c9                	li	a7,18
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6fc:	48a1                	li	a7,8
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <link>:
.global link
link:
 li a7, SYS_link
 704:	48cd                	li	a7,19
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 70c:	48d1                	li	a7,20
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 714:	48a5                	li	a7,9
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <dup>:
.global dup
dup:
 li a7, SYS_dup
 71c:	48a9                	li	a7,10
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 724:	48ad                	li	a7,11
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 72c:	48b1                	li	a7,12
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 734:	48b5                	li	a7,13
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 73c:	48b9                	li	a7,14
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <ps>:
.global ps
ps:
 li a7, SYS_ps
 744:	48d9                	li	a7,22
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 74c:	48dd                	li	a7,23
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 754:	48e1                	li	a7,24
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 75c:	1101                	addi	sp,sp,-32
 75e:	ec06                	sd	ra,24(sp)
 760:	e822                	sd	s0,16(sp)
 762:	1000                	addi	s0,sp,32
 764:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 768:	4605                	li	a2,1
 76a:	fef40593          	addi	a1,s0,-17
 76e:	00000097          	auipc	ra,0x0
 772:	f56080e7          	jalr	-170(ra) # 6c4 <write>
}
 776:	60e2                	ld	ra,24(sp)
 778:	6442                	ld	s0,16(sp)
 77a:	6105                	addi	sp,sp,32
 77c:	8082                	ret

000000000000077e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 77e:	7139                	addi	sp,sp,-64
 780:	fc06                	sd	ra,56(sp)
 782:	f822                	sd	s0,48(sp)
 784:	f426                	sd	s1,40(sp)
 786:	f04a                	sd	s2,32(sp)
 788:	ec4e                	sd	s3,24(sp)
 78a:	0080                	addi	s0,sp,64
 78c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 78e:	c299                	beqz	a3,794 <printint+0x16>
 790:	0805c963          	bltz	a1,822 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 794:	2581                	sext.w	a1,a1
  neg = 0;
 796:	4881                	li	a7,0
 798:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 79c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 79e:	2601                	sext.w	a2,a2
 7a0:	00000517          	auipc	a0,0x0
 7a4:	4e050513          	addi	a0,a0,1248 # c80 <digits>
 7a8:	883a                	mv	a6,a4
 7aa:	2705                	addiw	a4,a4,1
 7ac:	02c5f7bb          	remuw	a5,a1,a2
 7b0:	1782                	slli	a5,a5,0x20
 7b2:	9381                	srli	a5,a5,0x20
 7b4:	97aa                	add	a5,a5,a0
 7b6:	0007c783          	lbu	a5,0(a5)
 7ba:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7be:	0005879b          	sext.w	a5,a1
 7c2:	02c5d5bb          	divuw	a1,a1,a2
 7c6:	0685                	addi	a3,a3,1
 7c8:	fec7f0e3          	bgeu	a5,a2,7a8 <printint+0x2a>
  if(neg)
 7cc:	00088c63          	beqz	a7,7e4 <printint+0x66>
    buf[i++] = '-';
 7d0:	fd070793          	addi	a5,a4,-48
 7d4:	00878733          	add	a4,a5,s0
 7d8:	02d00793          	li	a5,45
 7dc:	fef70823          	sb	a5,-16(a4)
 7e0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7e4:	02e05863          	blez	a4,814 <printint+0x96>
 7e8:	fc040793          	addi	a5,s0,-64
 7ec:	00e78933          	add	s2,a5,a4
 7f0:	fff78993          	addi	s3,a5,-1
 7f4:	99ba                	add	s3,s3,a4
 7f6:	377d                	addiw	a4,a4,-1
 7f8:	1702                	slli	a4,a4,0x20
 7fa:	9301                	srli	a4,a4,0x20
 7fc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 800:	fff94583          	lbu	a1,-1(s2)
 804:	8526                	mv	a0,s1
 806:	00000097          	auipc	ra,0x0
 80a:	f56080e7          	jalr	-170(ra) # 75c <putc>
  while(--i >= 0)
 80e:	197d                	addi	s2,s2,-1
 810:	ff3918e3          	bne	s2,s3,800 <printint+0x82>
}
 814:	70e2                	ld	ra,56(sp)
 816:	7442                	ld	s0,48(sp)
 818:	74a2                	ld	s1,40(sp)
 81a:	7902                	ld	s2,32(sp)
 81c:	69e2                	ld	s3,24(sp)
 81e:	6121                	addi	sp,sp,64
 820:	8082                	ret
    x = -xx;
 822:	40b005bb          	negw	a1,a1
    neg = 1;
 826:	4885                	li	a7,1
    x = -xx;
 828:	bf85                	j	798 <printint+0x1a>

000000000000082a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82a:	715d                	addi	sp,sp,-80
 82c:	e486                	sd	ra,72(sp)
 82e:	e0a2                	sd	s0,64(sp)
 830:	fc26                	sd	s1,56(sp)
 832:	f84a                	sd	s2,48(sp)
 834:	f44e                	sd	s3,40(sp)
 836:	f052                	sd	s4,32(sp)
 838:	ec56                	sd	s5,24(sp)
 83a:	e85a                	sd	s6,16(sp)
 83c:	e45e                	sd	s7,8(sp)
 83e:	e062                	sd	s8,0(sp)
 840:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 842:	0005c903          	lbu	s2,0(a1)
 846:	18090c63          	beqz	s2,9de <vprintf+0x1b4>
 84a:	8aaa                	mv	s5,a0
 84c:	8bb2                	mv	s7,a2
 84e:	00158493          	addi	s1,a1,1
  state = 0;
 852:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 854:	02500a13          	li	s4,37
 858:	4b55                	li	s6,21
 85a:	a839                	j	878 <vprintf+0x4e>
        putc(fd, c);
 85c:	85ca                	mv	a1,s2
 85e:	8556                	mv	a0,s5
 860:	00000097          	auipc	ra,0x0
 864:	efc080e7          	jalr	-260(ra) # 75c <putc>
 868:	a019                	j	86e <vprintf+0x44>
    } else if(state == '%'){
 86a:	01498d63          	beq	s3,s4,884 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 86e:	0485                	addi	s1,s1,1
 870:	fff4c903          	lbu	s2,-1(s1)
 874:	16090563          	beqz	s2,9de <vprintf+0x1b4>
    if(state == 0){
 878:	fe0999e3          	bnez	s3,86a <vprintf+0x40>
      if(c == '%'){
 87c:	ff4910e3          	bne	s2,s4,85c <vprintf+0x32>
        state = '%';
 880:	89d2                	mv	s3,s4
 882:	b7f5                	j	86e <vprintf+0x44>
      if(c == 'd'){
 884:	13490263          	beq	s2,s4,9a8 <vprintf+0x17e>
 888:	f9d9079b          	addiw	a5,s2,-99
 88c:	0ff7f793          	zext.b	a5,a5
 890:	12fb6563          	bltu	s6,a5,9ba <vprintf+0x190>
 894:	f9d9079b          	addiw	a5,s2,-99
 898:	0ff7f713          	zext.b	a4,a5
 89c:	10eb6f63          	bltu	s6,a4,9ba <vprintf+0x190>
 8a0:	00271793          	slli	a5,a4,0x2
 8a4:	00000717          	auipc	a4,0x0
 8a8:	38470713          	addi	a4,a4,900 # c28 <malloc+0x14c>
 8ac:	97ba                	add	a5,a5,a4
 8ae:	439c                	lw	a5,0(a5)
 8b0:	97ba                	add	a5,a5,a4
 8b2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8b4:	008b8913          	addi	s2,s7,8
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	000ba583          	lw	a1,0(s7)
 8c0:	8556                	mv	a0,s5
 8c2:	00000097          	auipc	ra,0x0
 8c6:	ebc080e7          	jalr	-324(ra) # 77e <printint>
 8ca:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	b745                	j	86e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d0:	008b8913          	addi	s2,s7,8
 8d4:	4681                	li	a3,0
 8d6:	4629                	li	a2,10
 8d8:	000ba583          	lw	a1,0(s7)
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	ea0080e7          	jalr	-352(ra) # 77e <printint>
 8e6:	8bca                	mv	s7,s2
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	b751                	j	86e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8ec:	008b8913          	addi	s2,s7,8
 8f0:	4681                	li	a3,0
 8f2:	4641                	li	a2,16
 8f4:	000ba583          	lw	a1,0(s7)
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	e84080e7          	jalr	-380(ra) # 77e <printint>
 902:	8bca                	mv	s7,s2
      state = 0;
 904:	4981                	li	s3,0
 906:	b7a5                	j	86e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 908:	008b8c13          	addi	s8,s7,8
 90c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 910:	03000593          	li	a1,48
 914:	8556                	mv	a0,s5
 916:	00000097          	auipc	ra,0x0
 91a:	e46080e7          	jalr	-442(ra) # 75c <putc>
  putc(fd, 'x');
 91e:	07800593          	li	a1,120
 922:	8556                	mv	a0,s5
 924:	00000097          	auipc	ra,0x0
 928:	e38080e7          	jalr	-456(ra) # 75c <putc>
 92c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 92e:	00000b97          	auipc	s7,0x0
 932:	352b8b93          	addi	s7,s7,850 # c80 <digits>
 936:	03c9d793          	srli	a5,s3,0x3c
 93a:	97de                	add	a5,a5,s7
 93c:	0007c583          	lbu	a1,0(a5)
 940:	8556                	mv	a0,s5
 942:	00000097          	auipc	ra,0x0
 946:	e1a080e7          	jalr	-486(ra) # 75c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 94a:	0992                	slli	s3,s3,0x4
 94c:	397d                	addiw	s2,s2,-1
 94e:	fe0914e3          	bnez	s2,936 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 952:	8be2                	mv	s7,s8
      state = 0;
 954:	4981                	li	s3,0
 956:	bf21                	j	86e <vprintf+0x44>
        s = va_arg(ap, char*);
 958:	008b8993          	addi	s3,s7,8
 95c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 960:	02090163          	beqz	s2,982 <vprintf+0x158>
        while(*s != 0){
 964:	00094583          	lbu	a1,0(s2)
 968:	c9a5                	beqz	a1,9d8 <vprintf+0x1ae>
          putc(fd, *s);
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	df0080e7          	jalr	-528(ra) # 75c <putc>
          s++;
 974:	0905                	addi	s2,s2,1
        while(*s != 0){
 976:	00094583          	lbu	a1,0(s2)
 97a:	f9e5                	bnez	a1,96a <vprintf+0x140>
        s = va_arg(ap, char*);
 97c:	8bce                	mv	s7,s3
      state = 0;
 97e:	4981                	li	s3,0
 980:	b5fd                	j	86e <vprintf+0x44>
          s = "(null)";
 982:	00000917          	auipc	s2,0x0
 986:	29e90913          	addi	s2,s2,670 # c20 <malloc+0x144>
        while(*s != 0){
 98a:	02800593          	li	a1,40
 98e:	bff1                	j	96a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 990:	008b8913          	addi	s2,s7,8
 994:	000bc583          	lbu	a1,0(s7)
 998:	8556                	mv	a0,s5
 99a:	00000097          	auipc	ra,0x0
 99e:	dc2080e7          	jalr	-574(ra) # 75c <putc>
 9a2:	8bca                	mv	s7,s2
      state = 0;
 9a4:	4981                	li	s3,0
 9a6:	b5e1                	j	86e <vprintf+0x44>
        putc(fd, c);
 9a8:	02500593          	li	a1,37
 9ac:	8556                	mv	a0,s5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	dae080e7          	jalr	-594(ra) # 75c <putc>
      state = 0;
 9b6:	4981                	li	s3,0
 9b8:	bd5d                	j	86e <vprintf+0x44>
        putc(fd, '%');
 9ba:	02500593          	li	a1,37
 9be:	8556                	mv	a0,s5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	d9c080e7          	jalr	-612(ra) # 75c <putc>
        putc(fd, c);
 9c8:	85ca                	mv	a1,s2
 9ca:	8556                	mv	a0,s5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	d90080e7          	jalr	-624(ra) # 75c <putc>
      state = 0;
 9d4:	4981                	li	s3,0
 9d6:	bd61                	j	86e <vprintf+0x44>
        s = va_arg(ap, char*);
 9d8:	8bce                	mv	s7,s3
      state = 0;
 9da:	4981                	li	s3,0
 9dc:	bd49                	j	86e <vprintf+0x44>
    }
  }
}
 9de:	60a6                	ld	ra,72(sp)
 9e0:	6406                	ld	s0,64(sp)
 9e2:	74e2                	ld	s1,56(sp)
 9e4:	7942                	ld	s2,48(sp)
 9e6:	79a2                	ld	s3,40(sp)
 9e8:	7a02                	ld	s4,32(sp)
 9ea:	6ae2                	ld	s5,24(sp)
 9ec:	6b42                	ld	s6,16(sp)
 9ee:	6ba2                	ld	s7,8(sp)
 9f0:	6c02                	ld	s8,0(sp)
 9f2:	6161                	addi	sp,sp,80
 9f4:	8082                	ret

00000000000009f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f6:	715d                	addi	sp,sp,-80
 9f8:	ec06                	sd	ra,24(sp)
 9fa:	e822                	sd	s0,16(sp)
 9fc:	1000                	addi	s0,sp,32
 9fe:	e010                	sd	a2,0(s0)
 a00:	e414                	sd	a3,8(s0)
 a02:	e818                	sd	a4,16(s0)
 a04:	ec1c                	sd	a5,24(s0)
 a06:	03043023          	sd	a6,32(s0)
 a0a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a0e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a12:	8622                	mv	a2,s0
 a14:	00000097          	auipc	ra,0x0
 a18:	e16080e7          	jalr	-490(ra) # 82a <vprintf>
}
 a1c:	60e2                	ld	ra,24(sp)
 a1e:	6442                	ld	s0,16(sp)
 a20:	6161                	addi	sp,sp,80
 a22:	8082                	ret

0000000000000a24 <printf>:

void
printf(const char *fmt, ...)
{
 a24:	711d                	addi	sp,sp,-96
 a26:	ec06                	sd	ra,24(sp)
 a28:	e822                	sd	s0,16(sp)
 a2a:	1000                	addi	s0,sp,32
 a2c:	e40c                	sd	a1,8(s0)
 a2e:	e810                	sd	a2,16(s0)
 a30:	ec14                	sd	a3,24(s0)
 a32:	f018                	sd	a4,32(s0)
 a34:	f41c                	sd	a5,40(s0)
 a36:	03043823          	sd	a6,48(s0)
 a3a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a3e:	00840613          	addi	a2,s0,8
 a42:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a46:	85aa                	mv	a1,a0
 a48:	4505                	li	a0,1
 a4a:	00000097          	auipc	ra,0x0
 a4e:	de0080e7          	jalr	-544(ra) # 82a <vprintf>
}
 a52:	60e2                	ld	ra,24(sp)
 a54:	6442                	ld	s0,16(sp)
 a56:	6125                	addi	sp,sp,96
 a58:	8082                	ret

0000000000000a5a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a5a:	1141                	addi	sp,sp,-16
 a5c:	e422                	sd	s0,8(sp)
 a5e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a60:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a64:	00000797          	auipc	a5,0x0
 a68:	5b47b783          	ld	a5,1460(a5) # 1018 <freep>
 a6c:	a02d                	j	a96 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a6e:	4618                	lw	a4,8(a2)
 a70:	9f2d                	addw	a4,a4,a1
 a72:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a76:	6398                	ld	a4,0(a5)
 a78:	6310                	ld	a2,0(a4)
 a7a:	a83d                	j	ab8 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a7c:	ff852703          	lw	a4,-8(a0)
 a80:	9f31                	addw	a4,a4,a2
 a82:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a84:	ff053683          	ld	a3,-16(a0)
 a88:	a091                	j	acc <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8a:	6398                	ld	a4,0(a5)
 a8c:	00e7e463          	bltu	a5,a4,a94 <free+0x3a>
 a90:	00e6ea63          	bltu	a3,a4,aa4 <free+0x4a>
{
 a94:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a96:	fed7fae3          	bgeu	a5,a3,a8a <free+0x30>
 a9a:	6398                	ld	a4,0(a5)
 a9c:	00e6e463          	bltu	a3,a4,aa4 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa0:	fee7eae3          	bltu	a5,a4,a94 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 aa4:	ff852583          	lw	a1,-8(a0)
 aa8:	6390                	ld	a2,0(a5)
 aaa:	02059813          	slli	a6,a1,0x20
 aae:	01c85713          	srli	a4,a6,0x1c
 ab2:	9736                	add	a4,a4,a3
 ab4:	fae60de3          	beq	a2,a4,a6e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 ab8:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 abc:	4790                	lw	a2,8(a5)
 abe:	02061593          	slli	a1,a2,0x20
 ac2:	01c5d713          	srli	a4,a1,0x1c
 ac6:	973e                	add	a4,a4,a5
 ac8:	fae68ae3          	beq	a3,a4,a7c <free+0x22>
        p->s.ptr = bp->s.ptr;
 acc:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 ace:	00000717          	auipc	a4,0x0
 ad2:	54f73523          	sd	a5,1354(a4) # 1018 <freep>
}
 ad6:	6422                	ld	s0,8(sp)
 ad8:	0141                	addi	sp,sp,16
 ada:	8082                	ret

0000000000000adc <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 adc:	7139                	addi	sp,sp,-64
 ade:	fc06                	sd	ra,56(sp)
 ae0:	f822                	sd	s0,48(sp)
 ae2:	f426                	sd	s1,40(sp)
 ae4:	f04a                	sd	s2,32(sp)
 ae6:	ec4e                	sd	s3,24(sp)
 ae8:	e852                	sd	s4,16(sp)
 aea:	e456                	sd	s5,8(sp)
 aec:	e05a                	sd	s6,0(sp)
 aee:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 af0:	02051493          	slli	s1,a0,0x20
 af4:	9081                	srli	s1,s1,0x20
 af6:	04bd                	addi	s1,s1,15
 af8:	8091                	srli	s1,s1,0x4
 afa:	0014899b          	addiw	s3,s1,1
 afe:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b00:	00000517          	auipc	a0,0x0
 b04:	51853503          	ld	a0,1304(a0) # 1018 <freep>
 b08:	c515                	beqz	a0,b34 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b0a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b0c:	4798                	lw	a4,8(a5)
 b0e:	02977f63          	bgeu	a4,s1,b4c <malloc+0x70>
    if (nu < 4096)
 b12:	8a4e                	mv	s4,s3
 b14:	0009871b          	sext.w	a4,s3
 b18:	6685                	lui	a3,0x1
 b1a:	00d77363          	bgeu	a4,a3,b20 <malloc+0x44>
 b1e:	6a05                	lui	s4,0x1
 b20:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b24:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b28:	00000917          	auipc	s2,0x0
 b2c:	4f090913          	addi	s2,s2,1264 # 1018 <freep>
    if (p == (char *)-1)
 b30:	5afd                	li	s5,-1
 b32:	a895                	j	ba6 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b34:	00000797          	auipc	a5,0x0
 b38:	56c78793          	addi	a5,a5,1388 # 10a0 <base>
 b3c:	00000717          	auipc	a4,0x0
 b40:	4cf73e23          	sd	a5,1244(a4) # 1018 <freep>
 b44:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b46:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b4a:	b7e1                	j	b12 <malloc+0x36>
            if (p->s.size == nunits)
 b4c:	02e48c63          	beq	s1,a4,b84 <malloc+0xa8>
                p->s.size -= nunits;
 b50:	4137073b          	subw	a4,a4,s3
 b54:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b56:	02071693          	slli	a3,a4,0x20
 b5a:	01c6d713          	srli	a4,a3,0x1c
 b5e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b60:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b64:	00000717          	auipc	a4,0x0
 b68:	4aa73a23          	sd	a0,1204(a4) # 1018 <freep>
            return (void *)(p + 1);
 b6c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b70:	70e2                	ld	ra,56(sp)
 b72:	7442                	ld	s0,48(sp)
 b74:	74a2                	ld	s1,40(sp)
 b76:	7902                	ld	s2,32(sp)
 b78:	69e2                	ld	s3,24(sp)
 b7a:	6a42                	ld	s4,16(sp)
 b7c:	6aa2                	ld	s5,8(sp)
 b7e:	6b02                	ld	s6,0(sp)
 b80:	6121                	addi	sp,sp,64
 b82:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b84:	6398                	ld	a4,0(a5)
 b86:	e118                	sd	a4,0(a0)
 b88:	bff1                	j	b64 <malloc+0x88>
    hp->s.size = nu;
 b8a:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b8e:	0541                	addi	a0,a0,16
 b90:	00000097          	auipc	ra,0x0
 b94:	eca080e7          	jalr	-310(ra) # a5a <free>
    return freep;
 b98:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b9c:	d971                	beqz	a0,b70 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b9e:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ba0:	4798                	lw	a4,8(a5)
 ba2:	fa9775e3          	bgeu	a4,s1,b4c <malloc+0x70>
        if (p == freep)
 ba6:	00093703          	ld	a4,0(s2)
 baa:	853e                	mv	a0,a5
 bac:	fef719e3          	bne	a4,a5,b9e <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bb0:	8552                	mv	a0,s4
 bb2:	00000097          	auipc	ra,0x0
 bb6:	b7a080e7          	jalr	-1158(ra) # 72c <sbrk>
    if (p == (char *)-1)
 bba:	fd5518e3          	bne	a0,s5,b8a <malloc+0xae>
                return 0;
 bbe:	4501                	li	a0,0
 bc0:	bf45                	j	b70 <malloc+0x94>
