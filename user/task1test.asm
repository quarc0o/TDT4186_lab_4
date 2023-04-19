
user/_task1test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <hello_world>:
#include "kernel/types.h"
#include "user.h"

void *hello_world(void *arg)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    printf("Hello World\n");
   8:	00001517          	auipc	a0,0x1
   c:	bf850513          	addi	a0,a0,-1032 # c00 <malloc+0xec>
  10:	00001097          	auipc	ra,0x1
  14:	a4c080e7          	jalr	-1460(ra) # a5c <printf>
    return 0; // will be ignored, but just to make the compiler happy
}
  18:	4501                	li	a0,0
  1a:	60a2                	ld	ra,8(sp)
  1c:	6402                	ld	s0,0(sp)
  1e:	0141                	addi	sp,sp,16
  20:	8082                	ret

0000000000000022 <main>:

void main()
{
  22:	1101                	addi	sp,sp,-32
  24:	ec06                	sd	ra,24(sp)
  26:	e822                	sd	s0,16(sp)
  28:	1000                	addi	s0,sp,32
    // t not initialized
    struct thread *t;

    // passing &t (taking the address of the pointer value)
    tcreate(&t, 0, &hello_world, 0);
  2a:	4681                	li	a3,0
  2c:	00000617          	auipc	a2,0x0
  30:	fd460613          	addi	a2,a2,-44 # 0 <hello_world>
  34:	4581                	li	a1,0
  36:	fe840513          	addi	a0,s0,-24
  3a:	00000097          	auipc	ra,0x0
  3e:	24c080e7          	jalr	588(ra) # 286 <tcreate>
    // Now, t points to an initialized thread struct

    tyield();
  42:	00000097          	auipc	ra,0x0
  46:	2fe080e7          	jalr	766(ra) # 340 <tyield>
  4a:	60e2                	ld	ra,24(sp)
  4c:	6442                	ld	s0,16(sp)
  4e:	6105                	addi	sp,sp,32
  50:	8082                	ret

0000000000000052 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  52:	1141                	addi	sp,sp,-16
  54:	e422                	sd	s0,8(sp)
  56:	0800                	addi	s0,sp,16
    lk->name = name;
  58:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  5a:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  5e:	57fd                	li	a5,-1
  60:	00f50823          	sb	a5,16(a0)
}
  64:	6422                	ld	s0,8(sp)
  66:	0141                	addi	sp,sp,16
  68:	8082                	ret

000000000000006a <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  6a:	00054783          	lbu	a5,0(a0)
  6e:	e399                	bnez	a5,74 <holding+0xa>
  70:	4501                	li	a0,0
}
  72:	8082                	ret
{
  74:	1101                	addi	sp,sp,-32
  76:	ec06                	sd	ra,24(sp)
  78:	e822                	sd	s0,16(sp)
  7a:	e426                	sd	s1,8(sp)
  7c:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  7e:	01054483          	lbu	s1,16(a0)
  82:	00000097          	auipc	ra,0x0
  86:	340080e7          	jalr	832(ra) # 3c2 <twhoami>
  8a:	2501                	sext.w	a0,a0
  8c:	40a48533          	sub	a0,s1,a0
  90:	00153513          	seqz	a0,a0
}
  94:	60e2                	ld	ra,24(sp)
  96:	6442                	ld	s0,16(sp)
  98:	64a2                	ld	s1,8(sp)
  9a:	6105                	addi	sp,sp,32
  9c:	8082                	ret

000000000000009e <acquire>:

void acquire(struct lock *lk)
{
  9e:	7179                	addi	sp,sp,-48
  a0:	f406                	sd	ra,40(sp)
  a2:	f022                	sd	s0,32(sp)
  a4:	ec26                	sd	s1,24(sp)
  a6:	e84a                	sd	s2,16(sp)
  a8:	e44e                	sd	s3,8(sp)
  aa:	e052                	sd	s4,0(sp)
  ac:	1800                	addi	s0,sp,48
  ae:	8a2a                	mv	s4,a0
    if (holding(lk))
  b0:	00000097          	auipc	ra,0x0
  b4:	fba080e7          	jalr	-70(ra) # 6a <holding>
  b8:	e919                	bnez	a0,ce <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  ba:	ffca7493          	andi	s1,s4,-4
  be:	003a7913          	andi	s2,s4,3
  c2:	0039191b          	slliw	s2,s2,0x3
  c6:	4985                	li	s3,1
  c8:	012999bb          	sllw	s3,s3,s2
  cc:	a015                	j	f0 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  ce:	00001517          	auipc	a0,0x1
  d2:	b4250513          	addi	a0,a0,-1214 # c10 <malloc+0xfc>
  d6:	00001097          	auipc	ra,0x1
  da:	986080e7          	jalr	-1658(ra) # a5c <printf>
        exit(-1);
  de:	557d                	li	a0,-1
  e0:	00000097          	auipc	ra,0x0
  e4:	5fc080e7          	jalr	1532(ra) # 6dc <exit>
    {
        // give up the cpu for other threads
        tyield();
  e8:	00000097          	auipc	ra,0x0
  ec:	258080e7          	jalr	600(ra) # 340 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f0:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  f4:	0127d7bb          	srlw	a5,a5,s2
  f8:	0ff7f793          	zext.b	a5,a5
  fc:	f7f5                	bnez	a5,e8 <acquire+0x4a>
    }

    __sync_synchronize();
  fe:	0ff0000f          	fence

    lk->tid = twhoami();
 102:	00000097          	auipc	ra,0x0
 106:	2c0080e7          	jalr	704(ra) # 3c2 <twhoami>
 10a:	00aa0823          	sb	a0,16(s4)
}
 10e:	70a2                	ld	ra,40(sp)
 110:	7402                	ld	s0,32(sp)
 112:	64e2                	ld	s1,24(sp)
 114:	6942                	ld	s2,16(sp)
 116:	69a2                	ld	s3,8(sp)
 118:	6a02                	ld	s4,0(sp)
 11a:	6145                	addi	sp,sp,48
 11c:	8082                	ret

000000000000011e <release>:

void release(struct lock *lk)
{
 11e:	1101                	addi	sp,sp,-32
 120:	ec06                	sd	ra,24(sp)
 122:	e822                	sd	s0,16(sp)
 124:	e426                	sd	s1,8(sp)
 126:	1000                	addi	s0,sp,32
 128:	84aa                	mv	s1,a0
    if (!holding(lk))
 12a:	00000097          	auipc	ra,0x0
 12e:	f40080e7          	jalr	-192(ra) # 6a <holding>
 132:	c11d                	beqz	a0,158 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 134:	57fd                	li	a5,-1
 136:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 13a:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 13e:	0ff0000f          	fence
 142:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 146:	00000097          	auipc	ra,0x0
 14a:	1fa080e7          	jalr	506(ra) # 340 <tyield>
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret
        printf("releasing lock we are not holding");
 158:	00001517          	auipc	a0,0x1
 15c:	ae050513          	addi	a0,a0,-1312 # c38 <malloc+0x124>
 160:	00001097          	auipc	ra,0x1
 164:	8fc080e7          	jalr	-1796(ra) # a5c <printf>
        exit(-1);
 168:	557d                	li	a0,-1
 16a:	00000097          	auipc	ra,0x0
 16e:	572080e7          	jalr	1394(ra) # 6dc <exit>

0000000000000172 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 172:	1141                	addi	sp,sp,-16
 174:	e406                	sd	ra,8(sp)
 176:	e022                	sd	s0,0(sp)
 178:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 17a:	09800513          	li	a0,152
 17e:	00001097          	auipc	ra,0x1
 182:	996080e7          	jalr	-1642(ra) # b14 <malloc>

    main_thread->tid = next_tid;
 186:	00001797          	auipc	a5,0x1
 18a:	e7a78793          	addi	a5,a5,-390 # 1000 <next_tid>
 18e:	4398                	lw	a4,0(a5)
 190:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 194:	4398                	lw	a4,0(a5)
 196:	2705                	addiw	a4,a4,1
 198:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 19a:	4791                	li	a5,4
 19c:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 19e:	00001797          	auipc	a5,0x1
 1a2:	e6a7b923          	sd	a0,-398(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 1a6:	00001797          	auipc	a5,0x1
 1aa:	e7a78793          	addi	a5,a5,-390 # 1020 <threads>
 1ae:	00001717          	auipc	a4,0x1
 1b2:	ef270713          	addi	a4,a4,-270 # 10a0 <base>
        threads[i] = NULL;
 1b6:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 1ba:	07a1                	addi	a5,a5,8
 1bc:	fee79de3          	bne	a5,a4,1b6 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 1c0:	00001797          	auipc	a5,0x1
 1c4:	e6a7b023          	sd	a0,-416(a5) # 1020 <threads>
}
 1c8:	60a2                	ld	ra,8(sp)
 1ca:	6402                	ld	s0,0(sp)
 1cc:	0141                	addi	sp,sp,16
 1ce:	8082                	ret

00000000000001d0 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1d0:	00001517          	auipc	a0,0x1
 1d4:	e4053503          	ld	a0,-448(a0) # 1010 <current_thread>
 1d8:	00001717          	auipc	a4,0x1
 1dc:	e4870713          	addi	a4,a4,-440 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1e0:	4781                	li	a5,0
 1e2:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1e4:	6314                	ld	a3,0(a4)
 1e6:	00a68763          	beq	a3,a0,1f4 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1ea:	2785                	addiw	a5,a5,1
 1ec:	0721                	addi	a4,a4,8
 1ee:	fec79be3          	bne	a5,a2,1e4 <tsched+0x14>
    int current_index = 0;
 1f2:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1f4:	0017869b          	addiw	a3,a5,1
 1f8:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1fc:	00001817          	auipc	a6,0x1
 200:	e2480813          	addi	a6,a6,-476 # 1020 <threads>
 204:	488d                	li	a7,3
 206:	a021                	j	20e <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 208:	2685                	addiw	a3,a3,1
 20a:	04c68363          	beq	a3,a2,250 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 20e:	41f6d71b          	sraiw	a4,a3,0x1f
 212:	01c7571b          	srliw	a4,a4,0x1c
 216:	00d707bb          	addw	a5,a4,a3
 21a:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 21c:	9f99                	subw	a5,a5,a4
 21e:	078e                	slli	a5,a5,0x3
 220:	97c2                	add	a5,a5,a6
 222:	638c                	ld	a1,0(a5)
 224:	d1f5                	beqz	a1,208 <tsched+0x38>
 226:	5dbc                	lw	a5,120(a1)
 228:	ff1790e3          	bne	a5,a7,208 <tsched+0x38>
{
 22c:	1141                	addi	sp,sp,-16
 22e:	e406                	sd	ra,8(sp)
 230:	e022                	sd	s0,0(sp)
 232:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 234:	00001797          	auipc	a5,0x1
 238:	dcb7be23          	sd	a1,-548(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 23c:	05a1                	addi	a1,a1,8
 23e:	0521                	addi	a0,a0,8
 240:	00000097          	auipc	ra,0x0
 244:	19a080e7          	jalr	410(ra) # 3da <tswtch>
        //printf("Thread switch complete\n");
    }
}
 248:	60a2                	ld	ra,8(sp)
 24a:	6402                	ld	s0,0(sp)
 24c:	0141                	addi	sp,sp,16
 24e:	8082                	ret
 250:	8082                	ret

0000000000000252 <thread_wrapper>:
{
 252:	1101                	addi	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e426                	sd	s1,8(sp)
 25a:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 25c:	00001497          	auipc	s1,0x1
 260:	db448493          	addi	s1,s1,-588 # 1010 <current_thread>
 264:	609c                	ld	a5,0(s1)
 266:	6b9c                	ld	a5,16(a5)
    func(arg);
 268:	6398                	ld	a4,0(a5)
 26a:	6788                	ld	a0,8(a5)
 26c:	9702                	jalr	a4
    current_thread->state = EXITED;
 26e:	609c                	ld	a5,0(s1)
 270:	4719                	li	a4,6
 272:	dfb8                	sw	a4,120(a5)
    tsched();
 274:	00000097          	auipc	ra,0x0
 278:	f5c080e7          	jalr	-164(ra) # 1d0 <tsched>
}
 27c:	60e2                	ld	ra,24(sp)
 27e:	6442                	ld	s0,16(sp)
 280:	64a2                	ld	s1,8(sp)
 282:	6105                	addi	sp,sp,32
 284:	8082                	ret

0000000000000286 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 286:	7179                	addi	sp,sp,-48
 288:	f406                	sd	ra,40(sp)
 28a:	f022                	sd	s0,32(sp)
 28c:	ec26                	sd	s1,24(sp)
 28e:	e84a                	sd	s2,16(sp)
 290:	e44e                	sd	s3,8(sp)
 292:	1800                	addi	s0,sp,48
 294:	84aa                	mv	s1,a0
 296:	8932                	mv	s2,a2
 298:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 29a:	09800513          	li	a0,152
 29e:	00001097          	auipc	ra,0x1
 2a2:	876080e7          	jalr	-1930(ra) # b14 <malloc>
 2a6:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2a8:	478d                	li	a5,3
 2aa:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2ac:	609c                	ld	a5,0(s1)
 2ae:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 2b2:	609c                	ld	a5,0(s1)
 2b4:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 2b8:	6098                	ld	a4,0(s1)
 2ba:	00001797          	auipc	a5,0x1
 2be:	d4678793          	addi	a5,a5,-698 # 1000 <next_tid>
 2c2:	4394                	lw	a3,0(a5)
 2c4:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2c8:	4398                	lw	a4,0(a5)
 2ca:	2705                	addiw	a4,a4,1
 2cc:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 2ce:	6505                	lui	a0,0x1
 2d0:	00001097          	auipc	ra,0x1
 2d4:	844080e7          	jalr	-1980(ra) # b14 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 2d8:	6785                	lui	a5,0x1
 2da:	00a78733          	add	a4,a5,a0
 2de:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 2e2:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x330>
 2e4:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 2e6:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 2ea:	609c                	ld	a5,0(s1)
 2ec:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2ee:	609c                	ld	a5,0(s1)
 2f0:	00000717          	auipc	a4,0x0
 2f4:	f6270713          	addi	a4,a4,-158 # 252 <thread_wrapper>
 2f8:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 2fa:	00001717          	auipc	a4,0x1
 2fe:	d2670713          	addi	a4,a4,-730 # 1020 <threads>
 302:	4781                	li	a5,0
 304:	4641                	li	a2,16
        if (threads[i] == NULL) {
 306:	6314                	ld	a3,0(a4)
 308:	c29d                	beqz	a3,32e <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 30a:	2785                	addiw	a5,a5,1
 30c:	0721                	addi	a4,a4,8
 30e:	fec79ce3          	bne	a5,a2,306 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 312:	6088                	ld	a0,0(s1)
 314:	00000097          	auipc	ra,0x0
 318:	77e080e7          	jalr	1918(ra) # a92 <free>
        *thread = NULL;
 31c:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 320:	70a2                	ld	ra,40(sp)
 322:	7402                	ld	s0,32(sp)
 324:	64e2                	ld	s1,24(sp)
 326:	6942                	ld	s2,16(sp)
 328:	69a2                	ld	s3,8(sp)
 32a:	6145                	addi	sp,sp,48
 32c:	8082                	ret
            threads[i] = *thread;
 32e:	6094                	ld	a3,0(s1)
 330:	078e                	slli	a5,a5,0x3
 332:	00001717          	auipc	a4,0x1
 336:	cee70713          	addi	a4,a4,-786 # 1020 <threads>
 33a:	97ba                	add	a5,a5,a4
 33c:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 33e:	b7cd                	j	320 <tcreate+0x9a>

0000000000000340 <tyield>:
    return 0;
}


void tyield()
{
 340:	1141                	addi	sp,sp,-16
 342:	e406                	sd	ra,8(sp)
 344:	e022                	sd	s0,0(sp)
 346:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 348:	00001797          	auipc	a5,0x1
 34c:	cc87b783          	ld	a5,-824(a5) # 1010 <current_thread>
 350:	470d                	li	a4,3
 352:	dfb8                	sw	a4,120(a5)
    tsched();
 354:	00000097          	auipc	ra,0x0
 358:	e7c080e7          	jalr	-388(ra) # 1d0 <tsched>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <tjoin>:
{
 364:	1101                	addi	sp,sp,-32
 366:	ec06                	sd	ra,24(sp)
 368:	e822                	sd	s0,16(sp)
 36a:	e426                	sd	s1,8(sp)
 36c:	e04a                	sd	s2,0(sp)
 36e:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 370:	00001797          	auipc	a5,0x1
 374:	cb078793          	addi	a5,a5,-848 # 1020 <threads>
 378:	00001697          	auipc	a3,0x1
 37c:	d2868693          	addi	a3,a3,-728 # 10a0 <base>
 380:	a021                	j	388 <tjoin+0x24>
 382:	07a1                	addi	a5,a5,8
 384:	02d78b63          	beq	a5,a3,3ba <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 388:	6384                	ld	s1,0(a5)
 38a:	dce5                	beqz	s1,382 <tjoin+0x1e>
 38c:	0004c703          	lbu	a4,0(s1)
 390:	fea719e3          	bne	a4,a0,382 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 394:	5cb8                	lw	a4,120(s1)
 396:	4799                	li	a5,6
 398:	4919                	li	s2,6
 39a:	02f70263          	beq	a4,a5,3be <tjoin+0x5a>
        tyield();
 39e:	00000097          	auipc	ra,0x0
 3a2:	fa2080e7          	jalr	-94(ra) # 340 <tyield>
    while (target_thread->state != EXITED) {
 3a6:	5cbc                	lw	a5,120(s1)
 3a8:	ff279be3          	bne	a5,s2,39e <tjoin+0x3a>
    return 0;
 3ac:	4501                	li	a0,0
}
 3ae:	60e2                	ld	ra,24(sp)
 3b0:	6442                	ld	s0,16(sp)
 3b2:	64a2                	ld	s1,8(sp)
 3b4:	6902                	ld	s2,0(sp)
 3b6:	6105                	addi	sp,sp,32
 3b8:	8082                	ret
        return -1;
 3ba:	557d                	li	a0,-1
 3bc:	bfcd                	j	3ae <tjoin+0x4a>
    return 0;
 3be:	4501                	li	a0,0
 3c0:	b7fd                	j	3ae <tjoin+0x4a>

00000000000003c2 <twhoami>:

uint8 twhoami()
{
 3c2:	1141                	addi	sp,sp,-16
 3c4:	e422                	sd	s0,8(sp)
 3c6:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3c8:	00001797          	auipc	a5,0x1
 3cc:	c487b783          	ld	a5,-952(a5) # 1010 <current_thread>
 3d0:	0007c503          	lbu	a0,0(a5)
 3d4:	6422                	ld	s0,8(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret

00000000000003da <tswtch>:
 3da:	00153023          	sd	ra,0(a0)
 3de:	00253423          	sd	sp,8(a0)
 3e2:	e900                	sd	s0,16(a0)
 3e4:	ed04                	sd	s1,24(a0)
 3e6:	03253023          	sd	s2,32(a0)
 3ea:	03353423          	sd	s3,40(a0)
 3ee:	03453823          	sd	s4,48(a0)
 3f2:	03553c23          	sd	s5,56(a0)
 3f6:	05653023          	sd	s6,64(a0)
 3fa:	05753423          	sd	s7,72(a0)
 3fe:	05853823          	sd	s8,80(a0)
 402:	05953c23          	sd	s9,88(a0)
 406:	07a53023          	sd	s10,96(a0)
 40a:	07b53423          	sd	s11,104(a0)
 40e:	0005b083          	ld	ra,0(a1)
 412:	0085b103          	ld	sp,8(a1)
 416:	6980                	ld	s0,16(a1)
 418:	6d84                	ld	s1,24(a1)
 41a:	0205b903          	ld	s2,32(a1)
 41e:	0285b983          	ld	s3,40(a1)
 422:	0305ba03          	ld	s4,48(a1)
 426:	0385ba83          	ld	s5,56(a1)
 42a:	0405bb03          	ld	s6,64(a1)
 42e:	0485bb83          	ld	s7,72(a1)
 432:	0505bc03          	ld	s8,80(a1)
 436:	0585bc83          	ld	s9,88(a1)
 43a:	0605bd03          	ld	s10,96(a1)
 43e:	0685bd83          	ld	s11,104(a1)
 442:	8082                	ret

0000000000000444 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 444:	1101                	addi	sp,sp,-32
 446:	ec06                	sd	ra,24(sp)
 448:	e822                	sd	s0,16(sp)
 44a:	e426                	sd	s1,8(sp)
 44c:	e04a                	sd	s2,0(sp)
 44e:	1000                	addi	s0,sp,32
 450:	84aa                	mv	s1,a0
 452:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 454:	00000097          	auipc	ra,0x0
 458:	d1e080e7          	jalr	-738(ra) # 172 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 45c:	85ca                	mv	a1,s2
 45e:	8526                	mv	a0,s1
 460:	00000097          	auipc	ra,0x0
 464:	bc2080e7          	jalr	-1086(ra) # 22 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 468:	00000097          	auipc	ra,0x0
 46c:	274080e7          	jalr	628(ra) # 6dc <exit>

0000000000000470 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 470:	1141                	addi	sp,sp,-16
 472:	e422                	sd	s0,8(sp)
 474:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 476:	87aa                	mv	a5,a0
 478:	0585                	addi	a1,a1,1
 47a:	0785                	addi	a5,a5,1
 47c:	fff5c703          	lbu	a4,-1(a1)
 480:	fee78fa3          	sb	a4,-1(a5)
 484:	fb75                	bnez	a4,478 <strcpy+0x8>
        ;
    return os;
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret

000000000000048c <strcmp>:

int strcmp(const char *p, const char *q)
{
 48c:	1141                	addi	sp,sp,-16
 48e:	e422                	sd	s0,8(sp)
 490:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 492:	00054783          	lbu	a5,0(a0)
 496:	cb91                	beqz	a5,4aa <strcmp+0x1e>
 498:	0005c703          	lbu	a4,0(a1)
 49c:	00f71763          	bne	a4,a5,4aa <strcmp+0x1e>
        p++, q++;
 4a0:	0505                	addi	a0,a0,1
 4a2:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4a4:	00054783          	lbu	a5,0(a0)
 4a8:	fbe5                	bnez	a5,498 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4aa:	0005c503          	lbu	a0,0(a1)
}
 4ae:	40a7853b          	subw	a0,a5,a0
 4b2:	6422                	ld	s0,8(sp)
 4b4:	0141                	addi	sp,sp,16
 4b6:	8082                	ret

00000000000004b8 <strlen>:

uint strlen(const char *s)
{
 4b8:	1141                	addi	sp,sp,-16
 4ba:	e422                	sd	s0,8(sp)
 4bc:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4be:	00054783          	lbu	a5,0(a0)
 4c2:	cf91                	beqz	a5,4de <strlen+0x26>
 4c4:	0505                	addi	a0,a0,1
 4c6:	87aa                	mv	a5,a0
 4c8:	86be                	mv	a3,a5
 4ca:	0785                	addi	a5,a5,1
 4cc:	fff7c703          	lbu	a4,-1(a5)
 4d0:	ff65                	bnez	a4,4c8 <strlen+0x10>
 4d2:	40a6853b          	subw	a0,a3,a0
 4d6:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4d8:	6422                	ld	s0,8(sp)
 4da:	0141                	addi	sp,sp,16
 4dc:	8082                	ret
    for (n = 0; s[n]; n++)
 4de:	4501                	li	a0,0
 4e0:	bfe5                	j	4d8 <strlen+0x20>

00000000000004e2 <memset>:

void *
memset(void *dst, int c, uint n)
{
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e422                	sd	s0,8(sp)
 4e6:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4e8:	ca19                	beqz	a2,4fe <memset+0x1c>
 4ea:	87aa                	mv	a5,a0
 4ec:	1602                	slli	a2,a2,0x20
 4ee:	9201                	srli	a2,a2,0x20
 4f0:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4f4:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4f8:	0785                	addi	a5,a5,1
 4fa:	fee79de3          	bne	a5,a4,4f4 <memset+0x12>
    }
    return dst;
}
 4fe:	6422                	ld	s0,8(sp)
 500:	0141                	addi	sp,sp,16
 502:	8082                	ret

0000000000000504 <strchr>:

char *
strchr(const char *s, char c)
{
 504:	1141                	addi	sp,sp,-16
 506:	e422                	sd	s0,8(sp)
 508:	0800                	addi	s0,sp,16
    for (; *s; s++)
 50a:	00054783          	lbu	a5,0(a0)
 50e:	cb99                	beqz	a5,524 <strchr+0x20>
        if (*s == c)
 510:	00f58763          	beq	a1,a5,51e <strchr+0x1a>
    for (; *s; s++)
 514:	0505                	addi	a0,a0,1
 516:	00054783          	lbu	a5,0(a0)
 51a:	fbfd                	bnez	a5,510 <strchr+0xc>
            return (char *)s;
    return 0;
 51c:	4501                	li	a0,0
}
 51e:	6422                	ld	s0,8(sp)
 520:	0141                	addi	sp,sp,16
 522:	8082                	ret
    return 0;
 524:	4501                	li	a0,0
 526:	bfe5                	j	51e <strchr+0x1a>

0000000000000528 <gets>:

char *
gets(char *buf, int max)
{
 528:	711d                	addi	sp,sp,-96
 52a:	ec86                	sd	ra,88(sp)
 52c:	e8a2                	sd	s0,80(sp)
 52e:	e4a6                	sd	s1,72(sp)
 530:	e0ca                	sd	s2,64(sp)
 532:	fc4e                	sd	s3,56(sp)
 534:	f852                	sd	s4,48(sp)
 536:	f456                	sd	s5,40(sp)
 538:	f05a                	sd	s6,32(sp)
 53a:	ec5e                	sd	s7,24(sp)
 53c:	1080                	addi	s0,sp,96
 53e:	8baa                	mv	s7,a0
 540:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 542:	892a                	mv	s2,a0
 544:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 546:	4aa9                	li	s5,10
 548:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 54a:	89a6                	mv	s3,s1
 54c:	2485                	addiw	s1,s1,1
 54e:	0344d863          	bge	s1,s4,57e <gets+0x56>
        cc = read(0, &c, 1);
 552:	4605                	li	a2,1
 554:	faf40593          	addi	a1,s0,-81
 558:	4501                	li	a0,0
 55a:	00000097          	auipc	ra,0x0
 55e:	19a080e7          	jalr	410(ra) # 6f4 <read>
        if (cc < 1)
 562:	00a05e63          	blez	a0,57e <gets+0x56>
        buf[i++] = c;
 566:	faf44783          	lbu	a5,-81(s0)
 56a:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 56e:	01578763          	beq	a5,s5,57c <gets+0x54>
 572:	0905                	addi	s2,s2,1
 574:	fd679be3          	bne	a5,s6,54a <gets+0x22>
    for (i = 0; i + 1 < max;)
 578:	89a6                	mv	s3,s1
 57a:	a011                	j	57e <gets+0x56>
 57c:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 57e:	99de                	add	s3,s3,s7
 580:	00098023          	sb	zero,0(s3)
    return buf;
}
 584:	855e                	mv	a0,s7
 586:	60e6                	ld	ra,88(sp)
 588:	6446                	ld	s0,80(sp)
 58a:	64a6                	ld	s1,72(sp)
 58c:	6906                	ld	s2,64(sp)
 58e:	79e2                	ld	s3,56(sp)
 590:	7a42                	ld	s4,48(sp)
 592:	7aa2                	ld	s5,40(sp)
 594:	7b02                	ld	s6,32(sp)
 596:	6be2                	ld	s7,24(sp)
 598:	6125                	addi	sp,sp,96
 59a:	8082                	ret

000000000000059c <stat>:

int stat(const char *n, struct stat *st)
{
 59c:	1101                	addi	sp,sp,-32
 59e:	ec06                	sd	ra,24(sp)
 5a0:	e822                	sd	s0,16(sp)
 5a2:	e426                	sd	s1,8(sp)
 5a4:	e04a                	sd	s2,0(sp)
 5a6:	1000                	addi	s0,sp,32
 5a8:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5aa:	4581                	li	a1,0
 5ac:	00000097          	auipc	ra,0x0
 5b0:	170080e7          	jalr	368(ra) # 71c <open>
    if (fd < 0)
 5b4:	02054563          	bltz	a0,5de <stat+0x42>
 5b8:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5ba:	85ca                	mv	a1,s2
 5bc:	00000097          	auipc	ra,0x0
 5c0:	178080e7          	jalr	376(ra) # 734 <fstat>
 5c4:	892a                	mv	s2,a0
    close(fd);
 5c6:	8526                	mv	a0,s1
 5c8:	00000097          	auipc	ra,0x0
 5cc:	13c080e7          	jalr	316(ra) # 704 <close>
    return r;
}
 5d0:	854a                	mv	a0,s2
 5d2:	60e2                	ld	ra,24(sp)
 5d4:	6442                	ld	s0,16(sp)
 5d6:	64a2                	ld	s1,8(sp)
 5d8:	6902                	ld	s2,0(sp)
 5da:	6105                	addi	sp,sp,32
 5dc:	8082                	ret
        return -1;
 5de:	597d                	li	s2,-1
 5e0:	bfc5                	j	5d0 <stat+0x34>

00000000000005e2 <atoi>:

int atoi(const char *s)
{
 5e2:	1141                	addi	sp,sp,-16
 5e4:	e422                	sd	s0,8(sp)
 5e6:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5e8:	00054683          	lbu	a3,0(a0)
 5ec:	fd06879b          	addiw	a5,a3,-48
 5f0:	0ff7f793          	zext.b	a5,a5
 5f4:	4625                	li	a2,9
 5f6:	02f66863          	bltu	a2,a5,626 <atoi+0x44>
 5fa:	872a                	mv	a4,a0
    n = 0;
 5fc:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5fe:	0705                	addi	a4,a4,1
 600:	0025179b          	slliw	a5,a0,0x2
 604:	9fa9                	addw	a5,a5,a0
 606:	0017979b          	slliw	a5,a5,0x1
 60a:	9fb5                	addw	a5,a5,a3
 60c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 610:	00074683          	lbu	a3,0(a4)
 614:	fd06879b          	addiw	a5,a3,-48
 618:	0ff7f793          	zext.b	a5,a5
 61c:	fef671e3          	bgeu	a2,a5,5fe <atoi+0x1c>
    return n;
}
 620:	6422                	ld	s0,8(sp)
 622:	0141                	addi	sp,sp,16
 624:	8082                	ret
    n = 0;
 626:	4501                	li	a0,0
 628:	bfe5                	j	620 <atoi+0x3e>

000000000000062a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 62a:	1141                	addi	sp,sp,-16
 62c:	e422                	sd	s0,8(sp)
 62e:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 630:	02b57463          	bgeu	a0,a1,658 <memmove+0x2e>
    {
        while (n-- > 0)
 634:	00c05f63          	blez	a2,652 <memmove+0x28>
 638:	1602                	slli	a2,a2,0x20
 63a:	9201                	srli	a2,a2,0x20
 63c:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 640:	872a                	mv	a4,a0
            *dst++ = *src++;
 642:	0585                	addi	a1,a1,1
 644:	0705                	addi	a4,a4,1
 646:	fff5c683          	lbu	a3,-1(a1)
 64a:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 64e:	fee79ae3          	bne	a5,a4,642 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 652:	6422                	ld	s0,8(sp)
 654:	0141                	addi	sp,sp,16
 656:	8082                	ret
        dst += n;
 658:	00c50733          	add	a4,a0,a2
        src += n;
 65c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 65e:	fec05ae3          	blez	a2,652 <memmove+0x28>
 662:	fff6079b          	addiw	a5,a2,-1
 666:	1782                	slli	a5,a5,0x20
 668:	9381                	srli	a5,a5,0x20
 66a:	fff7c793          	not	a5,a5
 66e:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 670:	15fd                	addi	a1,a1,-1
 672:	177d                	addi	a4,a4,-1
 674:	0005c683          	lbu	a3,0(a1)
 678:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 67c:	fee79ae3          	bne	a5,a4,670 <memmove+0x46>
 680:	bfc9                	j	652 <memmove+0x28>

0000000000000682 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 682:	1141                	addi	sp,sp,-16
 684:	e422                	sd	s0,8(sp)
 686:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 688:	ca05                	beqz	a2,6b8 <memcmp+0x36>
 68a:	fff6069b          	addiw	a3,a2,-1
 68e:	1682                	slli	a3,a3,0x20
 690:	9281                	srli	a3,a3,0x20
 692:	0685                	addi	a3,a3,1
 694:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 696:	00054783          	lbu	a5,0(a0)
 69a:	0005c703          	lbu	a4,0(a1)
 69e:	00e79863          	bne	a5,a4,6ae <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6a2:	0505                	addi	a0,a0,1
        p2++;
 6a4:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6a6:	fed518e3          	bne	a0,a3,696 <memcmp+0x14>
    }
    return 0;
 6aa:	4501                	li	a0,0
 6ac:	a019                	j	6b2 <memcmp+0x30>
            return *p1 - *p2;
 6ae:	40e7853b          	subw	a0,a5,a4
}
 6b2:	6422                	ld	s0,8(sp)
 6b4:	0141                	addi	sp,sp,16
 6b6:	8082                	ret
    return 0;
 6b8:	4501                	li	a0,0
 6ba:	bfe5                	j	6b2 <memcmp+0x30>

00000000000006bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6bc:	1141                	addi	sp,sp,-16
 6be:	e406                	sd	ra,8(sp)
 6c0:	e022                	sd	s0,0(sp)
 6c2:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6c4:	00000097          	auipc	ra,0x0
 6c8:	f66080e7          	jalr	-154(ra) # 62a <memmove>
}
 6cc:	60a2                	ld	ra,8(sp)
 6ce:	6402                	ld	s0,0(sp)
 6d0:	0141                	addi	sp,sp,16
 6d2:	8082                	ret

00000000000006d4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6d4:	4885                	li	a7,1
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <exit>:
.global exit
exit:
 li a7, SYS_exit
 6dc:	4889                	li	a7,2
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6e4:	488d                	li	a7,3
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6ec:	4891                	li	a7,4
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <read>:
.global read
read:
 li a7, SYS_read
 6f4:	4895                	li	a7,5
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <write>:
.global write
write:
 li a7, SYS_write
 6fc:	48c1                	li	a7,16
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <close>:
.global close
close:
 li a7, SYS_close
 704:	48d5                	li	a7,21
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <kill>:
.global kill
kill:
 li a7, SYS_kill
 70c:	4899                	li	a7,6
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <exec>:
.global exec
exec:
 li a7, SYS_exec
 714:	489d                	li	a7,7
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <open>:
.global open
open:
 li a7, SYS_open
 71c:	48bd                	li	a7,15
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 724:	48c5                	li	a7,17
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 72c:	48c9                	li	a7,18
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 734:	48a1                	li	a7,8
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <link>:
.global link
link:
 li a7, SYS_link
 73c:	48cd                	li	a7,19
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 744:	48d1                	li	a7,20
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 74c:	48a5                	li	a7,9
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <dup>:
.global dup
dup:
 li a7, SYS_dup
 754:	48a9                	li	a7,10
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 75c:	48ad                	li	a7,11
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 764:	48b1                	li	a7,12
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 76c:	48b5                	li	a7,13
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 774:	48b9                	li	a7,14
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <ps>:
.global ps
ps:
 li a7, SYS_ps
 77c:	48d9                	li	a7,22
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 784:	48dd                	li	a7,23
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 78c:	48e1                	li	a7,24
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 794:	1101                	addi	sp,sp,-32
 796:	ec06                	sd	ra,24(sp)
 798:	e822                	sd	s0,16(sp)
 79a:	1000                	addi	s0,sp,32
 79c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7a0:	4605                	li	a2,1
 7a2:	fef40593          	addi	a1,s0,-17
 7a6:	00000097          	auipc	ra,0x0
 7aa:	f56080e7          	jalr	-170(ra) # 6fc <write>
}
 7ae:	60e2                	ld	ra,24(sp)
 7b0:	6442                	ld	s0,16(sp)
 7b2:	6105                	addi	sp,sp,32
 7b4:	8082                	ret

00000000000007b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7b6:	7139                	addi	sp,sp,-64
 7b8:	fc06                	sd	ra,56(sp)
 7ba:	f822                	sd	s0,48(sp)
 7bc:	f426                	sd	s1,40(sp)
 7be:	f04a                	sd	s2,32(sp)
 7c0:	ec4e                	sd	s3,24(sp)
 7c2:	0080                	addi	s0,sp,64
 7c4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7c6:	c299                	beqz	a3,7cc <printint+0x16>
 7c8:	0805c963          	bltz	a1,85a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7cc:	2581                	sext.w	a1,a1
  neg = 0;
 7ce:	4881                	li	a7,0
 7d0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7d4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7d6:	2601                	sext.w	a2,a2
 7d8:	00000517          	auipc	a0,0x0
 7dc:	4e850513          	addi	a0,a0,1256 # cc0 <digits>
 7e0:	883a                	mv	a6,a4
 7e2:	2705                	addiw	a4,a4,1
 7e4:	02c5f7bb          	remuw	a5,a1,a2
 7e8:	1782                	slli	a5,a5,0x20
 7ea:	9381                	srli	a5,a5,0x20
 7ec:	97aa                	add	a5,a5,a0
 7ee:	0007c783          	lbu	a5,0(a5)
 7f2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7f6:	0005879b          	sext.w	a5,a1
 7fa:	02c5d5bb          	divuw	a1,a1,a2
 7fe:	0685                	addi	a3,a3,1
 800:	fec7f0e3          	bgeu	a5,a2,7e0 <printint+0x2a>
  if(neg)
 804:	00088c63          	beqz	a7,81c <printint+0x66>
    buf[i++] = '-';
 808:	fd070793          	addi	a5,a4,-48
 80c:	00878733          	add	a4,a5,s0
 810:	02d00793          	li	a5,45
 814:	fef70823          	sb	a5,-16(a4)
 818:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 81c:	02e05863          	blez	a4,84c <printint+0x96>
 820:	fc040793          	addi	a5,s0,-64
 824:	00e78933          	add	s2,a5,a4
 828:	fff78993          	addi	s3,a5,-1
 82c:	99ba                	add	s3,s3,a4
 82e:	377d                	addiw	a4,a4,-1
 830:	1702                	slli	a4,a4,0x20
 832:	9301                	srli	a4,a4,0x20
 834:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 838:	fff94583          	lbu	a1,-1(s2)
 83c:	8526                	mv	a0,s1
 83e:	00000097          	auipc	ra,0x0
 842:	f56080e7          	jalr	-170(ra) # 794 <putc>
  while(--i >= 0)
 846:	197d                	addi	s2,s2,-1
 848:	ff3918e3          	bne	s2,s3,838 <printint+0x82>
}
 84c:	70e2                	ld	ra,56(sp)
 84e:	7442                	ld	s0,48(sp)
 850:	74a2                	ld	s1,40(sp)
 852:	7902                	ld	s2,32(sp)
 854:	69e2                	ld	s3,24(sp)
 856:	6121                	addi	sp,sp,64
 858:	8082                	ret
    x = -xx;
 85a:	40b005bb          	negw	a1,a1
    neg = 1;
 85e:	4885                	li	a7,1
    x = -xx;
 860:	bf85                	j	7d0 <printint+0x1a>

0000000000000862 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 862:	715d                	addi	sp,sp,-80
 864:	e486                	sd	ra,72(sp)
 866:	e0a2                	sd	s0,64(sp)
 868:	fc26                	sd	s1,56(sp)
 86a:	f84a                	sd	s2,48(sp)
 86c:	f44e                	sd	s3,40(sp)
 86e:	f052                	sd	s4,32(sp)
 870:	ec56                	sd	s5,24(sp)
 872:	e85a                	sd	s6,16(sp)
 874:	e45e                	sd	s7,8(sp)
 876:	e062                	sd	s8,0(sp)
 878:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 87a:	0005c903          	lbu	s2,0(a1)
 87e:	18090c63          	beqz	s2,a16 <vprintf+0x1b4>
 882:	8aaa                	mv	s5,a0
 884:	8bb2                	mv	s7,a2
 886:	00158493          	addi	s1,a1,1
  state = 0;
 88a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 88c:	02500a13          	li	s4,37
 890:	4b55                	li	s6,21
 892:	a839                	j	8b0 <vprintf+0x4e>
        putc(fd, c);
 894:	85ca                	mv	a1,s2
 896:	8556                	mv	a0,s5
 898:	00000097          	auipc	ra,0x0
 89c:	efc080e7          	jalr	-260(ra) # 794 <putc>
 8a0:	a019                	j	8a6 <vprintf+0x44>
    } else if(state == '%'){
 8a2:	01498d63          	beq	s3,s4,8bc <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8a6:	0485                	addi	s1,s1,1
 8a8:	fff4c903          	lbu	s2,-1(s1)
 8ac:	16090563          	beqz	s2,a16 <vprintf+0x1b4>
    if(state == 0){
 8b0:	fe0999e3          	bnez	s3,8a2 <vprintf+0x40>
      if(c == '%'){
 8b4:	ff4910e3          	bne	s2,s4,894 <vprintf+0x32>
        state = '%';
 8b8:	89d2                	mv	s3,s4
 8ba:	b7f5                	j	8a6 <vprintf+0x44>
      if(c == 'd'){
 8bc:	13490263          	beq	s2,s4,9e0 <vprintf+0x17e>
 8c0:	f9d9079b          	addiw	a5,s2,-99
 8c4:	0ff7f793          	zext.b	a5,a5
 8c8:	12fb6563          	bltu	s6,a5,9f2 <vprintf+0x190>
 8cc:	f9d9079b          	addiw	a5,s2,-99
 8d0:	0ff7f713          	zext.b	a4,a5
 8d4:	10eb6f63          	bltu	s6,a4,9f2 <vprintf+0x190>
 8d8:	00271793          	slli	a5,a4,0x2
 8dc:	00000717          	auipc	a4,0x0
 8e0:	38c70713          	addi	a4,a4,908 # c68 <malloc+0x154>
 8e4:	97ba                	add	a5,a5,a4
 8e6:	439c                	lw	a5,0(a5)
 8e8:	97ba                	add	a5,a5,a4
 8ea:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8ec:	008b8913          	addi	s2,s7,8
 8f0:	4685                	li	a3,1
 8f2:	4629                	li	a2,10
 8f4:	000ba583          	lw	a1,0(s7)
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	ebc080e7          	jalr	-324(ra) # 7b6 <printint>
 902:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 904:	4981                	li	s3,0
 906:	b745                	j	8a6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 908:	008b8913          	addi	s2,s7,8
 90c:	4681                	li	a3,0
 90e:	4629                	li	a2,10
 910:	000ba583          	lw	a1,0(s7)
 914:	8556                	mv	a0,s5
 916:	00000097          	auipc	ra,0x0
 91a:	ea0080e7          	jalr	-352(ra) # 7b6 <printint>
 91e:	8bca                	mv	s7,s2
      state = 0;
 920:	4981                	li	s3,0
 922:	b751                	j	8a6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 924:	008b8913          	addi	s2,s7,8
 928:	4681                	li	a3,0
 92a:	4641                	li	a2,16
 92c:	000ba583          	lw	a1,0(s7)
 930:	8556                	mv	a0,s5
 932:	00000097          	auipc	ra,0x0
 936:	e84080e7          	jalr	-380(ra) # 7b6 <printint>
 93a:	8bca                	mv	s7,s2
      state = 0;
 93c:	4981                	li	s3,0
 93e:	b7a5                	j	8a6 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 940:	008b8c13          	addi	s8,s7,8
 944:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 948:	03000593          	li	a1,48
 94c:	8556                	mv	a0,s5
 94e:	00000097          	auipc	ra,0x0
 952:	e46080e7          	jalr	-442(ra) # 794 <putc>
  putc(fd, 'x');
 956:	07800593          	li	a1,120
 95a:	8556                	mv	a0,s5
 95c:	00000097          	auipc	ra,0x0
 960:	e38080e7          	jalr	-456(ra) # 794 <putc>
 964:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 966:	00000b97          	auipc	s7,0x0
 96a:	35ab8b93          	addi	s7,s7,858 # cc0 <digits>
 96e:	03c9d793          	srli	a5,s3,0x3c
 972:	97de                	add	a5,a5,s7
 974:	0007c583          	lbu	a1,0(a5)
 978:	8556                	mv	a0,s5
 97a:	00000097          	auipc	ra,0x0
 97e:	e1a080e7          	jalr	-486(ra) # 794 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 982:	0992                	slli	s3,s3,0x4
 984:	397d                	addiw	s2,s2,-1
 986:	fe0914e3          	bnez	s2,96e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 98a:	8be2                	mv	s7,s8
      state = 0;
 98c:	4981                	li	s3,0
 98e:	bf21                	j	8a6 <vprintf+0x44>
        s = va_arg(ap, char*);
 990:	008b8993          	addi	s3,s7,8
 994:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 998:	02090163          	beqz	s2,9ba <vprintf+0x158>
        while(*s != 0){
 99c:	00094583          	lbu	a1,0(s2)
 9a0:	c9a5                	beqz	a1,a10 <vprintf+0x1ae>
          putc(fd, *s);
 9a2:	8556                	mv	a0,s5
 9a4:	00000097          	auipc	ra,0x0
 9a8:	df0080e7          	jalr	-528(ra) # 794 <putc>
          s++;
 9ac:	0905                	addi	s2,s2,1
        while(*s != 0){
 9ae:	00094583          	lbu	a1,0(s2)
 9b2:	f9e5                	bnez	a1,9a2 <vprintf+0x140>
        s = va_arg(ap, char*);
 9b4:	8bce                	mv	s7,s3
      state = 0;
 9b6:	4981                	li	s3,0
 9b8:	b5fd                	j	8a6 <vprintf+0x44>
          s = "(null)";
 9ba:	00000917          	auipc	s2,0x0
 9be:	2a690913          	addi	s2,s2,678 # c60 <malloc+0x14c>
        while(*s != 0){
 9c2:	02800593          	li	a1,40
 9c6:	bff1                	j	9a2 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9c8:	008b8913          	addi	s2,s7,8
 9cc:	000bc583          	lbu	a1,0(s7)
 9d0:	8556                	mv	a0,s5
 9d2:	00000097          	auipc	ra,0x0
 9d6:	dc2080e7          	jalr	-574(ra) # 794 <putc>
 9da:	8bca                	mv	s7,s2
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	b5e1                	j	8a6 <vprintf+0x44>
        putc(fd, c);
 9e0:	02500593          	li	a1,37
 9e4:	8556                	mv	a0,s5
 9e6:	00000097          	auipc	ra,0x0
 9ea:	dae080e7          	jalr	-594(ra) # 794 <putc>
      state = 0;
 9ee:	4981                	li	s3,0
 9f0:	bd5d                	j	8a6 <vprintf+0x44>
        putc(fd, '%');
 9f2:	02500593          	li	a1,37
 9f6:	8556                	mv	a0,s5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	d9c080e7          	jalr	-612(ra) # 794 <putc>
        putc(fd, c);
 a00:	85ca                	mv	a1,s2
 a02:	8556                	mv	a0,s5
 a04:	00000097          	auipc	ra,0x0
 a08:	d90080e7          	jalr	-624(ra) # 794 <putc>
      state = 0;
 a0c:	4981                	li	s3,0
 a0e:	bd61                	j	8a6 <vprintf+0x44>
        s = va_arg(ap, char*);
 a10:	8bce                	mv	s7,s3
      state = 0;
 a12:	4981                	li	s3,0
 a14:	bd49                	j	8a6 <vprintf+0x44>
    }
  }
}
 a16:	60a6                	ld	ra,72(sp)
 a18:	6406                	ld	s0,64(sp)
 a1a:	74e2                	ld	s1,56(sp)
 a1c:	7942                	ld	s2,48(sp)
 a1e:	79a2                	ld	s3,40(sp)
 a20:	7a02                	ld	s4,32(sp)
 a22:	6ae2                	ld	s5,24(sp)
 a24:	6b42                	ld	s6,16(sp)
 a26:	6ba2                	ld	s7,8(sp)
 a28:	6c02                	ld	s8,0(sp)
 a2a:	6161                	addi	sp,sp,80
 a2c:	8082                	ret

0000000000000a2e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a2e:	715d                	addi	sp,sp,-80
 a30:	ec06                	sd	ra,24(sp)
 a32:	e822                	sd	s0,16(sp)
 a34:	1000                	addi	s0,sp,32
 a36:	e010                	sd	a2,0(s0)
 a38:	e414                	sd	a3,8(s0)
 a3a:	e818                	sd	a4,16(s0)
 a3c:	ec1c                	sd	a5,24(s0)
 a3e:	03043023          	sd	a6,32(s0)
 a42:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a46:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a4a:	8622                	mv	a2,s0
 a4c:	00000097          	auipc	ra,0x0
 a50:	e16080e7          	jalr	-490(ra) # 862 <vprintf>
}
 a54:	60e2                	ld	ra,24(sp)
 a56:	6442                	ld	s0,16(sp)
 a58:	6161                	addi	sp,sp,80
 a5a:	8082                	ret

0000000000000a5c <printf>:

void
printf(const char *fmt, ...)
{
 a5c:	711d                	addi	sp,sp,-96
 a5e:	ec06                	sd	ra,24(sp)
 a60:	e822                	sd	s0,16(sp)
 a62:	1000                	addi	s0,sp,32
 a64:	e40c                	sd	a1,8(s0)
 a66:	e810                	sd	a2,16(s0)
 a68:	ec14                	sd	a3,24(s0)
 a6a:	f018                	sd	a4,32(s0)
 a6c:	f41c                	sd	a5,40(s0)
 a6e:	03043823          	sd	a6,48(s0)
 a72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a76:	00840613          	addi	a2,s0,8
 a7a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a7e:	85aa                	mv	a1,a0
 a80:	4505                	li	a0,1
 a82:	00000097          	auipc	ra,0x0
 a86:	de0080e7          	jalr	-544(ra) # 862 <vprintf>
}
 a8a:	60e2                	ld	ra,24(sp)
 a8c:	6442                	ld	s0,16(sp)
 a8e:	6125                	addi	sp,sp,96
 a90:	8082                	ret

0000000000000a92 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a92:	1141                	addi	sp,sp,-16
 a94:	e422                	sd	s0,8(sp)
 a96:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a98:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9c:	00000797          	auipc	a5,0x0
 aa0:	57c7b783          	ld	a5,1404(a5) # 1018 <freep>
 aa4:	a02d                	j	ace <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 aa6:	4618                	lw	a4,8(a2)
 aa8:	9f2d                	addw	a4,a4,a1
 aaa:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 aae:	6398                	ld	a4,0(a5)
 ab0:	6310                	ld	a2,0(a4)
 ab2:	a83d                	j	af0 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ab4:	ff852703          	lw	a4,-8(a0)
 ab8:	9f31                	addw	a4,a4,a2
 aba:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 abc:	ff053683          	ld	a3,-16(a0)
 ac0:	a091                	j	b04 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac2:	6398                	ld	a4,0(a5)
 ac4:	00e7e463          	bltu	a5,a4,acc <free+0x3a>
 ac8:	00e6ea63          	bltu	a3,a4,adc <free+0x4a>
{
 acc:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ace:	fed7fae3          	bgeu	a5,a3,ac2 <free+0x30>
 ad2:	6398                	ld	a4,0(a5)
 ad4:	00e6e463          	bltu	a3,a4,adc <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad8:	fee7eae3          	bltu	a5,a4,acc <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 adc:	ff852583          	lw	a1,-8(a0)
 ae0:	6390                	ld	a2,0(a5)
 ae2:	02059813          	slli	a6,a1,0x20
 ae6:	01c85713          	srli	a4,a6,0x1c
 aea:	9736                	add	a4,a4,a3
 aec:	fae60de3          	beq	a2,a4,aa6 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 af0:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 af4:	4790                	lw	a2,8(a5)
 af6:	02061593          	slli	a1,a2,0x20
 afa:	01c5d713          	srli	a4,a1,0x1c
 afe:	973e                	add	a4,a4,a5
 b00:	fae68ae3          	beq	a3,a4,ab4 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b04:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b06:	00000717          	auipc	a4,0x0
 b0a:	50f73923          	sd	a5,1298(a4) # 1018 <freep>
}
 b0e:	6422                	ld	s0,8(sp)
 b10:	0141                	addi	sp,sp,16
 b12:	8082                	ret

0000000000000b14 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b14:	7139                	addi	sp,sp,-64
 b16:	fc06                	sd	ra,56(sp)
 b18:	f822                	sd	s0,48(sp)
 b1a:	f426                	sd	s1,40(sp)
 b1c:	f04a                	sd	s2,32(sp)
 b1e:	ec4e                	sd	s3,24(sp)
 b20:	e852                	sd	s4,16(sp)
 b22:	e456                	sd	s5,8(sp)
 b24:	e05a                	sd	s6,0(sp)
 b26:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b28:	02051493          	slli	s1,a0,0x20
 b2c:	9081                	srli	s1,s1,0x20
 b2e:	04bd                	addi	s1,s1,15
 b30:	8091                	srli	s1,s1,0x4
 b32:	0014899b          	addiw	s3,s1,1
 b36:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b38:	00000517          	auipc	a0,0x0
 b3c:	4e053503          	ld	a0,1248(a0) # 1018 <freep>
 b40:	c515                	beqz	a0,b6c <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b42:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b44:	4798                	lw	a4,8(a5)
 b46:	02977f63          	bgeu	a4,s1,b84 <malloc+0x70>
    if (nu < 4096)
 b4a:	8a4e                	mv	s4,s3
 b4c:	0009871b          	sext.w	a4,s3
 b50:	6685                	lui	a3,0x1
 b52:	00d77363          	bgeu	a4,a3,b58 <malloc+0x44>
 b56:	6a05                	lui	s4,0x1
 b58:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b5c:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b60:	00000917          	auipc	s2,0x0
 b64:	4b890913          	addi	s2,s2,1208 # 1018 <freep>
    if (p == (char *)-1)
 b68:	5afd                	li	s5,-1
 b6a:	a895                	j	bde <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b6c:	00000797          	auipc	a5,0x0
 b70:	53478793          	addi	a5,a5,1332 # 10a0 <base>
 b74:	00000717          	auipc	a4,0x0
 b78:	4af73223          	sd	a5,1188(a4) # 1018 <freep>
 b7c:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b7e:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b82:	b7e1                	j	b4a <malloc+0x36>
            if (p->s.size == nunits)
 b84:	02e48c63          	beq	s1,a4,bbc <malloc+0xa8>
                p->s.size -= nunits;
 b88:	4137073b          	subw	a4,a4,s3
 b8c:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b8e:	02071693          	slli	a3,a4,0x20
 b92:	01c6d713          	srli	a4,a3,0x1c
 b96:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b98:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b9c:	00000717          	auipc	a4,0x0
 ba0:	46a73e23          	sd	a0,1148(a4) # 1018 <freep>
            return (void *)(p + 1);
 ba4:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 ba8:	70e2                	ld	ra,56(sp)
 baa:	7442                	ld	s0,48(sp)
 bac:	74a2                	ld	s1,40(sp)
 bae:	7902                	ld	s2,32(sp)
 bb0:	69e2                	ld	s3,24(sp)
 bb2:	6a42                	ld	s4,16(sp)
 bb4:	6aa2                	ld	s5,8(sp)
 bb6:	6b02                	ld	s6,0(sp)
 bb8:	6121                	addi	sp,sp,64
 bba:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bbc:	6398                	ld	a4,0(a5)
 bbe:	e118                	sd	a4,0(a0)
 bc0:	bff1                	j	b9c <malloc+0x88>
    hp->s.size = nu;
 bc2:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bc6:	0541                	addi	a0,a0,16
 bc8:	00000097          	auipc	ra,0x0
 bcc:	eca080e7          	jalr	-310(ra) # a92 <free>
    return freep;
 bd0:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bd4:	d971                	beqz	a0,ba8 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bd6:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bd8:	4798                	lw	a4,8(a5)
 bda:	fa9775e3          	bgeu	a4,s1,b84 <malloc+0x70>
        if (p == freep)
 bde:	00093703          	ld	a4,0(s2)
 be2:	853e                	mv	a0,a5
 be4:	fef719e3          	bne	a4,a5,bd6 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 be8:	8552                	mv	a0,s4
 bea:	00000097          	auipc	ra,0x0
 bee:	b7a080e7          	jalr	-1158(ra) # 764 <sbrk>
    if (p == (char *)-1)
 bf2:	fd5518e3          	bne	a0,s5,bc2 <malloc+0xae>
                return 0;
 bf6:	4501                	li	a0,0
 bf8:	bf45                	j	ba8 <malloc+0x94>
