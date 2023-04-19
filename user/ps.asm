
user/_ps:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

int main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
    struct user_proc *procs = ps(0, 64);
   e:	04000593          	li	a1,64
  12:	4501                	li	a0,0
  14:	00000097          	auipc	ra,0x0
  18:	770080e7          	jalr	1904(ra) # 784 <ps>

    for (int i = 0; i < 64; i++)
  1c:	01450493          	addi	s1,a0,20
  20:	6785                	lui	a5,0x1
  22:	91478793          	addi	a5,a5,-1772 # 914 <vprintf+0xaa>
  26:	00f50933          	add	s2,a0,a5
    {
        if (procs[i].state == UNUSED)
            break;
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  2a:	00001997          	auipc	s3,0x1
  2e:	be698993          	addi	s3,s3,-1050 # c10 <malloc+0xf4>
        if (procs[i].state == UNUSED)
  32:	fec4a683          	lw	a3,-20(s1)
  36:	ce89                	beqz	a3,50 <main+0x50>
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  38:	ff84a603          	lw	a2,-8(s1)
  3c:	85a6                	mv	a1,s1
  3e:	854e                	mv	a0,s3
  40:	00001097          	auipc	ra,0x1
  44:	a24080e7          	jalr	-1500(ra) # a64 <printf>
    for (int i = 0; i < 64; i++)
  48:	02448493          	addi	s1,s1,36
  4c:	ff2493e3          	bne	s1,s2,32 <main+0x32>
    }
    exit(0);
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	692080e7          	jalr	1682(ra) # 6e4 <exit>

000000000000005a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  5a:	1141                	addi	sp,sp,-16
  5c:	e422                	sd	s0,8(sp)
  5e:	0800                	addi	s0,sp,16
    lk->name = name;
  60:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  62:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  66:	57fd                	li	a5,-1
  68:	00f50823          	sb	a5,16(a0)
}
  6c:	6422                	ld	s0,8(sp)
  6e:	0141                	addi	sp,sp,16
  70:	8082                	ret

0000000000000072 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  72:	00054783          	lbu	a5,0(a0)
  76:	e399                	bnez	a5,7c <holding+0xa>
  78:	4501                	li	a0,0
}
  7a:	8082                	ret
{
  7c:	1101                	addi	sp,sp,-32
  7e:	ec06                	sd	ra,24(sp)
  80:	e822                	sd	s0,16(sp)
  82:	e426                	sd	s1,8(sp)
  84:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  86:	01054483          	lbu	s1,16(a0)
  8a:	00000097          	auipc	ra,0x0
  8e:	340080e7          	jalr	832(ra) # 3ca <twhoami>
  92:	2501                	sext.w	a0,a0
  94:	40a48533          	sub	a0,s1,a0
  98:	00153513          	seqz	a0,a0
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	6442                	ld	s0,16(sp)
  a0:	64a2                	ld	s1,8(sp)
  a2:	6105                	addi	sp,sp,32
  a4:	8082                	ret

00000000000000a6 <acquire>:

void acquire(struct lock *lk)
{
  a6:	7179                	addi	sp,sp,-48
  a8:	f406                	sd	ra,40(sp)
  aa:	f022                	sd	s0,32(sp)
  ac:	ec26                	sd	s1,24(sp)
  ae:	e84a                	sd	s2,16(sp)
  b0:	e44e                	sd	s3,8(sp)
  b2:	e052                	sd	s4,0(sp)
  b4:	1800                	addi	s0,sp,48
  b6:	8a2a                	mv	s4,a0
    if (holding(lk))
  b8:	00000097          	auipc	ra,0x0
  bc:	fba080e7          	jalr	-70(ra) # 72 <holding>
  c0:	e919                	bnez	a0,d6 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c2:	ffca7493          	andi	s1,s4,-4
  c6:	003a7913          	andi	s2,s4,3
  ca:	0039191b          	slliw	s2,s2,0x3
  ce:	4985                	li	s3,1
  d0:	012999bb          	sllw	s3,s3,s2
  d4:	a015                	j	f8 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  d6:	00001517          	auipc	a0,0x1
  da:	b4a50513          	addi	a0,a0,-1206 # c20 <malloc+0x104>
  de:	00001097          	auipc	ra,0x1
  e2:	986080e7          	jalr	-1658(ra) # a64 <printf>
        exit(-1);
  e6:	557d                	li	a0,-1
  e8:	00000097          	auipc	ra,0x0
  ec:	5fc080e7          	jalr	1532(ra) # 6e4 <exit>
    {
        // give up the cpu for other threads
        tyield();
  f0:	00000097          	auipc	ra,0x0
  f4:	258080e7          	jalr	600(ra) # 348 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f8:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  fc:	0127d7bb          	srlw	a5,a5,s2
 100:	0ff7f793          	zext.b	a5,a5
 104:	f7f5                	bnez	a5,f0 <acquire+0x4a>
    }

    __sync_synchronize();
 106:	0ff0000f          	fence

    lk->tid = twhoami();
 10a:	00000097          	auipc	ra,0x0
 10e:	2c0080e7          	jalr	704(ra) # 3ca <twhoami>
 112:	00aa0823          	sb	a0,16(s4)
}
 116:	70a2                	ld	ra,40(sp)
 118:	7402                	ld	s0,32(sp)
 11a:	64e2                	ld	s1,24(sp)
 11c:	6942                	ld	s2,16(sp)
 11e:	69a2                	ld	s3,8(sp)
 120:	6a02                	ld	s4,0(sp)
 122:	6145                	addi	sp,sp,48
 124:	8082                	ret

0000000000000126 <release>:

void release(struct lock *lk)
{
 126:	1101                	addi	sp,sp,-32
 128:	ec06                	sd	ra,24(sp)
 12a:	e822                	sd	s0,16(sp)
 12c:	e426                	sd	s1,8(sp)
 12e:	1000                	addi	s0,sp,32
 130:	84aa                	mv	s1,a0
    if (!holding(lk))
 132:	00000097          	auipc	ra,0x0
 136:	f40080e7          	jalr	-192(ra) # 72 <holding>
 13a:	c11d                	beqz	a0,160 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 13c:	57fd                	li	a5,-1
 13e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 142:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 146:	0ff0000f          	fence
 14a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 14e:	00000097          	auipc	ra,0x0
 152:	1fa080e7          	jalr	506(ra) # 348 <tyield>
}
 156:	60e2                	ld	ra,24(sp)
 158:	6442                	ld	s0,16(sp)
 15a:	64a2                	ld	s1,8(sp)
 15c:	6105                	addi	sp,sp,32
 15e:	8082                	ret
        printf("releasing lock we are not holding");
 160:	00001517          	auipc	a0,0x1
 164:	ae850513          	addi	a0,a0,-1304 # c48 <malloc+0x12c>
 168:	00001097          	auipc	ra,0x1
 16c:	8fc080e7          	jalr	-1796(ra) # a64 <printf>
        exit(-1);
 170:	557d                	li	a0,-1
 172:	00000097          	auipc	ra,0x0
 176:	572080e7          	jalr	1394(ra) # 6e4 <exit>

000000000000017a <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 17a:	1141                	addi	sp,sp,-16
 17c:	e406                	sd	ra,8(sp)
 17e:	e022                	sd	s0,0(sp)
 180:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 182:	09800513          	li	a0,152
 186:	00001097          	auipc	ra,0x1
 18a:	996080e7          	jalr	-1642(ra) # b1c <malloc>

    main_thread->tid = next_tid;
 18e:	00001797          	auipc	a5,0x1
 192:	e7278793          	addi	a5,a5,-398 # 1000 <next_tid>
 196:	4398                	lw	a4,0(a5)
 198:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 19c:	4398                	lw	a4,0(a5)
 19e:	2705                	addiw	a4,a4,1
 1a0:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 1a2:	4791                	li	a5,4
 1a4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 1a6:	00001797          	auipc	a5,0x1
 1aa:	e6a7b523          	sd	a0,-406(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 1ae:	00001797          	auipc	a5,0x1
 1b2:	e7278793          	addi	a5,a5,-398 # 1020 <threads>
 1b6:	00001717          	auipc	a4,0x1
 1ba:	eea70713          	addi	a4,a4,-278 # 10a0 <base>
        threads[i] = NULL;
 1be:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 1c2:	07a1                	addi	a5,a5,8
 1c4:	fee79de3          	bne	a5,a4,1be <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 1c8:	00001797          	auipc	a5,0x1
 1cc:	e4a7bc23          	sd	a0,-424(a5) # 1020 <threads>
}
 1d0:	60a2                	ld	ra,8(sp)
 1d2:	6402                	ld	s0,0(sp)
 1d4:	0141                	addi	sp,sp,16
 1d6:	8082                	ret

00000000000001d8 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1d8:	00001517          	auipc	a0,0x1
 1dc:	e3853503          	ld	a0,-456(a0) # 1010 <current_thread>
 1e0:	00001717          	auipc	a4,0x1
 1e4:	e4070713          	addi	a4,a4,-448 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1e8:	4781                	li	a5,0
 1ea:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1ec:	6314                	ld	a3,0(a4)
 1ee:	00a68763          	beq	a3,a0,1fc <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1f2:	2785                	addiw	a5,a5,1
 1f4:	0721                	addi	a4,a4,8
 1f6:	fec79be3          	bne	a5,a2,1ec <tsched+0x14>
    int current_index = 0;
 1fa:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1fc:	0017869b          	addiw	a3,a5,1
 200:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 204:	00001817          	auipc	a6,0x1
 208:	e1c80813          	addi	a6,a6,-484 # 1020 <threads>
 20c:	488d                	li	a7,3
 20e:	a021                	j	216 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 210:	2685                	addiw	a3,a3,1
 212:	04c68363          	beq	a3,a2,258 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 216:	41f6d71b          	sraiw	a4,a3,0x1f
 21a:	01c7571b          	srliw	a4,a4,0x1c
 21e:	00d707bb          	addw	a5,a4,a3
 222:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 224:	9f99                	subw	a5,a5,a4
 226:	078e                	slli	a5,a5,0x3
 228:	97c2                	add	a5,a5,a6
 22a:	638c                	ld	a1,0(a5)
 22c:	d1f5                	beqz	a1,210 <tsched+0x38>
 22e:	5dbc                	lw	a5,120(a1)
 230:	ff1790e3          	bne	a5,a7,210 <tsched+0x38>
{
 234:	1141                	addi	sp,sp,-16
 236:	e406                	sd	ra,8(sp)
 238:	e022                	sd	s0,0(sp)
 23a:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 23c:	00001797          	auipc	a5,0x1
 240:	dcb7ba23          	sd	a1,-556(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 244:	05a1                	addi	a1,a1,8
 246:	0521                	addi	a0,a0,8
 248:	00000097          	auipc	ra,0x0
 24c:	19a080e7          	jalr	410(ra) # 3e2 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 250:	60a2                	ld	ra,8(sp)
 252:	6402                	ld	s0,0(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret
 258:	8082                	ret

000000000000025a <thread_wrapper>:
{
 25a:	1101                	addi	sp,sp,-32
 25c:	ec06                	sd	ra,24(sp)
 25e:	e822                	sd	s0,16(sp)
 260:	e426                	sd	s1,8(sp)
 262:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 264:	00001497          	auipc	s1,0x1
 268:	dac48493          	addi	s1,s1,-596 # 1010 <current_thread>
 26c:	609c                	ld	a5,0(s1)
 26e:	6b9c                	ld	a5,16(a5)
    func(arg);
 270:	6398                	ld	a4,0(a5)
 272:	6788                	ld	a0,8(a5)
 274:	9702                	jalr	a4
    current_thread->state = EXITED;
 276:	609c                	ld	a5,0(s1)
 278:	4719                	li	a4,6
 27a:	dfb8                	sw	a4,120(a5)
    tsched();
 27c:	00000097          	auipc	ra,0x0
 280:	f5c080e7          	jalr	-164(ra) # 1d8 <tsched>
}
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	64a2                	ld	s1,8(sp)
 28a:	6105                	addi	sp,sp,32
 28c:	8082                	ret

000000000000028e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 28e:	7179                	addi	sp,sp,-48
 290:	f406                	sd	ra,40(sp)
 292:	f022                	sd	s0,32(sp)
 294:	ec26                	sd	s1,24(sp)
 296:	e84a                	sd	s2,16(sp)
 298:	e44e                	sd	s3,8(sp)
 29a:	1800                	addi	s0,sp,48
 29c:	84aa                	mv	s1,a0
 29e:	8932                	mv	s2,a2
 2a0:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2a2:	09800513          	li	a0,152
 2a6:	00001097          	auipc	ra,0x1
 2aa:	876080e7          	jalr	-1930(ra) # b1c <malloc>
 2ae:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2b0:	478d                	li	a5,3
 2b2:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2b4:	609c                	ld	a5,0(s1)
 2b6:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 2ba:	609c                	ld	a5,0(s1)
 2bc:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 2c0:	6098                	ld	a4,0(s1)
 2c2:	00001797          	auipc	a5,0x1
 2c6:	d3e78793          	addi	a5,a5,-706 # 1000 <next_tid>
 2ca:	4394                	lw	a3,0(a5)
 2cc:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2d0:	4398                	lw	a4,0(a5)
 2d2:	2705                	addiw	a4,a4,1
 2d4:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 2d6:	6505                	lui	a0,0x1
 2d8:	00001097          	auipc	ra,0x1
 2dc:	844080e7          	jalr	-1980(ra) # b1c <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 2e0:	6785                	lui	a5,0x1
 2e2:	00a78733          	add	a4,a5,a0
 2e6:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 2ea:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x320>
 2ec:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 2ee:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 2f2:	609c                	ld	a5,0(s1)
 2f4:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2f6:	609c                	ld	a5,0(s1)
 2f8:	00000717          	auipc	a4,0x0
 2fc:	f6270713          	addi	a4,a4,-158 # 25a <thread_wrapper>
 300:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 302:	00001717          	auipc	a4,0x1
 306:	d1e70713          	addi	a4,a4,-738 # 1020 <threads>
 30a:	4781                	li	a5,0
 30c:	4641                	li	a2,16
        if (threads[i] == NULL) {
 30e:	6314                	ld	a3,0(a4)
 310:	c29d                	beqz	a3,336 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 312:	2785                	addiw	a5,a5,1
 314:	0721                	addi	a4,a4,8
 316:	fec79ce3          	bne	a5,a2,30e <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 31a:	6088                	ld	a0,0(s1)
 31c:	00000097          	auipc	ra,0x0
 320:	77e080e7          	jalr	1918(ra) # a9a <free>
        *thread = NULL;
 324:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 328:	70a2                	ld	ra,40(sp)
 32a:	7402                	ld	s0,32(sp)
 32c:	64e2                	ld	s1,24(sp)
 32e:	6942                	ld	s2,16(sp)
 330:	69a2                	ld	s3,8(sp)
 332:	6145                	addi	sp,sp,48
 334:	8082                	ret
            threads[i] = *thread;
 336:	6094                	ld	a3,0(s1)
 338:	078e                	slli	a5,a5,0x3
 33a:	00001717          	auipc	a4,0x1
 33e:	ce670713          	addi	a4,a4,-794 # 1020 <threads>
 342:	97ba                	add	a5,a5,a4
 344:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 346:	b7cd                	j	328 <tcreate+0x9a>

0000000000000348 <tyield>:
    return 0;
}


void tyield()
{
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 350:	00001797          	auipc	a5,0x1
 354:	cc07b783          	ld	a5,-832(a5) # 1010 <current_thread>
 358:	470d                	li	a4,3
 35a:	dfb8                	sw	a4,120(a5)
    tsched();
 35c:	00000097          	auipc	ra,0x0
 360:	e7c080e7          	jalr	-388(ra) # 1d8 <tsched>
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <tjoin>:
{
 36c:	1101                	addi	sp,sp,-32
 36e:	ec06                	sd	ra,24(sp)
 370:	e822                	sd	s0,16(sp)
 372:	e426                	sd	s1,8(sp)
 374:	e04a                	sd	s2,0(sp)
 376:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 378:	00001797          	auipc	a5,0x1
 37c:	ca878793          	addi	a5,a5,-856 # 1020 <threads>
 380:	00001697          	auipc	a3,0x1
 384:	d2068693          	addi	a3,a3,-736 # 10a0 <base>
 388:	a021                	j	390 <tjoin+0x24>
 38a:	07a1                	addi	a5,a5,8
 38c:	02d78b63          	beq	a5,a3,3c2 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 390:	6384                	ld	s1,0(a5)
 392:	dce5                	beqz	s1,38a <tjoin+0x1e>
 394:	0004c703          	lbu	a4,0(s1)
 398:	fea719e3          	bne	a4,a0,38a <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 39c:	5cb8                	lw	a4,120(s1)
 39e:	4799                	li	a5,6
 3a0:	4919                	li	s2,6
 3a2:	02f70263          	beq	a4,a5,3c6 <tjoin+0x5a>
        tyield();
 3a6:	00000097          	auipc	ra,0x0
 3aa:	fa2080e7          	jalr	-94(ra) # 348 <tyield>
    while (target_thread->state != EXITED) {
 3ae:	5cbc                	lw	a5,120(s1)
 3b0:	ff279be3          	bne	a5,s2,3a6 <tjoin+0x3a>
    return 0;
 3b4:	4501                	li	a0,0
}
 3b6:	60e2                	ld	ra,24(sp)
 3b8:	6442                	ld	s0,16(sp)
 3ba:	64a2                	ld	s1,8(sp)
 3bc:	6902                	ld	s2,0(sp)
 3be:	6105                	addi	sp,sp,32
 3c0:	8082                	ret
        return -1;
 3c2:	557d                	li	a0,-1
 3c4:	bfcd                	j	3b6 <tjoin+0x4a>
    return 0;
 3c6:	4501                	li	a0,0
 3c8:	b7fd                	j	3b6 <tjoin+0x4a>

00000000000003ca <twhoami>:

uint8 twhoami()
{
 3ca:	1141                	addi	sp,sp,-16
 3cc:	e422                	sd	s0,8(sp)
 3ce:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3d0:	00001797          	auipc	a5,0x1
 3d4:	c407b783          	ld	a5,-960(a5) # 1010 <current_thread>
 3d8:	0007c503          	lbu	a0,0(a5)
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret

00000000000003e2 <tswtch>:
 3e2:	00153023          	sd	ra,0(a0)
 3e6:	00253423          	sd	sp,8(a0)
 3ea:	e900                	sd	s0,16(a0)
 3ec:	ed04                	sd	s1,24(a0)
 3ee:	03253023          	sd	s2,32(a0)
 3f2:	03353423          	sd	s3,40(a0)
 3f6:	03453823          	sd	s4,48(a0)
 3fa:	03553c23          	sd	s5,56(a0)
 3fe:	05653023          	sd	s6,64(a0)
 402:	05753423          	sd	s7,72(a0)
 406:	05853823          	sd	s8,80(a0)
 40a:	05953c23          	sd	s9,88(a0)
 40e:	07a53023          	sd	s10,96(a0)
 412:	07b53423          	sd	s11,104(a0)
 416:	0005b083          	ld	ra,0(a1)
 41a:	0085b103          	ld	sp,8(a1)
 41e:	6980                	ld	s0,16(a1)
 420:	6d84                	ld	s1,24(a1)
 422:	0205b903          	ld	s2,32(a1)
 426:	0285b983          	ld	s3,40(a1)
 42a:	0305ba03          	ld	s4,48(a1)
 42e:	0385ba83          	ld	s5,56(a1)
 432:	0405bb03          	ld	s6,64(a1)
 436:	0485bb83          	ld	s7,72(a1)
 43a:	0505bc03          	ld	s8,80(a1)
 43e:	0585bc83          	ld	s9,88(a1)
 442:	0605bd03          	ld	s10,96(a1)
 446:	0685bd83          	ld	s11,104(a1)
 44a:	8082                	ret

000000000000044c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 44c:	1101                	addi	sp,sp,-32
 44e:	ec06                	sd	ra,24(sp)
 450:	e822                	sd	s0,16(sp)
 452:	e426                	sd	s1,8(sp)
 454:	e04a                	sd	s2,0(sp)
 456:	1000                	addi	s0,sp,32
 458:	84aa                	mv	s1,a0
 45a:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 45c:	00000097          	auipc	ra,0x0
 460:	d1e080e7          	jalr	-738(ra) # 17a <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 464:	85ca                	mv	a1,s2
 466:	8526                	mv	a0,s1
 468:	00000097          	auipc	ra,0x0
 46c:	b98080e7          	jalr	-1128(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 470:	00000097          	auipc	ra,0x0
 474:	274080e7          	jalr	628(ra) # 6e4 <exit>

0000000000000478 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 478:	1141                	addi	sp,sp,-16
 47a:	e422                	sd	s0,8(sp)
 47c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 47e:	87aa                	mv	a5,a0
 480:	0585                	addi	a1,a1,1
 482:	0785                	addi	a5,a5,1
 484:	fff5c703          	lbu	a4,-1(a1)
 488:	fee78fa3          	sb	a4,-1(a5)
 48c:	fb75                	bnez	a4,480 <strcpy+0x8>
        ;
    return os;
}
 48e:	6422                	ld	s0,8(sp)
 490:	0141                	addi	sp,sp,16
 492:	8082                	ret

0000000000000494 <strcmp>:

int strcmp(const char *p, const char *q)
{
 494:	1141                	addi	sp,sp,-16
 496:	e422                	sd	s0,8(sp)
 498:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 49a:	00054783          	lbu	a5,0(a0)
 49e:	cb91                	beqz	a5,4b2 <strcmp+0x1e>
 4a0:	0005c703          	lbu	a4,0(a1)
 4a4:	00f71763          	bne	a4,a5,4b2 <strcmp+0x1e>
        p++, q++;
 4a8:	0505                	addi	a0,a0,1
 4aa:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4ac:	00054783          	lbu	a5,0(a0)
 4b0:	fbe5                	bnez	a5,4a0 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4b2:	0005c503          	lbu	a0,0(a1)
}
 4b6:	40a7853b          	subw	a0,a5,a0
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret

00000000000004c0 <strlen>:

uint strlen(const char *s)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4c6:	00054783          	lbu	a5,0(a0)
 4ca:	cf91                	beqz	a5,4e6 <strlen+0x26>
 4cc:	0505                	addi	a0,a0,1
 4ce:	87aa                	mv	a5,a0
 4d0:	86be                	mv	a3,a5
 4d2:	0785                	addi	a5,a5,1
 4d4:	fff7c703          	lbu	a4,-1(a5)
 4d8:	ff65                	bnez	a4,4d0 <strlen+0x10>
 4da:	40a6853b          	subw	a0,a3,a0
 4de:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4e0:	6422                	ld	s0,8(sp)
 4e2:	0141                	addi	sp,sp,16
 4e4:	8082                	ret
    for (n = 0; s[n]; n++)
 4e6:	4501                	li	a0,0
 4e8:	bfe5                	j	4e0 <strlen+0x20>

00000000000004ea <memset>:

void *
memset(void *dst, int c, uint n)
{
 4ea:	1141                	addi	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4f0:	ca19                	beqz	a2,506 <memset+0x1c>
 4f2:	87aa                	mv	a5,a0
 4f4:	1602                	slli	a2,a2,0x20
 4f6:	9201                	srli	a2,a2,0x20
 4f8:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4fc:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 500:	0785                	addi	a5,a5,1
 502:	fee79de3          	bne	a5,a4,4fc <memset+0x12>
    }
    return dst;
}
 506:	6422                	ld	s0,8(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret

000000000000050c <strchr>:

char *
strchr(const char *s, char c)
{
 50c:	1141                	addi	sp,sp,-16
 50e:	e422                	sd	s0,8(sp)
 510:	0800                	addi	s0,sp,16
    for (; *s; s++)
 512:	00054783          	lbu	a5,0(a0)
 516:	cb99                	beqz	a5,52c <strchr+0x20>
        if (*s == c)
 518:	00f58763          	beq	a1,a5,526 <strchr+0x1a>
    for (; *s; s++)
 51c:	0505                	addi	a0,a0,1
 51e:	00054783          	lbu	a5,0(a0)
 522:	fbfd                	bnez	a5,518 <strchr+0xc>
            return (char *)s;
    return 0;
 524:	4501                	li	a0,0
}
 526:	6422                	ld	s0,8(sp)
 528:	0141                	addi	sp,sp,16
 52a:	8082                	ret
    return 0;
 52c:	4501                	li	a0,0
 52e:	bfe5                	j	526 <strchr+0x1a>

0000000000000530 <gets>:

char *
gets(char *buf, int max)
{
 530:	711d                	addi	sp,sp,-96
 532:	ec86                	sd	ra,88(sp)
 534:	e8a2                	sd	s0,80(sp)
 536:	e4a6                	sd	s1,72(sp)
 538:	e0ca                	sd	s2,64(sp)
 53a:	fc4e                	sd	s3,56(sp)
 53c:	f852                	sd	s4,48(sp)
 53e:	f456                	sd	s5,40(sp)
 540:	f05a                	sd	s6,32(sp)
 542:	ec5e                	sd	s7,24(sp)
 544:	1080                	addi	s0,sp,96
 546:	8baa                	mv	s7,a0
 548:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 54a:	892a                	mv	s2,a0
 54c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 54e:	4aa9                	li	s5,10
 550:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 552:	89a6                	mv	s3,s1
 554:	2485                	addiw	s1,s1,1
 556:	0344d863          	bge	s1,s4,586 <gets+0x56>
        cc = read(0, &c, 1);
 55a:	4605                	li	a2,1
 55c:	faf40593          	addi	a1,s0,-81
 560:	4501                	li	a0,0
 562:	00000097          	auipc	ra,0x0
 566:	19a080e7          	jalr	410(ra) # 6fc <read>
        if (cc < 1)
 56a:	00a05e63          	blez	a0,586 <gets+0x56>
        buf[i++] = c;
 56e:	faf44783          	lbu	a5,-81(s0)
 572:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 576:	01578763          	beq	a5,s5,584 <gets+0x54>
 57a:	0905                	addi	s2,s2,1
 57c:	fd679be3          	bne	a5,s6,552 <gets+0x22>
    for (i = 0; i + 1 < max;)
 580:	89a6                	mv	s3,s1
 582:	a011                	j	586 <gets+0x56>
 584:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 586:	99de                	add	s3,s3,s7
 588:	00098023          	sb	zero,0(s3)
    return buf;
}
 58c:	855e                	mv	a0,s7
 58e:	60e6                	ld	ra,88(sp)
 590:	6446                	ld	s0,80(sp)
 592:	64a6                	ld	s1,72(sp)
 594:	6906                	ld	s2,64(sp)
 596:	79e2                	ld	s3,56(sp)
 598:	7a42                	ld	s4,48(sp)
 59a:	7aa2                	ld	s5,40(sp)
 59c:	7b02                	ld	s6,32(sp)
 59e:	6be2                	ld	s7,24(sp)
 5a0:	6125                	addi	sp,sp,96
 5a2:	8082                	ret

00000000000005a4 <stat>:

int stat(const char *n, struct stat *st)
{
 5a4:	1101                	addi	sp,sp,-32
 5a6:	ec06                	sd	ra,24(sp)
 5a8:	e822                	sd	s0,16(sp)
 5aa:	e426                	sd	s1,8(sp)
 5ac:	e04a                	sd	s2,0(sp)
 5ae:	1000                	addi	s0,sp,32
 5b0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5b2:	4581                	li	a1,0
 5b4:	00000097          	auipc	ra,0x0
 5b8:	170080e7          	jalr	368(ra) # 724 <open>
    if (fd < 0)
 5bc:	02054563          	bltz	a0,5e6 <stat+0x42>
 5c0:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5c2:	85ca                	mv	a1,s2
 5c4:	00000097          	auipc	ra,0x0
 5c8:	178080e7          	jalr	376(ra) # 73c <fstat>
 5cc:	892a                	mv	s2,a0
    close(fd);
 5ce:	8526                	mv	a0,s1
 5d0:	00000097          	auipc	ra,0x0
 5d4:	13c080e7          	jalr	316(ra) # 70c <close>
    return r;
}
 5d8:	854a                	mv	a0,s2
 5da:	60e2                	ld	ra,24(sp)
 5dc:	6442                	ld	s0,16(sp)
 5de:	64a2                	ld	s1,8(sp)
 5e0:	6902                	ld	s2,0(sp)
 5e2:	6105                	addi	sp,sp,32
 5e4:	8082                	ret
        return -1;
 5e6:	597d                	li	s2,-1
 5e8:	bfc5                	j	5d8 <stat+0x34>

00000000000005ea <atoi>:

int atoi(const char *s)
{
 5ea:	1141                	addi	sp,sp,-16
 5ec:	e422                	sd	s0,8(sp)
 5ee:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5f0:	00054683          	lbu	a3,0(a0)
 5f4:	fd06879b          	addiw	a5,a3,-48
 5f8:	0ff7f793          	zext.b	a5,a5
 5fc:	4625                	li	a2,9
 5fe:	02f66863          	bltu	a2,a5,62e <atoi+0x44>
 602:	872a                	mv	a4,a0
    n = 0;
 604:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 606:	0705                	addi	a4,a4,1
 608:	0025179b          	slliw	a5,a0,0x2
 60c:	9fa9                	addw	a5,a5,a0
 60e:	0017979b          	slliw	a5,a5,0x1
 612:	9fb5                	addw	a5,a5,a3
 614:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 618:	00074683          	lbu	a3,0(a4)
 61c:	fd06879b          	addiw	a5,a3,-48
 620:	0ff7f793          	zext.b	a5,a5
 624:	fef671e3          	bgeu	a2,a5,606 <atoi+0x1c>
    return n;
}
 628:	6422                	ld	s0,8(sp)
 62a:	0141                	addi	sp,sp,16
 62c:	8082                	ret
    n = 0;
 62e:	4501                	li	a0,0
 630:	bfe5                	j	628 <atoi+0x3e>

0000000000000632 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 632:	1141                	addi	sp,sp,-16
 634:	e422                	sd	s0,8(sp)
 636:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 638:	02b57463          	bgeu	a0,a1,660 <memmove+0x2e>
    {
        while (n-- > 0)
 63c:	00c05f63          	blez	a2,65a <memmove+0x28>
 640:	1602                	slli	a2,a2,0x20
 642:	9201                	srli	a2,a2,0x20
 644:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 648:	872a                	mv	a4,a0
            *dst++ = *src++;
 64a:	0585                	addi	a1,a1,1
 64c:	0705                	addi	a4,a4,1
 64e:	fff5c683          	lbu	a3,-1(a1)
 652:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 656:	fee79ae3          	bne	a5,a4,64a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 65a:	6422                	ld	s0,8(sp)
 65c:	0141                	addi	sp,sp,16
 65e:	8082                	ret
        dst += n;
 660:	00c50733          	add	a4,a0,a2
        src += n;
 664:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 666:	fec05ae3          	blez	a2,65a <memmove+0x28>
 66a:	fff6079b          	addiw	a5,a2,-1
 66e:	1782                	slli	a5,a5,0x20
 670:	9381                	srli	a5,a5,0x20
 672:	fff7c793          	not	a5,a5
 676:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 678:	15fd                	addi	a1,a1,-1
 67a:	177d                	addi	a4,a4,-1
 67c:	0005c683          	lbu	a3,0(a1)
 680:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 684:	fee79ae3          	bne	a5,a4,678 <memmove+0x46>
 688:	bfc9                	j	65a <memmove+0x28>

000000000000068a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 68a:	1141                	addi	sp,sp,-16
 68c:	e422                	sd	s0,8(sp)
 68e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 690:	ca05                	beqz	a2,6c0 <memcmp+0x36>
 692:	fff6069b          	addiw	a3,a2,-1
 696:	1682                	slli	a3,a3,0x20
 698:	9281                	srli	a3,a3,0x20
 69a:	0685                	addi	a3,a3,1
 69c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 69e:	00054783          	lbu	a5,0(a0)
 6a2:	0005c703          	lbu	a4,0(a1)
 6a6:	00e79863          	bne	a5,a4,6b6 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6aa:	0505                	addi	a0,a0,1
        p2++;
 6ac:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6ae:	fed518e3          	bne	a0,a3,69e <memcmp+0x14>
    }
    return 0;
 6b2:	4501                	li	a0,0
 6b4:	a019                	j	6ba <memcmp+0x30>
            return *p1 - *p2;
 6b6:	40e7853b          	subw	a0,a5,a4
}
 6ba:	6422                	ld	s0,8(sp)
 6bc:	0141                	addi	sp,sp,16
 6be:	8082                	ret
    return 0;
 6c0:	4501                	li	a0,0
 6c2:	bfe5                	j	6ba <memcmp+0x30>

00000000000006c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6c4:	1141                	addi	sp,sp,-16
 6c6:	e406                	sd	ra,8(sp)
 6c8:	e022                	sd	s0,0(sp)
 6ca:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6cc:	00000097          	auipc	ra,0x0
 6d0:	f66080e7          	jalr	-154(ra) # 632 <memmove>
}
 6d4:	60a2                	ld	ra,8(sp)
 6d6:	6402                	ld	s0,0(sp)
 6d8:	0141                	addi	sp,sp,16
 6da:	8082                	ret

00000000000006dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6dc:	4885                	li	a7,1
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6e4:	4889                	li	a7,2
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 6ec:	488d                	li	a7,3
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6f4:	4891                	li	a7,4
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <read>:
.global read
read:
 li a7, SYS_read
 6fc:	4895                	li	a7,5
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <write>:
.global write
write:
 li a7, SYS_write
 704:	48c1                	li	a7,16
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <close>:
.global close
close:
 li a7, SYS_close
 70c:	48d5                	li	a7,21
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <kill>:
.global kill
kill:
 li a7, SYS_kill
 714:	4899                	li	a7,6
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <exec>:
.global exec
exec:
 li a7, SYS_exec
 71c:	489d                	li	a7,7
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <open>:
.global open
open:
 li a7, SYS_open
 724:	48bd                	li	a7,15
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 72c:	48c5                	li	a7,17
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 734:	48c9                	li	a7,18
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 73c:	48a1                	li	a7,8
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <link>:
.global link
link:
 li a7, SYS_link
 744:	48cd                	li	a7,19
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 74c:	48d1                	li	a7,20
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 754:	48a5                	li	a7,9
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <dup>:
.global dup
dup:
 li a7, SYS_dup
 75c:	48a9                	li	a7,10
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 764:	48ad                	li	a7,11
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 76c:	48b1                	li	a7,12
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 774:	48b5                	li	a7,13
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 77c:	48b9                	li	a7,14
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <ps>:
.global ps
ps:
 li a7, SYS_ps
 784:	48d9                	li	a7,22
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 78c:	48dd                	li	a7,23
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 794:	48e1                	li	a7,24
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 79c:	1101                	addi	sp,sp,-32
 79e:	ec06                	sd	ra,24(sp)
 7a0:	e822                	sd	s0,16(sp)
 7a2:	1000                	addi	s0,sp,32
 7a4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7a8:	4605                	li	a2,1
 7aa:	fef40593          	addi	a1,s0,-17
 7ae:	00000097          	auipc	ra,0x0
 7b2:	f56080e7          	jalr	-170(ra) # 704 <write>
}
 7b6:	60e2                	ld	ra,24(sp)
 7b8:	6442                	ld	s0,16(sp)
 7ba:	6105                	addi	sp,sp,32
 7bc:	8082                	ret

00000000000007be <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7be:	7139                	addi	sp,sp,-64
 7c0:	fc06                	sd	ra,56(sp)
 7c2:	f822                	sd	s0,48(sp)
 7c4:	f426                	sd	s1,40(sp)
 7c6:	f04a                	sd	s2,32(sp)
 7c8:	ec4e                	sd	s3,24(sp)
 7ca:	0080                	addi	s0,sp,64
 7cc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7ce:	c299                	beqz	a3,7d4 <printint+0x16>
 7d0:	0805c963          	bltz	a1,862 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7d4:	2581                	sext.w	a1,a1
  neg = 0;
 7d6:	4881                	li	a7,0
 7d8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7dc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7de:	2601                	sext.w	a2,a2
 7e0:	00000517          	auipc	a0,0x0
 7e4:	4f050513          	addi	a0,a0,1264 # cd0 <digits>
 7e8:	883a                	mv	a6,a4
 7ea:	2705                	addiw	a4,a4,1
 7ec:	02c5f7bb          	remuw	a5,a1,a2
 7f0:	1782                	slli	a5,a5,0x20
 7f2:	9381                	srli	a5,a5,0x20
 7f4:	97aa                	add	a5,a5,a0
 7f6:	0007c783          	lbu	a5,0(a5)
 7fa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7fe:	0005879b          	sext.w	a5,a1
 802:	02c5d5bb          	divuw	a1,a1,a2
 806:	0685                	addi	a3,a3,1
 808:	fec7f0e3          	bgeu	a5,a2,7e8 <printint+0x2a>
  if(neg)
 80c:	00088c63          	beqz	a7,824 <printint+0x66>
    buf[i++] = '-';
 810:	fd070793          	addi	a5,a4,-48
 814:	00878733          	add	a4,a5,s0
 818:	02d00793          	li	a5,45
 81c:	fef70823          	sb	a5,-16(a4)
 820:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 824:	02e05863          	blez	a4,854 <printint+0x96>
 828:	fc040793          	addi	a5,s0,-64
 82c:	00e78933          	add	s2,a5,a4
 830:	fff78993          	addi	s3,a5,-1
 834:	99ba                	add	s3,s3,a4
 836:	377d                	addiw	a4,a4,-1
 838:	1702                	slli	a4,a4,0x20
 83a:	9301                	srli	a4,a4,0x20
 83c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 840:	fff94583          	lbu	a1,-1(s2)
 844:	8526                	mv	a0,s1
 846:	00000097          	auipc	ra,0x0
 84a:	f56080e7          	jalr	-170(ra) # 79c <putc>
  while(--i >= 0)
 84e:	197d                	addi	s2,s2,-1
 850:	ff3918e3          	bne	s2,s3,840 <printint+0x82>
}
 854:	70e2                	ld	ra,56(sp)
 856:	7442                	ld	s0,48(sp)
 858:	74a2                	ld	s1,40(sp)
 85a:	7902                	ld	s2,32(sp)
 85c:	69e2                	ld	s3,24(sp)
 85e:	6121                	addi	sp,sp,64
 860:	8082                	ret
    x = -xx;
 862:	40b005bb          	negw	a1,a1
    neg = 1;
 866:	4885                	li	a7,1
    x = -xx;
 868:	bf85                	j	7d8 <printint+0x1a>

000000000000086a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 86a:	715d                	addi	sp,sp,-80
 86c:	e486                	sd	ra,72(sp)
 86e:	e0a2                	sd	s0,64(sp)
 870:	fc26                	sd	s1,56(sp)
 872:	f84a                	sd	s2,48(sp)
 874:	f44e                	sd	s3,40(sp)
 876:	f052                	sd	s4,32(sp)
 878:	ec56                	sd	s5,24(sp)
 87a:	e85a                	sd	s6,16(sp)
 87c:	e45e                	sd	s7,8(sp)
 87e:	e062                	sd	s8,0(sp)
 880:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 882:	0005c903          	lbu	s2,0(a1)
 886:	18090c63          	beqz	s2,a1e <vprintf+0x1b4>
 88a:	8aaa                	mv	s5,a0
 88c:	8bb2                	mv	s7,a2
 88e:	00158493          	addi	s1,a1,1
  state = 0;
 892:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 894:	02500a13          	li	s4,37
 898:	4b55                	li	s6,21
 89a:	a839                	j	8b8 <vprintf+0x4e>
        putc(fd, c);
 89c:	85ca                	mv	a1,s2
 89e:	8556                	mv	a0,s5
 8a0:	00000097          	auipc	ra,0x0
 8a4:	efc080e7          	jalr	-260(ra) # 79c <putc>
 8a8:	a019                	j	8ae <vprintf+0x44>
    } else if(state == '%'){
 8aa:	01498d63          	beq	s3,s4,8c4 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8ae:	0485                	addi	s1,s1,1
 8b0:	fff4c903          	lbu	s2,-1(s1)
 8b4:	16090563          	beqz	s2,a1e <vprintf+0x1b4>
    if(state == 0){
 8b8:	fe0999e3          	bnez	s3,8aa <vprintf+0x40>
      if(c == '%'){
 8bc:	ff4910e3          	bne	s2,s4,89c <vprintf+0x32>
        state = '%';
 8c0:	89d2                	mv	s3,s4
 8c2:	b7f5                	j	8ae <vprintf+0x44>
      if(c == 'd'){
 8c4:	13490263          	beq	s2,s4,9e8 <vprintf+0x17e>
 8c8:	f9d9079b          	addiw	a5,s2,-99
 8cc:	0ff7f793          	zext.b	a5,a5
 8d0:	12fb6563          	bltu	s6,a5,9fa <vprintf+0x190>
 8d4:	f9d9079b          	addiw	a5,s2,-99
 8d8:	0ff7f713          	zext.b	a4,a5
 8dc:	10eb6f63          	bltu	s6,a4,9fa <vprintf+0x190>
 8e0:	00271793          	slli	a5,a4,0x2
 8e4:	00000717          	auipc	a4,0x0
 8e8:	39470713          	addi	a4,a4,916 # c78 <malloc+0x15c>
 8ec:	97ba                	add	a5,a5,a4
 8ee:	439c                	lw	a5,0(a5)
 8f0:	97ba                	add	a5,a5,a4
 8f2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8f4:	008b8913          	addi	s2,s7,8
 8f8:	4685                	li	a3,1
 8fa:	4629                	li	a2,10
 8fc:	000ba583          	lw	a1,0(s7)
 900:	8556                	mv	a0,s5
 902:	00000097          	auipc	ra,0x0
 906:	ebc080e7          	jalr	-324(ra) # 7be <printint>
 90a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 90c:	4981                	li	s3,0
 90e:	b745                	j	8ae <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 910:	008b8913          	addi	s2,s7,8
 914:	4681                	li	a3,0
 916:	4629                	li	a2,10
 918:	000ba583          	lw	a1,0(s7)
 91c:	8556                	mv	a0,s5
 91e:	00000097          	auipc	ra,0x0
 922:	ea0080e7          	jalr	-352(ra) # 7be <printint>
 926:	8bca                	mv	s7,s2
      state = 0;
 928:	4981                	li	s3,0
 92a:	b751                	j	8ae <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 92c:	008b8913          	addi	s2,s7,8
 930:	4681                	li	a3,0
 932:	4641                	li	a2,16
 934:	000ba583          	lw	a1,0(s7)
 938:	8556                	mv	a0,s5
 93a:	00000097          	auipc	ra,0x0
 93e:	e84080e7          	jalr	-380(ra) # 7be <printint>
 942:	8bca                	mv	s7,s2
      state = 0;
 944:	4981                	li	s3,0
 946:	b7a5                	j	8ae <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 948:	008b8c13          	addi	s8,s7,8
 94c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 950:	03000593          	li	a1,48
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	e46080e7          	jalr	-442(ra) # 79c <putc>
  putc(fd, 'x');
 95e:	07800593          	li	a1,120
 962:	8556                	mv	a0,s5
 964:	00000097          	auipc	ra,0x0
 968:	e38080e7          	jalr	-456(ra) # 79c <putc>
 96c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 96e:	00000b97          	auipc	s7,0x0
 972:	362b8b93          	addi	s7,s7,866 # cd0 <digits>
 976:	03c9d793          	srli	a5,s3,0x3c
 97a:	97de                	add	a5,a5,s7
 97c:	0007c583          	lbu	a1,0(a5)
 980:	8556                	mv	a0,s5
 982:	00000097          	auipc	ra,0x0
 986:	e1a080e7          	jalr	-486(ra) # 79c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 98a:	0992                	slli	s3,s3,0x4
 98c:	397d                	addiw	s2,s2,-1
 98e:	fe0914e3          	bnez	s2,976 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 992:	8be2                	mv	s7,s8
      state = 0;
 994:	4981                	li	s3,0
 996:	bf21                	j	8ae <vprintf+0x44>
        s = va_arg(ap, char*);
 998:	008b8993          	addi	s3,s7,8
 99c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9a0:	02090163          	beqz	s2,9c2 <vprintf+0x158>
        while(*s != 0){
 9a4:	00094583          	lbu	a1,0(s2)
 9a8:	c9a5                	beqz	a1,a18 <vprintf+0x1ae>
          putc(fd, *s);
 9aa:	8556                	mv	a0,s5
 9ac:	00000097          	auipc	ra,0x0
 9b0:	df0080e7          	jalr	-528(ra) # 79c <putc>
          s++;
 9b4:	0905                	addi	s2,s2,1
        while(*s != 0){
 9b6:	00094583          	lbu	a1,0(s2)
 9ba:	f9e5                	bnez	a1,9aa <vprintf+0x140>
        s = va_arg(ap, char*);
 9bc:	8bce                	mv	s7,s3
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	b5fd                	j	8ae <vprintf+0x44>
          s = "(null)";
 9c2:	00000917          	auipc	s2,0x0
 9c6:	2ae90913          	addi	s2,s2,686 # c70 <malloc+0x154>
        while(*s != 0){
 9ca:	02800593          	li	a1,40
 9ce:	bff1                	j	9aa <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9d0:	008b8913          	addi	s2,s7,8
 9d4:	000bc583          	lbu	a1,0(s7)
 9d8:	8556                	mv	a0,s5
 9da:	00000097          	auipc	ra,0x0
 9de:	dc2080e7          	jalr	-574(ra) # 79c <putc>
 9e2:	8bca                	mv	s7,s2
      state = 0;
 9e4:	4981                	li	s3,0
 9e6:	b5e1                	j	8ae <vprintf+0x44>
        putc(fd, c);
 9e8:	02500593          	li	a1,37
 9ec:	8556                	mv	a0,s5
 9ee:	00000097          	auipc	ra,0x0
 9f2:	dae080e7          	jalr	-594(ra) # 79c <putc>
      state = 0;
 9f6:	4981                	li	s3,0
 9f8:	bd5d                	j	8ae <vprintf+0x44>
        putc(fd, '%');
 9fa:	02500593          	li	a1,37
 9fe:	8556                	mv	a0,s5
 a00:	00000097          	auipc	ra,0x0
 a04:	d9c080e7          	jalr	-612(ra) # 79c <putc>
        putc(fd, c);
 a08:	85ca                	mv	a1,s2
 a0a:	8556                	mv	a0,s5
 a0c:	00000097          	auipc	ra,0x0
 a10:	d90080e7          	jalr	-624(ra) # 79c <putc>
      state = 0;
 a14:	4981                	li	s3,0
 a16:	bd61                	j	8ae <vprintf+0x44>
        s = va_arg(ap, char*);
 a18:	8bce                	mv	s7,s3
      state = 0;
 a1a:	4981                	li	s3,0
 a1c:	bd49                	j	8ae <vprintf+0x44>
    }
  }
}
 a1e:	60a6                	ld	ra,72(sp)
 a20:	6406                	ld	s0,64(sp)
 a22:	74e2                	ld	s1,56(sp)
 a24:	7942                	ld	s2,48(sp)
 a26:	79a2                	ld	s3,40(sp)
 a28:	7a02                	ld	s4,32(sp)
 a2a:	6ae2                	ld	s5,24(sp)
 a2c:	6b42                	ld	s6,16(sp)
 a2e:	6ba2                	ld	s7,8(sp)
 a30:	6c02                	ld	s8,0(sp)
 a32:	6161                	addi	sp,sp,80
 a34:	8082                	ret

0000000000000a36 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a36:	715d                	addi	sp,sp,-80
 a38:	ec06                	sd	ra,24(sp)
 a3a:	e822                	sd	s0,16(sp)
 a3c:	1000                	addi	s0,sp,32
 a3e:	e010                	sd	a2,0(s0)
 a40:	e414                	sd	a3,8(s0)
 a42:	e818                	sd	a4,16(s0)
 a44:	ec1c                	sd	a5,24(s0)
 a46:	03043023          	sd	a6,32(s0)
 a4a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a4e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a52:	8622                	mv	a2,s0
 a54:	00000097          	auipc	ra,0x0
 a58:	e16080e7          	jalr	-490(ra) # 86a <vprintf>
}
 a5c:	60e2                	ld	ra,24(sp)
 a5e:	6442                	ld	s0,16(sp)
 a60:	6161                	addi	sp,sp,80
 a62:	8082                	ret

0000000000000a64 <printf>:

void
printf(const char *fmt, ...)
{
 a64:	711d                	addi	sp,sp,-96
 a66:	ec06                	sd	ra,24(sp)
 a68:	e822                	sd	s0,16(sp)
 a6a:	1000                	addi	s0,sp,32
 a6c:	e40c                	sd	a1,8(s0)
 a6e:	e810                	sd	a2,16(s0)
 a70:	ec14                	sd	a3,24(s0)
 a72:	f018                	sd	a4,32(s0)
 a74:	f41c                	sd	a5,40(s0)
 a76:	03043823          	sd	a6,48(s0)
 a7a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a7e:	00840613          	addi	a2,s0,8
 a82:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a86:	85aa                	mv	a1,a0
 a88:	4505                	li	a0,1
 a8a:	00000097          	auipc	ra,0x0
 a8e:	de0080e7          	jalr	-544(ra) # 86a <vprintf>
}
 a92:	60e2                	ld	ra,24(sp)
 a94:	6442                	ld	s0,16(sp)
 a96:	6125                	addi	sp,sp,96
 a98:	8082                	ret

0000000000000a9a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a9a:	1141                	addi	sp,sp,-16
 a9c:	e422                	sd	s0,8(sp)
 a9e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 aa0:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa4:	00000797          	auipc	a5,0x0
 aa8:	5747b783          	ld	a5,1396(a5) # 1018 <freep>
 aac:	a02d                	j	ad6 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 aae:	4618                	lw	a4,8(a2)
 ab0:	9f2d                	addw	a4,a4,a1
 ab2:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 ab6:	6398                	ld	a4,0(a5)
 ab8:	6310                	ld	a2,0(a4)
 aba:	a83d                	j	af8 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 abc:	ff852703          	lw	a4,-8(a0)
 ac0:	9f31                	addw	a4,a4,a2
 ac2:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ac4:	ff053683          	ld	a3,-16(a0)
 ac8:	a091                	j	b0c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aca:	6398                	ld	a4,0(a5)
 acc:	00e7e463          	bltu	a5,a4,ad4 <free+0x3a>
 ad0:	00e6ea63          	bltu	a3,a4,ae4 <free+0x4a>
{
 ad4:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad6:	fed7fae3          	bgeu	a5,a3,aca <free+0x30>
 ada:	6398                	ld	a4,0(a5)
 adc:	00e6e463          	bltu	a3,a4,ae4 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae0:	fee7eae3          	bltu	a5,a4,ad4 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ae4:	ff852583          	lw	a1,-8(a0)
 ae8:	6390                	ld	a2,0(a5)
 aea:	02059813          	slli	a6,a1,0x20
 aee:	01c85713          	srli	a4,a6,0x1c
 af2:	9736                	add	a4,a4,a3
 af4:	fae60de3          	beq	a2,a4,aae <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 af8:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 afc:	4790                	lw	a2,8(a5)
 afe:	02061593          	slli	a1,a2,0x20
 b02:	01c5d713          	srli	a4,a1,0x1c
 b06:	973e                	add	a4,a4,a5
 b08:	fae68ae3          	beq	a3,a4,abc <free+0x22>
        p->s.ptr = bp->s.ptr;
 b0c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b0e:	00000717          	auipc	a4,0x0
 b12:	50f73523          	sd	a5,1290(a4) # 1018 <freep>
}
 b16:	6422                	ld	s0,8(sp)
 b18:	0141                	addi	sp,sp,16
 b1a:	8082                	ret

0000000000000b1c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b1c:	7139                	addi	sp,sp,-64
 b1e:	fc06                	sd	ra,56(sp)
 b20:	f822                	sd	s0,48(sp)
 b22:	f426                	sd	s1,40(sp)
 b24:	f04a                	sd	s2,32(sp)
 b26:	ec4e                	sd	s3,24(sp)
 b28:	e852                	sd	s4,16(sp)
 b2a:	e456                	sd	s5,8(sp)
 b2c:	e05a                	sd	s6,0(sp)
 b2e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b30:	02051493          	slli	s1,a0,0x20
 b34:	9081                	srli	s1,s1,0x20
 b36:	04bd                	addi	s1,s1,15
 b38:	8091                	srli	s1,s1,0x4
 b3a:	0014899b          	addiw	s3,s1,1
 b3e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b40:	00000517          	auipc	a0,0x0
 b44:	4d853503          	ld	a0,1240(a0) # 1018 <freep>
 b48:	c515                	beqz	a0,b74 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b4a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b4c:	4798                	lw	a4,8(a5)
 b4e:	02977f63          	bgeu	a4,s1,b8c <malloc+0x70>
    if (nu < 4096)
 b52:	8a4e                	mv	s4,s3
 b54:	0009871b          	sext.w	a4,s3
 b58:	6685                	lui	a3,0x1
 b5a:	00d77363          	bgeu	a4,a3,b60 <malloc+0x44>
 b5e:	6a05                	lui	s4,0x1
 b60:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b64:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b68:	00000917          	auipc	s2,0x0
 b6c:	4b090913          	addi	s2,s2,1200 # 1018 <freep>
    if (p == (char *)-1)
 b70:	5afd                	li	s5,-1
 b72:	a895                	j	be6 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b74:	00000797          	auipc	a5,0x0
 b78:	52c78793          	addi	a5,a5,1324 # 10a0 <base>
 b7c:	00000717          	auipc	a4,0x0
 b80:	48f73e23          	sd	a5,1180(a4) # 1018 <freep>
 b84:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b86:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b8a:	b7e1                	j	b52 <malloc+0x36>
            if (p->s.size == nunits)
 b8c:	02e48c63          	beq	s1,a4,bc4 <malloc+0xa8>
                p->s.size -= nunits;
 b90:	4137073b          	subw	a4,a4,s3
 b94:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b96:	02071693          	slli	a3,a4,0x20
 b9a:	01c6d713          	srli	a4,a3,0x1c
 b9e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 ba0:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 ba4:	00000717          	auipc	a4,0x0
 ba8:	46a73a23          	sd	a0,1140(a4) # 1018 <freep>
            return (void *)(p + 1);
 bac:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bb0:	70e2                	ld	ra,56(sp)
 bb2:	7442                	ld	s0,48(sp)
 bb4:	74a2                	ld	s1,40(sp)
 bb6:	7902                	ld	s2,32(sp)
 bb8:	69e2                	ld	s3,24(sp)
 bba:	6a42                	ld	s4,16(sp)
 bbc:	6aa2                	ld	s5,8(sp)
 bbe:	6b02                	ld	s6,0(sp)
 bc0:	6121                	addi	sp,sp,64
 bc2:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bc4:	6398                	ld	a4,0(a5)
 bc6:	e118                	sd	a4,0(a0)
 bc8:	bff1                	j	ba4 <malloc+0x88>
    hp->s.size = nu;
 bca:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bce:	0541                	addi	a0,a0,16
 bd0:	00000097          	auipc	ra,0x0
 bd4:	eca080e7          	jalr	-310(ra) # a9a <free>
    return freep;
 bd8:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bdc:	d971                	beqz	a0,bb0 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bde:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 be0:	4798                	lw	a4,8(a5)
 be2:	fa9775e3          	bgeu	a4,s1,b8c <malloc+0x70>
        if (p == freep)
 be6:	00093703          	ld	a4,0(s2)
 bea:	853e                	mv	a0,a5
 bec:	fef719e3          	bne	a4,a5,bde <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bf0:	8552                	mv	a0,s4
 bf2:	00000097          	auipc	ra,0x0
 bf6:	b7a080e7          	jalr	-1158(ra) # 76c <sbrk>
    if (p == (char *)-1)
 bfa:	fd5518e3          	bne	a0,s5,bca <malloc+0xae>
                return 0;
 bfe:	4501                	li	a0,0
 c00:	bf45                	j	bb0 <malloc+0x94>
