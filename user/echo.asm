
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d863          	bge	a5,a0,84 <main+0x84>
  18:	00858493          	addi	s1,a1,8
  1c:	3579                	addiw	a0,a0,-2
  1e:	02051793          	slli	a5,a0,0x20
  22:	01d7d513          	srli	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	addi	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	c10a8a93          	addi	s5,s5,-1008 # c40 <malloc+0xf0>
  38:	a819                	j	4e <main+0x4e>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	00000097          	auipc	ra,0x0
  44:	6f8080e7          	jalr	1784(ra) # 738 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03348d63          	beq	s1,s3,84 <main+0x84>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	00000097          	auipc	ra,0x0
  58:	4a0080e7          	jalr	1184(ra) # 4f4 <strlen>
  5c:	0005061b          	sext.w	a2,a0
  60:	85ca                	mv	a1,s2
  62:	4505                	li	a0,1
  64:	00000097          	auipc	ra,0x0
  68:	6d4080e7          	jalr	1748(ra) # 738 <write>
    if(i + 1 < argc){
  6c:	fd4497e3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  70:	4605                	li	a2,1
  72:	00001597          	auipc	a1,0x1
  76:	bd658593          	addi	a1,a1,-1066 # c48 <malloc+0xf8>
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	6bc080e7          	jalr	1724(ra) # 738 <write>
    }
  }
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	692080e7          	jalr	1682(ra) # 718 <exit>

000000000000008e <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e422                	sd	s0,8(sp)
  92:	0800                	addi	s0,sp,16
    lk->name = name;
  94:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  96:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  9a:	57fd                	li	a5,-1
  9c:	00f50823          	sb	a5,16(a0)
}
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	addi	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  a6:	00054783          	lbu	a5,0(a0)
  aa:	e399                	bnez	a5,b0 <holding+0xa>
  ac:	4501                	li	a0,0
}
  ae:	8082                	ret
{
  b0:	1101                	addi	sp,sp,-32
  b2:	ec06                	sd	ra,24(sp)
  b4:	e822                	sd	s0,16(sp)
  b6:	e426                	sd	s1,8(sp)
  b8:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  ba:	01054483          	lbu	s1,16(a0)
  be:	00000097          	auipc	ra,0x0
  c2:	340080e7          	jalr	832(ra) # 3fe <twhoami>
  c6:	2501                	sext.w	a0,a0
  c8:	40a48533          	sub	a0,s1,a0
  cc:	00153513          	seqz	a0,a0
}
  d0:	60e2                	ld	ra,24(sp)
  d2:	6442                	ld	s0,16(sp)
  d4:	64a2                	ld	s1,8(sp)
  d6:	6105                	addi	sp,sp,32
  d8:	8082                	ret

00000000000000da <acquire>:

void acquire(struct lock *lk)
{
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	ec26                	sd	s1,24(sp)
  e2:	e84a                	sd	s2,16(sp)
  e4:	e44e                	sd	s3,8(sp)
  e6:	e052                	sd	s4,0(sp)
  e8:	1800                	addi	s0,sp,48
  ea:	8a2a                	mv	s4,a0
    if (holding(lk))
  ec:	00000097          	auipc	ra,0x0
  f0:	fba080e7          	jalr	-70(ra) # a6 <holding>
  f4:	e919                	bnez	a0,10a <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f6:	ffca7493          	andi	s1,s4,-4
  fa:	003a7913          	andi	s2,s4,3
  fe:	0039191b          	slliw	s2,s2,0x3
 102:	4985                	li	s3,1
 104:	012999bb          	sllw	s3,s3,s2
 108:	a015                	j	12c <acquire+0x52>
        printf("re-acquiring lock we already hold");
 10a:	00001517          	auipc	a0,0x1
 10e:	b4650513          	addi	a0,a0,-1210 # c50 <malloc+0x100>
 112:	00001097          	auipc	ra,0x1
 116:	986080e7          	jalr	-1658(ra) # a98 <printf>
        exit(-1);
 11a:	557d                	li	a0,-1
 11c:	00000097          	auipc	ra,0x0
 120:	5fc080e7          	jalr	1532(ra) # 718 <exit>
    {
        // give up the cpu for other threads
        tyield();
 124:	00000097          	auipc	ra,0x0
 128:	258080e7          	jalr	600(ra) # 37c <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 12c:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 130:	0127d7bb          	srlw	a5,a5,s2
 134:	0ff7f793          	zext.b	a5,a5
 138:	f7f5                	bnez	a5,124 <acquire+0x4a>
    }

    __sync_synchronize();
 13a:	0ff0000f          	fence

    lk->tid = twhoami();
 13e:	00000097          	auipc	ra,0x0
 142:	2c0080e7          	jalr	704(ra) # 3fe <twhoami>
 146:	00aa0823          	sb	a0,16(s4)
}
 14a:	70a2                	ld	ra,40(sp)
 14c:	7402                	ld	s0,32(sp)
 14e:	64e2                	ld	s1,24(sp)
 150:	6942                	ld	s2,16(sp)
 152:	69a2                	ld	s3,8(sp)
 154:	6a02                	ld	s4,0(sp)
 156:	6145                	addi	sp,sp,48
 158:	8082                	ret

000000000000015a <release>:

void release(struct lock *lk)
{
 15a:	1101                	addi	sp,sp,-32
 15c:	ec06                	sd	ra,24(sp)
 15e:	e822                	sd	s0,16(sp)
 160:	e426                	sd	s1,8(sp)
 162:	1000                	addi	s0,sp,32
 164:	84aa                	mv	s1,a0
    if (!holding(lk))
 166:	00000097          	auipc	ra,0x0
 16a:	f40080e7          	jalr	-192(ra) # a6 <holding>
 16e:	c11d                	beqz	a0,194 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 170:	57fd                	li	a5,-1
 172:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 176:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 17a:	0ff0000f          	fence
 17e:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 182:	00000097          	auipc	ra,0x0
 186:	1fa080e7          	jalr	506(ra) # 37c <tyield>
}
 18a:	60e2                	ld	ra,24(sp)
 18c:	6442                	ld	s0,16(sp)
 18e:	64a2                	ld	s1,8(sp)
 190:	6105                	addi	sp,sp,32
 192:	8082                	ret
        printf("releasing lock we are not holding");
 194:	00001517          	auipc	a0,0x1
 198:	ae450513          	addi	a0,a0,-1308 # c78 <malloc+0x128>
 19c:	00001097          	auipc	ra,0x1
 1a0:	8fc080e7          	jalr	-1796(ra) # a98 <printf>
        exit(-1);
 1a4:	557d                	li	a0,-1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	572080e7          	jalr	1394(ra) # 718 <exit>

00000000000001ae <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 1ae:	1141                	addi	sp,sp,-16
 1b0:	e406                	sd	ra,8(sp)
 1b2:	e022                	sd	s0,0(sp)
 1b4:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 1b6:	09800513          	li	a0,152
 1ba:	00001097          	auipc	ra,0x1
 1be:	996080e7          	jalr	-1642(ra) # b50 <malloc>

    main_thread->tid = next_tid;
 1c2:	00001797          	auipc	a5,0x1
 1c6:	e3e78793          	addi	a5,a5,-450 # 1000 <next_tid>
 1ca:	4398                	lw	a4,0(a5)
 1cc:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 1d0:	4398                	lw	a4,0(a5)
 1d2:	2705                	addiw	a4,a4,1
 1d4:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 1d6:	4791                	li	a5,4
 1d8:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 1da:	00001797          	auipc	a5,0x1
 1de:	e2a7bb23          	sd	a0,-458(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 1e2:	00001797          	auipc	a5,0x1
 1e6:	e3e78793          	addi	a5,a5,-450 # 1020 <threads>
 1ea:	00001717          	auipc	a4,0x1
 1ee:	eb670713          	addi	a4,a4,-330 # 10a0 <base>
        threads[i] = NULL;
 1f2:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 1f6:	07a1                	addi	a5,a5,8
 1f8:	fee79de3          	bne	a5,a4,1f2 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 1fc:	00001797          	auipc	a5,0x1
 200:	e2a7b223          	sd	a0,-476(a5) # 1020 <threads>
}
 204:	60a2                	ld	ra,8(sp)
 206:	6402                	ld	s0,0(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret

000000000000020c <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 20c:	00001517          	auipc	a0,0x1
 210:	e0453503          	ld	a0,-508(a0) # 1010 <current_thread>
 214:	00001717          	auipc	a4,0x1
 218:	e0c70713          	addi	a4,a4,-500 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 21c:	4781                	li	a5,0
 21e:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 220:	6314                	ld	a3,0(a4)
 222:	00a68763          	beq	a3,a0,230 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 226:	2785                	addiw	a5,a5,1
 228:	0721                	addi	a4,a4,8
 22a:	fec79be3          	bne	a5,a2,220 <tsched+0x14>
    int current_index = 0;
 22e:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 230:	0017869b          	addiw	a3,a5,1
 234:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 238:	00001817          	auipc	a6,0x1
 23c:	de880813          	addi	a6,a6,-536 # 1020 <threads>
 240:	488d                	li	a7,3
 242:	a021                	j	24a <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 244:	2685                	addiw	a3,a3,1
 246:	04c68363          	beq	a3,a2,28c <tsched+0x80>
        int next_index = (current_index + i) % 16;
 24a:	41f6d71b          	sraiw	a4,a3,0x1f
 24e:	01c7571b          	srliw	a4,a4,0x1c
 252:	00d707bb          	addw	a5,a4,a3
 256:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 258:	9f99                	subw	a5,a5,a4
 25a:	078e                	slli	a5,a5,0x3
 25c:	97c2                	add	a5,a5,a6
 25e:	638c                	ld	a1,0(a5)
 260:	d1f5                	beqz	a1,244 <tsched+0x38>
 262:	5dbc                	lw	a5,120(a1)
 264:	ff1790e3          	bne	a5,a7,244 <tsched+0x38>
{
 268:	1141                	addi	sp,sp,-16
 26a:	e406                	sd	ra,8(sp)
 26c:	e022                	sd	s0,0(sp)
 26e:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 270:	00001797          	auipc	a5,0x1
 274:	dab7b023          	sd	a1,-608(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 278:	05a1                	addi	a1,a1,8
 27a:	0521                	addi	a0,a0,8
 27c:	00000097          	auipc	ra,0x0
 280:	19a080e7          	jalr	410(ra) # 416 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 284:	60a2                	ld	ra,8(sp)
 286:	6402                	ld	s0,0(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
 28c:	8082                	ret

000000000000028e <thread_wrapper>:
{
 28e:	1101                	addi	sp,sp,-32
 290:	ec06                	sd	ra,24(sp)
 292:	e822                	sd	s0,16(sp)
 294:	e426                	sd	s1,8(sp)
 296:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 298:	00001497          	auipc	s1,0x1
 29c:	d7848493          	addi	s1,s1,-648 # 1010 <current_thread>
 2a0:	609c                	ld	a5,0(s1)
 2a2:	6b9c                	ld	a5,16(a5)
    func(arg);
 2a4:	6398                	ld	a4,0(a5)
 2a6:	6788                	ld	a0,8(a5)
 2a8:	9702                	jalr	a4
    current_thread->state = EXITED;
 2aa:	609c                	ld	a5,0(s1)
 2ac:	4719                	li	a4,6
 2ae:	dfb8                	sw	a4,120(a5)
    tsched();
 2b0:	00000097          	auipc	ra,0x0
 2b4:	f5c080e7          	jalr	-164(ra) # 20c <tsched>
}
 2b8:	60e2                	ld	ra,24(sp)
 2ba:	6442                	ld	s0,16(sp)
 2bc:	64a2                	ld	s1,8(sp)
 2be:	6105                	addi	sp,sp,32
 2c0:	8082                	ret

00000000000002c2 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2c2:	7179                	addi	sp,sp,-48
 2c4:	f406                	sd	ra,40(sp)
 2c6:	f022                	sd	s0,32(sp)
 2c8:	ec26                	sd	s1,24(sp)
 2ca:	e84a                	sd	s2,16(sp)
 2cc:	e44e                	sd	s3,8(sp)
 2ce:	1800                	addi	s0,sp,48
 2d0:	84aa                	mv	s1,a0
 2d2:	8932                	mv	s2,a2
 2d4:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2d6:	09800513          	li	a0,152
 2da:	00001097          	auipc	ra,0x1
 2de:	876080e7          	jalr	-1930(ra) # b50 <malloc>
 2e2:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2e4:	478d                	li	a5,3
 2e6:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2e8:	609c                	ld	a5,0(s1)
 2ea:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 2ee:	609c                	ld	a5,0(s1)
 2f0:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 2f4:	6098                	ld	a4,0(s1)
 2f6:	00001797          	auipc	a5,0x1
 2fa:	d0a78793          	addi	a5,a5,-758 # 1000 <next_tid>
 2fe:	4394                	lw	a3,0(a5)
 300:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 304:	4398                	lw	a4,0(a5)
 306:	2705                	addiw	a4,a4,1
 308:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 30a:	6505                	lui	a0,0x1
 30c:	00001097          	auipc	ra,0x1
 310:	844080e7          	jalr	-1980(ra) # b50 <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 314:	6785                	lui	a5,0x1
 316:	00a78733          	add	a4,a5,a0
 31a:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 31e:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x2f0>
 320:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 322:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 326:	609c                	ld	a5,0(s1)
 328:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 32a:	609c                	ld	a5,0(s1)
 32c:	00000717          	auipc	a4,0x0
 330:	f6270713          	addi	a4,a4,-158 # 28e <thread_wrapper>
 334:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 336:	00001717          	auipc	a4,0x1
 33a:	cea70713          	addi	a4,a4,-790 # 1020 <threads>
 33e:	4781                	li	a5,0
 340:	4641                	li	a2,16
        if (threads[i] == NULL) {
 342:	6314                	ld	a3,0(a4)
 344:	c29d                	beqz	a3,36a <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 346:	2785                	addiw	a5,a5,1
 348:	0721                	addi	a4,a4,8
 34a:	fec79ce3          	bne	a5,a2,342 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 34e:	6088                	ld	a0,0(s1)
 350:	00000097          	auipc	ra,0x0
 354:	77e080e7          	jalr	1918(ra) # ace <free>
        *thread = NULL;
 358:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 35c:	70a2                	ld	ra,40(sp)
 35e:	7402                	ld	s0,32(sp)
 360:	64e2                	ld	s1,24(sp)
 362:	6942                	ld	s2,16(sp)
 364:	69a2                	ld	s3,8(sp)
 366:	6145                	addi	sp,sp,48
 368:	8082                	ret
            threads[i] = *thread;
 36a:	6094                	ld	a3,0(s1)
 36c:	078e                	slli	a5,a5,0x3
 36e:	00001717          	auipc	a4,0x1
 372:	cb270713          	addi	a4,a4,-846 # 1020 <threads>
 376:	97ba                	add	a5,a5,a4
 378:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 37a:	b7cd                	j	35c <tcreate+0x9a>

000000000000037c <tyield>:
    return 0;
}


void tyield()
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e406                	sd	ra,8(sp)
 380:	e022                	sd	s0,0(sp)
 382:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 384:	00001797          	auipc	a5,0x1
 388:	c8c7b783          	ld	a5,-884(a5) # 1010 <current_thread>
 38c:	470d                	li	a4,3
 38e:	dfb8                	sw	a4,120(a5)
    tsched();
 390:	00000097          	auipc	ra,0x0
 394:	e7c080e7          	jalr	-388(ra) # 20c <tsched>
}
 398:	60a2                	ld	ra,8(sp)
 39a:	6402                	ld	s0,0(sp)
 39c:	0141                	addi	sp,sp,16
 39e:	8082                	ret

00000000000003a0 <tjoin>:
{
 3a0:	1101                	addi	sp,sp,-32
 3a2:	ec06                	sd	ra,24(sp)
 3a4:	e822                	sd	s0,16(sp)
 3a6:	e426                	sd	s1,8(sp)
 3a8:	e04a                	sd	s2,0(sp)
 3aa:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 3ac:	00001797          	auipc	a5,0x1
 3b0:	c7478793          	addi	a5,a5,-908 # 1020 <threads>
 3b4:	00001697          	auipc	a3,0x1
 3b8:	cec68693          	addi	a3,a3,-788 # 10a0 <base>
 3bc:	a021                	j	3c4 <tjoin+0x24>
 3be:	07a1                	addi	a5,a5,8
 3c0:	02d78b63          	beq	a5,a3,3f6 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 3c4:	6384                	ld	s1,0(a5)
 3c6:	dce5                	beqz	s1,3be <tjoin+0x1e>
 3c8:	0004c703          	lbu	a4,0(s1)
 3cc:	fea719e3          	bne	a4,a0,3be <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3d0:	5cb8                	lw	a4,120(s1)
 3d2:	4799                	li	a5,6
 3d4:	4919                	li	s2,6
 3d6:	02f70263          	beq	a4,a5,3fa <tjoin+0x5a>
        tyield();
 3da:	00000097          	auipc	ra,0x0
 3de:	fa2080e7          	jalr	-94(ra) # 37c <tyield>
    while (target_thread->state != EXITED) {
 3e2:	5cbc                	lw	a5,120(s1)
 3e4:	ff279be3          	bne	a5,s2,3da <tjoin+0x3a>
    return 0;
 3e8:	4501                	li	a0,0
}
 3ea:	60e2                	ld	ra,24(sp)
 3ec:	6442                	ld	s0,16(sp)
 3ee:	64a2                	ld	s1,8(sp)
 3f0:	6902                	ld	s2,0(sp)
 3f2:	6105                	addi	sp,sp,32
 3f4:	8082                	ret
        return -1;
 3f6:	557d                	li	a0,-1
 3f8:	bfcd                	j	3ea <tjoin+0x4a>
    return 0;
 3fa:	4501                	li	a0,0
 3fc:	b7fd                	j	3ea <tjoin+0x4a>

00000000000003fe <twhoami>:

uint8 twhoami()
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e422                	sd	s0,8(sp)
 402:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 404:	00001797          	auipc	a5,0x1
 408:	c0c7b783          	ld	a5,-1012(a5) # 1010 <current_thread>
 40c:	0007c503          	lbu	a0,0(a5)
 410:	6422                	ld	s0,8(sp)
 412:	0141                	addi	sp,sp,16
 414:	8082                	ret

0000000000000416 <tswtch>:
 416:	00153023          	sd	ra,0(a0)
 41a:	00253423          	sd	sp,8(a0)
 41e:	e900                	sd	s0,16(a0)
 420:	ed04                	sd	s1,24(a0)
 422:	03253023          	sd	s2,32(a0)
 426:	03353423          	sd	s3,40(a0)
 42a:	03453823          	sd	s4,48(a0)
 42e:	03553c23          	sd	s5,56(a0)
 432:	05653023          	sd	s6,64(a0)
 436:	05753423          	sd	s7,72(a0)
 43a:	05853823          	sd	s8,80(a0)
 43e:	05953c23          	sd	s9,88(a0)
 442:	07a53023          	sd	s10,96(a0)
 446:	07b53423          	sd	s11,104(a0)
 44a:	0005b083          	ld	ra,0(a1)
 44e:	0085b103          	ld	sp,8(a1)
 452:	6980                	ld	s0,16(a1)
 454:	6d84                	ld	s1,24(a1)
 456:	0205b903          	ld	s2,32(a1)
 45a:	0285b983          	ld	s3,40(a1)
 45e:	0305ba03          	ld	s4,48(a1)
 462:	0385ba83          	ld	s5,56(a1)
 466:	0405bb03          	ld	s6,64(a1)
 46a:	0485bb83          	ld	s7,72(a1)
 46e:	0505bc03          	ld	s8,80(a1)
 472:	0585bc83          	ld	s9,88(a1)
 476:	0605bd03          	ld	s10,96(a1)
 47a:	0685bd83          	ld	s11,104(a1)
 47e:	8082                	ret

0000000000000480 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 480:	1101                	addi	sp,sp,-32
 482:	ec06                	sd	ra,24(sp)
 484:	e822                	sd	s0,16(sp)
 486:	e426                	sd	s1,8(sp)
 488:	e04a                	sd	s2,0(sp)
 48a:	1000                	addi	s0,sp,32
 48c:	84aa                	mv	s1,a0
 48e:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 490:	00000097          	auipc	ra,0x0
 494:	d1e080e7          	jalr	-738(ra) # 1ae <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 498:	85ca                	mv	a1,s2
 49a:	8526                	mv	a0,s1
 49c:	00000097          	auipc	ra,0x0
 4a0:	b64080e7          	jalr	-1180(ra) # 0 <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 4a4:	00000097          	auipc	ra,0x0
 4a8:	274080e7          	jalr	628(ra) # 718 <exit>

00000000000004ac <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4ac:	1141                	addi	sp,sp,-16
 4ae:	e422                	sd	s0,8(sp)
 4b0:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4b2:	87aa                	mv	a5,a0
 4b4:	0585                	addi	a1,a1,1
 4b6:	0785                	addi	a5,a5,1
 4b8:	fff5c703          	lbu	a4,-1(a1)
 4bc:	fee78fa3          	sb	a4,-1(a5)
 4c0:	fb75                	bnez	a4,4b4 <strcpy+0x8>
        ;
    return os;
}
 4c2:	6422                	ld	s0,8(sp)
 4c4:	0141                	addi	sp,sp,16
 4c6:	8082                	ret

00000000000004c8 <strcmp>:

int strcmp(const char *p, const char *q)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e422                	sd	s0,8(sp)
 4cc:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4ce:	00054783          	lbu	a5,0(a0)
 4d2:	cb91                	beqz	a5,4e6 <strcmp+0x1e>
 4d4:	0005c703          	lbu	a4,0(a1)
 4d8:	00f71763          	bne	a4,a5,4e6 <strcmp+0x1e>
        p++, q++;
 4dc:	0505                	addi	a0,a0,1
 4de:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4e0:	00054783          	lbu	a5,0(a0)
 4e4:	fbe5                	bnez	a5,4d4 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4e6:	0005c503          	lbu	a0,0(a1)
}
 4ea:	40a7853b          	subw	a0,a5,a0
 4ee:	6422                	ld	s0,8(sp)
 4f0:	0141                	addi	sp,sp,16
 4f2:	8082                	ret

00000000000004f4 <strlen>:

uint strlen(const char *s)
{
 4f4:	1141                	addi	sp,sp,-16
 4f6:	e422                	sd	s0,8(sp)
 4f8:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4fa:	00054783          	lbu	a5,0(a0)
 4fe:	cf91                	beqz	a5,51a <strlen+0x26>
 500:	0505                	addi	a0,a0,1
 502:	87aa                	mv	a5,a0
 504:	86be                	mv	a3,a5
 506:	0785                	addi	a5,a5,1
 508:	fff7c703          	lbu	a4,-1(a5)
 50c:	ff65                	bnez	a4,504 <strlen+0x10>
 50e:	40a6853b          	subw	a0,a3,a0
 512:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 514:	6422                	ld	s0,8(sp)
 516:	0141                	addi	sp,sp,16
 518:	8082                	ret
    for (n = 0; s[n]; n++)
 51a:	4501                	li	a0,0
 51c:	bfe5                	j	514 <strlen+0x20>

000000000000051e <memset>:

void *
memset(void *dst, int c, uint n)
{
 51e:	1141                	addi	sp,sp,-16
 520:	e422                	sd	s0,8(sp)
 522:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 524:	ca19                	beqz	a2,53a <memset+0x1c>
 526:	87aa                	mv	a5,a0
 528:	1602                	slli	a2,a2,0x20
 52a:	9201                	srli	a2,a2,0x20
 52c:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 530:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 534:	0785                	addi	a5,a5,1
 536:	fee79de3          	bne	a5,a4,530 <memset+0x12>
    }
    return dst;
}
 53a:	6422                	ld	s0,8(sp)
 53c:	0141                	addi	sp,sp,16
 53e:	8082                	ret

0000000000000540 <strchr>:

char *
strchr(const char *s, char c)
{
 540:	1141                	addi	sp,sp,-16
 542:	e422                	sd	s0,8(sp)
 544:	0800                	addi	s0,sp,16
    for (; *s; s++)
 546:	00054783          	lbu	a5,0(a0)
 54a:	cb99                	beqz	a5,560 <strchr+0x20>
        if (*s == c)
 54c:	00f58763          	beq	a1,a5,55a <strchr+0x1a>
    for (; *s; s++)
 550:	0505                	addi	a0,a0,1
 552:	00054783          	lbu	a5,0(a0)
 556:	fbfd                	bnez	a5,54c <strchr+0xc>
            return (char *)s;
    return 0;
 558:	4501                	li	a0,0
}
 55a:	6422                	ld	s0,8(sp)
 55c:	0141                	addi	sp,sp,16
 55e:	8082                	ret
    return 0;
 560:	4501                	li	a0,0
 562:	bfe5                	j	55a <strchr+0x1a>

0000000000000564 <gets>:

char *
gets(char *buf, int max)
{
 564:	711d                	addi	sp,sp,-96
 566:	ec86                	sd	ra,88(sp)
 568:	e8a2                	sd	s0,80(sp)
 56a:	e4a6                	sd	s1,72(sp)
 56c:	e0ca                	sd	s2,64(sp)
 56e:	fc4e                	sd	s3,56(sp)
 570:	f852                	sd	s4,48(sp)
 572:	f456                	sd	s5,40(sp)
 574:	f05a                	sd	s6,32(sp)
 576:	ec5e                	sd	s7,24(sp)
 578:	1080                	addi	s0,sp,96
 57a:	8baa                	mv	s7,a0
 57c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 57e:	892a                	mv	s2,a0
 580:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 582:	4aa9                	li	s5,10
 584:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 586:	89a6                	mv	s3,s1
 588:	2485                	addiw	s1,s1,1
 58a:	0344d863          	bge	s1,s4,5ba <gets+0x56>
        cc = read(0, &c, 1);
 58e:	4605                	li	a2,1
 590:	faf40593          	addi	a1,s0,-81
 594:	4501                	li	a0,0
 596:	00000097          	auipc	ra,0x0
 59a:	19a080e7          	jalr	410(ra) # 730 <read>
        if (cc < 1)
 59e:	00a05e63          	blez	a0,5ba <gets+0x56>
        buf[i++] = c;
 5a2:	faf44783          	lbu	a5,-81(s0)
 5a6:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5aa:	01578763          	beq	a5,s5,5b8 <gets+0x54>
 5ae:	0905                	addi	s2,s2,1
 5b0:	fd679be3          	bne	a5,s6,586 <gets+0x22>
    for (i = 0; i + 1 < max;)
 5b4:	89a6                	mv	s3,s1
 5b6:	a011                	j	5ba <gets+0x56>
 5b8:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5ba:	99de                	add	s3,s3,s7
 5bc:	00098023          	sb	zero,0(s3)
    return buf;
}
 5c0:	855e                	mv	a0,s7
 5c2:	60e6                	ld	ra,88(sp)
 5c4:	6446                	ld	s0,80(sp)
 5c6:	64a6                	ld	s1,72(sp)
 5c8:	6906                	ld	s2,64(sp)
 5ca:	79e2                	ld	s3,56(sp)
 5cc:	7a42                	ld	s4,48(sp)
 5ce:	7aa2                	ld	s5,40(sp)
 5d0:	7b02                	ld	s6,32(sp)
 5d2:	6be2                	ld	s7,24(sp)
 5d4:	6125                	addi	sp,sp,96
 5d6:	8082                	ret

00000000000005d8 <stat>:

int stat(const char *n, struct stat *st)
{
 5d8:	1101                	addi	sp,sp,-32
 5da:	ec06                	sd	ra,24(sp)
 5dc:	e822                	sd	s0,16(sp)
 5de:	e426                	sd	s1,8(sp)
 5e0:	e04a                	sd	s2,0(sp)
 5e2:	1000                	addi	s0,sp,32
 5e4:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5e6:	4581                	li	a1,0
 5e8:	00000097          	auipc	ra,0x0
 5ec:	170080e7          	jalr	368(ra) # 758 <open>
    if (fd < 0)
 5f0:	02054563          	bltz	a0,61a <stat+0x42>
 5f4:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5f6:	85ca                	mv	a1,s2
 5f8:	00000097          	auipc	ra,0x0
 5fc:	178080e7          	jalr	376(ra) # 770 <fstat>
 600:	892a                	mv	s2,a0
    close(fd);
 602:	8526                	mv	a0,s1
 604:	00000097          	auipc	ra,0x0
 608:	13c080e7          	jalr	316(ra) # 740 <close>
    return r;
}
 60c:	854a                	mv	a0,s2
 60e:	60e2                	ld	ra,24(sp)
 610:	6442                	ld	s0,16(sp)
 612:	64a2                	ld	s1,8(sp)
 614:	6902                	ld	s2,0(sp)
 616:	6105                	addi	sp,sp,32
 618:	8082                	ret
        return -1;
 61a:	597d                	li	s2,-1
 61c:	bfc5                	j	60c <stat+0x34>

000000000000061e <atoi>:

int atoi(const char *s)
{
 61e:	1141                	addi	sp,sp,-16
 620:	e422                	sd	s0,8(sp)
 622:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 624:	00054683          	lbu	a3,0(a0)
 628:	fd06879b          	addiw	a5,a3,-48
 62c:	0ff7f793          	zext.b	a5,a5
 630:	4625                	li	a2,9
 632:	02f66863          	bltu	a2,a5,662 <atoi+0x44>
 636:	872a                	mv	a4,a0
    n = 0;
 638:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 63a:	0705                	addi	a4,a4,1
 63c:	0025179b          	slliw	a5,a0,0x2
 640:	9fa9                	addw	a5,a5,a0
 642:	0017979b          	slliw	a5,a5,0x1
 646:	9fb5                	addw	a5,a5,a3
 648:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 64c:	00074683          	lbu	a3,0(a4)
 650:	fd06879b          	addiw	a5,a3,-48
 654:	0ff7f793          	zext.b	a5,a5
 658:	fef671e3          	bgeu	a2,a5,63a <atoi+0x1c>
    return n;
}
 65c:	6422                	ld	s0,8(sp)
 65e:	0141                	addi	sp,sp,16
 660:	8082                	ret
    n = 0;
 662:	4501                	li	a0,0
 664:	bfe5                	j	65c <atoi+0x3e>

0000000000000666 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 666:	1141                	addi	sp,sp,-16
 668:	e422                	sd	s0,8(sp)
 66a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 66c:	02b57463          	bgeu	a0,a1,694 <memmove+0x2e>
    {
        while (n-- > 0)
 670:	00c05f63          	blez	a2,68e <memmove+0x28>
 674:	1602                	slli	a2,a2,0x20
 676:	9201                	srli	a2,a2,0x20
 678:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 67c:	872a                	mv	a4,a0
            *dst++ = *src++;
 67e:	0585                	addi	a1,a1,1
 680:	0705                	addi	a4,a4,1
 682:	fff5c683          	lbu	a3,-1(a1)
 686:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 68a:	fee79ae3          	bne	a5,a4,67e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 68e:	6422                	ld	s0,8(sp)
 690:	0141                	addi	sp,sp,16
 692:	8082                	ret
        dst += n;
 694:	00c50733          	add	a4,a0,a2
        src += n;
 698:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 69a:	fec05ae3          	blez	a2,68e <memmove+0x28>
 69e:	fff6079b          	addiw	a5,a2,-1
 6a2:	1782                	slli	a5,a5,0x20
 6a4:	9381                	srli	a5,a5,0x20
 6a6:	fff7c793          	not	a5,a5
 6aa:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6ac:	15fd                	addi	a1,a1,-1
 6ae:	177d                	addi	a4,a4,-1
 6b0:	0005c683          	lbu	a3,0(a1)
 6b4:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6b8:	fee79ae3          	bne	a5,a4,6ac <memmove+0x46>
 6bc:	bfc9                	j	68e <memmove+0x28>

00000000000006be <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6be:	1141                	addi	sp,sp,-16
 6c0:	e422                	sd	s0,8(sp)
 6c2:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6c4:	ca05                	beqz	a2,6f4 <memcmp+0x36>
 6c6:	fff6069b          	addiw	a3,a2,-1
 6ca:	1682                	slli	a3,a3,0x20
 6cc:	9281                	srli	a3,a3,0x20
 6ce:	0685                	addi	a3,a3,1
 6d0:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6d2:	00054783          	lbu	a5,0(a0)
 6d6:	0005c703          	lbu	a4,0(a1)
 6da:	00e79863          	bne	a5,a4,6ea <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6de:	0505                	addi	a0,a0,1
        p2++;
 6e0:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6e2:	fed518e3          	bne	a0,a3,6d2 <memcmp+0x14>
    }
    return 0;
 6e6:	4501                	li	a0,0
 6e8:	a019                	j	6ee <memcmp+0x30>
            return *p1 - *p2;
 6ea:	40e7853b          	subw	a0,a5,a4
}
 6ee:	6422                	ld	s0,8(sp)
 6f0:	0141                	addi	sp,sp,16
 6f2:	8082                	ret
    return 0;
 6f4:	4501                	li	a0,0
 6f6:	bfe5                	j	6ee <memcmp+0x30>

00000000000006f8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6f8:	1141                	addi	sp,sp,-16
 6fa:	e406                	sd	ra,8(sp)
 6fc:	e022                	sd	s0,0(sp)
 6fe:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 700:	00000097          	auipc	ra,0x0
 704:	f66080e7          	jalr	-154(ra) # 666 <memmove>
}
 708:	60a2                	ld	ra,8(sp)
 70a:	6402                	ld	s0,0(sp)
 70c:	0141                	addi	sp,sp,16
 70e:	8082                	ret

0000000000000710 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 710:	4885                	li	a7,1
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <exit>:
.global exit
exit:
 li a7, SYS_exit
 718:	4889                	li	a7,2
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <wait>:
.global wait
wait:
 li a7, SYS_wait
 720:	488d                	li	a7,3
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 728:	4891                	li	a7,4
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <read>:
.global read
read:
 li a7, SYS_read
 730:	4895                	li	a7,5
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <write>:
.global write
write:
 li a7, SYS_write
 738:	48c1                	li	a7,16
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <close>:
.global close
close:
 li a7, SYS_close
 740:	48d5                	li	a7,21
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <kill>:
.global kill
kill:
 li a7, SYS_kill
 748:	4899                	li	a7,6
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <exec>:
.global exec
exec:
 li a7, SYS_exec
 750:	489d                	li	a7,7
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <open>:
.global open
open:
 li a7, SYS_open
 758:	48bd                	li	a7,15
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 760:	48c5                	li	a7,17
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 768:	48c9                	li	a7,18
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 770:	48a1                	li	a7,8
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <link>:
.global link
link:
 li a7, SYS_link
 778:	48cd                	li	a7,19
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 780:	48d1                	li	a7,20
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 788:	48a5                	li	a7,9
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <dup>:
.global dup
dup:
 li a7, SYS_dup
 790:	48a9                	li	a7,10
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 798:	48ad                	li	a7,11
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7a0:	48b1                	li	a7,12
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7a8:	48b5                	li	a7,13
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7b0:	48b9                	li	a7,14
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <ps>:
.global ps
ps:
 li a7, SYS_ps
 7b8:	48d9                	li	a7,22
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7c0:	48dd                	li	a7,23
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7c8:	48e1                	li	a7,24
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7d0:	1101                	addi	sp,sp,-32
 7d2:	ec06                	sd	ra,24(sp)
 7d4:	e822                	sd	s0,16(sp)
 7d6:	1000                	addi	s0,sp,32
 7d8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7dc:	4605                	li	a2,1
 7de:	fef40593          	addi	a1,s0,-17
 7e2:	00000097          	auipc	ra,0x0
 7e6:	f56080e7          	jalr	-170(ra) # 738 <write>
}
 7ea:	60e2                	ld	ra,24(sp)
 7ec:	6442                	ld	s0,16(sp)
 7ee:	6105                	addi	sp,sp,32
 7f0:	8082                	ret

00000000000007f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7f2:	7139                	addi	sp,sp,-64
 7f4:	fc06                	sd	ra,56(sp)
 7f6:	f822                	sd	s0,48(sp)
 7f8:	f426                	sd	s1,40(sp)
 7fa:	f04a                	sd	s2,32(sp)
 7fc:	ec4e                	sd	s3,24(sp)
 7fe:	0080                	addi	s0,sp,64
 800:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 802:	c299                	beqz	a3,808 <printint+0x16>
 804:	0805c963          	bltz	a1,896 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 808:	2581                	sext.w	a1,a1
  neg = 0;
 80a:	4881                	li	a7,0
 80c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 810:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 812:	2601                	sext.w	a2,a2
 814:	00000517          	auipc	a0,0x0
 818:	4ec50513          	addi	a0,a0,1260 # d00 <digits>
 81c:	883a                	mv	a6,a4
 81e:	2705                	addiw	a4,a4,1
 820:	02c5f7bb          	remuw	a5,a1,a2
 824:	1782                	slli	a5,a5,0x20
 826:	9381                	srli	a5,a5,0x20
 828:	97aa                	add	a5,a5,a0
 82a:	0007c783          	lbu	a5,0(a5)
 82e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 832:	0005879b          	sext.w	a5,a1
 836:	02c5d5bb          	divuw	a1,a1,a2
 83a:	0685                	addi	a3,a3,1
 83c:	fec7f0e3          	bgeu	a5,a2,81c <printint+0x2a>
  if(neg)
 840:	00088c63          	beqz	a7,858 <printint+0x66>
    buf[i++] = '-';
 844:	fd070793          	addi	a5,a4,-48
 848:	00878733          	add	a4,a5,s0
 84c:	02d00793          	li	a5,45
 850:	fef70823          	sb	a5,-16(a4)
 854:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 858:	02e05863          	blez	a4,888 <printint+0x96>
 85c:	fc040793          	addi	a5,s0,-64
 860:	00e78933          	add	s2,a5,a4
 864:	fff78993          	addi	s3,a5,-1
 868:	99ba                	add	s3,s3,a4
 86a:	377d                	addiw	a4,a4,-1
 86c:	1702                	slli	a4,a4,0x20
 86e:	9301                	srli	a4,a4,0x20
 870:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 874:	fff94583          	lbu	a1,-1(s2)
 878:	8526                	mv	a0,s1
 87a:	00000097          	auipc	ra,0x0
 87e:	f56080e7          	jalr	-170(ra) # 7d0 <putc>
  while(--i >= 0)
 882:	197d                	addi	s2,s2,-1
 884:	ff3918e3          	bne	s2,s3,874 <printint+0x82>
}
 888:	70e2                	ld	ra,56(sp)
 88a:	7442                	ld	s0,48(sp)
 88c:	74a2                	ld	s1,40(sp)
 88e:	7902                	ld	s2,32(sp)
 890:	69e2                	ld	s3,24(sp)
 892:	6121                	addi	sp,sp,64
 894:	8082                	ret
    x = -xx;
 896:	40b005bb          	negw	a1,a1
    neg = 1;
 89a:	4885                	li	a7,1
    x = -xx;
 89c:	bf85                	j	80c <printint+0x1a>

000000000000089e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 89e:	715d                	addi	sp,sp,-80
 8a0:	e486                	sd	ra,72(sp)
 8a2:	e0a2                	sd	s0,64(sp)
 8a4:	fc26                	sd	s1,56(sp)
 8a6:	f84a                	sd	s2,48(sp)
 8a8:	f44e                	sd	s3,40(sp)
 8aa:	f052                	sd	s4,32(sp)
 8ac:	ec56                	sd	s5,24(sp)
 8ae:	e85a                	sd	s6,16(sp)
 8b0:	e45e                	sd	s7,8(sp)
 8b2:	e062                	sd	s8,0(sp)
 8b4:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8b6:	0005c903          	lbu	s2,0(a1)
 8ba:	18090c63          	beqz	s2,a52 <vprintf+0x1b4>
 8be:	8aaa                	mv	s5,a0
 8c0:	8bb2                	mv	s7,a2
 8c2:	00158493          	addi	s1,a1,1
  state = 0;
 8c6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8c8:	02500a13          	li	s4,37
 8cc:	4b55                	li	s6,21
 8ce:	a839                	j	8ec <vprintf+0x4e>
        putc(fd, c);
 8d0:	85ca                	mv	a1,s2
 8d2:	8556                	mv	a0,s5
 8d4:	00000097          	auipc	ra,0x0
 8d8:	efc080e7          	jalr	-260(ra) # 7d0 <putc>
 8dc:	a019                	j	8e2 <vprintf+0x44>
    } else if(state == '%'){
 8de:	01498d63          	beq	s3,s4,8f8 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8e2:	0485                	addi	s1,s1,1
 8e4:	fff4c903          	lbu	s2,-1(s1)
 8e8:	16090563          	beqz	s2,a52 <vprintf+0x1b4>
    if(state == 0){
 8ec:	fe0999e3          	bnez	s3,8de <vprintf+0x40>
      if(c == '%'){
 8f0:	ff4910e3          	bne	s2,s4,8d0 <vprintf+0x32>
        state = '%';
 8f4:	89d2                	mv	s3,s4
 8f6:	b7f5                	j	8e2 <vprintf+0x44>
      if(c == 'd'){
 8f8:	13490263          	beq	s2,s4,a1c <vprintf+0x17e>
 8fc:	f9d9079b          	addiw	a5,s2,-99
 900:	0ff7f793          	zext.b	a5,a5
 904:	12fb6563          	bltu	s6,a5,a2e <vprintf+0x190>
 908:	f9d9079b          	addiw	a5,s2,-99
 90c:	0ff7f713          	zext.b	a4,a5
 910:	10eb6f63          	bltu	s6,a4,a2e <vprintf+0x190>
 914:	00271793          	slli	a5,a4,0x2
 918:	00000717          	auipc	a4,0x0
 91c:	39070713          	addi	a4,a4,912 # ca8 <malloc+0x158>
 920:	97ba                	add	a5,a5,a4
 922:	439c                	lw	a5,0(a5)
 924:	97ba                	add	a5,a5,a4
 926:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 928:	008b8913          	addi	s2,s7,8
 92c:	4685                	li	a3,1
 92e:	4629                	li	a2,10
 930:	000ba583          	lw	a1,0(s7)
 934:	8556                	mv	a0,s5
 936:	00000097          	auipc	ra,0x0
 93a:	ebc080e7          	jalr	-324(ra) # 7f2 <printint>
 93e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 940:	4981                	li	s3,0
 942:	b745                	j	8e2 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 944:	008b8913          	addi	s2,s7,8
 948:	4681                	li	a3,0
 94a:	4629                	li	a2,10
 94c:	000ba583          	lw	a1,0(s7)
 950:	8556                	mv	a0,s5
 952:	00000097          	auipc	ra,0x0
 956:	ea0080e7          	jalr	-352(ra) # 7f2 <printint>
 95a:	8bca                	mv	s7,s2
      state = 0;
 95c:	4981                	li	s3,0
 95e:	b751                	j	8e2 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 960:	008b8913          	addi	s2,s7,8
 964:	4681                	li	a3,0
 966:	4641                	li	a2,16
 968:	000ba583          	lw	a1,0(s7)
 96c:	8556                	mv	a0,s5
 96e:	00000097          	auipc	ra,0x0
 972:	e84080e7          	jalr	-380(ra) # 7f2 <printint>
 976:	8bca                	mv	s7,s2
      state = 0;
 978:	4981                	li	s3,0
 97a:	b7a5                	j	8e2 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 97c:	008b8c13          	addi	s8,s7,8
 980:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 984:	03000593          	li	a1,48
 988:	8556                	mv	a0,s5
 98a:	00000097          	auipc	ra,0x0
 98e:	e46080e7          	jalr	-442(ra) # 7d0 <putc>
  putc(fd, 'x');
 992:	07800593          	li	a1,120
 996:	8556                	mv	a0,s5
 998:	00000097          	auipc	ra,0x0
 99c:	e38080e7          	jalr	-456(ra) # 7d0 <putc>
 9a0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9a2:	00000b97          	auipc	s7,0x0
 9a6:	35eb8b93          	addi	s7,s7,862 # d00 <digits>
 9aa:	03c9d793          	srli	a5,s3,0x3c
 9ae:	97de                	add	a5,a5,s7
 9b0:	0007c583          	lbu	a1,0(a5)
 9b4:	8556                	mv	a0,s5
 9b6:	00000097          	auipc	ra,0x0
 9ba:	e1a080e7          	jalr	-486(ra) # 7d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9be:	0992                	slli	s3,s3,0x4
 9c0:	397d                	addiw	s2,s2,-1
 9c2:	fe0914e3          	bnez	s2,9aa <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9c6:	8be2                	mv	s7,s8
      state = 0;
 9c8:	4981                	li	s3,0
 9ca:	bf21                	j	8e2 <vprintf+0x44>
        s = va_arg(ap, char*);
 9cc:	008b8993          	addi	s3,s7,8
 9d0:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9d4:	02090163          	beqz	s2,9f6 <vprintf+0x158>
        while(*s != 0){
 9d8:	00094583          	lbu	a1,0(s2)
 9dc:	c9a5                	beqz	a1,a4c <vprintf+0x1ae>
          putc(fd, *s);
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	df0080e7          	jalr	-528(ra) # 7d0 <putc>
          s++;
 9e8:	0905                	addi	s2,s2,1
        while(*s != 0){
 9ea:	00094583          	lbu	a1,0(s2)
 9ee:	f9e5                	bnez	a1,9de <vprintf+0x140>
        s = va_arg(ap, char*);
 9f0:	8bce                	mv	s7,s3
      state = 0;
 9f2:	4981                	li	s3,0
 9f4:	b5fd                	j	8e2 <vprintf+0x44>
          s = "(null)";
 9f6:	00000917          	auipc	s2,0x0
 9fa:	2aa90913          	addi	s2,s2,682 # ca0 <malloc+0x150>
        while(*s != 0){
 9fe:	02800593          	li	a1,40
 a02:	bff1                	j	9de <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a04:	008b8913          	addi	s2,s7,8
 a08:	000bc583          	lbu	a1,0(s7)
 a0c:	8556                	mv	a0,s5
 a0e:	00000097          	auipc	ra,0x0
 a12:	dc2080e7          	jalr	-574(ra) # 7d0 <putc>
 a16:	8bca                	mv	s7,s2
      state = 0;
 a18:	4981                	li	s3,0
 a1a:	b5e1                	j	8e2 <vprintf+0x44>
        putc(fd, c);
 a1c:	02500593          	li	a1,37
 a20:	8556                	mv	a0,s5
 a22:	00000097          	auipc	ra,0x0
 a26:	dae080e7          	jalr	-594(ra) # 7d0 <putc>
      state = 0;
 a2a:	4981                	li	s3,0
 a2c:	bd5d                	j	8e2 <vprintf+0x44>
        putc(fd, '%');
 a2e:	02500593          	li	a1,37
 a32:	8556                	mv	a0,s5
 a34:	00000097          	auipc	ra,0x0
 a38:	d9c080e7          	jalr	-612(ra) # 7d0 <putc>
        putc(fd, c);
 a3c:	85ca                	mv	a1,s2
 a3e:	8556                	mv	a0,s5
 a40:	00000097          	auipc	ra,0x0
 a44:	d90080e7          	jalr	-624(ra) # 7d0 <putc>
      state = 0;
 a48:	4981                	li	s3,0
 a4a:	bd61                	j	8e2 <vprintf+0x44>
        s = va_arg(ap, char*);
 a4c:	8bce                	mv	s7,s3
      state = 0;
 a4e:	4981                	li	s3,0
 a50:	bd49                	j	8e2 <vprintf+0x44>
    }
  }
}
 a52:	60a6                	ld	ra,72(sp)
 a54:	6406                	ld	s0,64(sp)
 a56:	74e2                	ld	s1,56(sp)
 a58:	7942                	ld	s2,48(sp)
 a5a:	79a2                	ld	s3,40(sp)
 a5c:	7a02                	ld	s4,32(sp)
 a5e:	6ae2                	ld	s5,24(sp)
 a60:	6b42                	ld	s6,16(sp)
 a62:	6ba2                	ld	s7,8(sp)
 a64:	6c02                	ld	s8,0(sp)
 a66:	6161                	addi	sp,sp,80
 a68:	8082                	ret

0000000000000a6a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a6a:	715d                	addi	sp,sp,-80
 a6c:	ec06                	sd	ra,24(sp)
 a6e:	e822                	sd	s0,16(sp)
 a70:	1000                	addi	s0,sp,32
 a72:	e010                	sd	a2,0(s0)
 a74:	e414                	sd	a3,8(s0)
 a76:	e818                	sd	a4,16(s0)
 a78:	ec1c                	sd	a5,24(s0)
 a7a:	03043023          	sd	a6,32(s0)
 a7e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a82:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a86:	8622                	mv	a2,s0
 a88:	00000097          	auipc	ra,0x0
 a8c:	e16080e7          	jalr	-490(ra) # 89e <vprintf>
}
 a90:	60e2                	ld	ra,24(sp)
 a92:	6442                	ld	s0,16(sp)
 a94:	6161                	addi	sp,sp,80
 a96:	8082                	ret

0000000000000a98 <printf>:

void
printf(const char *fmt, ...)
{
 a98:	711d                	addi	sp,sp,-96
 a9a:	ec06                	sd	ra,24(sp)
 a9c:	e822                	sd	s0,16(sp)
 a9e:	1000                	addi	s0,sp,32
 aa0:	e40c                	sd	a1,8(s0)
 aa2:	e810                	sd	a2,16(s0)
 aa4:	ec14                	sd	a3,24(s0)
 aa6:	f018                	sd	a4,32(s0)
 aa8:	f41c                	sd	a5,40(s0)
 aaa:	03043823          	sd	a6,48(s0)
 aae:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ab2:	00840613          	addi	a2,s0,8
 ab6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 aba:	85aa                	mv	a1,a0
 abc:	4505                	li	a0,1
 abe:	00000097          	auipc	ra,0x0
 ac2:	de0080e7          	jalr	-544(ra) # 89e <vprintf>
}
 ac6:	60e2                	ld	ra,24(sp)
 ac8:	6442                	ld	s0,16(sp)
 aca:	6125                	addi	sp,sp,96
 acc:	8082                	ret

0000000000000ace <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ace:	1141                	addi	sp,sp,-16
 ad0:	e422                	sd	s0,8(sp)
 ad2:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 ad4:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad8:	00000797          	auipc	a5,0x0
 adc:	5407b783          	ld	a5,1344(a5) # 1018 <freep>
 ae0:	a02d                	j	b0a <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ae2:	4618                	lw	a4,8(a2)
 ae4:	9f2d                	addw	a4,a4,a1
 ae6:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 aea:	6398                	ld	a4,0(a5)
 aec:	6310                	ld	a2,0(a4)
 aee:	a83d                	j	b2c <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 af0:	ff852703          	lw	a4,-8(a0)
 af4:	9f31                	addw	a4,a4,a2
 af6:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 af8:	ff053683          	ld	a3,-16(a0)
 afc:	a091                	j	b40 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afe:	6398                	ld	a4,0(a5)
 b00:	00e7e463          	bltu	a5,a4,b08 <free+0x3a>
 b04:	00e6ea63          	bltu	a3,a4,b18 <free+0x4a>
{
 b08:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b0a:	fed7fae3          	bgeu	a5,a3,afe <free+0x30>
 b0e:	6398                	ld	a4,0(a5)
 b10:	00e6e463          	bltu	a3,a4,b18 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b14:	fee7eae3          	bltu	a5,a4,b08 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b18:	ff852583          	lw	a1,-8(a0)
 b1c:	6390                	ld	a2,0(a5)
 b1e:	02059813          	slli	a6,a1,0x20
 b22:	01c85713          	srli	a4,a6,0x1c
 b26:	9736                	add	a4,a4,a3
 b28:	fae60de3          	beq	a2,a4,ae2 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b2c:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b30:	4790                	lw	a2,8(a5)
 b32:	02061593          	slli	a1,a2,0x20
 b36:	01c5d713          	srli	a4,a1,0x1c
 b3a:	973e                	add	a4,a4,a5
 b3c:	fae68ae3          	beq	a3,a4,af0 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b40:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b42:	00000717          	auipc	a4,0x0
 b46:	4cf73b23          	sd	a5,1238(a4) # 1018 <freep>
}
 b4a:	6422                	ld	s0,8(sp)
 b4c:	0141                	addi	sp,sp,16
 b4e:	8082                	ret

0000000000000b50 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b50:	7139                	addi	sp,sp,-64
 b52:	fc06                	sd	ra,56(sp)
 b54:	f822                	sd	s0,48(sp)
 b56:	f426                	sd	s1,40(sp)
 b58:	f04a                	sd	s2,32(sp)
 b5a:	ec4e                	sd	s3,24(sp)
 b5c:	e852                	sd	s4,16(sp)
 b5e:	e456                	sd	s5,8(sp)
 b60:	e05a                	sd	s6,0(sp)
 b62:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b64:	02051493          	slli	s1,a0,0x20
 b68:	9081                	srli	s1,s1,0x20
 b6a:	04bd                	addi	s1,s1,15
 b6c:	8091                	srli	s1,s1,0x4
 b6e:	0014899b          	addiw	s3,s1,1
 b72:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b74:	00000517          	auipc	a0,0x0
 b78:	4a453503          	ld	a0,1188(a0) # 1018 <freep>
 b7c:	c515                	beqz	a0,ba8 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b7e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b80:	4798                	lw	a4,8(a5)
 b82:	02977f63          	bgeu	a4,s1,bc0 <malloc+0x70>
    if (nu < 4096)
 b86:	8a4e                	mv	s4,s3
 b88:	0009871b          	sext.w	a4,s3
 b8c:	6685                	lui	a3,0x1
 b8e:	00d77363          	bgeu	a4,a3,b94 <malloc+0x44>
 b92:	6a05                	lui	s4,0x1
 b94:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b98:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b9c:	00000917          	auipc	s2,0x0
 ba0:	47c90913          	addi	s2,s2,1148 # 1018 <freep>
    if (p == (char *)-1)
 ba4:	5afd                	li	s5,-1
 ba6:	a895                	j	c1a <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 ba8:	00000797          	auipc	a5,0x0
 bac:	4f878793          	addi	a5,a5,1272 # 10a0 <base>
 bb0:	00000717          	auipc	a4,0x0
 bb4:	46f73423          	sd	a5,1128(a4) # 1018 <freep>
 bb8:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bba:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bbe:	b7e1                	j	b86 <malloc+0x36>
            if (p->s.size == nunits)
 bc0:	02e48c63          	beq	s1,a4,bf8 <malloc+0xa8>
                p->s.size -= nunits;
 bc4:	4137073b          	subw	a4,a4,s3
 bc8:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bca:	02071693          	slli	a3,a4,0x20
 bce:	01c6d713          	srli	a4,a3,0x1c
 bd2:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bd4:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bd8:	00000717          	auipc	a4,0x0
 bdc:	44a73023          	sd	a0,1088(a4) # 1018 <freep>
            return (void *)(p + 1);
 be0:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 be4:	70e2                	ld	ra,56(sp)
 be6:	7442                	ld	s0,48(sp)
 be8:	74a2                	ld	s1,40(sp)
 bea:	7902                	ld	s2,32(sp)
 bec:	69e2                	ld	s3,24(sp)
 bee:	6a42                	ld	s4,16(sp)
 bf0:	6aa2                	ld	s5,8(sp)
 bf2:	6b02                	ld	s6,0(sp)
 bf4:	6121                	addi	sp,sp,64
 bf6:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bf8:	6398                	ld	a4,0(a5)
 bfa:	e118                	sd	a4,0(a0)
 bfc:	bff1                	j	bd8 <malloc+0x88>
    hp->s.size = nu;
 bfe:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c02:	0541                	addi	a0,a0,16
 c04:	00000097          	auipc	ra,0x0
 c08:	eca080e7          	jalr	-310(ra) # ace <free>
    return freep;
 c0c:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c10:	d971                	beqz	a0,be4 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c12:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c14:	4798                	lw	a4,8(a5)
 c16:	fa9775e3          	bgeu	a4,s1,bc0 <malloc+0x70>
        if (p == freep)
 c1a:	00093703          	ld	a4,0(s2)
 c1e:	853e                	mv	a0,a5
 c20:	fef719e3          	bne	a4,a5,c12 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c24:	8552                	mv	a0,s4
 c26:	00000097          	auipc	ra,0x0
 c2a:	b7a080e7          	jalr	-1158(ra) # 7a0 <sbrk>
    if (p == (char *)-1)
 c2e:	fd5518e3          	bne	a0,s5,bfe <malloc+0xae>
                return 0;
 c32:	4501                	li	a0,0
 c34:	bf45                	j	be4 <malloc+0x94>
