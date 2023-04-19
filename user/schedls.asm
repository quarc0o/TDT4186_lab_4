
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
   c:	700080e7          	jalr	1792(ra) # 708 <schedls>
    exit(0);
  10:	4501                	li	a0,0
  12:	00000097          	auipc	ra,0x0
  16:	64e080e7          	jalr	1614(ra) # 660 <exit>

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
  4e:	2c4080e7          	jalr	708(ra) # 30e <twhoami>
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
  9a:	aea50513          	addi	a0,a0,-1302 # b80 <malloc+0xe8>
  9e:	00001097          	auipc	ra,0x1
  a2:	942080e7          	jalr	-1726(ra) # 9e0 <printf>
        exit(-1);
  a6:	557d                	li	a0,-1
  a8:	00000097          	auipc	ra,0x0
  ac:	5b8080e7          	jalr	1464(ra) # 660 <exit>
    {
        // give up the cpu for other threads
        tyield();
  b0:	00000097          	auipc	ra,0x0
  b4:	1dc080e7          	jalr	476(ra) # 28c <tyield>
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
  ce:	244080e7          	jalr	580(ra) # 30e <twhoami>
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
 112:	17e080e7          	jalr	382(ra) # 28c <tyield>
}
 116:	60e2                	ld	ra,24(sp)
 118:	6442                	ld	s0,16(sp)
 11a:	64a2                	ld	s1,8(sp)
 11c:	6105                	addi	sp,sp,32
 11e:	8082                	ret
        printf("releasing lock we are not holding");
 120:	00001517          	auipc	a0,0x1
 124:	a8850513          	addi	a0,a0,-1400 # ba8 <malloc+0x110>
 128:	00001097          	auipc	ra,0x1
 12c:	8b8080e7          	jalr	-1864(ra) # 9e0 <printf>
        exit(-1);
 130:	557d                	li	a0,-1
 132:	00000097          	auipc	ra,0x0
 136:	52e080e7          	jalr	1326(ra) # 660 <exit>

000000000000013a <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 13a:	00001517          	auipc	a0,0x1
 13e:	ed653503          	ld	a0,-298(a0) # 1010 <current_thread>
 142:	00001717          	auipc	a4,0x1
 146:	ede70713          	addi	a4,a4,-290 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 14a:	4781                	li	a5,0
 14c:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 14e:	6314                	ld	a3,0(a4)
 150:	00a68763          	beq	a3,a0,15e <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 154:	2785                	addiw	a5,a5,1
 156:	0721                	addi	a4,a4,8
 158:	fec79be3          	bne	a5,a2,14e <tsched+0x14>
    int current_index = 0;
 15c:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 15e:	0017869b          	addiw	a3,a5,1
 162:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 166:	00001817          	auipc	a6,0x1
 16a:	eba80813          	addi	a6,a6,-326 # 1020 <threads>
 16e:	488d                	li	a7,3
 170:	a021                	j	178 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 172:	2685                	addiw	a3,a3,1
 174:	04c68363          	beq	a3,a2,1ba <tsched+0x80>
        int next_index = (current_index + i) % 16;
 178:	41f6d71b          	sraiw	a4,a3,0x1f
 17c:	01c7571b          	srliw	a4,a4,0x1c
 180:	00d707bb          	addw	a5,a4,a3
 184:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 186:	9f99                	subw	a5,a5,a4
 188:	078e                	slli	a5,a5,0x3
 18a:	97c2                	add	a5,a5,a6
 18c:	638c                	ld	a1,0(a5)
 18e:	d1f5                	beqz	a1,172 <tsched+0x38>
 190:	5dbc                	lw	a5,120(a1)
 192:	ff1790e3          	bne	a5,a7,172 <tsched+0x38>
{
 196:	1141                	addi	sp,sp,-16
 198:	e406                	sd	ra,8(sp)
 19a:	e022                	sd	s0,0(sp)
 19c:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 19e:	00001797          	auipc	a5,0x1
 1a2:	e6b7b923          	sd	a1,-398(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1a6:	05a1                	addi	a1,a1,8
 1a8:	0521                	addi	a0,a0,8
 1aa:	00000097          	auipc	ra,0x0
 1ae:	17c080e7          	jalr	380(ra) # 326 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 1b2:	60a2                	ld	ra,8(sp)
 1b4:	6402                	ld	s0,0(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret
 1ba:	8082                	ret

00000000000001bc <thread_wrapper>:
{
 1bc:	1101                	addi	sp,sp,-32
 1be:	ec06                	sd	ra,24(sp)
 1c0:	e822                	sd	s0,16(sp)
 1c2:	e426                	sd	s1,8(sp)
 1c4:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 1c6:	00001497          	auipc	s1,0x1
 1ca:	e4a48493          	addi	s1,s1,-438 # 1010 <current_thread>
 1ce:	609c                	ld	a5,0(s1)
 1d0:	67d8                	ld	a4,136(a5)
 1d2:	63c8                	ld	a0,128(a5)
 1d4:	9702                	jalr	a4
    current_thread->state = EXITED;
 1d6:	609c                	ld	a5,0(s1)
 1d8:	4719                	li	a4,6
 1da:	dfb8                	sw	a4,120(a5)
    tsched();
 1dc:	00000097          	auipc	ra,0x0
 1e0:	f5e080e7          	jalr	-162(ra) # 13a <tsched>
}
 1e4:	60e2                	ld	ra,24(sp)
 1e6:	6442                	ld	s0,16(sp)
 1e8:	64a2                	ld	s1,8(sp)
 1ea:	6105                	addi	sp,sp,32
 1ec:	8082                	ret

00000000000001ee <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 1ee:	7179                	addi	sp,sp,-48
 1f0:	f406                	sd	ra,40(sp)
 1f2:	f022                	sd	s0,32(sp)
 1f4:	ec26                	sd	s1,24(sp)
 1f6:	e84a                	sd	s2,16(sp)
 1f8:	e44e                	sd	s3,8(sp)
 1fa:	1800                	addi	s0,sp,48
 1fc:	84aa                	mv	s1,a0
 1fe:	89b2                	mv	s3,a2
 200:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 202:	09800513          	li	a0,152
 206:	00001097          	auipc	ra,0x1
 20a:	892080e7          	jalr	-1902(ra) # a98 <malloc>
 20e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 210:	478d                	li	a5,3
 212:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 214:	609c                	ld	a5,0(s1)
 216:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 21a:	609c                	ld	a5,0(s1)
 21c:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 220:	6098                	ld	a4,0(s1)
 222:	00001797          	auipc	a5,0x1
 226:	dde78793          	addi	a5,a5,-546 # 1000 <next_tid>
 22a:	4394                	lw	a3,0(a5)
 22c:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 230:	4398                	lw	a4,0(a5)
 232:	2705                	addiw	a4,a4,1
 234:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 236:	6505                	lui	a0,0x1
 238:	00001097          	auipc	ra,0x1
 23c:	860080e7          	jalr	-1952(ra) # a98 <malloc>
 240:	609c                	ld	a5,0(s1)
 242:	6705                	lui	a4,0x1
 244:	953a                	add	a0,a0,a4
 246:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 248:	609c                	ld	a5,0(s1)
 24a:	00000717          	auipc	a4,0x0
 24e:	f7270713          	addi	a4,a4,-142 # 1bc <thread_wrapper>
 252:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 254:	00001717          	auipc	a4,0x1
 258:	dcc70713          	addi	a4,a4,-564 # 1020 <threads>
 25c:	4781                	li	a5,0
 25e:	4641                	li	a2,16
        if (threads[i] == NULL) {
 260:	6314                	ld	a3,0(a4)
 262:	ce81                	beqz	a3,27a <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 264:	2785                	addiw	a5,a5,1
 266:	0721                	addi	a4,a4,8
 268:	fec79ce3          	bne	a5,a2,260 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 26c:	70a2                	ld	ra,40(sp)
 26e:	7402                	ld	s0,32(sp)
 270:	64e2                	ld	s1,24(sp)
 272:	6942                	ld	s2,16(sp)
 274:	69a2                	ld	s3,8(sp)
 276:	6145                	addi	sp,sp,48
 278:	8082                	ret
            threads[i] = *thread;
 27a:	6094                	ld	a3,0(s1)
 27c:	078e                	slli	a5,a5,0x3
 27e:	00001717          	auipc	a4,0x1
 282:	da270713          	addi	a4,a4,-606 # 1020 <threads>
 286:	97ba                	add	a5,a5,a4
 288:	e394                	sd	a3,0(a5)
            break;
 28a:	b7cd                	j	26c <tcreate+0x7e>

000000000000028c <tyield>:
    return 0;
}


void tyield()
{
 28c:	1141                	addi	sp,sp,-16
 28e:	e406                	sd	ra,8(sp)
 290:	e022                	sd	s0,0(sp)
 292:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 294:	00001797          	auipc	a5,0x1
 298:	d7c7b783          	ld	a5,-644(a5) # 1010 <current_thread>
 29c:	470d                	li	a4,3
 29e:	dfb8                	sw	a4,120(a5)
    tsched();
 2a0:	00000097          	auipc	ra,0x0
 2a4:	e9a080e7          	jalr	-358(ra) # 13a <tsched>
}
 2a8:	60a2                	ld	ra,8(sp)
 2aa:	6402                	ld	s0,0(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <tjoin>:
{
 2b0:	1101                	addi	sp,sp,-32
 2b2:	ec06                	sd	ra,24(sp)
 2b4:	e822                	sd	s0,16(sp)
 2b6:	e426                	sd	s1,8(sp)
 2b8:	e04a                	sd	s2,0(sp)
 2ba:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 2bc:	00001797          	auipc	a5,0x1
 2c0:	d6478793          	addi	a5,a5,-668 # 1020 <threads>
 2c4:	00001697          	auipc	a3,0x1
 2c8:	ddc68693          	addi	a3,a3,-548 # 10a0 <base>
 2cc:	a021                	j	2d4 <tjoin+0x24>
 2ce:	07a1                	addi	a5,a5,8
 2d0:	02d78b63          	beq	a5,a3,306 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 2d4:	6384                	ld	s1,0(a5)
 2d6:	dce5                	beqz	s1,2ce <tjoin+0x1e>
 2d8:	0004c703          	lbu	a4,0(s1)
 2dc:	fea719e3          	bne	a4,a0,2ce <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 2e0:	5cb8                	lw	a4,120(s1)
 2e2:	4799                	li	a5,6
 2e4:	4919                	li	s2,6
 2e6:	02f70263          	beq	a4,a5,30a <tjoin+0x5a>
        tyield();
 2ea:	00000097          	auipc	ra,0x0
 2ee:	fa2080e7          	jalr	-94(ra) # 28c <tyield>
    while (target_thread->state != EXITED) {
 2f2:	5cbc                	lw	a5,120(s1)
 2f4:	ff279be3          	bne	a5,s2,2ea <tjoin+0x3a>
    return 0;
 2f8:	4501                	li	a0,0
}
 2fa:	60e2                	ld	ra,24(sp)
 2fc:	6442                	ld	s0,16(sp)
 2fe:	64a2                	ld	s1,8(sp)
 300:	6902                	ld	s2,0(sp)
 302:	6105                	addi	sp,sp,32
 304:	8082                	ret
        return -1;
 306:	557d                	li	a0,-1
 308:	bfcd                	j	2fa <tjoin+0x4a>
    return 0;
 30a:	4501                	li	a0,0
 30c:	b7fd                	j	2fa <tjoin+0x4a>

000000000000030e <twhoami>:

uint8 twhoami()
{
 30e:	1141                	addi	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 314:	00001797          	auipc	a5,0x1
 318:	cfc7b783          	ld	a5,-772(a5) # 1010 <current_thread>
 31c:	0007c503          	lbu	a0,0(a5)
 320:	6422                	ld	s0,8(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <tswtch>:
 326:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 32a:	00253423          	sd	sp,8(a0)
 32e:	e900                	sd	s0,16(a0)
 330:	ed04                	sd	s1,24(a0)
 332:	03253023          	sd	s2,32(a0)
 336:	03353423          	sd	s3,40(a0)
 33a:	03453823          	sd	s4,48(a0)
 33e:	03553c23          	sd	s5,56(a0)
 342:	05653023          	sd	s6,64(a0)
 346:	05753423          	sd	s7,72(a0)
 34a:	05853823          	sd	s8,80(a0)
 34e:	05953c23          	sd	s9,88(a0)
 352:	07a53023          	sd	s10,96(a0)
 356:	07b53423          	sd	s11,104(a0)
 35a:	0005b083          	ld	ra,0(a1)
 35e:	0085b103          	ld	sp,8(a1)
 362:	6980                	ld	s0,16(a1)
 364:	6d84                	ld	s1,24(a1)
 366:	0205b903          	ld	s2,32(a1)
 36a:	0285b983          	ld	s3,40(a1)
 36e:	0305ba03          	ld	s4,48(a1)
 372:	0385ba83          	ld	s5,56(a1)
 376:	0405bb03          	ld	s6,64(a1)
 37a:	0485bb83          	ld	s7,72(a1)
 37e:	0505bc03          	ld	s8,80(a1)
 382:	0585bc83          	ld	s9,88(a1)
 386:	0605bd03          	ld	s10,96(a1)
 38a:	0685bd83          	ld	s11,104(a1)
 38e:	8082                	ret

0000000000000390 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 390:	1101                	addi	sp,sp,-32
 392:	ec06                	sd	ra,24(sp)
 394:	e822                	sd	s0,16(sp)
 396:	e426                	sd	s1,8(sp)
 398:	e04a                	sd	s2,0(sp)
 39a:	1000                	addi	s0,sp,32
 39c:	84aa                	mv	s1,a0
 39e:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3a0:	09800513          	li	a0,152
 3a4:	00000097          	auipc	ra,0x0
 3a8:	6f4080e7          	jalr	1780(ra) # a98 <malloc>

    main_thread->tid = 1;
 3ac:	4785                	li	a5,1
 3ae:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 3b2:	4791                	li	a5,4
 3b4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3b6:	00001797          	auipc	a5,0x1
 3ba:	c4a7bd23          	sd	a0,-934(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3be:	00001797          	auipc	a5,0x1
 3c2:	c6278793          	addi	a5,a5,-926 # 1020 <threads>
 3c6:	00001717          	auipc	a4,0x1
 3ca:	cda70713          	addi	a4,a4,-806 # 10a0 <base>
        threads[i] = NULL;
 3ce:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 3d2:	07a1                	addi	a5,a5,8
 3d4:	fee79de3          	bne	a5,a4,3ce <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 3d8:	00001797          	auipc	a5,0x1
 3dc:	c4a7b423          	sd	a0,-952(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 3e0:	85ca                	mv	a1,s2
 3e2:	8526                	mv	a0,s1
 3e4:	00000097          	auipc	ra,0x0
 3e8:	c1c080e7          	jalr	-996(ra) # 0 <main>
    //tsched();

    exit(res);
 3ec:	00000097          	auipc	ra,0x0
 3f0:	274080e7          	jalr	628(ra) # 660 <exit>

00000000000003f4 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 3fa:	87aa                	mv	a5,a0
 3fc:	0585                	addi	a1,a1,1
 3fe:	0785                	addi	a5,a5,1
 400:	fff5c703          	lbu	a4,-1(a1)
 404:	fee78fa3          	sb	a4,-1(a5)
 408:	fb75                	bnez	a4,3fc <strcpy+0x8>
        ;
    return os;
}
 40a:	6422                	ld	s0,8(sp)
 40c:	0141                	addi	sp,sp,16
 40e:	8082                	ret

0000000000000410 <strcmp>:

int strcmp(const char *p, const char *q)
{
 410:	1141                	addi	sp,sp,-16
 412:	e422                	sd	s0,8(sp)
 414:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 416:	00054783          	lbu	a5,0(a0)
 41a:	cb91                	beqz	a5,42e <strcmp+0x1e>
 41c:	0005c703          	lbu	a4,0(a1)
 420:	00f71763          	bne	a4,a5,42e <strcmp+0x1e>
        p++, q++;
 424:	0505                	addi	a0,a0,1
 426:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 428:	00054783          	lbu	a5,0(a0)
 42c:	fbe5                	bnez	a5,41c <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 42e:	0005c503          	lbu	a0,0(a1)
}
 432:	40a7853b          	subw	a0,a5,a0
 436:	6422                	ld	s0,8(sp)
 438:	0141                	addi	sp,sp,16
 43a:	8082                	ret

000000000000043c <strlen>:

uint strlen(const char *s)
{
 43c:	1141                	addi	sp,sp,-16
 43e:	e422                	sd	s0,8(sp)
 440:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 442:	00054783          	lbu	a5,0(a0)
 446:	cf91                	beqz	a5,462 <strlen+0x26>
 448:	0505                	addi	a0,a0,1
 44a:	87aa                	mv	a5,a0
 44c:	86be                	mv	a3,a5
 44e:	0785                	addi	a5,a5,1
 450:	fff7c703          	lbu	a4,-1(a5)
 454:	ff65                	bnez	a4,44c <strlen+0x10>
 456:	40a6853b          	subw	a0,a3,a0
 45a:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 45c:	6422                	ld	s0,8(sp)
 45e:	0141                	addi	sp,sp,16
 460:	8082                	ret
    for (n = 0; s[n]; n++)
 462:	4501                	li	a0,0
 464:	bfe5                	j	45c <strlen+0x20>

0000000000000466 <memset>:

void *
memset(void *dst, int c, uint n)
{
 466:	1141                	addi	sp,sp,-16
 468:	e422                	sd	s0,8(sp)
 46a:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 46c:	ca19                	beqz	a2,482 <memset+0x1c>
 46e:	87aa                	mv	a5,a0
 470:	1602                	slli	a2,a2,0x20
 472:	9201                	srli	a2,a2,0x20
 474:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 478:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 47c:	0785                	addi	a5,a5,1
 47e:	fee79de3          	bne	a5,a4,478 <memset+0x12>
    }
    return dst;
}
 482:	6422                	ld	s0,8(sp)
 484:	0141                	addi	sp,sp,16
 486:	8082                	ret

0000000000000488 <strchr>:

char *
strchr(const char *s, char c)
{
 488:	1141                	addi	sp,sp,-16
 48a:	e422                	sd	s0,8(sp)
 48c:	0800                	addi	s0,sp,16
    for (; *s; s++)
 48e:	00054783          	lbu	a5,0(a0)
 492:	cb99                	beqz	a5,4a8 <strchr+0x20>
        if (*s == c)
 494:	00f58763          	beq	a1,a5,4a2 <strchr+0x1a>
    for (; *s; s++)
 498:	0505                	addi	a0,a0,1
 49a:	00054783          	lbu	a5,0(a0)
 49e:	fbfd                	bnez	a5,494 <strchr+0xc>
            return (char *)s;
    return 0;
 4a0:	4501                	li	a0,0
}
 4a2:	6422                	ld	s0,8(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret
    return 0;
 4a8:	4501                	li	a0,0
 4aa:	bfe5                	j	4a2 <strchr+0x1a>

00000000000004ac <gets>:

char *
gets(char *buf, int max)
{
 4ac:	711d                	addi	sp,sp,-96
 4ae:	ec86                	sd	ra,88(sp)
 4b0:	e8a2                	sd	s0,80(sp)
 4b2:	e4a6                	sd	s1,72(sp)
 4b4:	e0ca                	sd	s2,64(sp)
 4b6:	fc4e                	sd	s3,56(sp)
 4b8:	f852                	sd	s4,48(sp)
 4ba:	f456                	sd	s5,40(sp)
 4bc:	f05a                	sd	s6,32(sp)
 4be:	ec5e                	sd	s7,24(sp)
 4c0:	1080                	addi	s0,sp,96
 4c2:	8baa                	mv	s7,a0
 4c4:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 4c6:	892a                	mv	s2,a0
 4c8:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 4ca:	4aa9                	li	s5,10
 4cc:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 4ce:	89a6                	mv	s3,s1
 4d0:	2485                	addiw	s1,s1,1
 4d2:	0344d863          	bge	s1,s4,502 <gets+0x56>
        cc = read(0, &c, 1);
 4d6:	4605                	li	a2,1
 4d8:	faf40593          	addi	a1,s0,-81
 4dc:	4501                	li	a0,0
 4de:	00000097          	auipc	ra,0x0
 4e2:	19a080e7          	jalr	410(ra) # 678 <read>
        if (cc < 1)
 4e6:	00a05e63          	blez	a0,502 <gets+0x56>
        buf[i++] = c;
 4ea:	faf44783          	lbu	a5,-81(s0)
 4ee:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 4f2:	01578763          	beq	a5,s5,500 <gets+0x54>
 4f6:	0905                	addi	s2,s2,1
 4f8:	fd679be3          	bne	a5,s6,4ce <gets+0x22>
    for (i = 0; i + 1 < max;)
 4fc:	89a6                	mv	s3,s1
 4fe:	a011                	j	502 <gets+0x56>
 500:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 502:	99de                	add	s3,s3,s7
 504:	00098023          	sb	zero,0(s3)
    return buf;
}
 508:	855e                	mv	a0,s7
 50a:	60e6                	ld	ra,88(sp)
 50c:	6446                	ld	s0,80(sp)
 50e:	64a6                	ld	s1,72(sp)
 510:	6906                	ld	s2,64(sp)
 512:	79e2                	ld	s3,56(sp)
 514:	7a42                	ld	s4,48(sp)
 516:	7aa2                	ld	s5,40(sp)
 518:	7b02                	ld	s6,32(sp)
 51a:	6be2                	ld	s7,24(sp)
 51c:	6125                	addi	sp,sp,96
 51e:	8082                	ret

0000000000000520 <stat>:

int stat(const char *n, struct stat *st)
{
 520:	1101                	addi	sp,sp,-32
 522:	ec06                	sd	ra,24(sp)
 524:	e822                	sd	s0,16(sp)
 526:	e426                	sd	s1,8(sp)
 528:	e04a                	sd	s2,0(sp)
 52a:	1000                	addi	s0,sp,32
 52c:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 52e:	4581                	li	a1,0
 530:	00000097          	auipc	ra,0x0
 534:	170080e7          	jalr	368(ra) # 6a0 <open>
    if (fd < 0)
 538:	02054563          	bltz	a0,562 <stat+0x42>
 53c:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 53e:	85ca                	mv	a1,s2
 540:	00000097          	auipc	ra,0x0
 544:	178080e7          	jalr	376(ra) # 6b8 <fstat>
 548:	892a                	mv	s2,a0
    close(fd);
 54a:	8526                	mv	a0,s1
 54c:	00000097          	auipc	ra,0x0
 550:	13c080e7          	jalr	316(ra) # 688 <close>
    return r;
}
 554:	854a                	mv	a0,s2
 556:	60e2                	ld	ra,24(sp)
 558:	6442                	ld	s0,16(sp)
 55a:	64a2                	ld	s1,8(sp)
 55c:	6902                	ld	s2,0(sp)
 55e:	6105                	addi	sp,sp,32
 560:	8082                	ret
        return -1;
 562:	597d                	li	s2,-1
 564:	bfc5                	j	554 <stat+0x34>

0000000000000566 <atoi>:

int atoi(const char *s)
{
 566:	1141                	addi	sp,sp,-16
 568:	e422                	sd	s0,8(sp)
 56a:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 56c:	00054683          	lbu	a3,0(a0)
 570:	fd06879b          	addiw	a5,a3,-48
 574:	0ff7f793          	zext.b	a5,a5
 578:	4625                	li	a2,9
 57a:	02f66863          	bltu	a2,a5,5aa <atoi+0x44>
 57e:	872a                	mv	a4,a0
    n = 0;
 580:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 582:	0705                	addi	a4,a4,1
 584:	0025179b          	slliw	a5,a0,0x2
 588:	9fa9                	addw	a5,a5,a0
 58a:	0017979b          	slliw	a5,a5,0x1
 58e:	9fb5                	addw	a5,a5,a3
 590:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 594:	00074683          	lbu	a3,0(a4)
 598:	fd06879b          	addiw	a5,a3,-48
 59c:	0ff7f793          	zext.b	a5,a5
 5a0:	fef671e3          	bgeu	a2,a5,582 <atoi+0x1c>
    return n;
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret
    n = 0;
 5aa:	4501                	li	a0,0
 5ac:	bfe5                	j	5a4 <atoi+0x3e>

00000000000005ae <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5ae:	1141                	addi	sp,sp,-16
 5b0:	e422                	sd	s0,8(sp)
 5b2:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5b4:	02b57463          	bgeu	a0,a1,5dc <memmove+0x2e>
    {
        while (n-- > 0)
 5b8:	00c05f63          	blez	a2,5d6 <memmove+0x28>
 5bc:	1602                	slli	a2,a2,0x20
 5be:	9201                	srli	a2,a2,0x20
 5c0:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 5c4:	872a                	mv	a4,a0
            *dst++ = *src++;
 5c6:	0585                	addi	a1,a1,1
 5c8:	0705                	addi	a4,a4,1
 5ca:	fff5c683          	lbu	a3,-1(a1)
 5ce:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 5d2:	fee79ae3          	bne	a5,a4,5c6 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 5d6:	6422                	ld	s0,8(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret
        dst += n;
 5dc:	00c50733          	add	a4,a0,a2
        src += n;
 5e0:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 5e2:	fec05ae3          	blez	a2,5d6 <memmove+0x28>
 5e6:	fff6079b          	addiw	a5,a2,-1
 5ea:	1782                	slli	a5,a5,0x20
 5ec:	9381                	srli	a5,a5,0x20
 5ee:	fff7c793          	not	a5,a5
 5f2:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 5f4:	15fd                	addi	a1,a1,-1
 5f6:	177d                	addi	a4,a4,-1
 5f8:	0005c683          	lbu	a3,0(a1)
 5fc:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 600:	fee79ae3          	bne	a5,a4,5f4 <memmove+0x46>
 604:	bfc9                	j	5d6 <memmove+0x28>

0000000000000606 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 606:	1141                	addi	sp,sp,-16
 608:	e422                	sd	s0,8(sp)
 60a:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 60c:	ca05                	beqz	a2,63c <memcmp+0x36>
 60e:	fff6069b          	addiw	a3,a2,-1
 612:	1682                	slli	a3,a3,0x20
 614:	9281                	srli	a3,a3,0x20
 616:	0685                	addi	a3,a3,1
 618:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 61a:	00054783          	lbu	a5,0(a0)
 61e:	0005c703          	lbu	a4,0(a1)
 622:	00e79863          	bne	a5,a4,632 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 626:	0505                	addi	a0,a0,1
        p2++;
 628:	0585                	addi	a1,a1,1
    while (n-- > 0)
 62a:	fed518e3          	bne	a0,a3,61a <memcmp+0x14>
    }
    return 0;
 62e:	4501                	li	a0,0
 630:	a019                	j	636 <memcmp+0x30>
            return *p1 - *p2;
 632:	40e7853b          	subw	a0,a5,a4
}
 636:	6422                	ld	s0,8(sp)
 638:	0141                	addi	sp,sp,16
 63a:	8082                	ret
    return 0;
 63c:	4501                	li	a0,0
 63e:	bfe5                	j	636 <memcmp+0x30>

0000000000000640 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 640:	1141                	addi	sp,sp,-16
 642:	e406                	sd	ra,8(sp)
 644:	e022                	sd	s0,0(sp)
 646:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 648:	00000097          	auipc	ra,0x0
 64c:	f66080e7          	jalr	-154(ra) # 5ae <memmove>
}
 650:	60a2                	ld	ra,8(sp)
 652:	6402                	ld	s0,0(sp)
 654:	0141                	addi	sp,sp,16
 656:	8082                	ret

0000000000000658 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 658:	4885                	li	a7,1
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <exit>:
.global exit
exit:
 li a7, SYS_exit
 660:	4889                	li	a7,2
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <wait>:
.global wait
wait:
 li a7, SYS_wait
 668:	488d                	li	a7,3
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 670:	4891                	li	a7,4
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <read>:
.global read
read:
 li a7, SYS_read
 678:	4895                	li	a7,5
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <write>:
.global write
write:
 li a7, SYS_write
 680:	48c1                	li	a7,16
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <close>:
.global close
close:
 li a7, SYS_close
 688:	48d5                	li	a7,21
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <kill>:
.global kill
kill:
 li a7, SYS_kill
 690:	4899                	li	a7,6
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <exec>:
.global exec
exec:
 li a7, SYS_exec
 698:	489d                	li	a7,7
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <open>:
.global open
open:
 li a7, SYS_open
 6a0:	48bd                	li	a7,15
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6a8:	48c5                	li	a7,17
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6b0:	48c9                	li	a7,18
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6b8:	48a1                	li	a7,8
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <link>:
.global link
link:
 li a7, SYS_link
 6c0:	48cd                	li	a7,19
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6c8:	48d1                	li	a7,20
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6d0:	48a5                	li	a7,9
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6d8:	48a9                	li	a7,10
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6e0:	48ad                	li	a7,11
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6e8:	48b1                	li	a7,12
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6f0:	48b5                	li	a7,13
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6f8:	48b9                	li	a7,14
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <ps>:
.global ps
ps:
 li a7, SYS_ps
 700:	48d9                	li	a7,22
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 708:	48dd                	li	a7,23
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 710:	48e1                	li	a7,24
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 718:	1101                	addi	sp,sp,-32
 71a:	ec06                	sd	ra,24(sp)
 71c:	e822                	sd	s0,16(sp)
 71e:	1000                	addi	s0,sp,32
 720:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 724:	4605                	li	a2,1
 726:	fef40593          	addi	a1,s0,-17
 72a:	00000097          	auipc	ra,0x0
 72e:	f56080e7          	jalr	-170(ra) # 680 <write>
}
 732:	60e2                	ld	ra,24(sp)
 734:	6442                	ld	s0,16(sp)
 736:	6105                	addi	sp,sp,32
 738:	8082                	ret

000000000000073a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 73a:	7139                	addi	sp,sp,-64
 73c:	fc06                	sd	ra,56(sp)
 73e:	f822                	sd	s0,48(sp)
 740:	f426                	sd	s1,40(sp)
 742:	f04a                	sd	s2,32(sp)
 744:	ec4e                	sd	s3,24(sp)
 746:	0080                	addi	s0,sp,64
 748:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 74a:	c299                	beqz	a3,750 <printint+0x16>
 74c:	0805c963          	bltz	a1,7de <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 750:	2581                	sext.w	a1,a1
  neg = 0;
 752:	4881                	li	a7,0
 754:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 758:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 75a:	2601                	sext.w	a2,a2
 75c:	00000517          	auipc	a0,0x0
 760:	4d450513          	addi	a0,a0,1236 # c30 <digits>
 764:	883a                	mv	a6,a4
 766:	2705                	addiw	a4,a4,1
 768:	02c5f7bb          	remuw	a5,a1,a2
 76c:	1782                	slli	a5,a5,0x20
 76e:	9381                	srli	a5,a5,0x20
 770:	97aa                	add	a5,a5,a0
 772:	0007c783          	lbu	a5,0(a5)
 776:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 77a:	0005879b          	sext.w	a5,a1
 77e:	02c5d5bb          	divuw	a1,a1,a2
 782:	0685                	addi	a3,a3,1
 784:	fec7f0e3          	bgeu	a5,a2,764 <printint+0x2a>
  if(neg)
 788:	00088c63          	beqz	a7,7a0 <printint+0x66>
    buf[i++] = '-';
 78c:	fd070793          	addi	a5,a4,-48
 790:	00878733          	add	a4,a5,s0
 794:	02d00793          	li	a5,45
 798:	fef70823          	sb	a5,-16(a4)
 79c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7a0:	02e05863          	blez	a4,7d0 <printint+0x96>
 7a4:	fc040793          	addi	a5,s0,-64
 7a8:	00e78933          	add	s2,a5,a4
 7ac:	fff78993          	addi	s3,a5,-1
 7b0:	99ba                	add	s3,s3,a4
 7b2:	377d                	addiw	a4,a4,-1
 7b4:	1702                	slli	a4,a4,0x20
 7b6:	9301                	srli	a4,a4,0x20
 7b8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7bc:	fff94583          	lbu	a1,-1(s2)
 7c0:	8526                	mv	a0,s1
 7c2:	00000097          	auipc	ra,0x0
 7c6:	f56080e7          	jalr	-170(ra) # 718 <putc>
  while(--i >= 0)
 7ca:	197d                	addi	s2,s2,-1
 7cc:	ff3918e3          	bne	s2,s3,7bc <printint+0x82>
}
 7d0:	70e2                	ld	ra,56(sp)
 7d2:	7442                	ld	s0,48(sp)
 7d4:	74a2                	ld	s1,40(sp)
 7d6:	7902                	ld	s2,32(sp)
 7d8:	69e2                	ld	s3,24(sp)
 7da:	6121                	addi	sp,sp,64
 7dc:	8082                	ret
    x = -xx;
 7de:	40b005bb          	negw	a1,a1
    neg = 1;
 7e2:	4885                	li	a7,1
    x = -xx;
 7e4:	bf85                	j	754 <printint+0x1a>

00000000000007e6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7e6:	715d                	addi	sp,sp,-80
 7e8:	e486                	sd	ra,72(sp)
 7ea:	e0a2                	sd	s0,64(sp)
 7ec:	fc26                	sd	s1,56(sp)
 7ee:	f84a                	sd	s2,48(sp)
 7f0:	f44e                	sd	s3,40(sp)
 7f2:	f052                	sd	s4,32(sp)
 7f4:	ec56                	sd	s5,24(sp)
 7f6:	e85a                	sd	s6,16(sp)
 7f8:	e45e                	sd	s7,8(sp)
 7fa:	e062                	sd	s8,0(sp)
 7fc:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7fe:	0005c903          	lbu	s2,0(a1)
 802:	18090c63          	beqz	s2,99a <vprintf+0x1b4>
 806:	8aaa                	mv	s5,a0
 808:	8bb2                	mv	s7,a2
 80a:	00158493          	addi	s1,a1,1
  state = 0;
 80e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 810:	02500a13          	li	s4,37
 814:	4b55                	li	s6,21
 816:	a839                	j	834 <vprintf+0x4e>
        putc(fd, c);
 818:	85ca                	mv	a1,s2
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	efc080e7          	jalr	-260(ra) # 718 <putc>
 824:	a019                	j	82a <vprintf+0x44>
    } else if(state == '%'){
 826:	01498d63          	beq	s3,s4,840 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 82a:	0485                	addi	s1,s1,1
 82c:	fff4c903          	lbu	s2,-1(s1)
 830:	16090563          	beqz	s2,99a <vprintf+0x1b4>
    if(state == 0){
 834:	fe0999e3          	bnez	s3,826 <vprintf+0x40>
      if(c == '%'){
 838:	ff4910e3          	bne	s2,s4,818 <vprintf+0x32>
        state = '%';
 83c:	89d2                	mv	s3,s4
 83e:	b7f5                	j	82a <vprintf+0x44>
      if(c == 'd'){
 840:	13490263          	beq	s2,s4,964 <vprintf+0x17e>
 844:	f9d9079b          	addiw	a5,s2,-99
 848:	0ff7f793          	zext.b	a5,a5
 84c:	12fb6563          	bltu	s6,a5,976 <vprintf+0x190>
 850:	f9d9079b          	addiw	a5,s2,-99
 854:	0ff7f713          	zext.b	a4,a5
 858:	10eb6f63          	bltu	s6,a4,976 <vprintf+0x190>
 85c:	00271793          	slli	a5,a4,0x2
 860:	00000717          	auipc	a4,0x0
 864:	37870713          	addi	a4,a4,888 # bd8 <malloc+0x140>
 868:	97ba                	add	a5,a5,a4
 86a:	439c                	lw	a5,0(a5)
 86c:	97ba                	add	a5,a5,a4
 86e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 870:	008b8913          	addi	s2,s7,8
 874:	4685                	li	a3,1
 876:	4629                	li	a2,10
 878:	000ba583          	lw	a1,0(s7)
 87c:	8556                	mv	a0,s5
 87e:	00000097          	auipc	ra,0x0
 882:	ebc080e7          	jalr	-324(ra) # 73a <printint>
 886:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 888:	4981                	li	s3,0
 88a:	b745                	j	82a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 88c:	008b8913          	addi	s2,s7,8
 890:	4681                	li	a3,0
 892:	4629                	li	a2,10
 894:	000ba583          	lw	a1,0(s7)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	ea0080e7          	jalr	-352(ra) # 73a <printint>
 8a2:	8bca                	mv	s7,s2
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b751                	j	82a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8a8:	008b8913          	addi	s2,s7,8
 8ac:	4681                	li	a3,0
 8ae:	4641                	li	a2,16
 8b0:	000ba583          	lw	a1,0(s7)
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	e84080e7          	jalr	-380(ra) # 73a <printint>
 8be:	8bca                	mv	s7,s2
      state = 0;
 8c0:	4981                	li	s3,0
 8c2:	b7a5                	j	82a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 8c4:	008b8c13          	addi	s8,s7,8
 8c8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8cc:	03000593          	li	a1,48
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	e46080e7          	jalr	-442(ra) # 718 <putc>
  putc(fd, 'x');
 8da:	07800593          	li	a1,120
 8de:	8556                	mv	a0,s5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	e38080e7          	jalr	-456(ra) # 718 <putc>
 8e8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8ea:	00000b97          	auipc	s7,0x0
 8ee:	346b8b93          	addi	s7,s7,838 # c30 <digits>
 8f2:	03c9d793          	srli	a5,s3,0x3c
 8f6:	97de                	add	a5,a5,s7
 8f8:	0007c583          	lbu	a1,0(a5)
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	e1a080e7          	jalr	-486(ra) # 718 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 906:	0992                	slli	s3,s3,0x4
 908:	397d                	addiw	s2,s2,-1
 90a:	fe0914e3          	bnez	s2,8f2 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 90e:	8be2                	mv	s7,s8
      state = 0;
 910:	4981                	li	s3,0
 912:	bf21                	j	82a <vprintf+0x44>
        s = va_arg(ap, char*);
 914:	008b8993          	addi	s3,s7,8
 918:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 91c:	02090163          	beqz	s2,93e <vprintf+0x158>
        while(*s != 0){
 920:	00094583          	lbu	a1,0(s2)
 924:	c9a5                	beqz	a1,994 <vprintf+0x1ae>
          putc(fd, *s);
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	df0080e7          	jalr	-528(ra) # 718 <putc>
          s++;
 930:	0905                	addi	s2,s2,1
        while(*s != 0){
 932:	00094583          	lbu	a1,0(s2)
 936:	f9e5                	bnez	a1,926 <vprintf+0x140>
        s = va_arg(ap, char*);
 938:	8bce                	mv	s7,s3
      state = 0;
 93a:	4981                	li	s3,0
 93c:	b5fd                	j	82a <vprintf+0x44>
          s = "(null)";
 93e:	00000917          	auipc	s2,0x0
 942:	29290913          	addi	s2,s2,658 # bd0 <malloc+0x138>
        while(*s != 0){
 946:	02800593          	li	a1,40
 94a:	bff1                	j	926 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 94c:	008b8913          	addi	s2,s7,8
 950:	000bc583          	lbu	a1,0(s7)
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	dc2080e7          	jalr	-574(ra) # 718 <putc>
 95e:	8bca                	mv	s7,s2
      state = 0;
 960:	4981                	li	s3,0
 962:	b5e1                	j	82a <vprintf+0x44>
        putc(fd, c);
 964:	02500593          	li	a1,37
 968:	8556                	mv	a0,s5
 96a:	00000097          	auipc	ra,0x0
 96e:	dae080e7          	jalr	-594(ra) # 718 <putc>
      state = 0;
 972:	4981                	li	s3,0
 974:	bd5d                	j	82a <vprintf+0x44>
        putc(fd, '%');
 976:	02500593          	li	a1,37
 97a:	8556                	mv	a0,s5
 97c:	00000097          	auipc	ra,0x0
 980:	d9c080e7          	jalr	-612(ra) # 718 <putc>
        putc(fd, c);
 984:	85ca                	mv	a1,s2
 986:	8556                	mv	a0,s5
 988:	00000097          	auipc	ra,0x0
 98c:	d90080e7          	jalr	-624(ra) # 718 <putc>
      state = 0;
 990:	4981                	li	s3,0
 992:	bd61                	j	82a <vprintf+0x44>
        s = va_arg(ap, char*);
 994:	8bce                	mv	s7,s3
      state = 0;
 996:	4981                	li	s3,0
 998:	bd49                	j	82a <vprintf+0x44>
    }
  }
}
 99a:	60a6                	ld	ra,72(sp)
 99c:	6406                	ld	s0,64(sp)
 99e:	74e2                	ld	s1,56(sp)
 9a0:	7942                	ld	s2,48(sp)
 9a2:	79a2                	ld	s3,40(sp)
 9a4:	7a02                	ld	s4,32(sp)
 9a6:	6ae2                	ld	s5,24(sp)
 9a8:	6b42                	ld	s6,16(sp)
 9aa:	6ba2                	ld	s7,8(sp)
 9ac:	6c02                	ld	s8,0(sp)
 9ae:	6161                	addi	sp,sp,80
 9b0:	8082                	ret

00000000000009b2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9b2:	715d                	addi	sp,sp,-80
 9b4:	ec06                	sd	ra,24(sp)
 9b6:	e822                	sd	s0,16(sp)
 9b8:	1000                	addi	s0,sp,32
 9ba:	e010                	sd	a2,0(s0)
 9bc:	e414                	sd	a3,8(s0)
 9be:	e818                	sd	a4,16(s0)
 9c0:	ec1c                	sd	a5,24(s0)
 9c2:	03043023          	sd	a6,32(s0)
 9c6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9ca:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9ce:	8622                	mv	a2,s0
 9d0:	00000097          	auipc	ra,0x0
 9d4:	e16080e7          	jalr	-490(ra) # 7e6 <vprintf>
}
 9d8:	60e2                	ld	ra,24(sp)
 9da:	6442                	ld	s0,16(sp)
 9dc:	6161                	addi	sp,sp,80
 9de:	8082                	ret

00000000000009e0 <printf>:

void
printf(const char *fmt, ...)
{
 9e0:	711d                	addi	sp,sp,-96
 9e2:	ec06                	sd	ra,24(sp)
 9e4:	e822                	sd	s0,16(sp)
 9e6:	1000                	addi	s0,sp,32
 9e8:	e40c                	sd	a1,8(s0)
 9ea:	e810                	sd	a2,16(s0)
 9ec:	ec14                	sd	a3,24(s0)
 9ee:	f018                	sd	a4,32(s0)
 9f0:	f41c                	sd	a5,40(s0)
 9f2:	03043823          	sd	a6,48(s0)
 9f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9fa:	00840613          	addi	a2,s0,8
 9fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a02:	85aa                	mv	a1,a0
 a04:	4505                	li	a0,1
 a06:	00000097          	auipc	ra,0x0
 a0a:	de0080e7          	jalr	-544(ra) # 7e6 <vprintf>
}
 a0e:	60e2                	ld	ra,24(sp)
 a10:	6442                	ld	s0,16(sp)
 a12:	6125                	addi	sp,sp,96
 a14:	8082                	ret

0000000000000a16 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a16:	1141                	addi	sp,sp,-16
 a18:	e422                	sd	s0,8(sp)
 a1a:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a1c:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a20:	00000797          	auipc	a5,0x0
 a24:	5f87b783          	ld	a5,1528(a5) # 1018 <freep>
 a28:	a02d                	j	a52 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a2a:	4618                	lw	a4,8(a2)
 a2c:	9f2d                	addw	a4,a4,a1
 a2e:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a32:	6398                	ld	a4,0(a5)
 a34:	6310                	ld	a2,0(a4)
 a36:	a83d                	j	a74 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a38:	ff852703          	lw	a4,-8(a0)
 a3c:	9f31                	addw	a4,a4,a2
 a3e:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a40:	ff053683          	ld	a3,-16(a0)
 a44:	a091                	j	a88 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a46:	6398                	ld	a4,0(a5)
 a48:	00e7e463          	bltu	a5,a4,a50 <free+0x3a>
 a4c:	00e6ea63          	bltu	a3,a4,a60 <free+0x4a>
{
 a50:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a52:	fed7fae3          	bgeu	a5,a3,a46 <free+0x30>
 a56:	6398                	ld	a4,0(a5)
 a58:	00e6e463          	bltu	a3,a4,a60 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5c:	fee7eae3          	bltu	a5,a4,a50 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 a60:	ff852583          	lw	a1,-8(a0)
 a64:	6390                	ld	a2,0(a5)
 a66:	02059813          	slli	a6,a1,0x20
 a6a:	01c85713          	srli	a4,a6,0x1c
 a6e:	9736                	add	a4,a4,a3
 a70:	fae60de3          	beq	a2,a4,a2a <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 a74:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 a78:	4790                	lw	a2,8(a5)
 a7a:	02061593          	slli	a1,a2,0x20
 a7e:	01c5d713          	srli	a4,a1,0x1c
 a82:	973e                	add	a4,a4,a5
 a84:	fae68ae3          	beq	a3,a4,a38 <free+0x22>
        p->s.ptr = bp->s.ptr;
 a88:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 a8a:	00000717          	auipc	a4,0x0
 a8e:	58f73723          	sd	a5,1422(a4) # 1018 <freep>
}
 a92:	6422                	ld	s0,8(sp)
 a94:	0141                	addi	sp,sp,16
 a96:	8082                	ret

0000000000000a98 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 a98:	7139                	addi	sp,sp,-64
 a9a:	fc06                	sd	ra,56(sp)
 a9c:	f822                	sd	s0,48(sp)
 a9e:	f426                	sd	s1,40(sp)
 aa0:	f04a                	sd	s2,32(sp)
 aa2:	ec4e                	sd	s3,24(sp)
 aa4:	e852                	sd	s4,16(sp)
 aa6:	e456                	sd	s5,8(sp)
 aa8:	e05a                	sd	s6,0(sp)
 aaa:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 aac:	02051493          	slli	s1,a0,0x20
 ab0:	9081                	srli	s1,s1,0x20
 ab2:	04bd                	addi	s1,s1,15
 ab4:	8091                	srli	s1,s1,0x4
 ab6:	0014899b          	addiw	s3,s1,1
 aba:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 abc:	00000517          	auipc	a0,0x0
 ac0:	55c53503          	ld	a0,1372(a0) # 1018 <freep>
 ac4:	c515                	beqz	a0,af0 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ac6:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 ac8:	4798                	lw	a4,8(a5)
 aca:	02977f63          	bgeu	a4,s1,b08 <malloc+0x70>
    if (nu < 4096)
 ace:	8a4e                	mv	s4,s3
 ad0:	0009871b          	sext.w	a4,s3
 ad4:	6685                	lui	a3,0x1
 ad6:	00d77363          	bgeu	a4,a3,adc <malloc+0x44>
 ada:	6a05                	lui	s4,0x1
 adc:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 ae0:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 ae4:	00000917          	auipc	s2,0x0
 ae8:	53490913          	addi	s2,s2,1332 # 1018 <freep>
    if (p == (char *)-1)
 aec:	5afd                	li	s5,-1
 aee:	a895                	j	b62 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 af0:	00000797          	auipc	a5,0x0
 af4:	5b078793          	addi	a5,a5,1456 # 10a0 <base>
 af8:	00000717          	auipc	a4,0x0
 afc:	52f73023          	sd	a5,1312(a4) # 1018 <freep>
 b00:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b02:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b06:	b7e1                	j	ace <malloc+0x36>
            if (p->s.size == nunits)
 b08:	02e48c63          	beq	s1,a4,b40 <malloc+0xa8>
                p->s.size -= nunits;
 b0c:	4137073b          	subw	a4,a4,s3
 b10:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b12:	02071693          	slli	a3,a4,0x20
 b16:	01c6d713          	srli	a4,a3,0x1c
 b1a:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b1c:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b20:	00000717          	auipc	a4,0x0
 b24:	4ea73c23          	sd	a0,1272(a4) # 1018 <freep>
            return (void *)(p + 1);
 b28:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b2c:	70e2                	ld	ra,56(sp)
 b2e:	7442                	ld	s0,48(sp)
 b30:	74a2                	ld	s1,40(sp)
 b32:	7902                	ld	s2,32(sp)
 b34:	69e2                	ld	s3,24(sp)
 b36:	6a42                	ld	s4,16(sp)
 b38:	6aa2                	ld	s5,8(sp)
 b3a:	6b02                	ld	s6,0(sp)
 b3c:	6121                	addi	sp,sp,64
 b3e:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b40:	6398                	ld	a4,0(a5)
 b42:	e118                	sd	a4,0(a0)
 b44:	bff1                	j	b20 <malloc+0x88>
    hp->s.size = nu;
 b46:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b4a:	0541                	addi	a0,a0,16
 b4c:	00000097          	auipc	ra,0x0
 b50:	eca080e7          	jalr	-310(ra) # a16 <free>
    return freep;
 b54:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b58:	d971                	beqz	a0,b2c <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b5a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 b5c:	4798                	lw	a4,8(a5)
 b5e:	fa9775e3          	bgeu	a4,s1,b08 <malloc+0x70>
        if (p == freep)
 b62:	00093703          	ld	a4,0(s2)
 b66:	853e                	mv	a0,a5
 b68:	fef719e3          	bne	a4,a5,b5a <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 b6c:	8552                	mv	a0,s4
 b6e:	00000097          	auipc	ra,0x0
 b72:	b7a080e7          	jalr	-1158(ra) # 6e8 <sbrk>
    if (p == (char *)-1)
 b76:	fd5518e3          	bne	a0,s5,b46 <malloc+0xae>
                return 0;
 b7a:	4501                	li	a0,0
 b7c:	bf45                	j	b2c <malloc+0x94>
