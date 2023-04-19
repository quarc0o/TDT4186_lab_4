
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
   c:	bb850513          	addi	a0,a0,-1096 # bc0 <malloc+0xf0>
  10:	00001097          	auipc	ra,0x1
  14:	a08080e7          	jalr	-1528(ra) # a18 <printf>
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
  3e:	1ec080e7          	jalr	492(ra) # 226 <tcreate>
    // Now, t points to an initialized thread struct

    tyield();
  42:	00000097          	auipc	ra,0x0
  46:	282080e7          	jalr	642(ra) # 2c4 <tyield>
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
  86:	2c4080e7          	jalr	708(ra) # 346 <twhoami>
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
  d2:	b0250513          	addi	a0,a0,-1278 # bd0 <malloc+0x100>
  d6:	00001097          	auipc	ra,0x1
  da:	942080e7          	jalr	-1726(ra) # a18 <printf>
        exit(-1);
  de:	557d                	li	a0,-1
  e0:	00000097          	auipc	ra,0x0
  e4:	5b8080e7          	jalr	1464(ra) # 698 <exit>
    {
        // give up the cpu for other threads
        tyield();
  e8:	00000097          	auipc	ra,0x0
  ec:	1dc080e7          	jalr	476(ra) # 2c4 <tyield>
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
 106:	244080e7          	jalr	580(ra) # 346 <twhoami>
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
 14a:	17e080e7          	jalr	382(ra) # 2c4 <tyield>
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret
        printf("releasing lock we are not holding");
 158:	00001517          	auipc	a0,0x1
 15c:	aa050513          	addi	a0,a0,-1376 # bf8 <malloc+0x128>
 160:	00001097          	auipc	ra,0x1
 164:	8b8080e7          	jalr	-1864(ra) # a18 <printf>
        exit(-1);
 168:	557d                	li	a0,-1
 16a:	00000097          	auipc	ra,0x0
 16e:	52e080e7          	jalr	1326(ra) # 698 <exit>

0000000000000172 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 172:	00001517          	auipc	a0,0x1
 176:	e9e53503          	ld	a0,-354(a0) # 1010 <current_thread>
 17a:	00001717          	auipc	a4,0x1
 17e:	ea670713          	addi	a4,a4,-346 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 182:	4781                	li	a5,0
 184:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 186:	6314                	ld	a3,0(a4)
 188:	00a68763          	beq	a3,a0,196 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 18c:	2785                	addiw	a5,a5,1
 18e:	0721                	addi	a4,a4,8
 190:	fec79be3          	bne	a5,a2,186 <tsched+0x14>
    int current_index = 0;
 194:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 196:	0017869b          	addiw	a3,a5,1
 19a:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 19e:	00001817          	auipc	a6,0x1
 1a2:	e8280813          	addi	a6,a6,-382 # 1020 <threads>
 1a6:	488d                	li	a7,3
 1a8:	a021                	j	1b0 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1aa:	2685                	addiw	a3,a3,1
 1ac:	04c68363          	beq	a3,a2,1f2 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1b0:	41f6d71b          	sraiw	a4,a3,0x1f
 1b4:	01c7571b          	srliw	a4,a4,0x1c
 1b8:	00d707bb          	addw	a5,a4,a3
 1bc:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1be:	9f99                	subw	a5,a5,a4
 1c0:	078e                	slli	a5,a5,0x3
 1c2:	97c2                	add	a5,a5,a6
 1c4:	638c                	ld	a1,0(a5)
 1c6:	d1f5                	beqz	a1,1aa <tsched+0x38>
 1c8:	5dbc                	lw	a5,120(a1)
 1ca:	ff1790e3          	bne	a5,a7,1aa <tsched+0x38>
{
 1ce:	1141                	addi	sp,sp,-16
 1d0:	e406                	sd	ra,8(sp)
 1d2:	e022                	sd	s0,0(sp)
 1d4:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1d6:	00001797          	auipc	a5,0x1
 1da:	e2b7bd23          	sd	a1,-454(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1de:	05a1                	addi	a1,a1,8
 1e0:	0521                	addi	a0,a0,8
 1e2:	00000097          	auipc	ra,0x0
 1e6:	17c080e7          	jalr	380(ra) # 35e <tswtch>
        //printf("Thread switch complete\n");
    }
}
 1ea:	60a2                	ld	ra,8(sp)
 1ec:	6402                	ld	s0,0(sp)
 1ee:	0141                	addi	sp,sp,16
 1f0:	8082                	ret
 1f2:	8082                	ret

00000000000001f4 <thread_wrapper>:
{
 1f4:	1101                	addi	sp,sp,-32
 1f6:	ec06                	sd	ra,24(sp)
 1f8:	e822                	sd	s0,16(sp)
 1fa:	e426                	sd	s1,8(sp)
 1fc:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 1fe:	00001497          	auipc	s1,0x1
 202:	e1248493          	addi	s1,s1,-494 # 1010 <current_thread>
 206:	609c                	ld	a5,0(s1)
 208:	67d8                	ld	a4,136(a5)
 20a:	63c8                	ld	a0,128(a5)
 20c:	9702                	jalr	a4
    current_thread->state = EXITED;
 20e:	609c                	ld	a5,0(s1)
 210:	4719                	li	a4,6
 212:	dfb8                	sw	a4,120(a5)
    tsched();
 214:	00000097          	auipc	ra,0x0
 218:	f5e080e7          	jalr	-162(ra) # 172 <tsched>
}
 21c:	60e2                	ld	ra,24(sp)
 21e:	6442                	ld	s0,16(sp)
 220:	64a2                	ld	s1,8(sp)
 222:	6105                	addi	sp,sp,32
 224:	8082                	ret

0000000000000226 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 226:	7179                	addi	sp,sp,-48
 228:	f406                	sd	ra,40(sp)
 22a:	f022                	sd	s0,32(sp)
 22c:	ec26                	sd	s1,24(sp)
 22e:	e84a                	sd	s2,16(sp)
 230:	e44e                	sd	s3,8(sp)
 232:	1800                	addi	s0,sp,48
 234:	84aa                	mv	s1,a0
 236:	89b2                	mv	s3,a2
 238:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 23a:	09800513          	li	a0,152
 23e:	00001097          	auipc	ra,0x1
 242:	892080e7          	jalr	-1902(ra) # ad0 <malloc>
 246:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 248:	478d                	li	a5,3
 24a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 24c:	609c                	ld	a5,0(s1)
 24e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 252:	609c                	ld	a5,0(s1)
 254:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 258:	6098                	ld	a4,0(s1)
 25a:	00001797          	auipc	a5,0x1
 25e:	da678793          	addi	a5,a5,-602 # 1000 <next_tid>
 262:	4394                	lw	a3,0(a5)
 264:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 268:	4398                	lw	a4,0(a5)
 26a:	2705                	addiw	a4,a4,1
 26c:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 26e:	6505                	lui	a0,0x1
 270:	00001097          	auipc	ra,0x1
 274:	860080e7          	jalr	-1952(ra) # ad0 <malloc>
 278:	609c                	ld	a5,0(s1)
 27a:	6705                	lui	a4,0x1
 27c:	953a                	add	a0,a0,a4
 27e:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 280:	609c                	ld	a5,0(s1)
 282:	00000717          	auipc	a4,0x0
 286:	f7270713          	addi	a4,a4,-142 # 1f4 <thread_wrapper>
 28a:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 28c:	00001717          	auipc	a4,0x1
 290:	d9470713          	addi	a4,a4,-620 # 1020 <threads>
 294:	4781                	li	a5,0
 296:	4641                	li	a2,16
        if (threads[i] == NULL) {
 298:	6314                	ld	a3,0(a4)
 29a:	ce81                	beqz	a3,2b2 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 29c:	2785                	addiw	a5,a5,1
 29e:	0721                	addi	a4,a4,8
 2a0:	fec79ce3          	bne	a5,a2,298 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 2a4:	70a2                	ld	ra,40(sp)
 2a6:	7402                	ld	s0,32(sp)
 2a8:	64e2                	ld	s1,24(sp)
 2aa:	6942                	ld	s2,16(sp)
 2ac:	69a2                	ld	s3,8(sp)
 2ae:	6145                	addi	sp,sp,48
 2b0:	8082                	ret
            threads[i] = *thread;
 2b2:	6094                	ld	a3,0(s1)
 2b4:	078e                	slli	a5,a5,0x3
 2b6:	00001717          	auipc	a4,0x1
 2ba:	d6a70713          	addi	a4,a4,-662 # 1020 <threads>
 2be:	97ba                	add	a5,a5,a4
 2c0:	e394                	sd	a3,0(a5)
            break;
 2c2:	b7cd                	j	2a4 <tcreate+0x7e>

00000000000002c4 <tyield>:
    return 0;
}


void tyield()
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 2cc:	00001797          	auipc	a5,0x1
 2d0:	d447b783          	ld	a5,-700(a5) # 1010 <current_thread>
 2d4:	470d                	li	a4,3
 2d6:	dfb8                	sw	a4,120(a5)
    tsched();
 2d8:	00000097          	auipc	ra,0x0
 2dc:	e9a080e7          	jalr	-358(ra) # 172 <tsched>
}
 2e0:	60a2                	ld	ra,8(sp)
 2e2:	6402                	ld	s0,0(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <tjoin>:
{
 2e8:	1101                	addi	sp,sp,-32
 2ea:	ec06                	sd	ra,24(sp)
 2ec:	e822                	sd	s0,16(sp)
 2ee:	e426                	sd	s1,8(sp)
 2f0:	e04a                	sd	s2,0(sp)
 2f2:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 2f4:	00001797          	auipc	a5,0x1
 2f8:	d2c78793          	addi	a5,a5,-724 # 1020 <threads>
 2fc:	00001697          	auipc	a3,0x1
 300:	da468693          	addi	a3,a3,-604 # 10a0 <base>
 304:	a021                	j	30c <tjoin+0x24>
 306:	07a1                	addi	a5,a5,8
 308:	02d78b63          	beq	a5,a3,33e <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 30c:	6384                	ld	s1,0(a5)
 30e:	dce5                	beqz	s1,306 <tjoin+0x1e>
 310:	0004c703          	lbu	a4,0(s1)
 314:	fea719e3          	bne	a4,a0,306 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 318:	5cb8                	lw	a4,120(s1)
 31a:	4799                	li	a5,6
 31c:	4919                	li	s2,6
 31e:	02f70263          	beq	a4,a5,342 <tjoin+0x5a>
        tyield();
 322:	00000097          	auipc	ra,0x0
 326:	fa2080e7          	jalr	-94(ra) # 2c4 <tyield>
    while (target_thread->state != EXITED) {
 32a:	5cbc                	lw	a5,120(s1)
 32c:	ff279be3          	bne	a5,s2,322 <tjoin+0x3a>
    return 0;
 330:	4501                	li	a0,0
}
 332:	60e2                	ld	ra,24(sp)
 334:	6442                	ld	s0,16(sp)
 336:	64a2                	ld	s1,8(sp)
 338:	6902                	ld	s2,0(sp)
 33a:	6105                	addi	sp,sp,32
 33c:	8082                	ret
        return -1;
 33e:	557d                	li	a0,-1
 340:	bfcd                	j	332 <tjoin+0x4a>
    return 0;
 342:	4501                	li	a0,0
 344:	b7fd                	j	332 <tjoin+0x4a>

0000000000000346 <twhoami>:

uint8 twhoami()
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 34c:	00001797          	auipc	a5,0x1
 350:	cc47b783          	ld	a5,-828(a5) # 1010 <current_thread>
 354:	0007c503          	lbu	a0,0(a5)
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret

000000000000035e <tswtch>:
 35e:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 362:	00253423          	sd	sp,8(a0)
 366:	e900                	sd	s0,16(a0)
 368:	ed04                	sd	s1,24(a0)
 36a:	03253023          	sd	s2,32(a0)
 36e:	03353423          	sd	s3,40(a0)
 372:	03453823          	sd	s4,48(a0)
 376:	03553c23          	sd	s5,56(a0)
 37a:	05653023          	sd	s6,64(a0)
 37e:	05753423          	sd	s7,72(a0)
 382:	05853823          	sd	s8,80(a0)
 386:	05953c23          	sd	s9,88(a0)
 38a:	07a53023          	sd	s10,96(a0)
 38e:	07b53423          	sd	s11,104(a0)
 392:	0005b083          	ld	ra,0(a1)
 396:	0085b103          	ld	sp,8(a1)
 39a:	6980                	ld	s0,16(a1)
 39c:	6d84                	ld	s1,24(a1)
 39e:	0205b903          	ld	s2,32(a1)
 3a2:	0285b983          	ld	s3,40(a1)
 3a6:	0305ba03          	ld	s4,48(a1)
 3aa:	0385ba83          	ld	s5,56(a1)
 3ae:	0405bb03          	ld	s6,64(a1)
 3b2:	0485bb83          	ld	s7,72(a1)
 3b6:	0505bc03          	ld	s8,80(a1)
 3ba:	0585bc83          	ld	s9,88(a1)
 3be:	0605bd03          	ld	s10,96(a1)
 3c2:	0685bd83          	ld	s11,104(a1)
 3c6:	8082                	ret

00000000000003c8 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3c8:	1101                	addi	sp,sp,-32
 3ca:	ec06                	sd	ra,24(sp)
 3cc:	e822                	sd	s0,16(sp)
 3ce:	e426                	sd	s1,8(sp)
 3d0:	e04a                	sd	s2,0(sp)
 3d2:	1000                	addi	s0,sp,32
 3d4:	84aa                	mv	s1,a0
 3d6:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3d8:	09800513          	li	a0,152
 3dc:	00000097          	auipc	ra,0x0
 3e0:	6f4080e7          	jalr	1780(ra) # ad0 <malloc>

    main_thread->tid = 1;
 3e4:	4785                	li	a5,1
 3e6:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 3ea:	4791                	li	a5,4
 3ec:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3ee:	00001797          	auipc	a5,0x1
 3f2:	c2a7b123          	sd	a0,-990(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3f6:	00001797          	auipc	a5,0x1
 3fa:	c2a78793          	addi	a5,a5,-982 # 1020 <threads>
 3fe:	00001717          	auipc	a4,0x1
 402:	ca270713          	addi	a4,a4,-862 # 10a0 <base>
        threads[i] = NULL;
 406:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 40a:	07a1                	addi	a5,a5,8
 40c:	fee79de3          	bne	a5,a4,406 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 410:	00001797          	auipc	a5,0x1
 414:	c0a7b823          	sd	a0,-1008(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 418:	85ca                	mv	a1,s2
 41a:	8526                	mv	a0,s1
 41c:	00000097          	auipc	ra,0x0
 420:	c06080e7          	jalr	-1018(ra) # 22 <main>
    //tsched();

    exit(res);
 424:	00000097          	auipc	ra,0x0
 428:	274080e7          	jalr	628(ra) # 698 <exit>

000000000000042c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 42c:	1141                	addi	sp,sp,-16
 42e:	e422                	sd	s0,8(sp)
 430:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 432:	87aa                	mv	a5,a0
 434:	0585                	addi	a1,a1,1
 436:	0785                	addi	a5,a5,1
 438:	fff5c703          	lbu	a4,-1(a1)
 43c:	fee78fa3          	sb	a4,-1(a5)
 440:	fb75                	bnez	a4,434 <strcpy+0x8>
        ;
    return os;
}
 442:	6422                	ld	s0,8(sp)
 444:	0141                	addi	sp,sp,16
 446:	8082                	ret

0000000000000448 <strcmp>:

int strcmp(const char *p, const char *q)
{
 448:	1141                	addi	sp,sp,-16
 44a:	e422                	sd	s0,8(sp)
 44c:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 44e:	00054783          	lbu	a5,0(a0)
 452:	cb91                	beqz	a5,466 <strcmp+0x1e>
 454:	0005c703          	lbu	a4,0(a1)
 458:	00f71763          	bne	a4,a5,466 <strcmp+0x1e>
        p++, q++;
 45c:	0505                	addi	a0,a0,1
 45e:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 460:	00054783          	lbu	a5,0(a0)
 464:	fbe5                	bnez	a5,454 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 466:	0005c503          	lbu	a0,0(a1)
}
 46a:	40a7853b          	subw	a0,a5,a0
 46e:	6422                	ld	s0,8(sp)
 470:	0141                	addi	sp,sp,16
 472:	8082                	ret

0000000000000474 <strlen>:

uint strlen(const char *s)
{
 474:	1141                	addi	sp,sp,-16
 476:	e422                	sd	s0,8(sp)
 478:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 47a:	00054783          	lbu	a5,0(a0)
 47e:	cf91                	beqz	a5,49a <strlen+0x26>
 480:	0505                	addi	a0,a0,1
 482:	87aa                	mv	a5,a0
 484:	86be                	mv	a3,a5
 486:	0785                	addi	a5,a5,1
 488:	fff7c703          	lbu	a4,-1(a5)
 48c:	ff65                	bnez	a4,484 <strlen+0x10>
 48e:	40a6853b          	subw	a0,a3,a0
 492:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret
    for (n = 0; s[n]; n++)
 49a:	4501                	li	a0,0
 49c:	bfe5                	j	494 <strlen+0x20>

000000000000049e <memset>:

void *
memset(void *dst, int c, uint n)
{
 49e:	1141                	addi	sp,sp,-16
 4a0:	e422                	sd	s0,8(sp)
 4a2:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4a4:	ca19                	beqz	a2,4ba <memset+0x1c>
 4a6:	87aa                	mv	a5,a0
 4a8:	1602                	slli	a2,a2,0x20
 4aa:	9201                	srli	a2,a2,0x20
 4ac:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4b0:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4b4:	0785                	addi	a5,a5,1
 4b6:	fee79de3          	bne	a5,a4,4b0 <memset+0x12>
    }
    return dst;
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret

00000000000004c0 <strchr>:

char *
strchr(const char *s, char c)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4c6:	00054783          	lbu	a5,0(a0)
 4ca:	cb99                	beqz	a5,4e0 <strchr+0x20>
        if (*s == c)
 4cc:	00f58763          	beq	a1,a5,4da <strchr+0x1a>
    for (; *s; s++)
 4d0:	0505                	addi	a0,a0,1
 4d2:	00054783          	lbu	a5,0(a0)
 4d6:	fbfd                	bnez	a5,4cc <strchr+0xc>
            return (char *)s;
    return 0;
 4d8:	4501                	li	a0,0
}
 4da:	6422                	ld	s0,8(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret
    return 0;
 4e0:	4501                	li	a0,0
 4e2:	bfe5                	j	4da <strchr+0x1a>

00000000000004e4 <gets>:

char *
gets(char *buf, int max)
{
 4e4:	711d                	addi	sp,sp,-96
 4e6:	ec86                	sd	ra,88(sp)
 4e8:	e8a2                	sd	s0,80(sp)
 4ea:	e4a6                	sd	s1,72(sp)
 4ec:	e0ca                	sd	s2,64(sp)
 4ee:	fc4e                	sd	s3,56(sp)
 4f0:	f852                	sd	s4,48(sp)
 4f2:	f456                	sd	s5,40(sp)
 4f4:	f05a                	sd	s6,32(sp)
 4f6:	ec5e                	sd	s7,24(sp)
 4f8:	1080                	addi	s0,sp,96
 4fa:	8baa                	mv	s7,a0
 4fc:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 4fe:	892a                	mv	s2,a0
 500:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 502:	4aa9                	li	s5,10
 504:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 506:	89a6                	mv	s3,s1
 508:	2485                	addiw	s1,s1,1
 50a:	0344d863          	bge	s1,s4,53a <gets+0x56>
        cc = read(0, &c, 1);
 50e:	4605                	li	a2,1
 510:	faf40593          	addi	a1,s0,-81
 514:	4501                	li	a0,0
 516:	00000097          	auipc	ra,0x0
 51a:	19a080e7          	jalr	410(ra) # 6b0 <read>
        if (cc < 1)
 51e:	00a05e63          	blez	a0,53a <gets+0x56>
        buf[i++] = c;
 522:	faf44783          	lbu	a5,-81(s0)
 526:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 52a:	01578763          	beq	a5,s5,538 <gets+0x54>
 52e:	0905                	addi	s2,s2,1
 530:	fd679be3          	bne	a5,s6,506 <gets+0x22>
    for (i = 0; i + 1 < max;)
 534:	89a6                	mv	s3,s1
 536:	a011                	j	53a <gets+0x56>
 538:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 53a:	99de                	add	s3,s3,s7
 53c:	00098023          	sb	zero,0(s3)
    return buf;
}
 540:	855e                	mv	a0,s7
 542:	60e6                	ld	ra,88(sp)
 544:	6446                	ld	s0,80(sp)
 546:	64a6                	ld	s1,72(sp)
 548:	6906                	ld	s2,64(sp)
 54a:	79e2                	ld	s3,56(sp)
 54c:	7a42                	ld	s4,48(sp)
 54e:	7aa2                	ld	s5,40(sp)
 550:	7b02                	ld	s6,32(sp)
 552:	6be2                	ld	s7,24(sp)
 554:	6125                	addi	sp,sp,96
 556:	8082                	ret

0000000000000558 <stat>:

int stat(const char *n, struct stat *st)
{
 558:	1101                	addi	sp,sp,-32
 55a:	ec06                	sd	ra,24(sp)
 55c:	e822                	sd	s0,16(sp)
 55e:	e426                	sd	s1,8(sp)
 560:	e04a                	sd	s2,0(sp)
 562:	1000                	addi	s0,sp,32
 564:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 566:	4581                	li	a1,0
 568:	00000097          	auipc	ra,0x0
 56c:	170080e7          	jalr	368(ra) # 6d8 <open>
    if (fd < 0)
 570:	02054563          	bltz	a0,59a <stat+0x42>
 574:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 576:	85ca                	mv	a1,s2
 578:	00000097          	auipc	ra,0x0
 57c:	178080e7          	jalr	376(ra) # 6f0 <fstat>
 580:	892a                	mv	s2,a0
    close(fd);
 582:	8526                	mv	a0,s1
 584:	00000097          	auipc	ra,0x0
 588:	13c080e7          	jalr	316(ra) # 6c0 <close>
    return r;
}
 58c:	854a                	mv	a0,s2
 58e:	60e2                	ld	ra,24(sp)
 590:	6442                	ld	s0,16(sp)
 592:	64a2                	ld	s1,8(sp)
 594:	6902                	ld	s2,0(sp)
 596:	6105                	addi	sp,sp,32
 598:	8082                	ret
        return -1;
 59a:	597d                	li	s2,-1
 59c:	bfc5                	j	58c <stat+0x34>

000000000000059e <atoi>:

int atoi(const char *s)
{
 59e:	1141                	addi	sp,sp,-16
 5a0:	e422                	sd	s0,8(sp)
 5a2:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5a4:	00054683          	lbu	a3,0(a0)
 5a8:	fd06879b          	addiw	a5,a3,-48
 5ac:	0ff7f793          	zext.b	a5,a5
 5b0:	4625                	li	a2,9
 5b2:	02f66863          	bltu	a2,a5,5e2 <atoi+0x44>
 5b6:	872a                	mv	a4,a0
    n = 0;
 5b8:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5ba:	0705                	addi	a4,a4,1
 5bc:	0025179b          	slliw	a5,a0,0x2
 5c0:	9fa9                	addw	a5,a5,a0
 5c2:	0017979b          	slliw	a5,a5,0x1
 5c6:	9fb5                	addw	a5,a5,a3
 5c8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5cc:	00074683          	lbu	a3,0(a4)
 5d0:	fd06879b          	addiw	a5,a3,-48
 5d4:	0ff7f793          	zext.b	a5,a5
 5d8:	fef671e3          	bgeu	a2,a5,5ba <atoi+0x1c>
    return n;
}
 5dc:	6422                	ld	s0,8(sp)
 5de:	0141                	addi	sp,sp,16
 5e0:	8082                	ret
    n = 0;
 5e2:	4501                	li	a0,0
 5e4:	bfe5                	j	5dc <atoi+0x3e>

00000000000005e6 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5e6:	1141                	addi	sp,sp,-16
 5e8:	e422                	sd	s0,8(sp)
 5ea:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5ec:	02b57463          	bgeu	a0,a1,614 <memmove+0x2e>
    {
        while (n-- > 0)
 5f0:	00c05f63          	blez	a2,60e <memmove+0x28>
 5f4:	1602                	slli	a2,a2,0x20
 5f6:	9201                	srli	a2,a2,0x20
 5f8:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 5fc:	872a                	mv	a4,a0
            *dst++ = *src++;
 5fe:	0585                	addi	a1,a1,1
 600:	0705                	addi	a4,a4,1
 602:	fff5c683          	lbu	a3,-1(a1)
 606:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 60a:	fee79ae3          	bne	a5,a4,5fe <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 60e:	6422                	ld	s0,8(sp)
 610:	0141                	addi	sp,sp,16
 612:	8082                	ret
        dst += n;
 614:	00c50733          	add	a4,a0,a2
        src += n;
 618:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 61a:	fec05ae3          	blez	a2,60e <memmove+0x28>
 61e:	fff6079b          	addiw	a5,a2,-1
 622:	1782                	slli	a5,a5,0x20
 624:	9381                	srli	a5,a5,0x20
 626:	fff7c793          	not	a5,a5
 62a:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 62c:	15fd                	addi	a1,a1,-1
 62e:	177d                	addi	a4,a4,-1
 630:	0005c683          	lbu	a3,0(a1)
 634:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 638:	fee79ae3          	bne	a5,a4,62c <memmove+0x46>
 63c:	bfc9                	j	60e <memmove+0x28>

000000000000063e <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 63e:	1141                	addi	sp,sp,-16
 640:	e422                	sd	s0,8(sp)
 642:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 644:	ca05                	beqz	a2,674 <memcmp+0x36>
 646:	fff6069b          	addiw	a3,a2,-1
 64a:	1682                	slli	a3,a3,0x20
 64c:	9281                	srli	a3,a3,0x20
 64e:	0685                	addi	a3,a3,1
 650:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 652:	00054783          	lbu	a5,0(a0)
 656:	0005c703          	lbu	a4,0(a1)
 65a:	00e79863          	bne	a5,a4,66a <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 65e:	0505                	addi	a0,a0,1
        p2++;
 660:	0585                	addi	a1,a1,1
    while (n-- > 0)
 662:	fed518e3          	bne	a0,a3,652 <memcmp+0x14>
    }
    return 0;
 666:	4501                	li	a0,0
 668:	a019                	j	66e <memcmp+0x30>
            return *p1 - *p2;
 66a:	40e7853b          	subw	a0,a5,a4
}
 66e:	6422                	ld	s0,8(sp)
 670:	0141                	addi	sp,sp,16
 672:	8082                	ret
    return 0;
 674:	4501                	li	a0,0
 676:	bfe5                	j	66e <memcmp+0x30>

0000000000000678 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 678:	1141                	addi	sp,sp,-16
 67a:	e406                	sd	ra,8(sp)
 67c:	e022                	sd	s0,0(sp)
 67e:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 680:	00000097          	auipc	ra,0x0
 684:	f66080e7          	jalr	-154(ra) # 5e6 <memmove>
}
 688:	60a2                	ld	ra,8(sp)
 68a:	6402                	ld	s0,0(sp)
 68c:	0141                	addi	sp,sp,16
 68e:	8082                	ret

0000000000000690 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 690:	4885                	li	a7,1
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <exit>:
.global exit
exit:
 li a7, SYS_exit
 698:	4889                	li	a7,2
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6a0:	488d                	li	a7,3
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6a8:	4891                	li	a7,4
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <read>:
.global read
read:
 li a7, SYS_read
 6b0:	4895                	li	a7,5
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <write>:
.global write
write:
 li a7, SYS_write
 6b8:	48c1                	li	a7,16
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <close>:
.global close
close:
 li a7, SYS_close
 6c0:	48d5                	li	a7,21
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6c8:	4899                	li	a7,6
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6d0:	489d                	li	a7,7
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <open>:
.global open
open:
 li a7, SYS_open
 6d8:	48bd                	li	a7,15
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6e0:	48c5                	li	a7,17
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6e8:	48c9                	li	a7,18
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6f0:	48a1                	li	a7,8
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <link>:
.global link
link:
 li a7, SYS_link
 6f8:	48cd                	li	a7,19
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 700:	48d1                	li	a7,20
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 708:	48a5                	li	a7,9
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <dup>:
.global dup
dup:
 li a7, SYS_dup
 710:	48a9                	li	a7,10
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 718:	48ad                	li	a7,11
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 720:	48b1                	li	a7,12
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 728:	48b5                	li	a7,13
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 730:	48b9                	li	a7,14
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <ps>:
.global ps
ps:
 li a7, SYS_ps
 738:	48d9                	li	a7,22
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 740:	48dd                	li	a7,23
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 748:	48e1                	li	a7,24
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 750:	1101                	addi	sp,sp,-32
 752:	ec06                	sd	ra,24(sp)
 754:	e822                	sd	s0,16(sp)
 756:	1000                	addi	s0,sp,32
 758:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 75c:	4605                	li	a2,1
 75e:	fef40593          	addi	a1,s0,-17
 762:	00000097          	auipc	ra,0x0
 766:	f56080e7          	jalr	-170(ra) # 6b8 <write>
}
 76a:	60e2                	ld	ra,24(sp)
 76c:	6442                	ld	s0,16(sp)
 76e:	6105                	addi	sp,sp,32
 770:	8082                	ret

0000000000000772 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 772:	7139                	addi	sp,sp,-64
 774:	fc06                	sd	ra,56(sp)
 776:	f822                	sd	s0,48(sp)
 778:	f426                	sd	s1,40(sp)
 77a:	f04a                	sd	s2,32(sp)
 77c:	ec4e                	sd	s3,24(sp)
 77e:	0080                	addi	s0,sp,64
 780:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 782:	c299                	beqz	a3,788 <printint+0x16>
 784:	0805c963          	bltz	a1,816 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 788:	2581                	sext.w	a1,a1
  neg = 0;
 78a:	4881                	li	a7,0
 78c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 790:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 792:	2601                	sext.w	a2,a2
 794:	00000517          	auipc	a0,0x0
 798:	4ec50513          	addi	a0,a0,1260 # c80 <digits>
 79c:	883a                	mv	a6,a4
 79e:	2705                	addiw	a4,a4,1
 7a0:	02c5f7bb          	remuw	a5,a1,a2
 7a4:	1782                	slli	a5,a5,0x20
 7a6:	9381                	srli	a5,a5,0x20
 7a8:	97aa                	add	a5,a5,a0
 7aa:	0007c783          	lbu	a5,0(a5)
 7ae:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7b2:	0005879b          	sext.w	a5,a1
 7b6:	02c5d5bb          	divuw	a1,a1,a2
 7ba:	0685                	addi	a3,a3,1
 7bc:	fec7f0e3          	bgeu	a5,a2,79c <printint+0x2a>
  if(neg)
 7c0:	00088c63          	beqz	a7,7d8 <printint+0x66>
    buf[i++] = '-';
 7c4:	fd070793          	addi	a5,a4,-48
 7c8:	00878733          	add	a4,a5,s0
 7cc:	02d00793          	li	a5,45
 7d0:	fef70823          	sb	a5,-16(a4)
 7d4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7d8:	02e05863          	blez	a4,808 <printint+0x96>
 7dc:	fc040793          	addi	a5,s0,-64
 7e0:	00e78933          	add	s2,a5,a4
 7e4:	fff78993          	addi	s3,a5,-1
 7e8:	99ba                	add	s3,s3,a4
 7ea:	377d                	addiw	a4,a4,-1
 7ec:	1702                	slli	a4,a4,0x20
 7ee:	9301                	srli	a4,a4,0x20
 7f0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7f4:	fff94583          	lbu	a1,-1(s2)
 7f8:	8526                	mv	a0,s1
 7fa:	00000097          	auipc	ra,0x0
 7fe:	f56080e7          	jalr	-170(ra) # 750 <putc>
  while(--i >= 0)
 802:	197d                	addi	s2,s2,-1
 804:	ff3918e3          	bne	s2,s3,7f4 <printint+0x82>
}
 808:	70e2                	ld	ra,56(sp)
 80a:	7442                	ld	s0,48(sp)
 80c:	74a2                	ld	s1,40(sp)
 80e:	7902                	ld	s2,32(sp)
 810:	69e2                	ld	s3,24(sp)
 812:	6121                	addi	sp,sp,64
 814:	8082                	ret
    x = -xx;
 816:	40b005bb          	negw	a1,a1
    neg = 1;
 81a:	4885                	li	a7,1
    x = -xx;
 81c:	bf85                	j	78c <printint+0x1a>

000000000000081e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 81e:	715d                	addi	sp,sp,-80
 820:	e486                	sd	ra,72(sp)
 822:	e0a2                	sd	s0,64(sp)
 824:	fc26                	sd	s1,56(sp)
 826:	f84a                	sd	s2,48(sp)
 828:	f44e                	sd	s3,40(sp)
 82a:	f052                	sd	s4,32(sp)
 82c:	ec56                	sd	s5,24(sp)
 82e:	e85a                	sd	s6,16(sp)
 830:	e45e                	sd	s7,8(sp)
 832:	e062                	sd	s8,0(sp)
 834:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 836:	0005c903          	lbu	s2,0(a1)
 83a:	18090c63          	beqz	s2,9d2 <vprintf+0x1b4>
 83e:	8aaa                	mv	s5,a0
 840:	8bb2                	mv	s7,a2
 842:	00158493          	addi	s1,a1,1
  state = 0;
 846:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 848:	02500a13          	li	s4,37
 84c:	4b55                	li	s6,21
 84e:	a839                	j	86c <vprintf+0x4e>
        putc(fd, c);
 850:	85ca                	mv	a1,s2
 852:	8556                	mv	a0,s5
 854:	00000097          	auipc	ra,0x0
 858:	efc080e7          	jalr	-260(ra) # 750 <putc>
 85c:	a019                	j	862 <vprintf+0x44>
    } else if(state == '%'){
 85e:	01498d63          	beq	s3,s4,878 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 862:	0485                	addi	s1,s1,1
 864:	fff4c903          	lbu	s2,-1(s1)
 868:	16090563          	beqz	s2,9d2 <vprintf+0x1b4>
    if(state == 0){
 86c:	fe0999e3          	bnez	s3,85e <vprintf+0x40>
      if(c == '%'){
 870:	ff4910e3          	bne	s2,s4,850 <vprintf+0x32>
        state = '%';
 874:	89d2                	mv	s3,s4
 876:	b7f5                	j	862 <vprintf+0x44>
      if(c == 'd'){
 878:	13490263          	beq	s2,s4,99c <vprintf+0x17e>
 87c:	f9d9079b          	addiw	a5,s2,-99
 880:	0ff7f793          	zext.b	a5,a5
 884:	12fb6563          	bltu	s6,a5,9ae <vprintf+0x190>
 888:	f9d9079b          	addiw	a5,s2,-99
 88c:	0ff7f713          	zext.b	a4,a5
 890:	10eb6f63          	bltu	s6,a4,9ae <vprintf+0x190>
 894:	00271793          	slli	a5,a4,0x2
 898:	00000717          	auipc	a4,0x0
 89c:	39070713          	addi	a4,a4,912 # c28 <malloc+0x158>
 8a0:	97ba                	add	a5,a5,a4
 8a2:	439c                	lw	a5,0(a5)
 8a4:	97ba                	add	a5,a5,a4
 8a6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8a8:	008b8913          	addi	s2,s7,8
 8ac:	4685                	li	a3,1
 8ae:	4629                	li	a2,10
 8b0:	000ba583          	lw	a1,0(s7)
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	ebc080e7          	jalr	-324(ra) # 772 <printint>
 8be:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8c0:	4981                	li	s3,0
 8c2:	b745                	j	862 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c4:	008b8913          	addi	s2,s7,8
 8c8:	4681                	li	a3,0
 8ca:	4629                	li	a2,10
 8cc:	000ba583          	lw	a1,0(s7)
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	ea0080e7          	jalr	-352(ra) # 772 <printint>
 8da:	8bca                	mv	s7,s2
      state = 0;
 8dc:	4981                	li	s3,0
 8de:	b751                	j	862 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8e0:	008b8913          	addi	s2,s7,8
 8e4:	4681                	li	a3,0
 8e6:	4641                	li	a2,16
 8e8:	000ba583          	lw	a1,0(s7)
 8ec:	8556                	mv	a0,s5
 8ee:	00000097          	auipc	ra,0x0
 8f2:	e84080e7          	jalr	-380(ra) # 772 <printint>
 8f6:	8bca                	mv	s7,s2
      state = 0;
 8f8:	4981                	li	s3,0
 8fa:	b7a5                	j	862 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 8fc:	008b8c13          	addi	s8,s7,8
 900:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 904:	03000593          	li	a1,48
 908:	8556                	mv	a0,s5
 90a:	00000097          	auipc	ra,0x0
 90e:	e46080e7          	jalr	-442(ra) # 750 <putc>
  putc(fd, 'x');
 912:	07800593          	li	a1,120
 916:	8556                	mv	a0,s5
 918:	00000097          	auipc	ra,0x0
 91c:	e38080e7          	jalr	-456(ra) # 750 <putc>
 920:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 922:	00000b97          	auipc	s7,0x0
 926:	35eb8b93          	addi	s7,s7,862 # c80 <digits>
 92a:	03c9d793          	srli	a5,s3,0x3c
 92e:	97de                	add	a5,a5,s7
 930:	0007c583          	lbu	a1,0(a5)
 934:	8556                	mv	a0,s5
 936:	00000097          	auipc	ra,0x0
 93a:	e1a080e7          	jalr	-486(ra) # 750 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 93e:	0992                	slli	s3,s3,0x4
 940:	397d                	addiw	s2,s2,-1
 942:	fe0914e3          	bnez	s2,92a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 946:	8be2                	mv	s7,s8
      state = 0;
 948:	4981                	li	s3,0
 94a:	bf21                	j	862 <vprintf+0x44>
        s = va_arg(ap, char*);
 94c:	008b8993          	addi	s3,s7,8
 950:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 954:	02090163          	beqz	s2,976 <vprintf+0x158>
        while(*s != 0){
 958:	00094583          	lbu	a1,0(s2)
 95c:	c9a5                	beqz	a1,9cc <vprintf+0x1ae>
          putc(fd, *s);
 95e:	8556                	mv	a0,s5
 960:	00000097          	auipc	ra,0x0
 964:	df0080e7          	jalr	-528(ra) # 750 <putc>
          s++;
 968:	0905                	addi	s2,s2,1
        while(*s != 0){
 96a:	00094583          	lbu	a1,0(s2)
 96e:	f9e5                	bnez	a1,95e <vprintf+0x140>
        s = va_arg(ap, char*);
 970:	8bce                	mv	s7,s3
      state = 0;
 972:	4981                	li	s3,0
 974:	b5fd                	j	862 <vprintf+0x44>
          s = "(null)";
 976:	00000917          	auipc	s2,0x0
 97a:	2aa90913          	addi	s2,s2,682 # c20 <malloc+0x150>
        while(*s != 0){
 97e:	02800593          	li	a1,40
 982:	bff1                	j	95e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 984:	008b8913          	addi	s2,s7,8
 988:	000bc583          	lbu	a1,0(s7)
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	dc2080e7          	jalr	-574(ra) # 750 <putc>
 996:	8bca                	mv	s7,s2
      state = 0;
 998:	4981                	li	s3,0
 99a:	b5e1                	j	862 <vprintf+0x44>
        putc(fd, c);
 99c:	02500593          	li	a1,37
 9a0:	8556                	mv	a0,s5
 9a2:	00000097          	auipc	ra,0x0
 9a6:	dae080e7          	jalr	-594(ra) # 750 <putc>
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	bd5d                	j	862 <vprintf+0x44>
        putc(fd, '%');
 9ae:	02500593          	li	a1,37
 9b2:	8556                	mv	a0,s5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	d9c080e7          	jalr	-612(ra) # 750 <putc>
        putc(fd, c);
 9bc:	85ca                	mv	a1,s2
 9be:	8556                	mv	a0,s5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	d90080e7          	jalr	-624(ra) # 750 <putc>
      state = 0;
 9c8:	4981                	li	s3,0
 9ca:	bd61                	j	862 <vprintf+0x44>
        s = va_arg(ap, char*);
 9cc:	8bce                	mv	s7,s3
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	bd49                	j	862 <vprintf+0x44>
    }
  }
}
 9d2:	60a6                	ld	ra,72(sp)
 9d4:	6406                	ld	s0,64(sp)
 9d6:	74e2                	ld	s1,56(sp)
 9d8:	7942                	ld	s2,48(sp)
 9da:	79a2                	ld	s3,40(sp)
 9dc:	7a02                	ld	s4,32(sp)
 9de:	6ae2                	ld	s5,24(sp)
 9e0:	6b42                	ld	s6,16(sp)
 9e2:	6ba2                	ld	s7,8(sp)
 9e4:	6c02                	ld	s8,0(sp)
 9e6:	6161                	addi	sp,sp,80
 9e8:	8082                	ret

00000000000009ea <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9ea:	715d                	addi	sp,sp,-80
 9ec:	ec06                	sd	ra,24(sp)
 9ee:	e822                	sd	s0,16(sp)
 9f0:	1000                	addi	s0,sp,32
 9f2:	e010                	sd	a2,0(s0)
 9f4:	e414                	sd	a3,8(s0)
 9f6:	e818                	sd	a4,16(s0)
 9f8:	ec1c                	sd	a5,24(s0)
 9fa:	03043023          	sd	a6,32(s0)
 9fe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a02:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a06:	8622                	mv	a2,s0
 a08:	00000097          	auipc	ra,0x0
 a0c:	e16080e7          	jalr	-490(ra) # 81e <vprintf>
}
 a10:	60e2                	ld	ra,24(sp)
 a12:	6442                	ld	s0,16(sp)
 a14:	6161                	addi	sp,sp,80
 a16:	8082                	ret

0000000000000a18 <printf>:

void
printf(const char *fmt, ...)
{
 a18:	711d                	addi	sp,sp,-96
 a1a:	ec06                	sd	ra,24(sp)
 a1c:	e822                	sd	s0,16(sp)
 a1e:	1000                	addi	s0,sp,32
 a20:	e40c                	sd	a1,8(s0)
 a22:	e810                	sd	a2,16(s0)
 a24:	ec14                	sd	a3,24(s0)
 a26:	f018                	sd	a4,32(s0)
 a28:	f41c                	sd	a5,40(s0)
 a2a:	03043823          	sd	a6,48(s0)
 a2e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a32:	00840613          	addi	a2,s0,8
 a36:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a3a:	85aa                	mv	a1,a0
 a3c:	4505                	li	a0,1
 a3e:	00000097          	auipc	ra,0x0
 a42:	de0080e7          	jalr	-544(ra) # 81e <vprintf>
}
 a46:	60e2                	ld	ra,24(sp)
 a48:	6442                	ld	s0,16(sp)
 a4a:	6125                	addi	sp,sp,96
 a4c:	8082                	ret

0000000000000a4e <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a4e:	1141                	addi	sp,sp,-16
 a50:	e422                	sd	s0,8(sp)
 a52:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a54:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a58:	00000797          	auipc	a5,0x0
 a5c:	5c07b783          	ld	a5,1472(a5) # 1018 <freep>
 a60:	a02d                	j	a8a <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a62:	4618                	lw	a4,8(a2)
 a64:	9f2d                	addw	a4,a4,a1
 a66:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a6a:	6398                	ld	a4,0(a5)
 a6c:	6310                	ld	a2,0(a4)
 a6e:	a83d                	j	aac <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a70:	ff852703          	lw	a4,-8(a0)
 a74:	9f31                	addw	a4,a4,a2
 a76:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a78:	ff053683          	ld	a3,-16(a0)
 a7c:	a091                	j	ac0 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a7e:	6398                	ld	a4,0(a5)
 a80:	00e7e463          	bltu	a5,a4,a88 <free+0x3a>
 a84:	00e6ea63          	bltu	a3,a4,a98 <free+0x4a>
{
 a88:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a8a:	fed7fae3          	bgeu	a5,a3,a7e <free+0x30>
 a8e:	6398                	ld	a4,0(a5)
 a90:	00e6e463          	bltu	a3,a4,a98 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a94:	fee7eae3          	bltu	a5,a4,a88 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 a98:	ff852583          	lw	a1,-8(a0)
 a9c:	6390                	ld	a2,0(a5)
 a9e:	02059813          	slli	a6,a1,0x20
 aa2:	01c85713          	srli	a4,a6,0x1c
 aa6:	9736                	add	a4,a4,a3
 aa8:	fae60de3          	beq	a2,a4,a62 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 aac:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 ab0:	4790                	lw	a2,8(a5)
 ab2:	02061593          	slli	a1,a2,0x20
 ab6:	01c5d713          	srli	a4,a1,0x1c
 aba:	973e                	add	a4,a4,a5
 abc:	fae68ae3          	beq	a3,a4,a70 <free+0x22>
        p->s.ptr = bp->s.ptr;
 ac0:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 ac2:	00000717          	auipc	a4,0x0
 ac6:	54f73b23          	sd	a5,1366(a4) # 1018 <freep>
}
 aca:	6422                	ld	s0,8(sp)
 acc:	0141                	addi	sp,sp,16
 ace:	8082                	ret

0000000000000ad0 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 ad0:	7139                	addi	sp,sp,-64
 ad2:	fc06                	sd	ra,56(sp)
 ad4:	f822                	sd	s0,48(sp)
 ad6:	f426                	sd	s1,40(sp)
 ad8:	f04a                	sd	s2,32(sp)
 ada:	ec4e                	sd	s3,24(sp)
 adc:	e852                	sd	s4,16(sp)
 ade:	e456                	sd	s5,8(sp)
 ae0:	e05a                	sd	s6,0(sp)
 ae2:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 ae4:	02051493          	slli	s1,a0,0x20
 ae8:	9081                	srli	s1,s1,0x20
 aea:	04bd                	addi	s1,s1,15
 aec:	8091                	srli	s1,s1,0x4
 aee:	0014899b          	addiw	s3,s1,1
 af2:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 af4:	00000517          	auipc	a0,0x0
 af8:	52453503          	ld	a0,1316(a0) # 1018 <freep>
 afc:	c515                	beqz	a0,b28 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 afe:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b00:	4798                	lw	a4,8(a5)
 b02:	02977f63          	bgeu	a4,s1,b40 <malloc+0x70>
    if (nu < 4096)
 b06:	8a4e                	mv	s4,s3
 b08:	0009871b          	sext.w	a4,s3
 b0c:	6685                	lui	a3,0x1
 b0e:	00d77363          	bgeu	a4,a3,b14 <malloc+0x44>
 b12:	6a05                	lui	s4,0x1
 b14:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b18:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b1c:	00000917          	auipc	s2,0x0
 b20:	4fc90913          	addi	s2,s2,1276 # 1018 <freep>
    if (p == (char *)-1)
 b24:	5afd                	li	s5,-1
 b26:	a895                	j	b9a <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b28:	00000797          	auipc	a5,0x0
 b2c:	57878793          	addi	a5,a5,1400 # 10a0 <base>
 b30:	00000717          	auipc	a4,0x0
 b34:	4ef73423          	sd	a5,1256(a4) # 1018 <freep>
 b38:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b3a:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b3e:	b7e1                	j	b06 <malloc+0x36>
            if (p->s.size == nunits)
 b40:	02e48c63          	beq	s1,a4,b78 <malloc+0xa8>
                p->s.size -= nunits;
 b44:	4137073b          	subw	a4,a4,s3
 b48:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b4a:	02071693          	slli	a3,a4,0x20
 b4e:	01c6d713          	srli	a4,a3,0x1c
 b52:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b54:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b58:	00000717          	auipc	a4,0x0
 b5c:	4ca73023          	sd	a0,1216(a4) # 1018 <freep>
            return (void *)(p + 1);
 b60:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b64:	70e2                	ld	ra,56(sp)
 b66:	7442                	ld	s0,48(sp)
 b68:	74a2                	ld	s1,40(sp)
 b6a:	7902                	ld	s2,32(sp)
 b6c:	69e2                	ld	s3,24(sp)
 b6e:	6a42                	ld	s4,16(sp)
 b70:	6aa2                	ld	s5,8(sp)
 b72:	6b02                	ld	s6,0(sp)
 b74:	6121                	addi	sp,sp,64
 b76:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b78:	6398                	ld	a4,0(a5)
 b7a:	e118                	sd	a4,0(a0)
 b7c:	bff1                	j	b58 <malloc+0x88>
    hp->s.size = nu;
 b7e:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b82:	0541                	addi	a0,a0,16
 b84:	00000097          	auipc	ra,0x0
 b88:	eca080e7          	jalr	-310(ra) # a4e <free>
    return freep;
 b8c:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b90:	d971                	beqz	a0,b64 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b92:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 b94:	4798                	lw	a4,8(a5)
 b96:	fa9775e3          	bgeu	a4,s1,b40 <malloc+0x70>
        if (p == freep)
 b9a:	00093703          	ld	a4,0(s2)
 b9e:	853e                	mv	a0,a5
 ba0:	fef719e3          	bne	a4,a5,b92 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 ba4:	8552                	mv	a0,s4
 ba6:	00000097          	auipc	ra,0x0
 baa:	b7a080e7          	jalr	-1158(ra) # 720 <sbrk>
    if (p == (char *)-1)
 bae:	fd5518e3          	bne	a0,s5,b7e <malloc+0xae>
                return 0;
 bb2:	4501                	li	a0,0
 bb4:	bf45                	j	b64 <malloc+0x94>
