
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7dd63          	bge	a5,a0,48 <main+0x48>
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	5cc080e7          	jalr	1484(ra) # 5f4 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	6ee080e7          	jalr	1774(ra) # 71e <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	6ae080e7          	jalr	1710(ra) # 6ee <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	bc858593          	addi	a1,a1,-1080 # c10 <malloc+0xea>
  50:	4509                	li	a0,2
  52:	00001097          	auipc	ra,0x1
  56:	9ee080e7          	jalr	-1554(ra) # a40 <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	692080e7          	jalr	1682(ra) # 6ee <exit>

0000000000000064 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
    lk->name = name;
  6a:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  6c:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  70:	57fd                	li	a5,-1
  72:	00f50823          	sb	a5,16(a0)
}
  76:	6422                	ld	s0,8(sp)
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  7c:	00054783          	lbu	a5,0(a0)
  80:	e399                	bnez	a5,86 <holding+0xa>
  82:	4501                	li	a0,0
}
  84:	8082                	ret
{
  86:	1101                	addi	sp,sp,-32
  88:	ec06                	sd	ra,24(sp)
  8a:	e822                	sd	s0,16(sp)
  8c:	e426                	sd	s1,8(sp)
  8e:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  90:	01054483          	lbu	s1,16(a0)
  94:	00000097          	auipc	ra,0x0
  98:	340080e7          	jalr	832(ra) # 3d4 <twhoami>
  9c:	2501                	sext.w	a0,a0
  9e:	40a48533          	sub	a0,s1,a0
  a2:	00153513          	seqz	a0,a0
}
  a6:	60e2                	ld	ra,24(sp)
  a8:	6442                	ld	s0,16(sp)
  aa:	64a2                	ld	s1,8(sp)
  ac:	6105                	addi	sp,sp,32
  ae:	8082                	ret

00000000000000b0 <acquire>:

void acquire(struct lock *lk)
{
  b0:	7179                	addi	sp,sp,-48
  b2:	f406                	sd	ra,40(sp)
  b4:	f022                	sd	s0,32(sp)
  b6:	ec26                	sd	s1,24(sp)
  b8:	e84a                	sd	s2,16(sp)
  ba:	e44e                	sd	s3,8(sp)
  bc:	e052                	sd	s4,0(sp)
  be:	1800                	addi	s0,sp,48
  c0:	8a2a                	mv	s4,a0
    if (holding(lk))
  c2:	00000097          	auipc	ra,0x0
  c6:	fba080e7          	jalr	-70(ra) # 7c <holding>
  ca:	e919                	bnez	a0,e0 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  cc:	ffca7493          	andi	s1,s4,-4
  d0:	003a7913          	andi	s2,s4,3
  d4:	0039191b          	slliw	s2,s2,0x3
  d8:	4985                	li	s3,1
  da:	012999bb          	sllw	s3,s3,s2
  de:	a015                	j	102 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  e0:	00001517          	auipc	a0,0x1
  e4:	b4850513          	addi	a0,a0,-1208 # c28 <malloc+0x102>
  e8:	00001097          	auipc	ra,0x1
  ec:	986080e7          	jalr	-1658(ra) # a6e <printf>
        exit(-1);
  f0:	557d                	li	a0,-1
  f2:	00000097          	auipc	ra,0x0
  f6:	5fc080e7          	jalr	1532(ra) # 6ee <exit>
    {
        // give up the cpu for other threads
        tyield();
  fa:	00000097          	auipc	ra,0x0
  fe:	258080e7          	jalr	600(ra) # 352 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 102:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 106:	0127d7bb          	srlw	a5,a5,s2
 10a:	0ff7f793          	zext.b	a5,a5
 10e:	f7f5                	bnez	a5,fa <acquire+0x4a>
    }

    __sync_synchronize();
 110:	0ff0000f          	fence

    lk->tid = twhoami();
 114:	00000097          	auipc	ra,0x0
 118:	2c0080e7          	jalr	704(ra) # 3d4 <twhoami>
 11c:	00aa0823          	sb	a0,16(s4)
}
 120:	70a2                	ld	ra,40(sp)
 122:	7402                	ld	s0,32(sp)
 124:	64e2                	ld	s1,24(sp)
 126:	6942                	ld	s2,16(sp)
 128:	69a2                	ld	s3,8(sp)
 12a:	6a02                	ld	s4,0(sp)
 12c:	6145                	addi	sp,sp,48
 12e:	8082                	ret

0000000000000130 <release>:

void release(struct lock *lk)
{
 130:	1101                	addi	sp,sp,-32
 132:	ec06                	sd	ra,24(sp)
 134:	e822                	sd	s0,16(sp)
 136:	e426                	sd	s1,8(sp)
 138:	1000                	addi	s0,sp,32
 13a:	84aa                	mv	s1,a0
    if (!holding(lk))
 13c:	00000097          	auipc	ra,0x0
 140:	f40080e7          	jalr	-192(ra) # 7c <holding>
 144:	c11d                	beqz	a0,16a <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 146:	57fd                	li	a5,-1
 148:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 14c:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 150:	0ff0000f          	fence
 154:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 158:	00000097          	auipc	ra,0x0
 15c:	1fa080e7          	jalr	506(ra) # 352 <tyield>
}
 160:	60e2                	ld	ra,24(sp)
 162:	6442                	ld	s0,16(sp)
 164:	64a2                	ld	s1,8(sp)
 166:	6105                	addi	sp,sp,32
 168:	8082                	ret
        printf("releasing lock we are not holding");
 16a:	00001517          	auipc	a0,0x1
 16e:	ae650513          	addi	a0,a0,-1306 # c50 <malloc+0x12a>
 172:	00001097          	auipc	ra,0x1
 176:	8fc080e7          	jalr	-1796(ra) # a6e <printf>
        exit(-1);
 17a:	557d                	li	a0,-1
 17c:	00000097          	auipc	ra,0x0
 180:	572080e7          	jalr	1394(ra) # 6ee <exit>

0000000000000184 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 184:	1141                	addi	sp,sp,-16
 186:	e406                	sd	ra,8(sp)
 188:	e022                	sd	s0,0(sp)
 18a:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 18c:	09800513          	li	a0,152
 190:	00001097          	auipc	ra,0x1
 194:	996080e7          	jalr	-1642(ra) # b26 <malloc>

    main_thread->tid = next_tid;
 198:	00001797          	auipc	a5,0x1
 19c:	e6878793          	addi	a5,a5,-408 # 1000 <next_tid>
 1a0:	4398                	lw	a4,0(a5)
 1a2:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 1a6:	4398                	lw	a4,0(a5)
 1a8:	2705                	addiw	a4,a4,1
 1aa:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 1ac:	4791                	li	a5,4
 1ae:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 1b0:	00001797          	auipc	a5,0x1
 1b4:	e6a7b023          	sd	a0,-416(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 1b8:	00001797          	auipc	a5,0x1
 1bc:	e6878793          	addi	a5,a5,-408 # 1020 <threads>
 1c0:	00001717          	auipc	a4,0x1
 1c4:	ee070713          	addi	a4,a4,-288 # 10a0 <base>
        threads[i] = NULL;
 1c8:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 1cc:	07a1                	addi	a5,a5,8
 1ce:	fee79de3          	bne	a5,a4,1c8 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 1d2:	00001797          	auipc	a5,0x1
 1d6:	e4a7b723          	sd	a0,-434(a5) # 1020 <threads>
}
 1da:	60a2                	ld	ra,8(sp)
 1dc:	6402                	ld	s0,0(sp)
 1de:	0141                	addi	sp,sp,16
 1e0:	8082                	ret

00000000000001e2 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1e2:	00001517          	auipc	a0,0x1
 1e6:	e2e53503          	ld	a0,-466(a0) # 1010 <current_thread>
 1ea:	00001717          	auipc	a4,0x1
 1ee:	e3670713          	addi	a4,a4,-458 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1f2:	4781                	li	a5,0
 1f4:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1f6:	6314                	ld	a3,0(a4)
 1f8:	00a68763          	beq	a3,a0,206 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1fc:	2785                	addiw	a5,a5,1
 1fe:	0721                	addi	a4,a4,8
 200:	fec79be3          	bne	a5,a2,1f6 <tsched+0x14>
    int current_index = 0;
 204:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 206:	0017869b          	addiw	a3,a5,1
 20a:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 20e:	00001817          	auipc	a6,0x1
 212:	e1280813          	addi	a6,a6,-494 # 1020 <threads>
 216:	488d                	li	a7,3
 218:	a021                	j	220 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 21a:	2685                	addiw	a3,a3,1
 21c:	04c68363          	beq	a3,a2,262 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 220:	41f6d71b          	sraiw	a4,a3,0x1f
 224:	01c7571b          	srliw	a4,a4,0x1c
 228:	00d707bb          	addw	a5,a4,a3
 22c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 22e:	9f99                	subw	a5,a5,a4
 230:	078e                	slli	a5,a5,0x3
 232:	97c2                	add	a5,a5,a6
 234:	638c                	ld	a1,0(a5)
 236:	d1f5                	beqz	a1,21a <tsched+0x38>
 238:	5dbc                	lw	a5,120(a1)
 23a:	ff1790e3          	bne	a5,a7,21a <tsched+0x38>
{
 23e:	1141                	addi	sp,sp,-16
 240:	e406                	sd	ra,8(sp)
 242:	e022                	sd	s0,0(sp)
 244:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 246:	00001797          	auipc	a5,0x1
 24a:	dcb7b523          	sd	a1,-566(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 24e:	05a1                	addi	a1,a1,8
 250:	0521                	addi	a0,a0,8
 252:	00000097          	auipc	ra,0x0
 256:	19a080e7          	jalr	410(ra) # 3ec <tswtch>
        //printf("Thread switch complete\n");
    }
}
 25a:	60a2                	ld	ra,8(sp)
 25c:	6402                	ld	s0,0(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret
 262:	8082                	ret

0000000000000264 <thread_wrapper>:
{
 264:	1101                	addi	sp,sp,-32
 266:	ec06                	sd	ra,24(sp)
 268:	e822                	sd	s0,16(sp)
 26a:	e426                	sd	s1,8(sp)
 26c:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 26e:	00001497          	auipc	s1,0x1
 272:	da248493          	addi	s1,s1,-606 # 1010 <current_thread>
 276:	609c                	ld	a5,0(s1)
 278:	6b9c                	ld	a5,16(a5)
    func(arg);
 27a:	6398                	ld	a4,0(a5)
 27c:	6788                	ld	a0,8(a5)
 27e:	9702                	jalr	a4
    current_thread->state = EXITED;
 280:	609c                	ld	a5,0(s1)
 282:	4719                	li	a4,6
 284:	dfb8                	sw	a4,120(a5)
    tsched();
 286:	00000097          	auipc	ra,0x0
 28a:	f5c080e7          	jalr	-164(ra) # 1e2 <tsched>
}
 28e:	60e2                	ld	ra,24(sp)
 290:	6442                	ld	s0,16(sp)
 292:	64a2                	ld	s1,8(sp)
 294:	6105                	addi	sp,sp,32
 296:	8082                	ret

0000000000000298 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 298:	7179                	addi	sp,sp,-48
 29a:	f406                	sd	ra,40(sp)
 29c:	f022                	sd	s0,32(sp)
 29e:	ec26                	sd	s1,24(sp)
 2a0:	e84a                	sd	s2,16(sp)
 2a2:	e44e                	sd	s3,8(sp)
 2a4:	1800                	addi	s0,sp,48
 2a6:	84aa                	mv	s1,a0
 2a8:	8932                	mv	s2,a2
 2aa:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2ac:	09800513          	li	a0,152
 2b0:	00001097          	auipc	ra,0x1
 2b4:	876080e7          	jalr	-1930(ra) # b26 <malloc>
 2b8:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2ba:	478d                	li	a5,3
 2bc:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2be:	609c                	ld	a5,0(s1)
 2c0:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 2c4:	609c                	ld	a5,0(s1)
 2c6:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 2ca:	6098                	ld	a4,0(s1)
 2cc:	00001797          	auipc	a5,0x1
 2d0:	d3478793          	addi	a5,a5,-716 # 1000 <next_tid>
 2d4:	4394                	lw	a3,0(a5)
 2d6:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2da:	4398                	lw	a4,0(a5)
 2dc:	2705                	addiw	a4,a4,1
 2de:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 2e0:	6505                	lui	a0,0x1
 2e2:	00001097          	auipc	ra,0x1
 2e6:	844080e7          	jalr	-1980(ra) # b26 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 2ea:	6785                	lui	a5,0x1
 2ec:	00a78733          	add	a4,a5,a0
 2f0:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 2f4:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x318>
 2f6:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 2f8:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 2fc:	609c                	ld	a5,0(s1)
 2fe:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 300:	609c                	ld	a5,0(s1)
 302:	00000717          	auipc	a4,0x0
 306:	f6270713          	addi	a4,a4,-158 # 264 <thread_wrapper>
 30a:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 30c:	00001717          	auipc	a4,0x1
 310:	d1470713          	addi	a4,a4,-748 # 1020 <threads>
 314:	4781                	li	a5,0
 316:	4641                	li	a2,16
        if (threads[i] == NULL) {
 318:	6314                	ld	a3,0(a4)
 31a:	c29d                	beqz	a3,340 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 31c:	2785                	addiw	a5,a5,1
 31e:	0721                	addi	a4,a4,8
 320:	fec79ce3          	bne	a5,a2,318 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 324:	6088                	ld	a0,0(s1)
 326:	00000097          	auipc	ra,0x0
 32a:	77e080e7          	jalr	1918(ra) # aa4 <free>
        *thread = NULL;
 32e:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 332:	70a2                	ld	ra,40(sp)
 334:	7402                	ld	s0,32(sp)
 336:	64e2                	ld	s1,24(sp)
 338:	6942                	ld	s2,16(sp)
 33a:	69a2                	ld	s3,8(sp)
 33c:	6145                	addi	sp,sp,48
 33e:	8082                	ret
            threads[i] = *thread;
 340:	6094                	ld	a3,0(s1)
 342:	078e                	slli	a5,a5,0x3
 344:	00001717          	auipc	a4,0x1
 348:	cdc70713          	addi	a4,a4,-804 # 1020 <threads>
 34c:	97ba                	add	a5,a5,a4
 34e:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 350:	b7cd                	j	332 <tcreate+0x9a>

0000000000000352 <tyield>:
    return 0;
}


void tyield()
{
 352:	1141                	addi	sp,sp,-16
 354:	e406                	sd	ra,8(sp)
 356:	e022                	sd	s0,0(sp)
 358:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 35a:	00001797          	auipc	a5,0x1
 35e:	cb67b783          	ld	a5,-842(a5) # 1010 <current_thread>
 362:	470d                	li	a4,3
 364:	dfb8                	sw	a4,120(a5)
    tsched();
 366:	00000097          	auipc	ra,0x0
 36a:	e7c080e7          	jalr	-388(ra) # 1e2 <tsched>
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <tjoin>:
{
 376:	1101                	addi	sp,sp,-32
 378:	ec06                	sd	ra,24(sp)
 37a:	e822                	sd	s0,16(sp)
 37c:	e426                	sd	s1,8(sp)
 37e:	e04a                	sd	s2,0(sp)
 380:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 382:	00001797          	auipc	a5,0x1
 386:	c9e78793          	addi	a5,a5,-866 # 1020 <threads>
 38a:	00001697          	auipc	a3,0x1
 38e:	d1668693          	addi	a3,a3,-746 # 10a0 <base>
 392:	a021                	j	39a <tjoin+0x24>
 394:	07a1                	addi	a5,a5,8
 396:	02d78b63          	beq	a5,a3,3cc <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 39a:	6384                	ld	s1,0(a5)
 39c:	dce5                	beqz	s1,394 <tjoin+0x1e>
 39e:	0004c703          	lbu	a4,0(s1)
 3a2:	fea719e3          	bne	a4,a0,394 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3a6:	5cb8                	lw	a4,120(s1)
 3a8:	4799                	li	a5,6
 3aa:	4919                	li	s2,6
 3ac:	02f70263          	beq	a4,a5,3d0 <tjoin+0x5a>
        tyield();
 3b0:	00000097          	auipc	ra,0x0
 3b4:	fa2080e7          	jalr	-94(ra) # 352 <tyield>
    while (target_thread->state != EXITED) {
 3b8:	5cbc                	lw	a5,120(s1)
 3ba:	ff279be3          	bne	a5,s2,3b0 <tjoin+0x3a>
    return 0;
 3be:	4501                	li	a0,0
}
 3c0:	60e2                	ld	ra,24(sp)
 3c2:	6442                	ld	s0,16(sp)
 3c4:	64a2                	ld	s1,8(sp)
 3c6:	6902                	ld	s2,0(sp)
 3c8:	6105                	addi	sp,sp,32
 3ca:	8082                	ret
        return -1;
 3cc:	557d                	li	a0,-1
 3ce:	bfcd                	j	3c0 <tjoin+0x4a>
    return 0;
 3d0:	4501                	li	a0,0
 3d2:	b7fd                	j	3c0 <tjoin+0x4a>

00000000000003d4 <twhoami>:

uint8 twhoami()
{
 3d4:	1141                	addi	sp,sp,-16
 3d6:	e422                	sd	s0,8(sp)
 3d8:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3da:	00001797          	auipc	a5,0x1
 3de:	c367b783          	ld	a5,-970(a5) # 1010 <current_thread>
 3e2:	0007c503          	lbu	a0,0(a5)
 3e6:	6422                	ld	s0,8(sp)
 3e8:	0141                	addi	sp,sp,16
 3ea:	8082                	ret

00000000000003ec <tswtch>:
 3ec:	00153023          	sd	ra,0(a0)
 3f0:	00253423          	sd	sp,8(a0)
 3f4:	e900                	sd	s0,16(a0)
 3f6:	ed04                	sd	s1,24(a0)
 3f8:	03253023          	sd	s2,32(a0)
 3fc:	03353423          	sd	s3,40(a0)
 400:	03453823          	sd	s4,48(a0)
 404:	03553c23          	sd	s5,56(a0)
 408:	05653023          	sd	s6,64(a0)
 40c:	05753423          	sd	s7,72(a0)
 410:	05853823          	sd	s8,80(a0)
 414:	05953c23          	sd	s9,88(a0)
 418:	07a53023          	sd	s10,96(a0)
 41c:	07b53423          	sd	s11,104(a0)
 420:	0005b083          	ld	ra,0(a1)
 424:	0085b103          	ld	sp,8(a1)
 428:	6980                	ld	s0,16(a1)
 42a:	6d84                	ld	s1,24(a1)
 42c:	0205b903          	ld	s2,32(a1)
 430:	0285b983          	ld	s3,40(a1)
 434:	0305ba03          	ld	s4,48(a1)
 438:	0385ba83          	ld	s5,56(a1)
 43c:	0405bb03          	ld	s6,64(a1)
 440:	0485bb83          	ld	s7,72(a1)
 444:	0505bc03          	ld	s8,80(a1)
 448:	0585bc83          	ld	s9,88(a1)
 44c:	0605bd03          	ld	s10,96(a1)
 450:	0685bd83          	ld	s11,104(a1)
 454:	8082                	ret

0000000000000456 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 456:	1101                	addi	sp,sp,-32
 458:	ec06                	sd	ra,24(sp)
 45a:	e822                	sd	s0,16(sp)
 45c:	e426                	sd	s1,8(sp)
 45e:	e04a                	sd	s2,0(sp)
 460:	1000                	addi	s0,sp,32
 462:	84aa                	mv	s1,a0
 464:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 466:	00000097          	auipc	ra,0x0
 46a:	d1e080e7          	jalr	-738(ra) # 184 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 46e:	85ca                	mv	a1,s2
 470:	8526                	mv	a0,s1
 472:	00000097          	auipc	ra,0x0
 476:	b8e080e7          	jalr	-1138(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 47a:	00000097          	auipc	ra,0x0
 47e:	274080e7          	jalr	628(ra) # 6ee <exit>

0000000000000482 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 482:	1141                	addi	sp,sp,-16
 484:	e422                	sd	s0,8(sp)
 486:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 488:	87aa                	mv	a5,a0
 48a:	0585                	addi	a1,a1,1
 48c:	0785                	addi	a5,a5,1
 48e:	fff5c703          	lbu	a4,-1(a1)
 492:	fee78fa3          	sb	a4,-1(a5)
 496:	fb75                	bnez	a4,48a <strcpy+0x8>
        ;
    return os;
}
 498:	6422                	ld	s0,8(sp)
 49a:	0141                	addi	sp,sp,16
 49c:	8082                	ret

000000000000049e <strcmp>:

int strcmp(const char *p, const char *q)
{
 49e:	1141                	addi	sp,sp,-16
 4a0:	e422                	sd	s0,8(sp)
 4a2:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4a4:	00054783          	lbu	a5,0(a0)
 4a8:	cb91                	beqz	a5,4bc <strcmp+0x1e>
 4aa:	0005c703          	lbu	a4,0(a1)
 4ae:	00f71763          	bne	a4,a5,4bc <strcmp+0x1e>
        p++, q++;
 4b2:	0505                	addi	a0,a0,1
 4b4:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	fbe5                	bnez	a5,4aa <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4bc:	0005c503          	lbu	a0,0(a1)
}
 4c0:	40a7853b          	subw	a0,a5,a0
 4c4:	6422                	ld	s0,8(sp)
 4c6:	0141                	addi	sp,sp,16
 4c8:	8082                	ret

00000000000004ca <strlen>:

uint strlen(const char *s)
{
 4ca:	1141                	addi	sp,sp,-16
 4cc:	e422                	sd	s0,8(sp)
 4ce:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4d0:	00054783          	lbu	a5,0(a0)
 4d4:	cf91                	beqz	a5,4f0 <strlen+0x26>
 4d6:	0505                	addi	a0,a0,1
 4d8:	87aa                	mv	a5,a0
 4da:	86be                	mv	a3,a5
 4dc:	0785                	addi	a5,a5,1
 4de:	fff7c703          	lbu	a4,-1(a5)
 4e2:	ff65                	bnez	a4,4da <strlen+0x10>
 4e4:	40a6853b          	subw	a0,a3,a0
 4e8:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4ea:	6422                	ld	s0,8(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret
    for (n = 0; s[n]; n++)
 4f0:	4501                	li	a0,0
 4f2:	bfe5                	j	4ea <strlen+0x20>

00000000000004f4 <memset>:

void *
memset(void *dst, int c, uint n)
{
 4f4:	1141                	addi	sp,sp,-16
 4f6:	e422                	sd	s0,8(sp)
 4f8:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4fa:	ca19                	beqz	a2,510 <memset+0x1c>
 4fc:	87aa                	mv	a5,a0
 4fe:	1602                	slli	a2,a2,0x20
 500:	9201                	srli	a2,a2,0x20
 502:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 506:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 50a:	0785                	addi	a5,a5,1
 50c:	fee79de3          	bne	a5,a4,506 <memset+0x12>
    }
    return dst;
}
 510:	6422                	ld	s0,8(sp)
 512:	0141                	addi	sp,sp,16
 514:	8082                	ret

0000000000000516 <strchr>:

char *
strchr(const char *s, char c)
{
 516:	1141                	addi	sp,sp,-16
 518:	e422                	sd	s0,8(sp)
 51a:	0800                	addi	s0,sp,16
    for (; *s; s++)
 51c:	00054783          	lbu	a5,0(a0)
 520:	cb99                	beqz	a5,536 <strchr+0x20>
        if (*s == c)
 522:	00f58763          	beq	a1,a5,530 <strchr+0x1a>
    for (; *s; s++)
 526:	0505                	addi	a0,a0,1
 528:	00054783          	lbu	a5,0(a0)
 52c:	fbfd                	bnez	a5,522 <strchr+0xc>
            return (char *)s;
    return 0;
 52e:	4501                	li	a0,0
}
 530:	6422                	ld	s0,8(sp)
 532:	0141                	addi	sp,sp,16
 534:	8082                	ret
    return 0;
 536:	4501                	li	a0,0
 538:	bfe5                	j	530 <strchr+0x1a>

000000000000053a <gets>:

char *
gets(char *buf, int max)
{
 53a:	711d                	addi	sp,sp,-96
 53c:	ec86                	sd	ra,88(sp)
 53e:	e8a2                	sd	s0,80(sp)
 540:	e4a6                	sd	s1,72(sp)
 542:	e0ca                	sd	s2,64(sp)
 544:	fc4e                	sd	s3,56(sp)
 546:	f852                	sd	s4,48(sp)
 548:	f456                	sd	s5,40(sp)
 54a:	f05a                	sd	s6,32(sp)
 54c:	ec5e                	sd	s7,24(sp)
 54e:	1080                	addi	s0,sp,96
 550:	8baa                	mv	s7,a0
 552:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 554:	892a                	mv	s2,a0
 556:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 558:	4aa9                	li	s5,10
 55a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 55c:	89a6                	mv	s3,s1
 55e:	2485                	addiw	s1,s1,1
 560:	0344d863          	bge	s1,s4,590 <gets+0x56>
        cc = read(0, &c, 1);
 564:	4605                	li	a2,1
 566:	faf40593          	addi	a1,s0,-81
 56a:	4501                	li	a0,0
 56c:	00000097          	auipc	ra,0x0
 570:	19a080e7          	jalr	410(ra) # 706 <read>
        if (cc < 1)
 574:	00a05e63          	blez	a0,590 <gets+0x56>
        buf[i++] = c;
 578:	faf44783          	lbu	a5,-81(s0)
 57c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 580:	01578763          	beq	a5,s5,58e <gets+0x54>
 584:	0905                	addi	s2,s2,1
 586:	fd679be3          	bne	a5,s6,55c <gets+0x22>
    for (i = 0; i + 1 < max;)
 58a:	89a6                	mv	s3,s1
 58c:	a011                	j	590 <gets+0x56>
 58e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 590:	99de                	add	s3,s3,s7
 592:	00098023          	sb	zero,0(s3)
    return buf;
}
 596:	855e                	mv	a0,s7
 598:	60e6                	ld	ra,88(sp)
 59a:	6446                	ld	s0,80(sp)
 59c:	64a6                	ld	s1,72(sp)
 59e:	6906                	ld	s2,64(sp)
 5a0:	79e2                	ld	s3,56(sp)
 5a2:	7a42                	ld	s4,48(sp)
 5a4:	7aa2                	ld	s5,40(sp)
 5a6:	7b02                	ld	s6,32(sp)
 5a8:	6be2                	ld	s7,24(sp)
 5aa:	6125                	addi	sp,sp,96
 5ac:	8082                	ret

00000000000005ae <stat>:

int stat(const char *n, struct stat *st)
{
 5ae:	1101                	addi	sp,sp,-32
 5b0:	ec06                	sd	ra,24(sp)
 5b2:	e822                	sd	s0,16(sp)
 5b4:	e426                	sd	s1,8(sp)
 5b6:	e04a                	sd	s2,0(sp)
 5b8:	1000                	addi	s0,sp,32
 5ba:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5bc:	4581                	li	a1,0
 5be:	00000097          	auipc	ra,0x0
 5c2:	170080e7          	jalr	368(ra) # 72e <open>
    if (fd < 0)
 5c6:	02054563          	bltz	a0,5f0 <stat+0x42>
 5ca:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5cc:	85ca                	mv	a1,s2
 5ce:	00000097          	auipc	ra,0x0
 5d2:	178080e7          	jalr	376(ra) # 746 <fstat>
 5d6:	892a                	mv	s2,a0
    close(fd);
 5d8:	8526                	mv	a0,s1
 5da:	00000097          	auipc	ra,0x0
 5de:	13c080e7          	jalr	316(ra) # 716 <close>
    return r;
}
 5e2:	854a                	mv	a0,s2
 5e4:	60e2                	ld	ra,24(sp)
 5e6:	6442                	ld	s0,16(sp)
 5e8:	64a2                	ld	s1,8(sp)
 5ea:	6902                	ld	s2,0(sp)
 5ec:	6105                	addi	sp,sp,32
 5ee:	8082                	ret
        return -1;
 5f0:	597d                	li	s2,-1
 5f2:	bfc5                	j	5e2 <stat+0x34>

00000000000005f4 <atoi>:

int atoi(const char *s)
{
 5f4:	1141                	addi	sp,sp,-16
 5f6:	e422                	sd	s0,8(sp)
 5f8:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5fa:	00054683          	lbu	a3,0(a0)
 5fe:	fd06879b          	addiw	a5,a3,-48
 602:	0ff7f793          	zext.b	a5,a5
 606:	4625                	li	a2,9
 608:	02f66863          	bltu	a2,a5,638 <atoi+0x44>
 60c:	872a                	mv	a4,a0
    n = 0;
 60e:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 610:	0705                	addi	a4,a4,1
 612:	0025179b          	slliw	a5,a0,0x2
 616:	9fa9                	addw	a5,a5,a0
 618:	0017979b          	slliw	a5,a5,0x1
 61c:	9fb5                	addw	a5,a5,a3
 61e:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 622:	00074683          	lbu	a3,0(a4)
 626:	fd06879b          	addiw	a5,a3,-48
 62a:	0ff7f793          	zext.b	a5,a5
 62e:	fef671e3          	bgeu	a2,a5,610 <atoi+0x1c>
    return n;
}
 632:	6422                	ld	s0,8(sp)
 634:	0141                	addi	sp,sp,16
 636:	8082                	ret
    n = 0;
 638:	4501                	li	a0,0
 63a:	bfe5                	j	632 <atoi+0x3e>

000000000000063c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 63c:	1141                	addi	sp,sp,-16
 63e:	e422                	sd	s0,8(sp)
 640:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 642:	02b57463          	bgeu	a0,a1,66a <memmove+0x2e>
    {
        while (n-- > 0)
 646:	00c05f63          	blez	a2,664 <memmove+0x28>
 64a:	1602                	slli	a2,a2,0x20
 64c:	9201                	srli	a2,a2,0x20
 64e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 652:	872a                	mv	a4,a0
            *dst++ = *src++;
 654:	0585                	addi	a1,a1,1
 656:	0705                	addi	a4,a4,1
 658:	fff5c683          	lbu	a3,-1(a1)
 65c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 660:	fee79ae3          	bne	a5,a4,654 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 664:	6422                	ld	s0,8(sp)
 666:	0141                	addi	sp,sp,16
 668:	8082                	ret
        dst += n;
 66a:	00c50733          	add	a4,a0,a2
        src += n;
 66e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 670:	fec05ae3          	blez	a2,664 <memmove+0x28>
 674:	fff6079b          	addiw	a5,a2,-1
 678:	1782                	slli	a5,a5,0x20
 67a:	9381                	srli	a5,a5,0x20
 67c:	fff7c793          	not	a5,a5
 680:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 682:	15fd                	addi	a1,a1,-1
 684:	177d                	addi	a4,a4,-1
 686:	0005c683          	lbu	a3,0(a1)
 68a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 68e:	fee79ae3          	bne	a5,a4,682 <memmove+0x46>
 692:	bfc9                	j	664 <memmove+0x28>

0000000000000694 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 694:	1141                	addi	sp,sp,-16
 696:	e422                	sd	s0,8(sp)
 698:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 69a:	ca05                	beqz	a2,6ca <memcmp+0x36>
 69c:	fff6069b          	addiw	a3,a2,-1
 6a0:	1682                	slli	a3,a3,0x20
 6a2:	9281                	srli	a3,a3,0x20
 6a4:	0685                	addi	a3,a3,1
 6a6:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6a8:	00054783          	lbu	a5,0(a0)
 6ac:	0005c703          	lbu	a4,0(a1)
 6b0:	00e79863          	bne	a5,a4,6c0 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6b4:	0505                	addi	a0,a0,1
        p2++;
 6b6:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6b8:	fed518e3          	bne	a0,a3,6a8 <memcmp+0x14>
    }
    return 0;
 6bc:	4501                	li	a0,0
 6be:	a019                	j	6c4 <memcmp+0x30>
            return *p1 - *p2;
 6c0:	40e7853b          	subw	a0,a5,a4
}
 6c4:	6422                	ld	s0,8(sp)
 6c6:	0141                	addi	sp,sp,16
 6c8:	8082                	ret
    return 0;
 6ca:	4501                	li	a0,0
 6cc:	bfe5                	j	6c4 <memcmp+0x30>

00000000000006ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6ce:	1141                	addi	sp,sp,-16
 6d0:	e406                	sd	ra,8(sp)
 6d2:	e022                	sd	s0,0(sp)
 6d4:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6d6:	00000097          	auipc	ra,0x0
 6da:	f66080e7          	jalr	-154(ra) # 63c <memmove>
}
 6de:	60a2                	ld	ra,8(sp)
 6e0:	6402                	ld	s0,0(sp)
 6e2:	0141                	addi	sp,sp,16
 6e4:	8082                	ret

00000000000006e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6e6:	4885                	li	a7,1
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <exit>:
.global exit
exit:
 li a7, SYS_exit
 6ee:	4889                	li	a7,2
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6f6:	488d                	li	a7,3
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6fe:	4891                	li	a7,4
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <read>:
.global read
read:
 li a7, SYS_read
 706:	4895                	li	a7,5
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <write>:
.global write
write:
 li a7, SYS_write
 70e:	48c1                	li	a7,16
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <close>:
.global close
close:
 li a7, SYS_close
 716:	48d5                	li	a7,21
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <kill>:
.global kill
kill:
 li a7, SYS_kill
 71e:	4899                	li	a7,6
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <exec>:
.global exec
exec:
 li a7, SYS_exec
 726:	489d                	li	a7,7
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <open>:
.global open
open:
 li a7, SYS_open
 72e:	48bd                	li	a7,15
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 736:	48c5                	li	a7,17
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 73e:	48c9                	li	a7,18
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 746:	48a1                	li	a7,8
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <link>:
.global link
link:
 li a7, SYS_link
 74e:	48cd                	li	a7,19
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 756:	48d1                	li	a7,20
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 75e:	48a5                	li	a7,9
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <dup>:
.global dup
dup:
 li a7, SYS_dup
 766:	48a9                	li	a7,10
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 76e:	48ad                	li	a7,11
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 776:	48b1                	li	a7,12
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 77e:	48b5                	li	a7,13
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 786:	48b9                	li	a7,14
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <ps>:
.global ps
ps:
 li a7, SYS_ps
 78e:	48d9                	li	a7,22
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 796:	48dd                	li	a7,23
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 79e:	48e1                	li	a7,24
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7a6:	1101                	addi	sp,sp,-32
 7a8:	ec06                	sd	ra,24(sp)
 7aa:	e822                	sd	s0,16(sp)
 7ac:	1000                	addi	s0,sp,32
 7ae:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7b2:	4605                	li	a2,1
 7b4:	fef40593          	addi	a1,s0,-17
 7b8:	00000097          	auipc	ra,0x0
 7bc:	f56080e7          	jalr	-170(ra) # 70e <write>
}
 7c0:	60e2                	ld	ra,24(sp)
 7c2:	6442                	ld	s0,16(sp)
 7c4:	6105                	addi	sp,sp,32
 7c6:	8082                	ret

00000000000007c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7c8:	7139                	addi	sp,sp,-64
 7ca:	fc06                	sd	ra,56(sp)
 7cc:	f822                	sd	s0,48(sp)
 7ce:	f426                	sd	s1,40(sp)
 7d0:	f04a                	sd	s2,32(sp)
 7d2:	ec4e                	sd	s3,24(sp)
 7d4:	0080                	addi	s0,sp,64
 7d6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7d8:	c299                	beqz	a3,7de <printint+0x16>
 7da:	0805c963          	bltz	a1,86c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7de:	2581                	sext.w	a1,a1
  neg = 0;
 7e0:	4881                	li	a7,0
 7e2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7e6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7e8:	2601                	sext.w	a2,a2
 7ea:	00000517          	auipc	a0,0x0
 7ee:	4ee50513          	addi	a0,a0,1262 # cd8 <digits>
 7f2:	883a                	mv	a6,a4
 7f4:	2705                	addiw	a4,a4,1
 7f6:	02c5f7bb          	remuw	a5,a1,a2
 7fa:	1782                	slli	a5,a5,0x20
 7fc:	9381                	srli	a5,a5,0x20
 7fe:	97aa                	add	a5,a5,a0
 800:	0007c783          	lbu	a5,0(a5)
 804:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 808:	0005879b          	sext.w	a5,a1
 80c:	02c5d5bb          	divuw	a1,a1,a2
 810:	0685                	addi	a3,a3,1
 812:	fec7f0e3          	bgeu	a5,a2,7f2 <printint+0x2a>
  if(neg)
 816:	00088c63          	beqz	a7,82e <printint+0x66>
    buf[i++] = '-';
 81a:	fd070793          	addi	a5,a4,-48
 81e:	00878733          	add	a4,a5,s0
 822:	02d00793          	li	a5,45
 826:	fef70823          	sb	a5,-16(a4)
 82a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 82e:	02e05863          	blez	a4,85e <printint+0x96>
 832:	fc040793          	addi	a5,s0,-64
 836:	00e78933          	add	s2,a5,a4
 83a:	fff78993          	addi	s3,a5,-1
 83e:	99ba                	add	s3,s3,a4
 840:	377d                	addiw	a4,a4,-1
 842:	1702                	slli	a4,a4,0x20
 844:	9301                	srli	a4,a4,0x20
 846:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 84a:	fff94583          	lbu	a1,-1(s2)
 84e:	8526                	mv	a0,s1
 850:	00000097          	auipc	ra,0x0
 854:	f56080e7          	jalr	-170(ra) # 7a6 <putc>
  while(--i >= 0)
 858:	197d                	addi	s2,s2,-1
 85a:	ff3918e3          	bne	s2,s3,84a <printint+0x82>
}
 85e:	70e2                	ld	ra,56(sp)
 860:	7442                	ld	s0,48(sp)
 862:	74a2                	ld	s1,40(sp)
 864:	7902                	ld	s2,32(sp)
 866:	69e2                	ld	s3,24(sp)
 868:	6121                	addi	sp,sp,64
 86a:	8082                	ret
    x = -xx;
 86c:	40b005bb          	negw	a1,a1
    neg = 1;
 870:	4885                	li	a7,1
    x = -xx;
 872:	bf85                	j	7e2 <printint+0x1a>

0000000000000874 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 874:	715d                	addi	sp,sp,-80
 876:	e486                	sd	ra,72(sp)
 878:	e0a2                	sd	s0,64(sp)
 87a:	fc26                	sd	s1,56(sp)
 87c:	f84a                	sd	s2,48(sp)
 87e:	f44e                	sd	s3,40(sp)
 880:	f052                	sd	s4,32(sp)
 882:	ec56                	sd	s5,24(sp)
 884:	e85a                	sd	s6,16(sp)
 886:	e45e                	sd	s7,8(sp)
 888:	e062                	sd	s8,0(sp)
 88a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 88c:	0005c903          	lbu	s2,0(a1)
 890:	18090c63          	beqz	s2,a28 <vprintf+0x1b4>
 894:	8aaa                	mv	s5,a0
 896:	8bb2                	mv	s7,a2
 898:	00158493          	addi	s1,a1,1
  state = 0;
 89c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 89e:	02500a13          	li	s4,37
 8a2:	4b55                	li	s6,21
 8a4:	a839                	j	8c2 <vprintf+0x4e>
        putc(fd, c);
 8a6:	85ca                	mv	a1,s2
 8a8:	8556                	mv	a0,s5
 8aa:	00000097          	auipc	ra,0x0
 8ae:	efc080e7          	jalr	-260(ra) # 7a6 <putc>
 8b2:	a019                	j	8b8 <vprintf+0x44>
    } else if(state == '%'){
 8b4:	01498d63          	beq	s3,s4,8ce <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8b8:	0485                	addi	s1,s1,1
 8ba:	fff4c903          	lbu	s2,-1(s1)
 8be:	16090563          	beqz	s2,a28 <vprintf+0x1b4>
    if(state == 0){
 8c2:	fe0999e3          	bnez	s3,8b4 <vprintf+0x40>
      if(c == '%'){
 8c6:	ff4910e3          	bne	s2,s4,8a6 <vprintf+0x32>
        state = '%';
 8ca:	89d2                	mv	s3,s4
 8cc:	b7f5                	j	8b8 <vprintf+0x44>
      if(c == 'd'){
 8ce:	13490263          	beq	s2,s4,9f2 <vprintf+0x17e>
 8d2:	f9d9079b          	addiw	a5,s2,-99
 8d6:	0ff7f793          	zext.b	a5,a5
 8da:	12fb6563          	bltu	s6,a5,a04 <vprintf+0x190>
 8de:	f9d9079b          	addiw	a5,s2,-99
 8e2:	0ff7f713          	zext.b	a4,a5
 8e6:	10eb6f63          	bltu	s6,a4,a04 <vprintf+0x190>
 8ea:	00271793          	slli	a5,a4,0x2
 8ee:	00000717          	auipc	a4,0x0
 8f2:	39270713          	addi	a4,a4,914 # c80 <malloc+0x15a>
 8f6:	97ba                	add	a5,a5,a4
 8f8:	439c                	lw	a5,0(a5)
 8fa:	97ba                	add	a5,a5,a4
 8fc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8fe:	008b8913          	addi	s2,s7,8
 902:	4685                	li	a3,1
 904:	4629                	li	a2,10
 906:	000ba583          	lw	a1,0(s7)
 90a:	8556                	mv	a0,s5
 90c:	00000097          	auipc	ra,0x0
 910:	ebc080e7          	jalr	-324(ra) # 7c8 <printint>
 914:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 916:	4981                	li	s3,0
 918:	b745                	j	8b8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 91a:	008b8913          	addi	s2,s7,8
 91e:	4681                	li	a3,0
 920:	4629                	li	a2,10
 922:	000ba583          	lw	a1,0(s7)
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	ea0080e7          	jalr	-352(ra) # 7c8 <printint>
 930:	8bca                	mv	s7,s2
      state = 0;
 932:	4981                	li	s3,0
 934:	b751                	j	8b8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 936:	008b8913          	addi	s2,s7,8
 93a:	4681                	li	a3,0
 93c:	4641                	li	a2,16
 93e:	000ba583          	lw	a1,0(s7)
 942:	8556                	mv	a0,s5
 944:	00000097          	auipc	ra,0x0
 948:	e84080e7          	jalr	-380(ra) # 7c8 <printint>
 94c:	8bca                	mv	s7,s2
      state = 0;
 94e:	4981                	li	s3,0
 950:	b7a5                	j	8b8 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 952:	008b8c13          	addi	s8,s7,8
 956:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 95a:	03000593          	li	a1,48
 95e:	8556                	mv	a0,s5
 960:	00000097          	auipc	ra,0x0
 964:	e46080e7          	jalr	-442(ra) # 7a6 <putc>
  putc(fd, 'x');
 968:	07800593          	li	a1,120
 96c:	8556                	mv	a0,s5
 96e:	00000097          	auipc	ra,0x0
 972:	e38080e7          	jalr	-456(ra) # 7a6 <putc>
 976:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 978:	00000b97          	auipc	s7,0x0
 97c:	360b8b93          	addi	s7,s7,864 # cd8 <digits>
 980:	03c9d793          	srli	a5,s3,0x3c
 984:	97de                	add	a5,a5,s7
 986:	0007c583          	lbu	a1,0(a5)
 98a:	8556                	mv	a0,s5
 98c:	00000097          	auipc	ra,0x0
 990:	e1a080e7          	jalr	-486(ra) # 7a6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 994:	0992                	slli	s3,s3,0x4
 996:	397d                	addiw	s2,s2,-1
 998:	fe0914e3          	bnez	s2,980 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 99c:	8be2                	mv	s7,s8
      state = 0;
 99e:	4981                	li	s3,0
 9a0:	bf21                	j	8b8 <vprintf+0x44>
        s = va_arg(ap, char*);
 9a2:	008b8993          	addi	s3,s7,8
 9a6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9aa:	02090163          	beqz	s2,9cc <vprintf+0x158>
        while(*s != 0){
 9ae:	00094583          	lbu	a1,0(s2)
 9b2:	c9a5                	beqz	a1,a22 <vprintf+0x1ae>
          putc(fd, *s);
 9b4:	8556                	mv	a0,s5
 9b6:	00000097          	auipc	ra,0x0
 9ba:	df0080e7          	jalr	-528(ra) # 7a6 <putc>
          s++;
 9be:	0905                	addi	s2,s2,1
        while(*s != 0){
 9c0:	00094583          	lbu	a1,0(s2)
 9c4:	f9e5                	bnez	a1,9b4 <vprintf+0x140>
        s = va_arg(ap, char*);
 9c6:	8bce                	mv	s7,s3
      state = 0;
 9c8:	4981                	li	s3,0
 9ca:	b5fd                	j	8b8 <vprintf+0x44>
          s = "(null)";
 9cc:	00000917          	auipc	s2,0x0
 9d0:	2ac90913          	addi	s2,s2,684 # c78 <malloc+0x152>
        while(*s != 0){
 9d4:	02800593          	li	a1,40
 9d8:	bff1                	j	9b4 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9da:	008b8913          	addi	s2,s7,8
 9de:	000bc583          	lbu	a1,0(s7)
 9e2:	8556                	mv	a0,s5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	dc2080e7          	jalr	-574(ra) # 7a6 <putc>
 9ec:	8bca                	mv	s7,s2
      state = 0;
 9ee:	4981                	li	s3,0
 9f0:	b5e1                	j	8b8 <vprintf+0x44>
        putc(fd, c);
 9f2:	02500593          	li	a1,37
 9f6:	8556                	mv	a0,s5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	dae080e7          	jalr	-594(ra) # 7a6 <putc>
      state = 0;
 a00:	4981                	li	s3,0
 a02:	bd5d                	j	8b8 <vprintf+0x44>
        putc(fd, '%');
 a04:	02500593          	li	a1,37
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	d9c080e7          	jalr	-612(ra) # 7a6 <putc>
        putc(fd, c);
 a12:	85ca                	mv	a1,s2
 a14:	8556                	mv	a0,s5
 a16:	00000097          	auipc	ra,0x0
 a1a:	d90080e7          	jalr	-624(ra) # 7a6 <putc>
      state = 0;
 a1e:	4981                	li	s3,0
 a20:	bd61                	j	8b8 <vprintf+0x44>
        s = va_arg(ap, char*);
 a22:	8bce                	mv	s7,s3
      state = 0;
 a24:	4981                	li	s3,0
 a26:	bd49                	j	8b8 <vprintf+0x44>
    }
  }
}
 a28:	60a6                	ld	ra,72(sp)
 a2a:	6406                	ld	s0,64(sp)
 a2c:	74e2                	ld	s1,56(sp)
 a2e:	7942                	ld	s2,48(sp)
 a30:	79a2                	ld	s3,40(sp)
 a32:	7a02                	ld	s4,32(sp)
 a34:	6ae2                	ld	s5,24(sp)
 a36:	6b42                	ld	s6,16(sp)
 a38:	6ba2                	ld	s7,8(sp)
 a3a:	6c02                	ld	s8,0(sp)
 a3c:	6161                	addi	sp,sp,80
 a3e:	8082                	ret

0000000000000a40 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a40:	715d                	addi	sp,sp,-80
 a42:	ec06                	sd	ra,24(sp)
 a44:	e822                	sd	s0,16(sp)
 a46:	1000                	addi	s0,sp,32
 a48:	e010                	sd	a2,0(s0)
 a4a:	e414                	sd	a3,8(s0)
 a4c:	e818                	sd	a4,16(s0)
 a4e:	ec1c                	sd	a5,24(s0)
 a50:	03043023          	sd	a6,32(s0)
 a54:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a58:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a5c:	8622                	mv	a2,s0
 a5e:	00000097          	auipc	ra,0x0
 a62:	e16080e7          	jalr	-490(ra) # 874 <vprintf>
}
 a66:	60e2                	ld	ra,24(sp)
 a68:	6442                	ld	s0,16(sp)
 a6a:	6161                	addi	sp,sp,80
 a6c:	8082                	ret

0000000000000a6e <printf>:

void
printf(const char *fmt, ...)
{
 a6e:	711d                	addi	sp,sp,-96
 a70:	ec06                	sd	ra,24(sp)
 a72:	e822                	sd	s0,16(sp)
 a74:	1000                	addi	s0,sp,32
 a76:	e40c                	sd	a1,8(s0)
 a78:	e810                	sd	a2,16(s0)
 a7a:	ec14                	sd	a3,24(s0)
 a7c:	f018                	sd	a4,32(s0)
 a7e:	f41c                	sd	a5,40(s0)
 a80:	03043823          	sd	a6,48(s0)
 a84:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a88:	00840613          	addi	a2,s0,8
 a8c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a90:	85aa                	mv	a1,a0
 a92:	4505                	li	a0,1
 a94:	00000097          	auipc	ra,0x0
 a98:	de0080e7          	jalr	-544(ra) # 874 <vprintf>
}
 a9c:	60e2                	ld	ra,24(sp)
 a9e:	6442                	ld	s0,16(sp)
 aa0:	6125                	addi	sp,sp,96
 aa2:	8082                	ret

0000000000000aa4 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 aa4:	1141                	addi	sp,sp,-16
 aa6:	e422                	sd	s0,8(sp)
 aa8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 aaa:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aae:	00000797          	auipc	a5,0x0
 ab2:	56a7b783          	ld	a5,1386(a5) # 1018 <freep>
 ab6:	a02d                	j	ae0 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ab8:	4618                	lw	a4,8(a2)
 aba:	9f2d                	addw	a4,a4,a1
 abc:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 ac0:	6398                	ld	a4,0(a5)
 ac2:	6310                	ld	a2,0(a4)
 ac4:	a83d                	j	b02 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ac6:	ff852703          	lw	a4,-8(a0)
 aca:	9f31                	addw	a4,a4,a2
 acc:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ace:	ff053683          	ld	a3,-16(a0)
 ad2:	a091                	j	b16 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad4:	6398                	ld	a4,0(a5)
 ad6:	00e7e463          	bltu	a5,a4,ade <free+0x3a>
 ada:	00e6ea63          	bltu	a3,a4,aee <free+0x4a>
{
 ade:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae0:	fed7fae3          	bgeu	a5,a3,ad4 <free+0x30>
 ae4:	6398                	ld	a4,0(a5)
 ae6:	00e6e463          	bltu	a3,a4,aee <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aea:	fee7eae3          	bltu	a5,a4,ade <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 aee:	ff852583          	lw	a1,-8(a0)
 af2:	6390                	ld	a2,0(a5)
 af4:	02059813          	slli	a6,a1,0x20
 af8:	01c85713          	srli	a4,a6,0x1c
 afc:	9736                	add	a4,a4,a3
 afe:	fae60de3          	beq	a2,a4,ab8 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b02:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b06:	4790                	lw	a2,8(a5)
 b08:	02061593          	slli	a1,a2,0x20
 b0c:	01c5d713          	srli	a4,a1,0x1c
 b10:	973e                	add	a4,a4,a5
 b12:	fae68ae3          	beq	a3,a4,ac6 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b16:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b18:	00000717          	auipc	a4,0x0
 b1c:	50f73023          	sd	a5,1280(a4) # 1018 <freep>
}
 b20:	6422                	ld	s0,8(sp)
 b22:	0141                	addi	sp,sp,16
 b24:	8082                	ret

0000000000000b26 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b26:	7139                	addi	sp,sp,-64
 b28:	fc06                	sd	ra,56(sp)
 b2a:	f822                	sd	s0,48(sp)
 b2c:	f426                	sd	s1,40(sp)
 b2e:	f04a                	sd	s2,32(sp)
 b30:	ec4e                	sd	s3,24(sp)
 b32:	e852                	sd	s4,16(sp)
 b34:	e456                	sd	s5,8(sp)
 b36:	e05a                	sd	s6,0(sp)
 b38:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b3a:	02051493          	slli	s1,a0,0x20
 b3e:	9081                	srli	s1,s1,0x20
 b40:	04bd                	addi	s1,s1,15
 b42:	8091                	srli	s1,s1,0x4
 b44:	0014899b          	addiw	s3,s1,1
 b48:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b4a:	00000517          	auipc	a0,0x0
 b4e:	4ce53503          	ld	a0,1230(a0) # 1018 <freep>
 b52:	c515                	beqz	a0,b7e <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b54:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b56:	4798                	lw	a4,8(a5)
 b58:	02977f63          	bgeu	a4,s1,b96 <malloc+0x70>
    if (nu < 4096)
 b5c:	8a4e                	mv	s4,s3
 b5e:	0009871b          	sext.w	a4,s3
 b62:	6685                	lui	a3,0x1
 b64:	00d77363          	bgeu	a4,a3,b6a <malloc+0x44>
 b68:	6a05                	lui	s4,0x1
 b6a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b6e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b72:	00000917          	auipc	s2,0x0
 b76:	4a690913          	addi	s2,s2,1190 # 1018 <freep>
    if (p == (char *)-1)
 b7a:	5afd                	li	s5,-1
 b7c:	a895                	j	bf0 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b7e:	00000797          	auipc	a5,0x0
 b82:	52278793          	addi	a5,a5,1314 # 10a0 <base>
 b86:	00000717          	auipc	a4,0x0
 b8a:	48f73923          	sd	a5,1170(a4) # 1018 <freep>
 b8e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b90:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b94:	b7e1                	j	b5c <malloc+0x36>
            if (p->s.size == nunits)
 b96:	02e48c63          	beq	s1,a4,bce <malloc+0xa8>
                p->s.size -= nunits;
 b9a:	4137073b          	subw	a4,a4,s3
 b9e:	c798                	sw	a4,8(a5)
                p += p->s.size;
 ba0:	02071693          	slli	a3,a4,0x20
 ba4:	01c6d713          	srli	a4,a3,0x1c
 ba8:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 baa:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bae:	00000717          	auipc	a4,0x0
 bb2:	46a73523          	sd	a0,1130(a4) # 1018 <freep>
            return (void *)(p + 1);
 bb6:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bba:	70e2                	ld	ra,56(sp)
 bbc:	7442                	ld	s0,48(sp)
 bbe:	74a2                	ld	s1,40(sp)
 bc0:	7902                	ld	s2,32(sp)
 bc2:	69e2                	ld	s3,24(sp)
 bc4:	6a42                	ld	s4,16(sp)
 bc6:	6aa2                	ld	s5,8(sp)
 bc8:	6b02                	ld	s6,0(sp)
 bca:	6121                	addi	sp,sp,64
 bcc:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bce:	6398                	ld	a4,0(a5)
 bd0:	e118                	sd	a4,0(a0)
 bd2:	bff1                	j	bae <malloc+0x88>
    hp->s.size = nu;
 bd4:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bd8:	0541                	addi	a0,a0,16
 bda:	00000097          	auipc	ra,0x0
 bde:	eca080e7          	jalr	-310(ra) # aa4 <free>
    return freep;
 be2:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 be6:	d971                	beqz	a0,bba <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 be8:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bea:	4798                	lw	a4,8(a5)
 bec:	fa9775e3          	bgeu	a4,s1,b96 <malloc+0x70>
        if (p == freep)
 bf0:	00093703          	ld	a4,0(s2)
 bf4:	853e                	mv	a0,a5
 bf6:	fef719e3          	bne	a4,a5,be8 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bfa:	8552                	mv	a0,s4
 bfc:	00000097          	auipc	ra,0x0
 c00:	b7a080e7          	jalr	-1158(ra) # 776 <sbrk>
    if (p == (char *)-1)
 c04:	fd5518e3          	bne	a0,s5,bd4 <malloc+0xae>
                return 0;
 c08:	4501                	li	a0,0
 c0a:	bf45                	j	bba <malloc+0x94>
