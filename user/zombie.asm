
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
   c:	660080e7          	jalr	1632(ra) # 668 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	65a080e7          	jalr	1626(ra) # 670 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	6e0080e7          	jalr	1760(ra) # 700 <sleep>
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
  5e:	2c4080e7          	jalr	708(ra) # 31e <twhoami>
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
  aa:	aea50513          	addi	a0,a0,-1302 # b90 <malloc+0xe8>
  ae:	00001097          	auipc	ra,0x1
  b2:	942080e7          	jalr	-1726(ra) # 9f0 <printf>
        exit(-1);
  b6:	557d                	li	a0,-1
  b8:	00000097          	auipc	ra,0x0
  bc:	5b8080e7          	jalr	1464(ra) # 670 <exit>
    {
        // give up the cpu for other threads
        tyield();
  c0:	00000097          	auipc	ra,0x0
  c4:	1dc080e7          	jalr	476(ra) # 29c <tyield>
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
  de:	244080e7          	jalr	580(ra) # 31e <twhoami>
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
 122:	17e080e7          	jalr	382(ra) # 29c <tyield>
}
 126:	60e2                	ld	ra,24(sp)
 128:	6442                	ld	s0,16(sp)
 12a:	64a2                	ld	s1,8(sp)
 12c:	6105                	addi	sp,sp,32
 12e:	8082                	ret
        printf("releasing lock we are not holding");
 130:	00001517          	auipc	a0,0x1
 134:	a8850513          	addi	a0,a0,-1400 # bb8 <malloc+0x110>
 138:	00001097          	auipc	ra,0x1
 13c:	8b8080e7          	jalr	-1864(ra) # 9f0 <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	52e080e7          	jalr	1326(ra) # 670 <exit>

000000000000014a <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 14a:	00001517          	auipc	a0,0x1
 14e:	ec653503          	ld	a0,-314(a0) # 1010 <current_thread>
 152:	00001717          	auipc	a4,0x1
 156:	ece70713          	addi	a4,a4,-306 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 15a:	4781                	li	a5,0
 15c:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 15e:	6314                	ld	a3,0(a4)
 160:	00a68763          	beq	a3,a0,16e <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 164:	2785                	addiw	a5,a5,1
 166:	0721                	addi	a4,a4,8
 168:	fec79be3          	bne	a5,a2,15e <tsched+0x14>
    int current_index = 0;
 16c:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 16e:	0017869b          	addiw	a3,a5,1
 172:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 176:	00001817          	auipc	a6,0x1
 17a:	eaa80813          	addi	a6,a6,-342 # 1020 <threads>
 17e:	488d                	li	a7,3
 180:	a021                	j	188 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 182:	2685                	addiw	a3,a3,1
 184:	04c68363          	beq	a3,a2,1ca <tsched+0x80>
        int next_index = (current_index + i) % 16;
 188:	41f6d71b          	sraiw	a4,a3,0x1f
 18c:	01c7571b          	srliw	a4,a4,0x1c
 190:	00d707bb          	addw	a5,a4,a3
 194:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 196:	9f99                	subw	a5,a5,a4
 198:	078e                	slli	a5,a5,0x3
 19a:	97c2                	add	a5,a5,a6
 19c:	638c                	ld	a1,0(a5)
 19e:	d1f5                	beqz	a1,182 <tsched+0x38>
 1a0:	5dbc                	lw	a5,120(a1)
 1a2:	ff1790e3          	bne	a5,a7,182 <tsched+0x38>
{
 1a6:	1141                	addi	sp,sp,-16
 1a8:	e406                	sd	ra,8(sp)
 1aa:	e022                	sd	s0,0(sp)
 1ac:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1ae:	00001797          	auipc	a5,0x1
 1b2:	e6b7b123          	sd	a1,-414(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1b6:	05a1                	addi	a1,a1,8
 1b8:	0521                	addi	a0,a0,8
 1ba:	00000097          	auipc	ra,0x0
 1be:	17c080e7          	jalr	380(ra) # 336 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 1c2:	60a2                	ld	ra,8(sp)
 1c4:	6402                	ld	s0,0(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret
 1ca:	8082                	ret

00000000000001cc <thread_wrapper>:
{
 1cc:	1101                	addi	sp,sp,-32
 1ce:	ec06                	sd	ra,24(sp)
 1d0:	e822                	sd	s0,16(sp)
 1d2:	e426                	sd	s1,8(sp)
 1d4:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 1d6:	00001497          	auipc	s1,0x1
 1da:	e3a48493          	addi	s1,s1,-454 # 1010 <current_thread>
 1de:	609c                	ld	a5,0(s1)
 1e0:	67d8                	ld	a4,136(a5)
 1e2:	63c8                	ld	a0,128(a5)
 1e4:	9702                	jalr	a4
    current_thread->state = EXITED;
 1e6:	609c                	ld	a5,0(s1)
 1e8:	4719                	li	a4,6
 1ea:	dfb8                	sw	a4,120(a5)
    tsched();
 1ec:	00000097          	auipc	ra,0x0
 1f0:	f5e080e7          	jalr	-162(ra) # 14a <tsched>
}
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	64a2                	ld	s1,8(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret

00000000000001fe <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 1fe:	7179                	addi	sp,sp,-48
 200:	f406                	sd	ra,40(sp)
 202:	f022                	sd	s0,32(sp)
 204:	ec26                	sd	s1,24(sp)
 206:	e84a                	sd	s2,16(sp)
 208:	e44e                	sd	s3,8(sp)
 20a:	1800                	addi	s0,sp,48
 20c:	84aa                	mv	s1,a0
 20e:	89b2                	mv	s3,a2
 210:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 212:	09800513          	li	a0,152
 216:	00001097          	auipc	ra,0x1
 21a:	892080e7          	jalr	-1902(ra) # aa8 <malloc>
 21e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 220:	478d                	li	a5,3
 222:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 224:	609c                	ld	a5,0(s1)
 226:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 22a:	609c                	ld	a5,0(s1)
 22c:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 230:	6098                	ld	a4,0(s1)
 232:	00001797          	auipc	a5,0x1
 236:	dce78793          	addi	a5,a5,-562 # 1000 <next_tid>
 23a:	4394                	lw	a3,0(a5)
 23c:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 240:	4398                	lw	a4,0(a5)
 242:	2705                	addiw	a4,a4,1
 244:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 246:	6505                	lui	a0,0x1
 248:	00001097          	auipc	ra,0x1
 24c:	860080e7          	jalr	-1952(ra) # aa8 <malloc>
 250:	609c                	ld	a5,0(s1)
 252:	6705                	lui	a4,0x1
 254:	953a                	add	a0,a0,a4
 256:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 258:	609c                	ld	a5,0(s1)
 25a:	00000717          	auipc	a4,0x0
 25e:	f7270713          	addi	a4,a4,-142 # 1cc <thread_wrapper>
 262:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 264:	00001717          	auipc	a4,0x1
 268:	dbc70713          	addi	a4,a4,-580 # 1020 <threads>
 26c:	4781                	li	a5,0
 26e:	4641                	li	a2,16
        if (threads[i] == NULL) {
 270:	6314                	ld	a3,0(a4)
 272:	ce81                	beqz	a3,28a <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 274:	2785                	addiw	a5,a5,1
 276:	0721                	addi	a4,a4,8
 278:	fec79ce3          	bne	a5,a2,270 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 27c:	70a2                	ld	ra,40(sp)
 27e:	7402                	ld	s0,32(sp)
 280:	64e2                	ld	s1,24(sp)
 282:	6942                	ld	s2,16(sp)
 284:	69a2                	ld	s3,8(sp)
 286:	6145                	addi	sp,sp,48
 288:	8082                	ret
            threads[i] = *thread;
 28a:	6094                	ld	a3,0(s1)
 28c:	078e                	slli	a5,a5,0x3
 28e:	00001717          	auipc	a4,0x1
 292:	d9270713          	addi	a4,a4,-622 # 1020 <threads>
 296:	97ba                	add	a5,a5,a4
 298:	e394                	sd	a3,0(a5)
            break;
 29a:	b7cd                	j	27c <tcreate+0x7e>

000000000000029c <tyield>:
    return 0;
}


void tyield()
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 2a4:	00001797          	auipc	a5,0x1
 2a8:	d6c7b783          	ld	a5,-660(a5) # 1010 <current_thread>
 2ac:	470d                	li	a4,3
 2ae:	dfb8                	sw	a4,120(a5)
    tsched();
 2b0:	00000097          	auipc	ra,0x0
 2b4:	e9a080e7          	jalr	-358(ra) # 14a <tsched>
}
 2b8:	60a2                	ld	ra,8(sp)
 2ba:	6402                	ld	s0,0(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret

00000000000002c0 <tjoin>:
{
 2c0:	1101                	addi	sp,sp,-32
 2c2:	ec06                	sd	ra,24(sp)
 2c4:	e822                	sd	s0,16(sp)
 2c6:	e426                	sd	s1,8(sp)
 2c8:	e04a                	sd	s2,0(sp)
 2ca:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 2cc:	00001797          	auipc	a5,0x1
 2d0:	d5478793          	addi	a5,a5,-684 # 1020 <threads>
 2d4:	00001697          	auipc	a3,0x1
 2d8:	dcc68693          	addi	a3,a3,-564 # 10a0 <base>
 2dc:	a021                	j	2e4 <tjoin+0x24>
 2de:	07a1                	addi	a5,a5,8
 2e0:	02d78b63          	beq	a5,a3,316 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 2e4:	6384                	ld	s1,0(a5)
 2e6:	dce5                	beqz	s1,2de <tjoin+0x1e>
 2e8:	0004c703          	lbu	a4,0(s1)
 2ec:	fea719e3          	bne	a4,a0,2de <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 2f0:	5cb8                	lw	a4,120(s1)
 2f2:	4799                	li	a5,6
 2f4:	4919                	li	s2,6
 2f6:	02f70263          	beq	a4,a5,31a <tjoin+0x5a>
        tyield();
 2fa:	00000097          	auipc	ra,0x0
 2fe:	fa2080e7          	jalr	-94(ra) # 29c <tyield>
    while (target_thread->state != EXITED) {
 302:	5cbc                	lw	a5,120(s1)
 304:	ff279be3          	bne	a5,s2,2fa <tjoin+0x3a>
    return 0;
 308:	4501                	li	a0,0
}
 30a:	60e2                	ld	ra,24(sp)
 30c:	6442                	ld	s0,16(sp)
 30e:	64a2                	ld	s1,8(sp)
 310:	6902                	ld	s2,0(sp)
 312:	6105                	addi	sp,sp,32
 314:	8082                	ret
        return -1;
 316:	557d                	li	a0,-1
 318:	bfcd                	j	30a <tjoin+0x4a>
    return 0;
 31a:	4501                	li	a0,0
 31c:	b7fd                	j	30a <tjoin+0x4a>

000000000000031e <twhoami>:

uint8 twhoami()
{
 31e:	1141                	addi	sp,sp,-16
 320:	e422                	sd	s0,8(sp)
 322:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 324:	00001797          	auipc	a5,0x1
 328:	cec7b783          	ld	a5,-788(a5) # 1010 <current_thread>
 32c:	0007c503          	lbu	a0,0(a5)
 330:	6422                	ld	s0,8(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret

0000000000000336 <tswtch>:
 336:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 33a:	00253423          	sd	sp,8(a0)
 33e:	e900                	sd	s0,16(a0)
 340:	ed04                	sd	s1,24(a0)
 342:	03253023          	sd	s2,32(a0)
 346:	03353423          	sd	s3,40(a0)
 34a:	03453823          	sd	s4,48(a0)
 34e:	03553c23          	sd	s5,56(a0)
 352:	05653023          	sd	s6,64(a0)
 356:	05753423          	sd	s7,72(a0)
 35a:	05853823          	sd	s8,80(a0)
 35e:	05953c23          	sd	s9,88(a0)
 362:	07a53023          	sd	s10,96(a0)
 366:	07b53423          	sd	s11,104(a0)
 36a:	0005b083          	ld	ra,0(a1)
 36e:	0085b103          	ld	sp,8(a1)
 372:	6980                	ld	s0,16(a1)
 374:	6d84                	ld	s1,24(a1)
 376:	0205b903          	ld	s2,32(a1)
 37a:	0285b983          	ld	s3,40(a1)
 37e:	0305ba03          	ld	s4,48(a1)
 382:	0385ba83          	ld	s5,56(a1)
 386:	0405bb03          	ld	s6,64(a1)
 38a:	0485bb83          	ld	s7,72(a1)
 38e:	0505bc03          	ld	s8,80(a1)
 392:	0585bc83          	ld	s9,88(a1)
 396:	0605bd03          	ld	s10,96(a1)
 39a:	0685bd83          	ld	s11,104(a1)
 39e:	8082                	ret

00000000000003a0 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3a0:	1101                	addi	sp,sp,-32
 3a2:	ec06                	sd	ra,24(sp)
 3a4:	e822                	sd	s0,16(sp)
 3a6:	e426                	sd	s1,8(sp)
 3a8:	e04a                	sd	s2,0(sp)
 3aa:	1000                	addi	s0,sp,32
 3ac:	84aa                	mv	s1,a0
 3ae:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3b0:	09800513          	li	a0,152
 3b4:	00000097          	auipc	ra,0x0
 3b8:	6f4080e7          	jalr	1780(ra) # aa8 <malloc>

    main_thread->tid = 1;
 3bc:	4785                	li	a5,1
 3be:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 3c2:	4791                	li	a5,4
 3c4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3c6:	00001797          	auipc	a5,0x1
 3ca:	c4a7b523          	sd	a0,-950(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3ce:	00001797          	auipc	a5,0x1
 3d2:	c5278793          	addi	a5,a5,-942 # 1020 <threads>
 3d6:	00001717          	auipc	a4,0x1
 3da:	cca70713          	addi	a4,a4,-822 # 10a0 <base>
        threads[i] = NULL;
 3de:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 3e2:	07a1                	addi	a5,a5,8
 3e4:	fee79de3          	bne	a5,a4,3de <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 3e8:	00001797          	auipc	a5,0x1
 3ec:	c2a7bc23          	sd	a0,-968(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 3f0:	85ca                	mv	a1,s2
 3f2:	8526                	mv	a0,s1
 3f4:	00000097          	auipc	ra,0x0
 3f8:	c0c080e7          	jalr	-1012(ra) # 0 <main>
    //tsched();

    exit(res);
 3fc:	00000097          	auipc	ra,0x0
 400:	274080e7          	jalr	628(ra) # 670 <exit>

0000000000000404 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 404:	1141                	addi	sp,sp,-16
 406:	e422                	sd	s0,8(sp)
 408:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 40a:	87aa                	mv	a5,a0
 40c:	0585                	addi	a1,a1,1
 40e:	0785                	addi	a5,a5,1
 410:	fff5c703          	lbu	a4,-1(a1)
 414:	fee78fa3          	sb	a4,-1(a5)
 418:	fb75                	bnez	a4,40c <strcpy+0x8>
        ;
    return os;
}
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <strcmp>:

int strcmp(const char *p, const char *q)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 426:	00054783          	lbu	a5,0(a0)
 42a:	cb91                	beqz	a5,43e <strcmp+0x1e>
 42c:	0005c703          	lbu	a4,0(a1)
 430:	00f71763          	bne	a4,a5,43e <strcmp+0x1e>
        p++, q++;
 434:	0505                	addi	a0,a0,1
 436:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 438:	00054783          	lbu	a5,0(a0)
 43c:	fbe5                	bnez	a5,42c <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 43e:	0005c503          	lbu	a0,0(a1)
}
 442:	40a7853b          	subw	a0,a5,a0
 446:	6422                	ld	s0,8(sp)
 448:	0141                	addi	sp,sp,16
 44a:	8082                	ret

000000000000044c <strlen>:

uint strlen(const char *s)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e422                	sd	s0,8(sp)
 450:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 452:	00054783          	lbu	a5,0(a0)
 456:	cf91                	beqz	a5,472 <strlen+0x26>
 458:	0505                	addi	a0,a0,1
 45a:	87aa                	mv	a5,a0
 45c:	86be                	mv	a3,a5
 45e:	0785                	addi	a5,a5,1
 460:	fff7c703          	lbu	a4,-1(a5)
 464:	ff65                	bnez	a4,45c <strlen+0x10>
 466:	40a6853b          	subw	a0,a3,a0
 46a:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 46c:	6422                	ld	s0,8(sp)
 46e:	0141                	addi	sp,sp,16
 470:	8082                	ret
    for (n = 0; s[n]; n++)
 472:	4501                	li	a0,0
 474:	bfe5                	j	46c <strlen+0x20>

0000000000000476 <memset>:

void *
memset(void *dst, int c, uint n)
{
 476:	1141                	addi	sp,sp,-16
 478:	e422                	sd	s0,8(sp)
 47a:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 47c:	ca19                	beqz	a2,492 <memset+0x1c>
 47e:	87aa                	mv	a5,a0
 480:	1602                	slli	a2,a2,0x20
 482:	9201                	srli	a2,a2,0x20
 484:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 488:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 48c:	0785                	addi	a5,a5,1
 48e:	fee79de3          	bne	a5,a4,488 <memset+0x12>
    }
    return dst;
}
 492:	6422                	ld	s0,8(sp)
 494:	0141                	addi	sp,sp,16
 496:	8082                	ret

0000000000000498 <strchr>:

char *
strchr(const char *s, char c)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e422                	sd	s0,8(sp)
 49c:	0800                	addi	s0,sp,16
    for (; *s; s++)
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	cb99                	beqz	a5,4b8 <strchr+0x20>
        if (*s == c)
 4a4:	00f58763          	beq	a1,a5,4b2 <strchr+0x1a>
    for (; *s; s++)
 4a8:	0505                	addi	a0,a0,1
 4aa:	00054783          	lbu	a5,0(a0)
 4ae:	fbfd                	bnez	a5,4a4 <strchr+0xc>
            return (char *)s;
    return 0;
 4b0:	4501                	li	a0,0
}
 4b2:	6422                	ld	s0,8(sp)
 4b4:	0141                	addi	sp,sp,16
 4b6:	8082                	ret
    return 0;
 4b8:	4501                	li	a0,0
 4ba:	bfe5                	j	4b2 <strchr+0x1a>

00000000000004bc <gets>:

char *
gets(char *buf, int max)
{
 4bc:	711d                	addi	sp,sp,-96
 4be:	ec86                	sd	ra,88(sp)
 4c0:	e8a2                	sd	s0,80(sp)
 4c2:	e4a6                	sd	s1,72(sp)
 4c4:	e0ca                	sd	s2,64(sp)
 4c6:	fc4e                	sd	s3,56(sp)
 4c8:	f852                	sd	s4,48(sp)
 4ca:	f456                	sd	s5,40(sp)
 4cc:	f05a                	sd	s6,32(sp)
 4ce:	ec5e                	sd	s7,24(sp)
 4d0:	1080                	addi	s0,sp,96
 4d2:	8baa                	mv	s7,a0
 4d4:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 4d6:	892a                	mv	s2,a0
 4d8:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 4da:	4aa9                	li	s5,10
 4dc:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 4de:	89a6                	mv	s3,s1
 4e0:	2485                	addiw	s1,s1,1
 4e2:	0344d863          	bge	s1,s4,512 <gets+0x56>
        cc = read(0, &c, 1);
 4e6:	4605                	li	a2,1
 4e8:	faf40593          	addi	a1,s0,-81
 4ec:	4501                	li	a0,0
 4ee:	00000097          	auipc	ra,0x0
 4f2:	19a080e7          	jalr	410(ra) # 688 <read>
        if (cc < 1)
 4f6:	00a05e63          	blez	a0,512 <gets+0x56>
        buf[i++] = c;
 4fa:	faf44783          	lbu	a5,-81(s0)
 4fe:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 502:	01578763          	beq	a5,s5,510 <gets+0x54>
 506:	0905                	addi	s2,s2,1
 508:	fd679be3          	bne	a5,s6,4de <gets+0x22>
    for (i = 0; i + 1 < max;)
 50c:	89a6                	mv	s3,s1
 50e:	a011                	j	512 <gets+0x56>
 510:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 512:	99de                	add	s3,s3,s7
 514:	00098023          	sb	zero,0(s3)
    return buf;
}
 518:	855e                	mv	a0,s7
 51a:	60e6                	ld	ra,88(sp)
 51c:	6446                	ld	s0,80(sp)
 51e:	64a6                	ld	s1,72(sp)
 520:	6906                	ld	s2,64(sp)
 522:	79e2                	ld	s3,56(sp)
 524:	7a42                	ld	s4,48(sp)
 526:	7aa2                	ld	s5,40(sp)
 528:	7b02                	ld	s6,32(sp)
 52a:	6be2                	ld	s7,24(sp)
 52c:	6125                	addi	sp,sp,96
 52e:	8082                	ret

0000000000000530 <stat>:

int stat(const char *n, struct stat *st)
{
 530:	1101                	addi	sp,sp,-32
 532:	ec06                	sd	ra,24(sp)
 534:	e822                	sd	s0,16(sp)
 536:	e426                	sd	s1,8(sp)
 538:	e04a                	sd	s2,0(sp)
 53a:	1000                	addi	s0,sp,32
 53c:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 53e:	4581                	li	a1,0
 540:	00000097          	auipc	ra,0x0
 544:	170080e7          	jalr	368(ra) # 6b0 <open>
    if (fd < 0)
 548:	02054563          	bltz	a0,572 <stat+0x42>
 54c:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 54e:	85ca                	mv	a1,s2
 550:	00000097          	auipc	ra,0x0
 554:	178080e7          	jalr	376(ra) # 6c8 <fstat>
 558:	892a                	mv	s2,a0
    close(fd);
 55a:	8526                	mv	a0,s1
 55c:	00000097          	auipc	ra,0x0
 560:	13c080e7          	jalr	316(ra) # 698 <close>
    return r;
}
 564:	854a                	mv	a0,s2
 566:	60e2                	ld	ra,24(sp)
 568:	6442                	ld	s0,16(sp)
 56a:	64a2                	ld	s1,8(sp)
 56c:	6902                	ld	s2,0(sp)
 56e:	6105                	addi	sp,sp,32
 570:	8082                	ret
        return -1;
 572:	597d                	li	s2,-1
 574:	bfc5                	j	564 <stat+0x34>

0000000000000576 <atoi>:

int atoi(const char *s)
{
 576:	1141                	addi	sp,sp,-16
 578:	e422                	sd	s0,8(sp)
 57a:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 57c:	00054683          	lbu	a3,0(a0)
 580:	fd06879b          	addiw	a5,a3,-48
 584:	0ff7f793          	zext.b	a5,a5
 588:	4625                	li	a2,9
 58a:	02f66863          	bltu	a2,a5,5ba <atoi+0x44>
 58e:	872a                	mv	a4,a0
    n = 0;
 590:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 592:	0705                	addi	a4,a4,1
 594:	0025179b          	slliw	a5,a0,0x2
 598:	9fa9                	addw	a5,a5,a0
 59a:	0017979b          	slliw	a5,a5,0x1
 59e:	9fb5                	addw	a5,a5,a3
 5a0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5a4:	00074683          	lbu	a3,0(a4)
 5a8:	fd06879b          	addiw	a5,a3,-48
 5ac:	0ff7f793          	zext.b	a5,a5
 5b0:	fef671e3          	bgeu	a2,a5,592 <atoi+0x1c>
    return n;
}
 5b4:	6422                	ld	s0,8(sp)
 5b6:	0141                	addi	sp,sp,16
 5b8:	8082                	ret
    n = 0;
 5ba:	4501                	li	a0,0
 5bc:	bfe5                	j	5b4 <atoi+0x3e>

00000000000005be <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5be:	1141                	addi	sp,sp,-16
 5c0:	e422                	sd	s0,8(sp)
 5c2:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5c4:	02b57463          	bgeu	a0,a1,5ec <memmove+0x2e>
    {
        while (n-- > 0)
 5c8:	00c05f63          	blez	a2,5e6 <memmove+0x28>
 5cc:	1602                	slli	a2,a2,0x20
 5ce:	9201                	srli	a2,a2,0x20
 5d0:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 5d4:	872a                	mv	a4,a0
            *dst++ = *src++;
 5d6:	0585                	addi	a1,a1,1
 5d8:	0705                	addi	a4,a4,1
 5da:	fff5c683          	lbu	a3,-1(a1)
 5de:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 5e2:	fee79ae3          	bne	a5,a4,5d6 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 5e6:	6422                	ld	s0,8(sp)
 5e8:	0141                	addi	sp,sp,16
 5ea:	8082                	ret
        dst += n;
 5ec:	00c50733          	add	a4,a0,a2
        src += n;
 5f0:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 5f2:	fec05ae3          	blez	a2,5e6 <memmove+0x28>
 5f6:	fff6079b          	addiw	a5,a2,-1
 5fa:	1782                	slli	a5,a5,0x20
 5fc:	9381                	srli	a5,a5,0x20
 5fe:	fff7c793          	not	a5,a5
 602:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 604:	15fd                	addi	a1,a1,-1
 606:	177d                	addi	a4,a4,-1
 608:	0005c683          	lbu	a3,0(a1)
 60c:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 610:	fee79ae3          	bne	a5,a4,604 <memmove+0x46>
 614:	bfc9                	j	5e6 <memmove+0x28>

0000000000000616 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 616:	1141                	addi	sp,sp,-16
 618:	e422                	sd	s0,8(sp)
 61a:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 61c:	ca05                	beqz	a2,64c <memcmp+0x36>
 61e:	fff6069b          	addiw	a3,a2,-1
 622:	1682                	slli	a3,a3,0x20
 624:	9281                	srli	a3,a3,0x20
 626:	0685                	addi	a3,a3,1
 628:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 62a:	00054783          	lbu	a5,0(a0)
 62e:	0005c703          	lbu	a4,0(a1)
 632:	00e79863          	bne	a5,a4,642 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 636:	0505                	addi	a0,a0,1
        p2++;
 638:	0585                	addi	a1,a1,1
    while (n-- > 0)
 63a:	fed518e3          	bne	a0,a3,62a <memcmp+0x14>
    }
    return 0;
 63e:	4501                	li	a0,0
 640:	a019                	j	646 <memcmp+0x30>
            return *p1 - *p2;
 642:	40e7853b          	subw	a0,a5,a4
}
 646:	6422                	ld	s0,8(sp)
 648:	0141                	addi	sp,sp,16
 64a:	8082                	ret
    return 0;
 64c:	4501                	li	a0,0
 64e:	bfe5                	j	646 <memcmp+0x30>

0000000000000650 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 650:	1141                	addi	sp,sp,-16
 652:	e406                	sd	ra,8(sp)
 654:	e022                	sd	s0,0(sp)
 656:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 658:	00000097          	auipc	ra,0x0
 65c:	f66080e7          	jalr	-154(ra) # 5be <memmove>
}
 660:	60a2                	ld	ra,8(sp)
 662:	6402                	ld	s0,0(sp)
 664:	0141                	addi	sp,sp,16
 666:	8082                	ret

0000000000000668 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 668:	4885                	li	a7,1
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <exit>:
.global exit
exit:
 li a7, SYS_exit
 670:	4889                	li	a7,2
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <wait>:
.global wait
wait:
 li a7, SYS_wait
 678:	488d                	li	a7,3
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 680:	4891                	li	a7,4
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <read>:
.global read
read:
 li a7, SYS_read
 688:	4895                	li	a7,5
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <write>:
.global write
write:
 li a7, SYS_write
 690:	48c1                	li	a7,16
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <close>:
.global close
close:
 li a7, SYS_close
 698:	48d5                	li	a7,21
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6a0:	4899                	li	a7,6
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6a8:	489d                	li	a7,7
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <open>:
.global open
open:
 li a7, SYS_open
 6b0:	48bd                	li	a7,15
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6b8:	48c5                	li	a7,17
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6c0:	48c9                	li	a7,18
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6c8:	48a1                	li	a7,8
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <link>:
.global link
link:
 li a7, SYS_link
 6d0:	48cd                	li	a7,19
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6d8:	48d1                	li	a7,20
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6e0:	48a5                	li	a7,9
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6e8:	48a9                	li	a7,10
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6f0:	48ad                	li	a7,11
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6f8:	48b1                	li	a7,12
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 700:	48b5                	li	a7,13
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 708:	48b9                	li	a7,14
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <ps>:
.global ps
ps:
 li a7, SYS_ps
 710:	48d9                	li	a7,22
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 718:	48dd                	li	a7,23
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 720:	48e1                	li	a7,24
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 728:	1101                	addi	sp,sp,-32
 72a:	ec06                	sd	ra,24(sp)
 72c:	e822                	sd	s0,16(sp)
 72e:	1000                	addi	s0,sp,32
 730:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 734:	4605                	li	a2,1
 736:	fef40593          	addi	a1,s0,-17
 73a:	00000097          	auipc	ra,0x0
 73e:	f56080e7          	jalr	-170(ra) # 690 <write>
}
 742:	60e2                	ld	ra,24(sp)
 744:	6442                	ld	s0,16(sp)
 746:	6105                	addi	sp,sp,32
 748:	8082                	ret

000000000000074a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 74a:	7139                	addi	sp,sp,-64
 74c:	fc06                	sd	ra,56(sp)
 74e:	f822                	sd	s0,48(sp)
 750:	f426                	sd	s1,40(sp)
 752:	f04a                	sd	s2,32(sp)
 754:	ec4e                	sd	s3,24(sp)
 756:	0080                	addi	s0,sp,64
 758:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 75a:	c299                	beqz	a3,760 <printint+0x16>
 75c:	0805c963          	bltz	a1,7ee <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 760:	2581                	sext.w	a1,a1
  neg = 0;
 762:	4881                	li	a7,0
 764:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 768:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 76a:	2601                	sext.w	a2,a2
 76c:	00000517          	auipc	a0,0x0
 770:	4d450513          	addi	a0,a0,1236 # c40 <digits>
 774:	883a                	mv	a6,a4
 776:	2705                	addiw	a4,a4,1
 778:	02c5f7bb          	remuw	a5,a1,a2
 77c:	1782                	slli	a5,a5,0x20
 77e:	9381                	srli	a5,a5,0x20
 780:	97aa                	add	a5,a5,a0
 782:	0007c783          	lbu	a5,0(a5)
 786:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 78a:	0005879b          	sext.w	a5,a1
 78e:	02c5d5bb          	divuw	a1,a1,a2
 792:	0685                	addi	a3,a3,1
 794:	fec7f0e3          	bgeu	a5,a2,774 <printint+0x2a>
  if(neg)
 798:	00088c63          	beqz	a7,7b0 <printint+0x66>
    buf[i++] = '-';
 79c:	fd070793          	addi	a5,a4,-48
 7a0:	00878733          	add	a4,a5,s0
 7a4:	02d00793          	li	a5,45
 7a8:	fef70823          	sb	a5,-16(a4)
 7ac:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7b0:	02e05863          	blez	a4,7e0 <printint+0x96>
 7b4:	fc040793          	addi	a5,s0,-64
 7b8:	00e78933          	add	s2,a5,a4
 7bc:	fff78993          	addi	s3,a5,-1
 7c0:	99ba                	add	s3,s3,a4
 7c2:	377d                	addiw	a4,a4,-1
 7c4:	1702                	slli	a4,a4,0x20
 7c6:	9301                	srli	a4,a4,0x20
 7c8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7cc:	fff94583          	lbu	a1,-1(s2)
 7d0:	8526                	mv	a0,s1
 7d2:	00000097          	auipc	ra,0x0
 7d6:	f56080e7          	jalr	-170(ra) # 728 <putc>
  while(--i >= 0)
 7da:	197d                	addi	s2,s2,-1
 7dc:	ff3918e3          	bne	s2,s3,7cc <printint+0x82>
}
 7e0:	70e2                	ld	ra,56(sp)
 7e2:	7442                	ld	s0,48(sp)
 7e4:	74a2                	ld	s1,40(sp)
 7e6:	7902                	ld	s2,32(sp)
 7e8:	69e2                	ld	s3,24(sp)
 7ea:	6121                	addi	sp,sp,64
 7ec:	8082                	ret
    x = -xx;
 7ee:	40b005bb          	negw	a1,a1
    neg = 1;
 7f2:	4885                	li	a7,1
    x = -xx;
 7f4:	bf85                	j	764 <printint+0x1a>

00000000000007f6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7f6:	715d                	addi	sp,sp,-80
 7f8:	e486                	sd	ra,72(sp)
 7fa:	e0a2                	sd	s0,64(sp)
 7fc:	fc26                	sd	s1,56(sp)
 7fe:	f84a                	sd	s2,48(sp)
 800:	f44e                	sd	s3,40(sp)
 802:	f052                	sd	s4,32(sp)
 804:	ec56                	sd	s5,24(sp)
 806:	e85a                	sd	s6,16(sp)
 808:	e45e                	sd	s7,8(sp)
 80a:	e062                	sd	s8,0(sp)
 80c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 80e:	0005c903          	lbu	s2,0(a1)
 812:	18090c63          	beqz	s2,9aa <vprintf+0x1b4>
 816:	8aaa                	mv	s5,a0
 818:	8bb2                	mv	s7,a2
 81a:	00158493          	addi	s1,a1,1
  state = 0;
 81e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 820:	02500a13          	li	s4,37
 824:	4b55                	li	s6,21
 826:	a839                	j	844 <vprintf+0x4e>
        putc(fd, c);
 828:	85ca                	mv	a1,s2
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	efc080e7          	jalr	-260(ra) # 728 <putc>
 834:	a019                	j	83a <vprintf+0x44>
    } else if(state == '%'){
 836:	01498d63          	beq	s3,s4,850 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 83a:	0485                	addi	s1,s1,1
 83c:	fff4c903          	lbu	s2,-1(s1)
 840:	16090563          	beqz	s2,9aa <vprintf+0x1b4>
    if(state == 0){
 844:	fe0999e3          	bnez	s3,836 <vprintf+0x40>
      if(c == '%'){
 848:	ff4910e3          	bne	s2,s4,828 <vprintf+0x32>
        state = '%';
 84c:	89d2                	mv	s3,s4
 84e:	b7f5                	j	83a <vprintf+0x44>
      if(c == 'd'){
 850:	13490263          	beq	s2,s4,974 <vprintf+0x17e>
 854:	f9d9079b          	addiw	a5,s2,-99
 858:	0ff7f793          	zext.b	a5,a5
 85c:	12fb6563          	bltu	s6,a5,986 <vprintf+0x190>
 860:	f9d9079b          	addiw	a5,s2,-99
 864:	0ff7f713          	zext.b	a4,a5
 868:	10eb6f63          	bltu	s6,a4,986 <vprintf+0x190>
 86c:	00271793          	slli	a5,a4,0x2
 870:	00000717          	auipc	a4,0x0
 874:	37870713          	addi	a4,a4,888 # be8 <malloc+0x140>
 878:	97ba                	add	a5,a5,a4
 87a:	439c                	lw	a5,0(a5)
 87c:	97ba                	add	a5,a5,a4
 87e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 880:	008b8913          	addi	s2,s7,8
 884:	4685                	li	a3,1
 886:	4629                	li	a2,10
 888:	000ba583          	lw	a1,0(s7)
 88c:	8556                	mv	a0,s5
 88e:	00000097          	auipc	ra,0x0
 892:	ebc080e7          	jalr	-324(ra) # 74a <printint>
 896:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 898:	4981                	li	s3,0
 89a:	b745                	j	83a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 89c:	008b8913          	addi	s2,s7,8
 8a0:	4681                	li	a3,0
 8a2:	4629                	li	a2,10
 8a4:	000ba583          	lw	a1,0(s7)
 8a8:	8556                	mv	a0,s5
 8aa:	00000097          	auipc	ra,0x0
 8ae:	ea0080e7          	jalr	-352(ra) # 74a <printint>
 8b2:	8bca                	mv	s7,s2
      state = 0;
 8b4:	4981                	li	s3,0
 8b6:	b751                	j	83a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8b8:	008b8913          	addi	s2,s7,8
 8bc:	4681                	li	a3,0
 8be:	4641                	li	a2,16
 8c0:	000ba583          	lw	a1,0(s7)
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	e84080e7          	jalr	-380(ra) # 74a <printint>
 8ce:	8bca                	mv	s7,s2
      state = 0;
 8d0:	4981                	li	s3,0
 8d2:	b7a5                	j	83a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 8d4:	008b8c13          	addi	s8,s7,8
 8d8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8dc:	03000593          	li	a1,48
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	e46080e7          	jalr	-442(ra) # 728 <putc>
  putc(fd, 'x');
 8ea:	07800593          	li	a1,120
 8ee:	8556                	mv	a0,s5
 8f0:	00000097          	auipc	ra,0x0
 8f4:	e38080e7          	jalr	-456(ra) # 728 <putc>
 8f8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8fa:	00000b97          	auipc	s7,0x0
 8fe:	346b8b93          	addi	s7,s7,838 # c40 <digits>
 902:	03c9d793          	srli	a5,s3,0x3c
 906:	97de                	add	a5,a5,s7
 908:	0007c583          	lbu	a1,0(a5)
 90c:	8556                	mv	a0,s5
 90e:	00000097          	auipc	ra,0x0
 912:	e1a080e7          	jalr	-486(ra) # 728 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 916:	0992                	slli	s3,s3,0x4
 918:	397d                	addiw	s2,s2,-1
 91a:	fe0914e3          	bnez	s2,902 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 91e:	8be2                	mv	s7,s8
      state = 0;
 920:	4981                	li	s3,0
 922:	bf21                	j	83a <vprintf+0x44>
        s = va_arg(ap, char*);
 924:	008b8993          	addi	s3,s7,8
 928:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 92c:	02090163          	beqz	s2,94e <vprintf+0x158>
        while(*s != 0){
 930:	00094583          	lbu	a1,0(s2)
 934:	c9a5                	beqz	a1,9a4 <vprintf+0x1ae>
          putc(fd, *s);
 936:	8556                	mv	a0,s5
 938:	00000097          	auipc	ra,0x0
 93c:	df0080e7          	jalr	-528(ra) # 728 <putc>
          s++;
 940:	0905                	addi	s2,s2,1
        while(*s != 0){
 942:	00094583          	lbu	a1,0(s2)
 946:	f9e5                	bnez	a1,936 <vprintf+0x140>
        s = va_arg(ap, char*);
 948:	8bce                	mv	s7,s3
      state = 0;
 94a:	4981                	li	s3,0
 94c:	b5fd                	j	83a <vprintf+0x44>
          s = "(null)";
 94e:	00000917          	auipc	s2,0x0
 952:	29290913          	addi	s2,s2,658 # be0 <malloc+0x138>
        while(*s != 0){
 956:	02800593          	li	a1,40
 95a:	bff1                	j	936 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 95c:	008b8913          	addi	s2,s7,8
 960:	000bc583          	lbu	a1,0(s7)
 964:	8556                	mv	a0,s5
 966:	00000097          	auipc	ra,0x0
 96a:	dc2080e7          	jalr	-574(ra) # 728 <putc>
 96e:	8bca                	mv	s7,s2
      state = 0;
 970:	4981                	li	s3,0
 972:	b5e1                	j	83a <vprintf+0x44>
        putc(fd, c);
 974:	02500593          	li	a1,37
 978:	8556                	mv	a0,s5
 97a:	00000097          	auipc	ra,0x0
 97e:	dae080e7          	jalr	-594(ra) # 728 <putc>
      state = 0;
 982:	4981                	li	s3,0
 984:	bd5d                	j	83a <vprintf+0x44>
        putc(fd, '%');
 986:	02500593          	li	a1,37
 98a:	8556                	mv	a0,s5
 98c:	00000097          	auipc	ra,0x0
 990:	d9c080e7          	jalr	-612(ra) # 728 <putc>
        putc(fd, c);
 994:	85ca                	mv	a1,s2
 996:	8556                	mv	a0,s5
 998:	00000097          	auipc	ra,0x0
 99c:	d90080e7          	jalr	-624(ra) # 728 <putc>
      state = 0;
 9a0:	4981                	li	s3,0
 9a2:	bd61                	j	83a <vprintf+0x44>
        s = va_arg(ap, char*);
 9a4:	8bce                	mv	s7,s3
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	bd49                	j	83a <vprintf+0x44>
    }
  }
}
 9aa:	60a6                	ld	ra,72(sp)
 9ac:	6406                	ld	s0,64(sp)
 9ae:	74e2                	ld	s1,56(sp)
 9b0:	7942                	ld	s2,48(sp)
 9b2:	79a2                	ld	s3,40(sp)
 9b4:	7a02                	ld	s4,32(sp)
 9b6:	6ae2                	ld	s5,24(sp)
 9b8:	6b42                	ld	s6,16(sp)
 9ba:	6ba2                	ld	s7,8(sp)
 9bc:	6c02                	ld	s8,0(sp)
 9be:	6161                	addi	sp,sp,80
 9c0:	8082                	ret

00000000000009c2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9c2:	715d                	addi	sp,sp,-80
 9c4:	ec06                	sd	ra,24(sp)
 9c6:	e822                	sd	s0,16(sp)
 9c8:	1000                	addi	s0,sp,32
 9ca:	e010                	sd	a2,0(s0)
 9cc:	e414                	sd	a3,8(s0)
 9ce:	e818                	sd	a4,16(s0)
 9d0:	ec1c                	sd	a5,24(s0)
 9d2:	03043023          	sd	a6,32(s0)
 9d6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9da:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9de:	8622                	mv	a2,s0
 9e0:	00000097          	auipc	ra,0x0
 9e4:	e16080e7          	jalr	-490(ra) # 7f6 <vprintf>
}
 9e8:	60e2                	ld	ra,24(sp)
 9ea:	6442                	ld	s0,16(sp)
 9ec:	6161                	addi	sp,sp,80
 9ee:	8082                	ret

00000000000009f0 <printf>:

void
printf(const char *fmt, ...)
{
 9f0:	711d                	addi	sp,sp,-96
 9f2:	ec06                	sd	ra,24(sp)
 9f4:	e822                	sd	s0,16(sp)
 9f6:	1000                	addi	s0,sp,32
 9f8:	e40c                	sd	a1,8(s0)
 9fa:	e810                	sd	a2,16(s0)
 9fc:	ec14                	sd	a3,24(s0)
 9fe:	f018                	sd	a4,32(s0)
 a00:	f41c                	sd	a5,40(s0)
 a02:	03043823          	sd	a6,48(s0)
 a06:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a0a:	00840613          	addi	a2,s0,8
 a0e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a12:	85aa                	mv	a1,a0
 a14:	4505                	li	a0,1
 a16:	00000097          	auipc	ra,0x0
 a1a:	de0080e7          	jalr	-544(ra) # 7f6 <vprintf>
}
 a1e:	60e2                	ld	ra,24(sp)
 a20:	6442                	ld	s0,16(sp)
 a22:	6125                	addi	sp,sp,96
 a24:	8082                	ret

0000000000000a26 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a26:	1141                	addi	sp,sp,-16
 a28:	e422                	sd	s0,8(sp)
 a2a:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a2c:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a30:	00000797          	auipc	a5,0x0
 a34:	5e87b783          	ld	a5,1512(a5) # 1018 <freep>
 a38:	a02d                	j	a62 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a3a:	4618                	lw	a4,8(a2)
 a3c:	9f2d                	addw	a4,a4,a1
 a3e:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a42:	6398                	ld	a4,0(a5)
 a44:	6310                	ld	a2,0(a4)
 a46:	a83d                	j	a84 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a48:	ff852703          	lw	a4,-8(a0)
 a4c:	9f31                	addw	a4,a4,a2
 a4e:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a50:	ff053683          	ld	a3,-16(a0)
 a54:	a091                	j	a98 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a56:	6398                	ld	a4,0(a5)
 a58:	00e7e463          	bltu	a5,a4,a60 <free+0x3a>
 a5c:	00e6ea63          	bltu	a3,a4,a70 <free+0x4a>
{
 a60:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a62:	fed7fae3          	bgeu	a5,a3,a56 <free+0x30>
 a66:	6398                	ld	a4,0(a5)
 a68:	00e6e463          	bltu	a3,a4,a70 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a6c:	fee7eae3          	bltu	a5,a4,a60 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 a70:	ff852583          	lw	a1,-8(a0)
 a74:	6390                	ld	a2,0(a5)
 a76:	02059813          	slli	a6,a1,0x20
 a7a:	01c85713          	srli	a4,a6,0x1c
 a7e:	9736                	add	a4,a4,a3
 a80:	fae60de3          	beq	a2,a4,a3a <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 a84:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 a88:	4790                	lw	a2,8(a5)
 a8a:	02061593          	slli	a1,a2,0x20
 a8e:	01c5d713          	srli	a4,a1,0x1c
 a92:	973e                	add	a4,a4,a5
 a94:	fae68ae3          	beq	a3,a4,a48 <free+0x22>
        p->s.ptr = bp->s.ptr;
 a98:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 a9a:	00000717          	auipc	a4,0x0
 a9e:	56f73f23          	sd	a5,1406(a4) # 1018 <freep>
}
 aa2:	6422                	ld	s0,8(sp)
 aa4:	0141                	addi	sp,sp,16
 aa6:	8082                	ret

0000000000000aa8 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 aa8:	7139                	addi	sp,sp,-64
 aaa:	fc06                	sd	ra,56(sp)
 aac:	f822                	sd	s0,48(sp)
 aae:	f426                	sd	s1,40(sp)
 ab0:	f04a                	sd	s2,32(sp)
 ab2:	ec4e                	sd	s3,24(sp)
 ab4:	e852                	sd	s4,16(sp)
 ab6:	e456                	sd	s5,8(sp)
 ab8:	e05a                	sd	s6,0(sp)
 aba:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 abc:	02051493          	slli	s1,a0,0x20
 ac0:	9081                	srli	s1,s1,0x20
 ac2:	04bd                	addi	s1,s1,15
 ac4:	8091                	srli	s1,s1,0x4
 ac6:	0014899b          	addiw	s3,s1,1
 aca:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 acc:	00000517          	auipc	a0,0x0
 ad0:	54c53503          	ld	a0,1356(a0) # 1018 <freep>
 ad4:	c515                	beqz	a0,b00 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ad6:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 ad8:	4798                	lw	a4,8(a5)
 ada:	02977f63          	bgeu	a4,s1,b18 <malloc+0x70>
    if (nu < 4096)
 ade:	8a4e                	mv	s4,s3
 ae0:	0009871b          	sext.w	a4,s3
 ae4:	6685                	lui	a3,0x1
 ae6:	00d77363          	bgeu	a4,a3,aec <malloc+0x44>
 aea:	6a05                	lui	s4,0x1
 aec:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 af0:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 af4:	00000917          	auipc	s2,0x0
 af8:	52490913          	addi	s2,s2,1316 # 1018 <freep>
    if (p == (char *)-1)
 afc:	5afd                	li	s5,-1
 afe:	a895                	j	b72 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b00:	00000797          	auipc	a5,0x0
 b04:	5a078793          	addi	a5,a5,1440 # 10a0 <base>
 b08:	00000717          	auipc	a4,0x0
 b0c:	50f73823          	sd	a5,1296(a4) # 1018 <freep>
 b10:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b12:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b16:	b7e1                	j	ade <malloc+0x36>
            if (p->s.size == nunits)
 b18:	02e48c63          	beq	s1,a4,b50 <malloc+0xa8>
                p->s.size -= nunits;
 b1c:	4137073b          	subw	a4,a4,s3
 b20:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b22:	02071693          	slli	a3,a4,0x20
 b26:	01c6d713          	srli	a4,a3,0x1c
 b2a:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b2c:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b30:	00000717          	auipc	a4,0x0
 b34:	4ea73423          	sd	a0,1256(a4) # 1018 <freep>
            return (void *)(p + 1);
 b38:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b3c:	70e2                	ld	ra,56(sp)
 b3e:	7442                	ld	s0,48(sp)
 b40:	74a2                	ld	s1,40(sp)
 b42:	7902                	ld	s2,32(sp)
 b44:	69e2                	ld	s3,24(sp)
 b46:	6a42                	ld	s4,16(sp)
 b48:	6aa2                	ld	s5,8(sp)
 b4a:	6b02                	ld	s6,0(sp)
 b4c:	6121                	addi	sp,sp,64
 b4e:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b50:	6398                	ld	a4,0(a5)
 b52:	e118                	sd	a4,0(a0)
 b54:	bff1                	j	b30 <malloc+0x88>
    hp->s.size = nu;
 b56:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b5a:	0541                	addi	a0,a0,16
 b5c:	00000097          	auipc	ra,0x0
 b60:	eca080e7          	jalr	-310(ra) # a26 <free>
    return freep;
 b64:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b68:	d971                	beqz	a0,b3c <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b6a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 b6c:	4798                	lw	a4,8(a5)
 b6e:	fa9775e3          	bgeu	a4,s1,b18 <malloc+0x70>
        if (p == freep)
 b72:	00093703          	ld	a4,0(s2)
 b76:	853e                	mv	a0,a5
 b78:	fef719e3          	bne	a4,a5,b6a <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 b7c:	8552                	mv	a0,s4
 b7e:	00000097          	auipc	ra,0x0
 b82:	b7a080e7          	jalr	-1158(ra) # 6f8 <sbrk>
    if (p == (char *)-1)
 b86:	fd5518e3          	bne	a0,s5,b56 <malloc+0xae>
                return 0;
 b8a:	4501                	li	a0,0
 b8c:	bf45                	j	b3c <malloc+0x94>
