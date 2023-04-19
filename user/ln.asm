
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	c0058593          	addi	a1,a1,-1024 # c10 <malloc+0xee>
  18:	4509                	li	a0,2
  1a:	00001097          	auipc	ra,0x1
  1e:	a22080e7          	jalr	-1502(ra) # a3c <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	6c6080e7          	jalr	1734(ra) # 6ea <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	718080e7          	jalr	1816(ra) # 74a <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	6aa080e7          	jalr	1706(ra) # 6ea <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	bdc58593          	addi	a1,a1,-1060 # c28 <malloc+0x106>
  54:	4509                	li	a0,2
  56:	00001097          	auipc	ra,0x1
  5a:	9e6080e7          	jalr	-1562(ra) # a3c <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
    lk->name = name;
  66:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  68:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  6c:	57fd                	li	a5,-1
  6e:	00f50823          	sb	a5,16(a0)
}
  72:	6422                	ld	s0,8(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  78:	00054783          	lbu	a5,0(a0)
  7c:	e399                	bnez	a5,82 <holding+0xa>
  7e:	4501                	li	a0,0
}
  80:	8082                	ret
{
  82:	1101                	addi	sp,sp,-32
  84:	ec06                	sd	ra,24(sp)
  86:	e822                	sd	s0,16(sp)
  88:	e426                	sd	s1,8(sp)
  8a:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  8c:	01054483          	lbu	s1,16(a0)
  90:	00000097          	auipc	ra,0x0
  94:	340080e7          	jalr	832(ra) # 3d0 <twhoami>
  98:	2501                	sext.w	a0,a0
  9a:	40a48533          	sub	a0,s1,a0
  9e:	00153513          	seqz	a0,a0
}
  a2:	60e2                	ld	ra,24(sp)
  a4:	6442                	ld	s0,16(sp)
  a6:	64a2                	ld	s1,8(sp)
  a8:	6105                	addi	sp,sp,32
  aa:	8082                	ret

00000000000000ac <acquire>:

void acquire(struct lock *lk)
{
  ac:	7179                	addi	sp,sp,-48
  ae:	f406                	sd	ra,40(sp)
  b0:	f022                	sd	s0,32(sp)
  b2:	ec26                	sd	s1,24(sp)
  b4:	e84a                	sd	s2,16(sp)
  b6:	e44e                	sd	s3,8(sp)
  b8:	e052                	sd	s4,0(sp)
  ba:	1800                	addi	s0,sp,48
  bc:	8a2a                	mv	s4,a0
    if (holding(lk))
  be:	00000097          	auipc	ra,0x0
  c2:	fba080e7          	jalr	-70(ra) # 78 <holding>
  c6:	e919                	bnez	a0,dc <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c8:	ffca7493          	andi	s1,s4,-4
  cc:	003a7913          	andi	s2,s4,3
  d0:	0039191b          	slliw	s2,s2,0x3
  d4:	4985                	li	s3,1
  d6:	012999bb          	sllw	s3,s3,s2
  da:	a015                	j	fe <acquire+0x52>
        printf("re-acquiring lock we already hold");
  dc:	00001517          	auipc	a0,0x1
  e0:	b6450513          	addi	a0,a0,-1180 # c40 <malloc+0x11e>
  e4:	00001097          	auipc	ra,0x1
  e8:	986080e7          	jalr	-1658(ra) # a6a <printf>
        exit(-1);
  ec:	557d                	li	a0,-1
  ee:	00000097          	auipc	ra,0x0
  f2:	5fc080e7          	jalr	1532(ra) # 6ea <exit>
    {
        // give up the cpu for other threads
        tyield();
  f6:	00000097          	auipc	ra,0x0
  fa:	258080e7          	jalr	600(ra) # 34e <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  fe:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 102:	0127d7bb          	srlw	a5,a5,s2
 106:	0ff7f793          	zext.b	a5,a5
 10a:	f7f5                	bnez	a5,f6 <acquire+0x4a>
    }

    __sync_synchronize();
 10c:	0ff0000f          	fence

    lk->tid = twhoami();
 110:	00000097          	auipc	ra,0x0
 114:	2c0080e7          	jalr	704(ra) # 3d0 <twhoami>
 118:	00aa0823          	sb	a0,16(s4)
}
 11c:	70a2                	ld	ra,40(sp)
 11e:	7402                	ld	s0,32(sp)
 120:	64e2                	ld	s1,24(sp)
 122:	6942                	ld	s2,16(sp)
 124:	69a2                	ld	s3,8(sp)
 126:	6a02                	ld	s4,0(sp)
 128:	6145                	addi	sp,sp,48
 12a:	8082                	ret

000000000000012c <release>:

void release(struct lock *lk)
{
 12c:	1101                	addi	sp,sp,-32
 12e:	ec06                	sd	ra,24(sp)
 130:	e822                	sd	s0,16(sp)
 132:	e426                	sd	s1,8(sp)
 134:	1000                	addi	s0,sp,32
 136:	84aa                	mv	s1,a0
    if (!holding(lk))
 138:	00000097          	auipc	ra,0x0
 13c:	f40080e7          	jalr	-192(ra) # 78 <holding>
 140:	c11d                	beqz	a0,166 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 142:	57fd                	li	a5,-1
 144:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 148:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 14c:	0ff0000f          	fence
 150:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 154:	00000097          	auipc	ra,0x0
 158:	1fa080e7          	jalr	506(ra) # 34e <tyield>
}
 15c:	60e2                	ld	ra,24(sp)
 15e:	6442                	ld	s0,16(sp)
 160:	64a2                	ld	s1,8(sp)
 162:	6105                	addi	sp,sp,32
 164:	8082                	ret
        printf("releasing lock we are not holding");
 166:	00001517          	auipc	a0,0x1
 16a:	b0250513          	addi	a0,a0,-1278 # c68 <malloc+0x146>
 16e:	00001097          	auipc	ra,0x1
 172:	8fc080e7          	jalr	-1796(ra) # a6a <printf>
        exit(-1);
 176:	557d                	li	a0,-1
 178:	00000097          	auipc	ra,0x0
 17c:	572080e7          	jalr	1394(ra) # 6ea <exit>

0000000000000180 <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 180:	1141                	addi	sp,sp,-16
 182:	e406                	sd	ra,8(sp)
 184:	e022                	sd	s0,0(sp)
 186:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 188:	09800513          	li	a0,152
 18c:	00001097          	auipc	ra,0x1
 190:	996080e7          	jalr	-1642(ra) # b22 <malloc>

    main_thread->tid = next_tid;
 194:	00001797          	auipc	a5,0x1
 198:	e6c78793          	addi	a5,a5,-404 # 1000 <next_tid>
 19c:	4398                	lw	a4,0(a5)
 19e:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 1a2:	4398                	lw	a4,0(a5)
 1a4:	2705                	addiw	a4,a4,1
 1a6:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 1a8:	4791                	li	a5,4
 1aa:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 1ac:	00001797          	auipc	a5,0x1
 1b0:	e6a7b223          	sd	a0,-412(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 1b4:	00001797          	auipc	a5,0x1
 1b8:	e6c78793          	addi	a5,a5,-404 # 1020 <threads>
 1bc:	00001717          	auipc	a4,0x1
 1c0:	ee470713          	addi	a4,a4,-284 # 10a0 <base>
        threads[i] = NULL;
 1c4:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 1c8:	07a1                	addi	a5,a5,8
 1ca:	fee79de3          	bne	a5,a4,1c4 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 1ce:	00001797          	auipc	a5,0x1
 1d2:	e4a7b923          	sd	a0,-430(a5) # 1020 <threads>
}
 1d6:	60a2                	ld	ra,8(sp)
 1d8:	6402                	ld	s0,0(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1de:	00001517          	auipc	a0,0x1
 1e2:	e3253503          	ld	a0,-462(a0) # 1010 <current_thread>
 1e6:	00001717          	auipc	a4,0x1
 1ea:	e3a70713          	addi	a4,a4,-454 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 1ee:	4781                	li	a5,0
 1f0:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 1f2:	6314                	ld	a3,0(a4)
 1f4:	00a68763          	beq	a3,a0,202 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 1f8:	2785                	addiw	a5,a5,1
 1fa:	0721                	addi	a4,a4,8
 1fc:	fec79be3          	bne	a5,a2,1f2 <tsched+0x14>
    int current_index = 0;
 200:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 202:	0017869b          	addiw	a3,a5,1
 206:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 20a:	00001817          	auipc	a6,0x1
 20e:	e1680813          	addi	a6,a6,-490 # 1020 <threads>
 212:	488d                	li	a7,3
 214:	a021                	j	21c <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 216:	2685                	addiw	a3,a3,1
 218:	04c68363          	beq	a3,a2,25e <tsched+0x80>
        int next_index = (current_index + i) % 16;
 21c:	41f6d71b          	sraiw	a4,a3,0x1f
 220:	01c7571b          	srliw	a4,a4,0x1c
 224:	00d707bb          	addw	a5,a4,a3
 228:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 22a:	9f99                	subw	a5,a5,a4
 22c:	078e                	slli	a5,a5,0x3
 22e:	97c2                	add	a5,a5,a6
 230:	638c                	ld	a1,0(a5)
 232:	d1f5                	beqz	a1,216 <tsched+0x38>
 234:	5dbc                	lw	a5,120(a1)
 236:	ff1790e3          	bne	a5,a7,216 <tsched+0x38>
{
 23a:	1141                	addi	sp,sp,-16
 23c:	e406                	sd	ra,8(sp)
 23e:	e022                	sd	s0,0(sp)
 240:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 242:	00001797          	auipc	a5,0x1
 246:	dcb7b723          	sd	a1,-562(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 24a:	05a1                	addi	a1,a1,8
 24c:	0521                	addi	a0,a0,8
 24e:	00000097          	auipc	ra,0x0
 252:	19a080e7          	jalr	410(ra) # 3e8 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 256:	60a2                	ld	ra,8(sp)
 258:	6402                	ld	s0,0(sp)
 25a:	0141                	addi	sp,sp,16
 25c:	8082                	ret
 25e:	8082                	ret

0000000000000260 <thread_wrapper>:
{
 260:	1101                	addi	sp,sp,-32
 262:	ec06                	sd	ra,24(sp)
 264:	e822                	sd	s0,16(sp)
 266:	e426                	sd	s1,8(sp)
 268:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 26a:	00001497          	auipc	s1,0x1
 26e:	da648493          	addi	s1,s1,-602 # 1010 <current_thread>
 272:	609c                	ld	a5,0(s1)
 274:	6b9c                	ld	a5,16(a5)
    func(arg);
 276:	6398                	ld	a4,0(a5)
 278:	6788                	ld	a0,8(a5)
 27a:	9702                	jalr	a4
    current_thread->state = EXITED;
 27c:	609c                	ld	a5,0(s1)
 27e:	4719                	li	a4,6
 280:	dfb8                	sw	a4,120(a5)
    tsched();
 282:	00000097          	auipc	ra,0x0
 286:	f5c080e7          	jalr	-164(ra) # 1de <tsched>
}
 28a:	60e2                	ld	ra,24(sp)
 28c:	6442                	ld	s0,16(sp)
 28e:	64a2                	ld	s1,8(sp)
 290:	6105                	addi	sp,sp,32
 292:	8082                	ret

0000000000000294 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 294:	7179                	addi	sp,sp,-48
 296:	f406                	sd	ra,40(sp)
 298:	f022                	sd	s0,32(sp)
 29a:	ec26                	sd	s1,24(sp)
 29c:	e84a                	sd	s2,16(sp)
 29e:	e44e                	sd	s3,8(sp)
 2a0:	1800                	addi	s0,sp,48
 2a2:	84aa                	mv	s1,a0
 2a4:	8932                	mv	s2,a2
 2a6:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2a8:	09800513          	li	a0,152
 2ac:	00001097          	auipc	ra,0x1
 2b0:	876080e7          	jalr	-1930(ra) # b22 <malloc>
 2b4:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2b6:	478d                	li	a5,3
 2b8:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2ba:	609c                	ld	a5,0(s1)
 2bc:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 2c0:	609c                	ld	a5,0(s1)
 2c2:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 2c6:	6098                	ld	a4,0(s1)
 2c8:	00001797          	auipc	a5,0x1
 2cc:	d3878793          	addi	a5,a5,-712 # 1000 <next_tid>
 2d0:	4394                	lw	a3,0(a5)
 2d2:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 2d6:	4398                	lw	a4,0(a5)
 2d8:	2705                	addiw	a4,a4,1
 2da:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 2dc:	6505                	lui	a0,0x1
 2de:	00001097          	auipc	ra,0x1
 2e2:	844080e7          	jalr	-1980(ra) # b22 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 2e6:	6785                	lui	a5,0x1
 2e8:	00a78733          	add	a4,a5,a0
 2ec:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 2f0:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x300>
 2f2:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 2f4:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 2f8:	609c                	ld	a5,0(s1)
 2fa:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 2fc:	609c                	ld	a5,0(s1)
 2fe:	00000717          	auipc	a4,0x0
 302:	f6270713          	addi	a4,a4,-158 # 260 <thread_wrapper>
 306:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 308:	00001717          	auipc	a4,0x1
 30c:	d1870713          	addi	a4,a4,-744 # 1020 <threads>
 310:	4781                	li	a5,0
 312:	4641                	li	a2,16
        if (threads[i] == NULL) {
 314:	6314                	ld	a3,0(a4)
 316:	c29d                	beqz	a3,33c <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 318:	2785                	addiw	a5,a5,1
 31a:	0721                	addi	a4,a4,8
 31c:	fec79ce3          	bne	a5,a2,314 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 320:	6088                	ld	a0,0(s1)
 322:	00000097          	auipc	ra,0x0
 326:	77e080e7          	jalr	1918(ra) # aa0 <free>
        *thread = NULL;
 32a:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 32e:	70a2                	ld	ra,40(sp)
 330:	7402                	ld	s0,32(sp)
 332:	64e2                	ld	s1,24(sp)
 334:	6942                	ld	s2,16(sp)
 336:	69a2                	ld	s3,8(sp)
 338:	6145                	addi	sp,sp,48
 33a:	8082                	ret
            threads[i] = *thread;
 33c:	6094                	ld	a3,0(s1)
 33e:	078e                	slli	a5,a5,0x3
 340:	00001717          	auipc	a4,0x1
 344:	ce070713          	addi	a4,a4,-800 # 1020 <threads>
 348:	97ba                	add	a5,a5,a4
 34a:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 34c:	b7cd                	j	32e <tcreate+0x9a>

000000000000034e <tyield>:
    return 0;
}


void tyield()
{
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 356:	00001797          	auipc	a5,0x1
 35a:	cba7b783          	ld	a5,-838(a5) # 1010 <current_thread>
 35e:	470d                	li	a4,3
 360:	dfb8                	sw	a4,120(a5)
    tsched();
 362:	00000097          	auipc	ra,0x0
 366:	e7c080e7          	jalr	-388(ra) # 1de <tsched>
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret

0000000000000372 <tjoin>:
{
 372:	1101                	addi	sp,sp,-32
 374:	ec06                	sd	ra,24(sp)
 376:	e822                	sd	s0,16(sp)
 378:	e426                	sd	s1,8(sp)
 37a:	e04a                	sd	s2,0(sp)
 37c:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 37e:	00001797          	auipc	a5,0x1
 382:	ca278793          	addi	a5,a5,-862 # 1020 <threads>
 386:	00001697          	auipc	a3,0x1
 38a:	d1a68693          	addi	a3,a3,-742 # 10a0 <base>
 38e:	a021                	j	396 <tjoin+0x24>
 390:	07a1                	addi	a5,a5,8
 392:	02d78b63          	beq	a5,a3,3c8 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 396:	6384                	ld	s1,0(a5)
 398:	dce5                	beqz	s1,390 <tjoin+0x1e>
 39a:	0004c703          	lbu	a4,0(s1)
 39e:	fea719e3          	bne	a4,a0,390 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3a2:	5cb8                	lw	a4,120(s1)
 3a4:	4799                	li	a5,6
 3a6:	4919                	li	s2,6
 3a8:	02f70263          	beq	a4,a5,3cc <tjoin+0x5a>
        tyield();
 3ac:	00000097          	auipc	ra,0x0
 3b0:	fa2080e7          	jalr	-94(ra) # 34e <tyield>
    while (target_thread->state != EXITED) {
 3b4:	5cbc                	lw	a5,120(s1)
 3b6:	ff279be3          	bne	a5,s2,3ac <tjoin+0x3a>
    return 0;
 3ba:	4501                	li	a0,0
}
 3bc:	60e2                	ld	ra,24(sp)
 3be:	6442                	ld	s0,16(sp)
 3c0:	64a2                	ld	s1,8(sp)
 3c2:	6902                	ld	s2,0(sp)
 3c4:	6105                	addi	sp,sp,32
 3c6:	8082                	ret
        return -1;
 3c8:	557d                	li	a0,-1
 3ca:	bfcd                	j	3bc <tjoin+0x4a>
    return 0;
 3cc:	4501                	li	a0,0
 3ce:	b7fd                	j	3bc <tjoin+0x4a>

00000000000003d0 <twhoami>:

uint8 twhoami()
{
 3d0:	1141                	addi	sp,sp,-16
 3d2:	e422                	sd	s0,8(sp)
 3d4:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 3d6:	00001797          	auipc	a5,0x1
 3da:	c3a7b783          	ld	a5,-966(a5) # 1010 <current_thread>
 3de:	0007c503          	lbu	a0,0(a5)
 3e2:	6422                	ld	s0,8(sp)
 3e4:	0141                	addi	sp,sp,16
 3e6:	8082                	ret

00000000000003e8 <tswtch>:
 3e8:	00153023          	sd	ra,0(a0)
 3ec:	00253423          	sd	sp,8(a0)
 3f0:	e900                	sd	s0,16(a0)
 3f2:	ed04                	sd	s1,24(a0)
 3f4:	03253023          	sd	s2,32(a0)
 3f8:	03353423          	sd	s3,40(a0)
 3fc:	03453823          	sd	s4,48(a0)
 400:	03553c23          	sd	s5,56(a0)
 404:	05653023          	sd	s6,64(a0)
 408:	05753423          	sd	s7,72(a0)
 40c:	05853823          	sd	s8,80(a0)
 410:	05953c23          	sd	s9,88(a0)
 414:	07a53023          	sd	s10,96(a0)
 418:	07b53423          	sd	s11,104(a0)
 41c:	0005b083          	ld	ra,0(a1)
 420:	0085b103          	ld	sp,8(a1)
 424:	6980                	ld	s0,16(a1)
 426:	6d84                	ld	s1,24(a1)
 428:	0205b903          	ld	s2,32(a1)
 42c:	0285b983          	ld	s3,40(a1)
 430:	0305ba03          	ld	s4,48(a1)
 434:	0385ba83          	ld	s5,56(a1)
 438:	0405bb03          	ld	s6,64(a1)
 43c:	0485bb83          	ld	s7,72(a1)
 440:	0505bc03          	ld	s8,80(a1)
 444:	0585bc83          	ld	s9,88(a1)
 448:	0605bd03          	ld	s10,96(a1)
 44c:	0685bd83          	ld	s11,104(a1)
 450:	8082                	ret

0000000000000452 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 452:	1101                	addi	sp,sp,-32
 454:	ec06                	sd	ra,24(sp)
 456:	e822                	sd	s0,16(sp)
 458:	e426                	sd	s1,8(sp)
 45a:	e04a                	sd	s2,0(sp)
 45c:	1000                	addi	s0,sp,32
 45e:	84aa                	mv	s1,a0
 460:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 462:	00000097          	auipc	ra,0x0
 466:	d1e080e7          	jalr	-738(ra) # 180 <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 46a:	85ca                	mv	a1,s2
 46c:	8526                	mv	a0,s1
 46e:	00000097          	auipc	ra,0x0
 472:	b92080e7          	jalr	-1134(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 476:	00000097          	auipc	ra,0x0
 47a:	274080e7          	jalr	628(ra) # 6ea <exit>

000000000000047e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 484:	87aa                	mv	a5,a0
 486:	0585                	addi	a1,a1,1
 488:	0785                	addi	a5,a5,1
 48a:	fff5c703          	lbu	a4,-1(a1)
 48e:	fee78fa3          	sb	a4,-1(a5)
 492:	fb75                	bnez	a4,486 <strcpy+0x8>
        ;
    return os;
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret

000000000000049a <strcmp>:

int strcmp(const char *p, const char *q)
{
 49a:	1141                	addi	sp,sp,-16
 49c:	e422                	sd	s0,8(sp)
 49e:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4a0:	00054783          	lbu	a5,0(a0)
 4a4:	cb91                	beqz	a5,4b8 <strcmp+0x1e>
 4a6:	0005c703          	lbu	a4,0(a1)
 4aa:	00f71763          	bne	a4,a5,4b8 <strcmp+0x1e>
        p++, q++;
 4ae:	0505                	addi	a0,a0,1
 4b0:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4b2:	00054783          	lbu	a5,0(a0)
 4b6:	fbe5                	bnez	a5,4a6 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4b8:	0005c503          	lbu	a0,0(a1)
}
 4bc:	40a7853b          	subw	a0,a5,a0
 4c0:	6422                	ld	s0,8(sp)
 4c2:	0141                	addi	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <strlen>:

uint strlen(const char *s)
{
 4c6:	1141                	addi	sp,sp,-16
 4c8:	e422                	sd	s0,8(sp)
 4ca:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4cc:	00054783          	lbu	a5,0(a0)
 4d0:	cf91                	beqz	a5,4ec <strlen+0x26>
 4d2:	0505                	addi	a0,a0,1
 4d4:	87aa                	mv	a5,a0
 4d6:	86be                	mv	a3,a5
 4d8:	0785                	addi	a5,a5,1
 4da:	fff7c703          	lbu	a4,-1(a5)
 4de:	ff65                	bnez	a4,4d6 <strlen+0x10>
 4e0:	40a6853b          	subw	a0,a3,a0
 4e4:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4e6:	6422                	ld	s0,8(sp)
 4e8:	0141                	addi	sp,sp,16
 4ea:	8082                	ret
    for (n = 0; s[n]; n++)
 4ec:	4501                	li	a0,0
 4ee:	bfe5                	j	4e6 <strlen+0x20>

00000000000004f0 <memset>:

void *
memset(void *dst, int c, uint n)
{
 4f0:	1141                	addi	sp,sp,-16
 4f2:	e422                	sd	s0,8(sp)
 4f4:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4f6:	ca19                	beqz	a2,50c <memset+0x1c>
 4f8:	87aa                	mv	a5,a0
 4fa:	1602                	slli	a2,a2,0x20
 4fc:	9201                	srli	a2,a2,0x20
 4fe:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 502:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 506:	0785                	addi	a5,a5,1
 508:	fee79de3          	bne	a5,a4,502 <memset+0x12>
    }
    return dst;
}
 50c:	6422                	ld	s0,8(sp)
 50e:	0141                	addi	sp,sp,16
 510:	8082                	ret

0000000000000512 <strchr>:

char *
strchr(const char *s, char c)
{
 512:	1141                	addi	sp,sp,-16
 514:	e422                	sd	s0,8(sp)
 516:	0800                	addi	s0,sp,16
    for (; *s; s++)
 518:	00054783          	lbu	a5,0(a0)
 51c:	cb99                	beqz	a5,532 <strchr+0x20>
        if (*s == c)
 51e:	00f58763          	beq	a1,a5,52c <strchr+0x1a>
    for (; *s; s++)
 522:	0505                	addi	a0,a0,1
 524:	00054783          	lbu	a5,0(a0)
 528:	fbfd                	bnez	a5,51e <strchr+0xc>
            return (char *)s;
    return 0;
 52a:	4501                	li	a0,0
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret
    return 0;
 532:	4501                	li	a0,0
 534:	bfe5                	j	52c <strchr+0x1a>

0000000000000536 <gets>:

char *
gets(char *buf, int max)
{
 536:	711d                	addi	sp,sp,-96
 538:	ec86                	sd	ra,88(sp)
 53a:	e8a2                	sd	s0,80(sp)
 53c:	e4a6                	sd	s1,72(sp)
 53e:	e0ca                	sd	s2,64(sp)
 540:	fc4e                	sd	s3,56(sp)
 542:	f852                	sd	s4,48(sp)
 544:	f456                	sd	s5,40(sp)
 546:	f05a                	sd	s6,32(sp)
 548:	ec5e                	sd	s7,24(sp)
 54a:	1080                	addi	s0,sp,96
 54c:	8baa                	mv	s7,a0
 54e:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 550:	892a                	mv	s2,a0
 552:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 554:	4aa9                	li	s5,10
 556:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 558:	89a6                	mv	s3,s1
 55a:	2485                	addiw	s1,s1,1
 55c:	0344d863          	bge	s1,s4,58c <gets+0x56>
        cc = read(0, &c, 1);
 560:	4605                	li	a2,1
 562:	faf40593          	addi	a1,s0,-81
 566:	4501                	li	a0,0
 568:	00000097          	auipc	ra,0x0
 56c:	19a080e7          	jalr	410(ra) # 702 <read>
        if (cc < 1)
 570:	00a05e63          	blez	a0,58c <gets+0x56>
        buf[i++] = c;
 574:	faf44783          	lbu	a5,-81(s0)
 578:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 57c:	01578763          	beq	a5,s5,58a <gets+0x54>
 580:	0905                	addi	s2,s2,1
 582:	fd679be3          	bne	a5,s6,558 <gets+0x22>
    for (i = 0; i + 1 < max;)
 586:	89a6                	mv	s3,s1
 588:	a011                	j	58c <gets+0x56>
 58a:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 58c:	99de                	add	s3,s3,s7
 58e:	00098023          	sb	zero,0(s3)
    return buf;
}
 592:	855e                	mv	a0,s7
 594:	60e6                	ld	ra,88(sp)
 596:	6446                	ld	s0,80(sp)
 598:	64a6                	ld	s1,72(sp)
 59a:	6906                	ld	s2,64(sp)
 59c:	79e2                	ld	s3,56(sp)
 59e:	7a42                	ld	s4,48(sp)
 5a0:	7aa2                	ld	s5,40(sp)
 5a2:	7b02                	ld	s6,32(sp)
 5a4:	6be2                	ld	s7,24(sp)
 5a6:	6125                	addi	sp,sp,96
 5a8:	8082                	ret

00000000000005aa <stat>:

int stat(const char *n, struct stat *st)
{
 5aa:	1101                	addi	sp,sp,-32
 5ac:	ec06                	sd	ra,24(sp)
 5ae:	e822                	sd	s0,16(sp)
 5b0:	e426                	sd	s1,8(sp)
 5b2:	e04a                	sd	s2,0(sp)
 5b4:	1000                	addi	s0,sp,32
 5b6:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5b8:	4581                	li	a1,0
 5ba:	00000097          	auipc	ra,0x0
 5be:	170080e7          	jalr	368(ra) # 72a <open>
    if (fd < 0)
 5c2:	02054563          	bltz	a0,5ec <stat+0x42>
 5c6:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5c8:	85ca                	mv	a1,s2
 5ca:	00000097          	auipc	ra,0x0
 5ce:	178080e7          	jalr	376(ra) # 742 <fstat>
 5d2:	892a                	mv	s2,a0
    close(fd);
 5d4:	8526                	mv	a0,s1
 5d6:	00000097          	auipc	ra,0x0
 5da:	13c080e7          	jalr	316(ra) # 712 <close>
    return r;
}
 5de:	854a                	mv	a0,s2
 5e0:	60e2                	ld	ra,24(sp)
 5e2:	6442                	ld	s0,16(sp)
 5e4:	64a2                	ld	s1,8(sp)
 5e6:	6902                	ld	s2,0(sp)
 5e8:	6105                	addi	sp,sp,32
 5ea:	8082                	ret
        return -1;
 5ec:	597d                	li	s2,-1
 5ee:	bfc5                	j	5de <stat+0x34>

00000000000005f0 <atoi>:

int atoi(const char *s)
{
 5f0:	1141                	addi	sp,sp,-16
 5f2:	e422                	sd	s0,8(sp)
 5f4:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5f6:	00054683          	lbu	a3,0(a0)
 5fa:	fd06879b          	addiw	a5,a3,-48
 5fe:	0ff7f793          	zext.b	a5,a5
 602:	4625                	li	a2,9
 604:	02f66863          	bltu	a2,a5,634 <atoi+0x44>
 608:	872a                	mv	a4,a0
    n = 0;
 60a:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 60c:	0705                	addi	a4,a4,1
 60e:	0025179b          	slliw	a5,a0,0x2
 612:	9fa9                	addw	a5,a5,a0
 614:	0017979b          	slliw	a5,a5,0x1
 618:	9fb5                	addw	a5,a5,a3
 61a:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 61e:	00074683          	lbu	a3,0(a4)
 622:	fd06879b          	addiw	a5,a3,-48
 626:	0ff7f793          	zext.b	a5,a5
 62a:	fef671e3          	bgeu	a2,a5,60c <atoi+0x1c>
    return n;
}
 62e:	6422                	ld	s0,8(sp)
 630:	0141                	addi	sp,sp,16
 632:	8082                	ret
    n = 0;
 634:	4501                	li	a0,0
 636:	bfe5                	j	62e <atoi+0x3e>

0000000000000638 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 638:	1141                	addi	sp,sp,-16
 63a:	e422                	sd	s0,8(sp)
 63c:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 63e:	02b57463          	bgeu	a0,a1,666 <memmove+0x2e>
    {
        while (n-- > 0)
 642:	00c05f63          	blez	a2,660 <memmove+0x28>
 646:	1602                	slli	a2,a2,0x20
 648:	9201                	srli	a2,a2,0x20
 64a:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 64e:	872a                	mv	a4,a0
            *dst++ = *src++;
 650:	0585                	addi	a1,a1,1
 652:	0705                	addi	a4,a4,1
 654:	fff5c683          	lbu	a3,-1(a1)
 658:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 65c:	fee79ae3          	bne	a5,a4,650 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 660:	6422                	ld	s0,8(sp)
 662:	0141                	addi	sp,sp,16
 664:	8082                	ret
        dst += n;
 666:	00c50733          	add	a4,a0,a2
        src += n;
 66a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 66c:	fec05ae3          	blez	a2,660 <memmove+0x28>
 670:	fff6079b          	addiw	a5,a2,-1
 674:	1782                	slli	a5,a5,0x20
 676:	9381                	srli	a5,a5,0x20
 678:	fff7c793          	not	a5,a5
 67c:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 67e:	15fd                	addi	a1,a1,-1
 680:	177d                	addi	a4,a4,-1
 682:	0005c683          	lbu	a3,0(a1)
 686:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 68a:	fee79ae3          	bne	a5,a4,67e <memmove+0x46>
 68e:	bfc9                	j	660 <memmove+0x28>

0000000000000690 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 690:	1141                	addi	sp,sp,-16
 692:	e422                	sd	s0,8(sp)
 694:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 696:	ca05                	beqz	a2,6c6 <memcmp+0x36>
 698:	fff6069b          	addiw	a3,a2,-1
 69c:	1682                	slli	a3,a3,0x20
 69e:	9281                	srli	a3,a3,0x20
 6a0:	0685                	addi	a3,a3,1
 6a2:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6a4:	00054783          	lbu	a5,0(a0)
 6a8:	0005c703          	lbu	a4,0(a1)
 6ac:	00e79863          	bne	a5,a4,6bc <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6b0:	0505                	addi	a0,a0,1
        p2++;
 6b2:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6b4:	fed518e3          	bne	a0,a3,6a4 <memcmp+0x14>
    }
    return 0;
 6b8:	4501                	li	a0,0
 6ba:	a019                	j	6c0 <memcmp+0x30>
            return *p1 - *p2;
 6bc:	40e7853b          	subw	a0,a5,a4
}
 6c0:	6422                	ld	s0,8(sp)
 6c2:	0141                	addi	sp,sp,16
 6c4:	8082                	ret
    return 0;
 6c6:	4501                	li	a0,0
 6c8:	bfe5                	j	6c0 <memcmp+0x30>

00000000000006ca <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6ca:	1141                	addi	sp,sp,-16
 6cc:	e406                	sd	ra,8(sp)
 6ce:	e022                	sd	s0,0(sp)
 6d0:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6d2:	00000097          	auipc	ra,0x0
 6d6:	f66080e7          	jalr	-154(ra) # 638 <memmove>
}
 6da:	60a2                	ld	ra,8(sp)
 6dc:	6402                	ld	s0,0(sp)
 6de:	0141                	addi	sp,sp,16
 6e0:	8082                	ret

00000000000006e2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6e2:	4885                	li	a7,1
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <exit>:
.global exit
exit:
 li a7, SYS_exit
 6ea:	4889                	li	a7,2
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6f2:	488d                	li	a7,3
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6fa:	4891                	li	a7,4
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <read>:
.global read
read:
 li a7, SYS_read
 702:	4895                	li	a7,5
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <write>:
.global write
write:
 li a7, SYS_write
 70a:	48c1                	li	a7,16
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <close>:
.global close
close:
 li a7, SYS_close
 712:	48d5                	li	a7,21
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <kill>:
.global kill
kill:
 li a7, SYS_kill
 71a:	4899                	li	a7,6
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <exec>:
.global exec
exec:
 li a7, SYS_exec
 722:	489d                	li	a7,7
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <open>:
.global open
open:
 li a7, SYS_open
 72a:	48bd                	li	a7,15
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 732:	48c5                	li	a7,17
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 73a:	48c9                	li	a7,18
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 742:	48a1                	li	a7,8
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <link>:
.global link
link:
 li a7, SYS_link
 74a:	48cd                	li	a7,19
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 752:	48d1                	li	a7,20
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 75a:	48a5                	li	a7,9
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <dup>:
.global dup
dup:
 li a7, SYS_dup
 762:	48a9                	li	a7,10
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 76a:	48ad                	li	a7,11
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 772:	48b1                	li	a7,12
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 77a:	48b5                	li	a7,13
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 782:	48b9                	li	a7,14
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <ps>:
.global ps
ps:
 li a7, SYS_ps
 78a:	48d9                	li	a7,22
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 792:	48dd                	li	a7,23
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 79a:	48e1                	li	a7,24
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7a2:	1101                	addi	sp,sp,-32
 7a4:	ec06                	sd	ra,24(sp)
 7a6:	e822                	sd	s0,16(sp)
 7a8:	1000                	addi	s0,sp,32
 7aa:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7ae:	4605                	li	a2,1
 7b0:	fef40593          	addi	a1,s0,-17
 7b4:	00000097          	auipc	ra,0x0
 7b8:	f56080e7          	jalr	-170(ra) # 70a <write>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6105                	addi	sp,sp,32
 7c2:	8082                	ret

00000000000007c4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7c4:	7139                	addi	sp,sp,-64
 7c6:	fc06                	sd	ra,56(sp)
 7c8:	f822                	sd	s0,48(sp)
 7ca:	f426                	sd	s1,40(sp)
 7cc:	f04a                	sd	s2,32(sp)
 7ce:	ec4e                	sd	s3,24(sp)
 7d0:	0080                	addi	s0,sp,64
 7d2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7d4:	c299                	beqz	a3,7da <printint+0x16>
 7d6:	0805c963          	bltz	a1,868 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7da:	2581                	sext.w	a1,a1
  neg = 0;
 7dc:	4881                	li	a7,0
 7de:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7e2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7e4:	2601                	sext.w	a2,a2
 7e6:	00000517          	auipc	a0,0x0
 7ea:	50a50513          	addi	a0,a0,1290 # cf0 <digits>
 7ee:	883a                	mv	a6,a4
 7f0:	2705                	addiw	a4,a4,1
 7f2:	02c5f7bb          	remuw	a5,a1,a2
 7f6:	1782                	slli	a5,a5,0x20
 7f8:	9381                	srli	a5,a5,0x20
 7fa:	97aa                	add	a5,a5,a0
 7fc:	0007c783          	lbu	a5,0(a5)
 800:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 804:	0005879b          	sext.w	a5,a1
 808:	02c5d5bb          	divuw	a1,a1,a2
 80c:	0685                	addi	a3,a3,1
 80e:	fec7f0e3          	bgeu	a5,a2,7ee <printint+0x2a>
  if(neg)
 812:	00088c63          	beqz	a7,82a <printint+0x66>
    buf[i++] = '-';
 816:	fd070793          	addi	a5,a4,-48
 81a:	00878733          	add	a4,a5,s0
 81e:	02d00793          	li	a5,45
 822:	fef70823          	sb	a5,-16(a4)
 826:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 82a:	02e05863          	blez	a4,85a <printint+0x96>
 82e:	fc040793          	addi	a5,s0,-64
 832:	00e78933          	add	s2,a5,a4
 836:	fff78993          	addi	s3,a5,-1
 83a:	99ba                	add	s3,s3,a4
 83c:	377d                	addiw	a4,a4,-1
 83e:	1702                	slli	a4,a4,0x20
 840:	9301                	srli	a4,a4,0x20
 842:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 846:	fff94583          	lbu	a1,-1(s2)
 84a:	8526                	mv	a0,s1
 84c:	00000097          	auipc	ra,0x0
 850:	f56080e7          	jalr	-170(ra) # 7a2 <putc>
  while(--i >= 0)
 854:	197d                	addi	s2,s2,-1
 856:	ff3918e3          	bne	s2,s3,846 <printint+0x82>
}
 85a:	70e2                	ld	ra,56(sp)
 85c:	7442                	ld	s0,48(sp)
 85e:	74a2                	ld	s1,40(sp)
 860:	7902                	ld	s2,32(sp)
 862:	69e2                	ld	s3,24(sp)
 864:	6121                	addi	sp,sp,64
 866:	8082                	ret
    x = -xx;
 868:	40b005bb          	negw	a1,a1
    neg = 1;
 86c:	4885                	li	a7,1
    x = -xx;
 86e:	bf85                	j	7de <printint+0x1a>

0000000000000870 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 870:	715d                	addi	sp,sp,-80
 872:	e486                	sd	ra,72(sp)
 874:	e0a2                	sd	s0,64(sp)
 876:	fc26                	sd	s1,56(sp)
 878:	f84a                	sd	s2,48(sp)
 87a:	f44e                	sd	s3,40(sp)
 87c:	f052                	sd	s4,32(sp)
 87e:	ec56                	sd	s5,24(sp)
 880:	e85a                	sd	s6,16(sp)
 882:	e45e                	sd	s7,8(sp)
 884:	e062                	sd	s8,0(sp)
 886:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 888:	0005c903          	lbu	s2,0(a1)
 88c:	18090c63          	beqz	s2,a24 <vprintf+0x1b4>
 890:	8aaa                	mv	s5,a0
 892:	8bb2                	mv	s7,a2
 894:	00158493          	addi	s1,a1,1
  state = 0;
 898:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 89a:	02500a13          	li	s4,37
 89e:	4b55                	li	s6,21
 8a0:	a839                	j	8be <vprintf+0x4e>
        putc(fd, c);
 8a2:	85ca                	mv	a1,s2
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	efc080e7          	jalr	-260(ra) # 7a2 <putc>
 8ae:	a019                	j	8b4 <vprintf+0x44>
    } else if(state == '%'){
 8b0:	01498d63          	beq	s3,s4,8ca <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8b4:	0485                	addi	s1,s1,1
 8b6:	fff4c903          	lbu	s2,-1(s1)
 8ba:	16090563          	beqz	s2,a24 <vprintf+0x1b4>
    if(state == 0){
 8be:	fe0999e3          	bnez	s3,8b0 <vprintf+0x40>
      if(c == '%'){
 8c2:	ff4910e3          	bne	s2,s4,8a2 <vprintf+0x32>
        state = '%';
 8c6:	89d2                	mv	s3,s4
 8c8:	b7f5                	j	8b4 <vprintf+0x44>
      if(c == 'd'){
 8ca:	13490263          	beq	s2,s4,9ee <vprintf+0x17e>
 8ce:	f9d9079b          	addiw	a5,s2,-99
 8d2:	0ff7f793          	zext.b	a5,a5
 8d6:	12fb6563          	bltu	s6,a5,a00 <vprintf+0x190>
 8da:	f9d9079b          	addiw	a5,s2,-99
 8de:	0ff7f713          	zext.b	a4,a5
 8e2:	10eb6f63          	bltu	s6,a4,a00 <vprintf+0x190>
 8e6:	00271793          	slli	a5,a4,0x2
 8ea:	00000717          	auipc	a4,0x0
 8ee:	3ae70713          	addi	a4,a4,942 # c98 <malloc+0x176>
 8f2:	97ba                	add	a5,a5,a4
 8f4:	439c                	lw	a5,0(a5)
 8f6:	97ba                	add	a5,a5,a4
 8f8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8fa:	008b8913          	addi	s2,s7,8
 8fe:	4685                	li	a3,1
 900:	4629                	li	a2,10
 902:	000ba583          	lw	a1,0(s7)
 906:	8556                	mv	a0,s5
 908:	00000097          	auipc	ra,0x0
 90c:	ebc080e7          	jalr	-324(ra) # 7c4 <printint>
 910:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 912:	4981                	li	s3,0
 914:	b745                	j	8b4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 916:	008b8913          	addi	s2,s7,8
 91a:	4681                	li	a3,0
 91c:	4629                	li	a2,10
 91e:	000ba583          	lw	a1,0(s7)
 922:	8556                	mv	a0,s5
 924:	00000097          	auipc	ra,0x0
 928:	ea0080e7          	jalr	-352(ra) # 7c4 <printint>
 92c:	8bca                	mv	s7,s2
      state = 0;
 92e:	4981                	li	s3,0
 930:	b751                	j	8b4 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 932:	008b8913          	addi	s2,s7,8
 936:	4681                	li	a3,0
 938:	4641                	li	a2,16
 93a:	000ba583          	lw	a1,0(s7)
 93e:	8556                	mv	a0,s5
 940:	00000097          	auipc	ra,0x0
 944:	e84080e7          	jalr	-380(ra) # 7c4 <printint>
 948:	8bca                	mv	s7,s2
      state = 0;
 94a:	4981                	li	s3,0
 94c:	b7a5                	j	8b4 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 94e:	008b8c13          	addi	s8,s7,8
 952:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 956:	03000593          	li	a1,48
 95a:	8556                	mv	a0,s5
 95c:	00000097          	auipc	ra,0x0
 960:	e46080e7          	jalr	-442(ra) # 7a2 <putc>
  putc(fd, 'x');
 964:	07800593          	li	a1,120
 968:	8556                	mv	a0,s5
 96a:	00000097          	auipc	ra,0x0
 96e:	e38080e7          	jalr	-456(ra) # 7a2 <putc>
 972:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 974:	00000b97          	auipc	s7,0x0
 978:	37cb8b93          	addi	s7,s7,892 # cf0 <digits>
 97c:	03c9d793          	srli	a5,s3,0x3c
 980:	97de                	add	a5,a5,s7
 982:	0007c583          	lbu	a1,0(a5)
 986:	8556                	mv	a0,s5
 988:	00000097          	auipc	ra,0x0
 98c:	e1a080e7          	jalr	-486(ra) # 7a2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 990:	0992                	slli	s3,s3,0x4
 992:	397d                	addiw	s2,s2,-1
 994:	fe0914e3          	bnez	s2,97c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 998:	8be2                	mv	s7,s8
      state = 0;
 99a:	4981                	li	s3,0
 99c:	bf21                	j	8b4 <vprintf+0x44>
        s = va_arg(ap, char*);
 99e:	008b8993          	addi	s3,s7,8
 9a2:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9a6:	02090163          	beqz	s2,9c8 <vprintf+0x158>
        while(*s != 0){
 9aa:	00094583          	lbu	a1,0(s2)
 9ae:	c9a5                	beqz	a1,a1e <vprintf+0x1ae>
          putc(fd, *s);
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	df0080e7          	jalr	-528(ra) # 7a2 <putc>
          s++;
 9ba:	0905                	addi	s2,s2,1
        while(*s != 0){
 9bc:	00094583          	lbu	a1,0(s2)
 9c0:	f9e5                	bnez	a1,9b0 <vprintf+0x140>
        s = va_arg(ap, char*);
 9c2:	8bce                	mv	s7,s3
      state = 0;
 9c4:	4981                	li	s3,0
 9c6:	b5fd                	j	8b4 <vprintf+0x44>
          s = "(null)";
 9c8:	00000917          	auipc	s2,0x0
 9cc:	2c890913          	addi	s2,s2,712 # c90 <malloc+0x16e>
        while(*s != 0){
 9d0:	02800593          	li	a1,40
 9d4:	bff1                	j	9b0 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9d6:	008b8913          	addi	s2,s7,8
 9da:	000bc583          	lbu	a1,0(s7)
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	dc2080e7          	jalr	-574(ra) # 7a2 <putc>
 9e8:	8bca                	mv	s7,s2
      state = 0;
 9ea:	4981                	li	s3,0
 9ec:	b5e1                	j	8b4 <vprintf+0x44>
        putc(fd, c);
 9ee:	02500593          	li	a1,37
 9f2:	8556                	mv	a0,s5
 9f4:	00000097          	auipc	ra,0x0
 9f8:	dae080e7          	jalr	-594(ra) # 7a2 <putc>
      state = 0;
 9fc:	4981                	li	s3,0
 9fe:	bd5d                	j	8b4 <vprintf+0x44>
        putc(fd, '%');
 a00:	02500593          	li	a1,37
 a04:	8556                	mv	a0,s5
 a06:	00000097          	auipc	ra,0x0
 a0a:	d9c080e7          	jalr	-612(ra) # 7a2 <putc>
        putc(fd, c);
 a0e:	85ca                	mv	a1,s2
 a10:	8556                	mv	a0,s5
 a12:	00000097          	auipc	ra,0x0
 a16:	d90080e7          	jalr	-624(ra) # 7a2 <putc>
      state = 0;
 a1a:	4981                	li	s3,0
 a1c:	bd61                	j	8b4 <vprintf+0x44>
        s = va_arg(ap, char*);
 a1e:	8bce                	mv	s7,s3
      state = 0;
 a20:	4981                	li	s3,0
 a22:	bd49                	j	8b4 <vprintf+0x44>
    }
  }
}
 a24:	60a6                	ld	ra,72(sp)
 a26:	6406                	ld	s0,64(sp)
 a28:	74e2                	ld	s1,56(sp)
 a2a:	7942                	ld	s2,48(sp)
 a2c:	79a2                	ld	s3,40(sp)
 a2e:	7a02                	ld	s4,32(sp)
 a30:	6ae2                	ld	s5,24(sp)
 a32:	6b42                	ld	s6,16(sp)
 a34:	6ba2                	ld	s7,8(sp)
 a36:	6c02                	ld	s8,0(sp)
 a38:	6161                	addi	sp,sp,80
 a3a:	8082                	ret

0000000000000a3c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a3c:	715d                	addi	sp,sp,-80
 a3e:	ec06                	sd	ra,24(sp)
 a40:	e822                	sd	s0,16(sp)
 a42:	1000                	addi	s0,sp,32
 a44:	e010                	sd	a2,0(s0)
 a46:	e414                	sd	a3,8(s0)
 a48:	e818                	sd	a4,16(s0)
 a4a:	ec1c                	sd	a5,24(s0)
 a4c:	03043023          	sd	a6,32(s0)
 a50:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a54:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a58:	8622                	mv	a2,s0
 a5a:	00000097          	auipc	ra,0x0
 a5e:	e16080e7          	jalr	-490(ra) # 870 <vprintf>
}
 a62:	60e2                	ld	ra,24(sp)
 a64:	6442                	ld	s0,16(sp)
 a66:	6161                	addi	sp,sp,80
 a68:	8082                	ret

0000000000000a6a <printf>:

void
printf(const char *fmt, ...)
{
 a6a:	711d                	addi	sp,sp,-96
 a6c:	ec06                	sd	ra,24(sp)
 a6e:	e822                	sd	s0,16(sp)
 a70:	1000                	addi	s0,sp,32
 a72:	e40c                	sd	a1,8(s0)
 a74:	e810                	sd	a2,16(s0)
 a76:	ec14                	sd	a3,24(s0)
 a78:	f018                	sd	a4,32(s0)
 a7a:	f41c                	sd	a5,40(s0)
 a7c:	03043823          	sd	a6,48(s0)
 a80:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a84:	00840613          	addi	a2,s0,8
 a88:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a8c:	85aa                	mv	a1,a0
 a8e:	4505                	li	a0,1
 a90:	00000097          	auipc	ra,0x0
 a94:	de0080e7          	jalr	-544(ra) # 870 <vprintf>
}
 a98:	60e2                	ld	ra,24(sp)
 a9a:	6442                	ld	s0,16(sp)
 a9c:	6125                	addi	sp,sp,96
 a9e:	8082                	ret

0000000000000aa0 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 aa0:	1141                	addi	sp,sp,-16
 aa2:	e422                	sd	s0,8(sp)
 aa4:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 aa6:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aaa:	00000797          	auipc	a5,0x0
 aae:	56e7b783          	ld	a5,1390(a5) # 1018 <freep>
 ab2:	a02d                	j	adc <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ab4:	4618                	lw	a4,8(a2)
 ab6:	9f2d                	addw	a4,a4,a1
 ab8:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 abc:	6398                	ld	a4,0(a5)
 abe:	6310                	ld	a2,0(a4)
 ac0:	a83d                	j	afe <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ac2:	ff852703          	lw	a4,-8(a0)
 ac6:	9f31                	addw	a4,a4,a2
 ac8:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 aca:	ff053683          	ld	a3,-16(a0)
 ace:	a091                	j	b12 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad0:	6398                	ld	a4,0(a5)
 ad2:	00e7e463          	bltu	a5,a4,ada <free+0x3a>
 ad6:	00e6ea63          	bltu	a3,a4,aea <free+0x4a>
{
 ada:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 adc:	fed7fae3          	bgeu	a5,a3,ad0 <free+0x30>
 ae0:	6398                	ld	a4,0(a5)
 ae2:	00e6e463          	bltu	a3,a4,aea <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae6:	fee7eae3          	bltu	a5,a4,ada <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 aea:	ff852583          	lw	a1,-8(a0)
 aee:	6390                	ld	a2,0(a5)
 af0:	02059813          	slli	a6,a1,0x20
 af4:	01c85713          	srli	a4,a6,0x1c
 af8:	9736                	add	a4,a4,a3
 afa:	fae60de3          	beq	a2,a4,ab4 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 afe:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b02:	4790                	lw	a2,8(a5)
 b04:	02061593          	slli	a1,a2,0x20
 b08:	01c5d713          	srli	a4,a1,0x1c
 b0c:	973e                	add	a4,a4,a5
 b0e:	fae68ae3          	beq	a3,a4,ac2 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b12:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b14:	00000717          	auipc	a4,0x0
 b18:	50f73223          	sd	a5,1284(a4) # 1018 <freep>
}
 b1c:	6422                	ld	s0,8(sp)
 b1e:	0141                	addi	sp,sp,16
 b20:	8082                	ret

0000000000000b22 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b22:	7139                	addi	sp,sp,-64
 b24:	fc06                	sd	ra,56(sp)
 b26:	f822                	sd	s0,48(sp)
 b28:	f426                	sd	s1,40(sp)
 b2a:	f04a                	sd	s2,32(sp)
 b2c:	ec4e                	sd	s3,24(sp)
 b2e:	e852                	sd	s4,16(sp)
 b30:	e456                	sd	s5,8(sp)
 b32:	e05a                	sd	s6,0(sp)
 b34:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b36:	02051493          	slli	s1,a0,0x20
 b3a:	9081                	srli	s1,s1,0x20
 b3c:	04bd                	addi	s1,s1,15
 b3e:	8091                	srli	s1,s1,0x4
 b40:	0014899b          	addiw	s3,s1,1
 b44:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b46:	00000517          	auipc	a0,0x0
 b4a:	4d253503          	ld	a0,1234(a0) # 1018 <freep>
 b4e:	c515                	beqz	a0,b7a <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b50:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b52:	4798                	lw	a4,8(a5)
 b54:	02977f63          	bgeu	a4,s1,b92 <malloc+0x70>
    if (nu < 4096)
 b58:	8a4e                	mv	s4,s3
 b5a:	0009871b          	sext.w	a4,s3
 b5e:	6685                	lui	a3,0x1
 b60:	00d77363          	bgeu	a4,a3,b66 <malloc+0x44>
 b64:	6a05                	lui	s4,0x1
 b66:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b6a:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b6e:	00000917          	auipc	s2,0x0
 b72:	4aa90913          	addi	s2,s2,1194 # 1018 <freep>
    if (p == (char *)-1)
 b76:	5afd                	li	s5,-1
 b78:	a895                	j	bec <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b7a:	00000797          	auipc	a5,0x0
 b7e:	52678793          	addi	a5,a5,1318 # 10a0 <base>
 b82:	00000717          	auipc	a4,0x0
 b86:	48f73b23          	sd	a5,1174(a4) # 1018 <freep>
 b8a:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b8c:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b90:	b7e1                	j	b58 <malloc+0x36>
            if (p->s.size == nunits)
 b92:	02e48c63          	beq	s1,a4,bca <malloc+0xa8>
                p->s.size -= nunits;
 b96:	4137073b          	subw	a4,a4,s3
 b9a:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b9c:	02071693          	slli	a3,a4,0x20
 ba0:	01c6d713          	srli	a4,a3,0x1c
 ba4:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 ba6:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 baa:	00000717          	auipc	a4,0x0
 bae:	46a73723          	sd	a0,1134(a4) # 1018 <freep>
            return (void *)(p + 1);
 bb2:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 bb6:	70e2                	ld	ra,56(sp)
 bb8:	7442                	ld	s0,48(sp)
 bba:	74a2                	ld	s1,40(sp)
 bbc:	7902                	ld	s2,32(sp)
 bbe:	69e2                	ld	s3,24(sp)
 bc0:	6a42                	ld	s4,16(sp)
 bc2:	6aa2                	ld	s5,8(sp)
 bc4:	6b02                	ld	s6,0(sp)
 bc6:	6121                	addi	sp,sp,64
 bc8:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bca:	6398                	ld	a4,0(a5)
 bcc:	e118                	sd	a4,0(a0)
 bce:	bff1                	j	baa <malloc+0x88>
    hp->s.size = nu;
 bd0:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bd4:	0541                	addi	a0,a0,16
 bd6:	00000097          	auipc	ra,0x0
 bda:	eca080e7          	jalr	-310(ra) # aa0 <free>
    return freep;
 bde:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 be2:	d971                	beqz	a0,bb6 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 be4:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 be6:	4798                	lw	a4,8(a5)
 be8:	fa9775e3          	bgeu	a4,s1,b92 <malloc+0x70>
        if (p == freep)
 bec:	00093703          	ld	a4,0(s2)
 bf0:	853e                	mv	a0,a5
 bf2:	fef719e3          	bne	a4,a5,be4 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bf6:	8552                	mv	a0,s4
 bf8:	00000097          	auipc	ra,0x0
 bfc:	b7a080e7          	jalr	-1158(ra) # 772 <sbrk>
    if (p == (char *)-1)
 c00:	fd5518e3          	bne	a0,s5,bd0 <malloc+0xae>
                return 0;
 c04:	4501                	li	a0,0
 c06:	bf45                	j	bb6 <malloc+0x94>
