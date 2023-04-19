
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
  12:	ba250513          	addi	a0,a0,-1118 # bb0 <malloc+0xee>
  16:	00001097          	auipc	ra,0x1
  1a:	9f4080e7          	jalr	-1548(ra) # a0a <printf>
        exit(1);
  1e:	4505                	li	a0,1
  20:	00000097          	auipc	ra,0x0
  24:	66a080e7          	jalr	1642(ra) # 68a <exit>
    }
    int schedid = (*argv[1]) - '0';
  28:	659c                	ld	a5,8(a1)
  2a:	0007c503          	lbu	a0,0(a5)
    schedset(schedid);
  2e:	fd05051b          	addiw	a0,a0,-48
  32:	00000097          	auipc	ra,0x0
  36:	708080e7          	jalr	1800(ra) # 73a <schedset>
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	64e080e7          	jalr	1614(ra) # 68a <exit>

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
  78:	2c4080e7          	jalr	708(ra) # 338 <twhoami>
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
  c4:	b1050513          	addi	a0,a0,-1264 # bd0 <malloc+0x10e>
  c8:	00001097          	auipc	ra,0x1
  cc:	942080e7          	jalr	-1726(ra) # a0a <printf>
        exit(-1);
  d0:	557d                	li	a0,-1
  d2:	00000097          	auipc	ra,0x0
  d6:	5b8080e7          	jalr	1464(ra) # 68a <exit>
    {
        // give up the cpu for other threads
        tyield();
  da:	00000097          	auipc	ra,0x0
  de:	1dc080e7          	jalr	476(ra) # 2b6 <tyield>
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
  f8:	244080e7          	jalr	580(ra) # 338 <twhoami>
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
 13c:	17e080e7          	jalr	382(ra) # 2b6 <tyield>
}
 140:	60e2                	ld	ra,24(sp)
 142:	6442                	ld	s0,16(sp)
 144:	64a2                	ld	s1,8(sp)
 146:	6105                	addi	sp,sp,32
 148:	8082                	ret
        printf("releasing lock we are not holding");
 14a:	00001517          	auipc	a0,0x1
 14e:	aae50513          	addi	a0,a0,-1362 # bf8 <malloc+0x136>
 152:	00001097          	auipc	ra,0x1
 156:	8b8080e7          	jalr	-1864(ra) # a0a <printf>
        exit(-1);
 15a:	557d                	li	a0,-1
 15c:	00000097          	auipc	ra,0x0
 160:	52e080e7          	jalr	1326(ra) # 68a <exit>

0000000000000164 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 164:	00001517          	auipc	a0,0x1
 168:	eac53503          	ld	a0,-340(a0) # 1010 <current_thread>
 16c:	00001717          	auipc	a4,0x1
 170:	eb470713          	addi	a4,a4,-332 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 174:	4781                	li	a5,0
 176:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 178:	6314                	ld	a3,0(a4)
 17a:	00a68763          	beq	a3,a0,188 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 17e:	2785                	addiw	a5,a5,1
 180:	0721                	addi	a4,a4,8
 182:	fec79be3          	bne	a5,a2,178 <tsched+0x14>
    int current_index = 0;
 186:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 188:	0017869b          	addiw	a3,a5,1
 18c:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 190:	00001817          	auipc	a6,0x1
 194:	e9080813          	addi	a6,a6,-368 # 1020 <threads>
 198:	488d                	li	a7,3
 19a:	a021                	j	1a2 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 19c:	2685                	addiw	a3,a3,1
 19e:	04c68363          	beq	a3,a2,1e4 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1a2:	41f6d71b          	sraiw	a4,a3,0x1f
 1a6:	01c7571b          	srliw	a4,a4,0x1c
 1aa:	00d707bb          	addw	a5,a4,a3
 1ae:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1b0:	9f99                	subw	a5,a5,a4
 1b2:	078e                	slli	a5,a5,0x3
 1b4:	97c2                	add	a5,a5,a6
 1b6:	638c                	ld	a1,0(a5)
 1b8:	d1f5                	beqz	a1,19c <tsched+0x38>
 1ba:	5dbc                	lw	a5,120(a1)
 1bc:	ff1790e3          	bne	a5,a7,19c <tsched+0x38>
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e406                	sd	ra,8(sp)
 1c4:	e022                	sd	s0,0(sp)
 1c6:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1c8:	00001797          	auipc	a5,0x1
 1cc:	e4b7b423          	sd	a1,-440(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1d0:	05a1                	addi	a1,a1,8
 1d2:	0521                	addi	a0,a0,8
 1d4:	00000097          	auipc	ra,0x0
 1d8:	17c080e7          	jalr	380(ra) # 350 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 1dc:	60a2                	ld	ra,8(sp)
 1de:	6402                	ld	s0,0(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
 1e4:	8082                	ret

00000000000001e6 <thread_wrapper>:
{
 1e6:	1101                	addi	sp,sp,-32
 1e8:	ec06                	sd	ra,24(sp)
 1ea:	e822                	sd	s0,16(sp)
 1ec:	e426                	sd	s1,8(sp)
 1ee:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 1f0:	00001497          	auipc	s1,0x1
 1f4:	e2048493          	addi	s1,s1,-480 # 1010 <current_thread>
 1f8:	609c                	ld	a5,0(s1)
 1fa:	67d8                	ld	a4,136(a5)
 1fc:	63c8                	ld	a0,128(a5)
 1fe:	9702                	jalr	a4
    current_thread->state = EXITED;
 200:	609c                	ld	a5,0(s1)
 202:	4719                	li	a4,6
 204:	dfb8                	sw	a4,120(a5)
    tsched();
 206:	00000097          	auipc	ra,0x0
 20a:	f5e080e7          	jalr	-162(ra) # 164 <tsched>
}
 20e:	60e2                	ld	ra,24(sp)
 210:	6442                	ld	s0,16(sp)
 212:	64a2                	ld	s1,8(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret

0000000000000218 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 218:	7179                	addi	sp,sp,-48
 21a:	f406                	sd	ra,40(sp)
 21c:	f022                	sd	s0,32(sp)
 21e:	ec26                	sd	s1,24(sp)
 220:	e84a                	sd	s2,16(sp)
 222:	e44e                	sd	s3,8(sp)
 224:	1800                	addi	s0,sp,48
 226:	84aa                	mv	s1,a0
 228:	89b2                	mv	s3,a2
 22a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 22c:	09800513          	li	a0,152
 230:	00001097          	auipc	ra,0x1
 234:	892080e7          	jalr	-1902(ra) # ac2 <malloc>
 238:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 23a:	478d                	li	a5,3
 23c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 23e:	609c                	ld	a5,0(s1)
 240:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 244:	609c                	ld	a5,0(s1)
 246:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 24a:	6098                	ld	a4,0(s1)
 24c:	00001797          	auipc	a5,0x1
 250:	db478793          	addi	a5,a5,-588 # 1000 <next_tid>
 254:	4394                	lw	a3,0(a5)
 256:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 25a:	4398                	lw	a4,0(a5)
 25c:	2705                	addiw	a4,a4,1
 25e:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 260:	6505                	lui	a0,0x1
 262:	00001097          	auipc	ra,0x1
 266:	860080e7          	jalr	-1952(ra) # ac2 <malloc>
 26a:	609c                	ld	a5,0(s1)
 26c:	6705                	lui	a4,0x1
 26e:	953a                	add	a0,a0,a4
 270:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 272:	609c                	ld	a5,0(s1)
 274:	00000717          	auipc	a4,0x0
 278:	f7270713          	addi	a4,a4,-142 # 1e6 <thread_wrapper>
 27c:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 27e:	00001717          	auipc	a4,0x1
 282:	da270713          	addi	a4,a4,-606 # 1020 <threads>
 286:	4781                	li	a5,0
 288:	4641                	li	a2,16
        if (threads[i] == NULL) {
 28a:	6314                	ld	a3,0(a4)
 28c:	ce81                	beqz	a3,2a4 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 28e:	2785                	addiw	a5,a5,1
 290:	0721                	addi	a4,a4,8
 292:	fec79ce3          	bne	a5,a2,28a <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 296:	70a2                	ld	ra,40(sp)
 298:	7402                	ld	s0,32(sp)
 29a:	64e2                	ld	s1,24(sp)
 29c:	6942                	ld	s2,16(sp)
 29e:	69a2                	ld	s3,8(sp)
 2a0:	6145                	addi	sp,sp,48
 2a2:	8082                	ret
            threads[i] = *thread;
 2a4:	6094                	ld	a3,0(s1)
 2a6:	078e                	slli	a5,a5,0x3
 2a8:	00001717          	auipc	a4,0x1
 2ac:	d7870713          	addi	a4,a4,-648 # 1020 <threads>
 2b0:	97ba                	add	a5,a5,a4
 2b2:	e394                	sd	a3,0(a5)
            break;
 2b4:	b7cd                	j	296 <tcreate+0x7e>

00000000000002b6 <tyield>:
    return 0;
}


void tyield()
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 2be:	00001797          	auipc	a5,0x1
 2c2:	d527b783          	ld	a5,-686(a5) # 1010 <current_thread>
 2c6:	470d                	li	a4,3
 2c8:	dfb8                	sw	a4,120(a5)
    tsched();
 2ca:	00000097          	auipc	ra,0x0
 2ce:	e9a080e7          	jalr	-358(ra) # 164 <tsched>
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret

00000000000002da <tjoin>:
{
 2da:	1101                	addi	sp,sp,-32
 2dc:	ec06                	sd	ra,24(sp)
 2de:	e822                	sd	s0,16(sp)
 2e0:	e426                	sd	s1,8(sp)
 2e2:	e04a                	sd	s2,0(sp)
 2e4:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 2e6:	00001797          	auipc	a5,0x1
 2ea:	d3a78793          	addi	a5,a5,-710 # 1020 <threads>
 2ee:	00001697          	auipc	a3,0x1
 2f2:	db268693          	addi	a3,a3,-590 # 10a0 <base>
 2f6:	a021                	j	2fe <tjoin+0x24>
 2f8:	07a1                	addi	a5,a5,8
 2fa:	02d78b63          	beq	a5,a3,330 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 2fe:	6384                	ld	s1,0(a5)
 300:	dce5                	beqz	s1,2f8 <tjoin+0x1e>
 302:	0004c703          	lbu	a4,0(s1)
 306:	fea719e3          	bne	a4,a0,2f8 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 30a:	5cb8                	lw	a4,120(s1)
 30c:	4799                	li	a5,6
 30e:	4919                	li	s2,6
 310:	02f70263          	beq	a4,a5,334 <tjoin+0x5a>
        tyield();
 314:	00000097          	auipc	ra,0x0
 318:	fa2080e7          	jalr	-94(ra) # 2b6 <tyield>
    while (target_thread->state != EXITED) {
 31c:	5cbc                	lw	a5,120(s1)
 31e:	ff279be3          	bne	a5,s2,314 <tjoin+0x3a>
    return 0;
 322:	4501                	li	a0,0
}
 324:	60e2                	ld	ra,24(sp)
 326:	6442                	ld	s0,16(sp)
 328:	64a2                	ld	s1,8(sp)
 32a:	6902                	ld	s2,0(sp)
 32c:	6105                	addi	sp,sp,32
 32e:	8082                	ret
        return -1;
 330:	557d                	li	a0,-1
 332:	bfcd                	j	324 <tjoin+0x4a>
    return 0;
 334:	4501                	li	a0,0
 336:	b7fd                	j	324 <tjoin+0x4a>

0000000000000338 <twhoami>:

uint8 twhoami()
{
 338:	1141                	addi	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 33e:	00001797          	auipc	a5,0x1
 342:	cd27b783          	ld	a5,-814(a5) # 1010 <current_thread>
 346:	0007c503          	lbu	a0,0(a5)
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <tswtch>:
 350:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 354:	00253423          	sd	sp,8(a0)
 358:	e900                	sd	s0,16(a0)
 35a:	ed04                	sd	s1,24(a0)
 35c:	03253023          	sd	s2,32(a0)
 360:	03353423          	sd	s3,40(a0)
 364:	03453823          	sd	s4,48(a0)
 368:	03553c23          	sd	s5,56(a0)
 36c:	05653023          	sd	s6,64(a0)
 370:	05753423          	sd	s7,72(a0)
 374:	05853823          	sd	s8,80(a0)
 378:	05953c23          	sd	s9,88(a0)
 37c:	07a53023          	sd	s10,96(a0)
 380:	07b53423          	sd	s11,104(a0)
 384:	0005b083          	ld	ra,0(a1)
 388:	0085b103          	ld	sp,8(a1)
 38c:	6980                	ld	s0,16(a1)
 38e:	6d84                	ld	s1,24(a1)
 390:	0205b903          	ld	s2,32(a1)
 394:	0285b983          	ld	s3,40(a1)
 398:	0305ba03          	ld	s4,48(a1)
 39c:	0385ba83          	ld	s5,56(a1)
 3a0:	0405bb03          	ld	s6,64(a1)
 3a4:	0485bb83          	ld	s7,72(a1)
 3a8:	0505bc03          	ld	s8,80(a1)
 3ac:	0585bc83          	ld	s9,88(a1)
 3b0:	0605bd03          	ld	s10,96(a1)
 3b4:	0685bd83          	ld	s11,104(a1)
 3b8:	8082                	ret

00000000000003ba <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3ba:	1101                	addi	sp,sp,-32
 3bc:	ec06                	sd	ra,24(sp)
 3be:	e822                	sd	s0,16(sp)
 3c0:	e426                	sd	s1,8(sp)
 3c2:	e04a                	sd	s2,0(sp)
 3c4:	1000                	addi	s0,sp,32
 3c6:	84aa                	mv	s1,a0
 3c8:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3ca:	09800513          	li	a0,152
 3ce:	00000097          	auipc	ra,0x0
 3d2:	6f4080e7          	jalr	1780(ra) # ac2 <malloc>

    main_thread->tid = 1;
 3d6:	4785                	li	a5,1
 3d8:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 3dc:	4791                	li	a5,4
 3de:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3e0:	00001797          	auipc	a5,0x1
 3e4:	c2a7b823          	sd	a0,-976(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3e8:	00001797          	auipc	a5,0x1
 3ec:	c3878793          	addi	a5,a5,-968 # 1020 <threads>
 3f0:	00001717          	auipc	a4,0x1
 3f4:	cb070713          	addi	a4,a4,-848 # 10a0 <base>
        threads[i] = NULL;
 3f8:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 3fc:	07a1                	addi	a5,a5,8
 3fe:	fee79de3          	bne	a5,a4,3f8 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 402:	00001797          	auipc	a5,0x1
 406:	c0a7bf23          	sd	a0,-994(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 40a:	85ca                	mv	a1,s2
 40c:	8526                	mv	a0,s1
 40e:	00000097          	auipc	ra,0x0
 412:	bf2080e7          	jalr	-1038(ra) # 0 <main>
    //tsched();

    exit(res);
 416:	00000097          	auipc	ra,0x0
 41a:	274080e7          	jalr	628(ra) # 68a <exit>

000000000000041e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 41e:	1141                	addi	sp,sp,-16
 420:	e422                	sd	s0,8(sp)
 422:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 424:	87aa                	mv	a5,a0
 426:	0585                	addi	a1,a1,1
 428:	0785                	addi	a5,a5,1
 42a:	fff5c703          	lbu	a4,-1(a1)
 42e:	fee78fa3          	sb	a4,-1(a5)
 432:	fb75                	bnez	a4,426 <strcpy+0x8>
        ;
    return os;
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret

000000000000043a <strcmp>:

int strcmp(const char *p, const char *q)
{
 43a:	1141                	addi	sp,sp,-16
 43c:	e422                	sd	s0,8(sp)
 43e:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 440:	00054783          	lbu	a5,0(a0)
 444:	cb91                	beqz	a5,458 <strcmp+0x1e>
 446:	0005c703          	lbu	a4,0(a1)
 44a:	00f71763          	bne	a4,a5,458 <strcmp+0x1e>
        p++, q++;
 44e:	0505                	addi	a0,a0,1
 450:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 452:	00054783          	lbu	a5,0(a0)
 456:	fbe5                	bnez	a5,446 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 458:	0005c503          	lbu	a0,0(a1)
}
 45c:	40a7853b          	subw	a0,a5,a0
 460:	6422                	ld	s0,8(sp)
 462:	0141                	addi	sp,sp,16
 464:	8082                	ret

0000000000000466 <strlen>:

uint strlen(const char *s)
{
 466:	1141                	addi	sp,sp,-16
 468:	e422                	sd	s0,8(sp)
 46a:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 46c:	00054783          	lbu	a5,0(a0)
 470:	cf91                	beqz	a5,48c <strlen+0x26>
 472:	0505                	addi	a0,a0,1
 474:	87aa                	mv	a5,a0
 476:	86be                	mv	a3,a5
 478:	0785                	addi	a5,a5,1
 47a:	fff7c703          	lbu	a4,-1(a5)
 47e:	ff65                	bnez	a4,476 <strlen+0x10>
 480:	40a6853b          	subw	a0,a3,a0
 484:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret
    for (n = 0; s[n]; n++)
 48c:	4501                	li	a0,0
 48e:	bfe5                	j	486 <strlen+0x20>

0000000000000490 <memset>:

void *
memset(void *dst, int c, uint n)
{
 490:	1141                	addi	sp,sp,-16
 492:	e422                	sd	s0,8(sp)
 494:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 496:	ca19                	beqz	a2,4ac <memset+0x1c>
 498:	87aa                	mv	a5,a0
 49a:	1602                	slli	a2,a2,0x20
 49c:	9201                	srli	a2,a2,0x20
 49e:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4a2:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4a6:	0785                	addi	a5,a5,1
 4a8:	fee79de3          	bne	a5,a4,4a2 <memset+0x12>
    }
    return dst;
}
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	addi	sp,sp,16
 4b0:	8082                	ret

00000000000004b2 <strchr>:

char *
strchr(const char *s, char c)
{
 4b2:	1141                	addi	sp,sp,-16
 4b4:	e422                	sd	s0,8(sp)
 4b6:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4b8:	00054783          	lbu	a5,0(a0)
 4bc:	cb99                	beqz	a5,4d2 <strchr+0x20>
        if (*s == c)
 4be:	00f58763          	beq	a1,a5,4cc <strchr+0x1a>
    for (; *s; s++)
 4c2:	0505                	addi	a0,a0,1
 4c4:	00054783          	lbu	a5,0(a0)
 4c8:	fbfd                	bnez	a5,4be <strchr+0xc>
            return (char *)s;
    return 0;
 4ca:	4501                	li	a0,0
}
 4cc:	6422                	ld	s0,8(sp)
 4ce:	0141                	addi	sp,sp,16
 4d0:	8082                	ret
    return 0;
 4d2:	4501                	li	a0,0
 4d4:	bfe5                	j	4cc <strchr+0x1a>

00000000000004d6 <gets>:

char *
gets(char *buf, int max)
{
 4d6:	711d                	addi	sp,sp,-96
 4d8:	ec86                	sd	ra,88(sp)
 4da:	e8a2                	sd	s0,80(sp)
 4dc:	e4a6                	sd	s1,72(sp)
 4de:	e0ca                	sd	s2,64(sp)
 4e0:	fc4e                	sd	s3,56(sp)
 4e2:	f852                	sd	s4,48(sp)
 4e4:	f456                	sd	s5,40(sp)
 4e6:	f05a                	sd	s6,32(sp)
 4e8:	ec5e                	sd	s7,24(sp)
 4ea:	1080                	addi	s0,sp,96
 4ec:	8baa                	mv	s7,a0
 4ee:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 4f0:	892a                	mv	s2,a0
 4f2:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 4f4:	4aa9                	li	s5,10
 4f6:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 4f8:	89a6                	mv	s3,s1
 4fa:	2485                	addiw	s1,s1,1
 4fc:	0344d863          	bge	s1,s4,52c <gets+0x56>
        cc = read(0, &c, 1);
 500:	4605                	li	a2,1
 502:	faf40593          	addi	a1,s0,-81
 506:	4501                	li	a0,0
 508:	00000097          	auipc	ra,0x0
 50c:	19a080e7          	jalr	410(ra) # 6a2 <read>
        if (cc < 1)
 510:	00a05e63          	blez	a0,52c <gets+0x56>
        buf[i++] = c;
 514:	faf44783          	lbu	a5,-81(s0)
 518:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 51c:	01578763          	beq	a5,s5,52a <gets+0x54>
 520:	0905                	addi	s2,s2,1
 522:	fd679be3          	bne	a5,s6,4f8 <gets+0x22>
    for (i = 0; i + 1 < max;)
 526:	89a6                	mv	s3,s1
 528:	a011                	j	52c <gets+0x56>
 52a:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 52c:	99de                	add	s3,s3,s7
 52e:	00098023          	sb	zero,0(s3)
    return buf;
}
 532:	855e                	mv	a0,s7
 534:	60e6                	ld	ra,88(sp)
 536:	6446                	ld	s0,80(sp)
 538:	64a6                	ld	s1,72(sp)
 53a:	6906                	ld	s2,64(sp)
 53c:	79e2                	ld	s3,56(sp)
 53e:	7a42                	ld	s4,48(sp)
 540:	7aa2                	ld	s5,40(sp)
 542:	7b02                	ld	s6,32(sp)
 544:	6be2                	ld	s7,24(sp)
 546:	6125                	addi	sp,sp,96
 548:	8082                	ret

000000000000054a <stat>:

int stat(const char *n, struct stat *st)
{
 54a:	1101                	addi	sp,sp,-32
 54c:	ec06                	sd	ra,24(sp)
 54e:	e822                	sd	s0,16(sp)
 550:	e426                	sd	s1,8(sp)
 552:	e04a                	sd	s2,0(sp)
 554:	1000                	addi	s0,sp,32
 556:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 558:	4581                	li	a1,0
 55a:	00000097          	auipc	ra,0x0
 55e:	170080e7          	jalr	368(ra) # 6ca <open>
    if (fd < 0)
 562:	02054563          	bltz	a0,58c <stat+0x42>
 566:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 568:	85ca                	mv	a1,s2
 56a:	00000097          	auipc	ra,0x0
 56e:	178080e7          	jalr	376(ra) # 6e2 <fstat>
 572:	892a                	mv	s2,a0
    close(fd);
 574:	8526                	mv	a0,s1
 576:	00000097          	auipc	ra,0x0
 57a:	13c080e7          	jalr	316(ra) # 6b2 <close>
    return r;
}
 57e:	854a                	mv	a0,s2
 580:	60e2                	ld	ra,24(sp)
 582:	6442                	ld	s0,16(sp)
 584:	64a2                	ld	s1,8(sp)
 586:	6902                	ld	s2,0(sp)
 588:	6105                	addi	sp,sp,32
 58a:	8082                	ret
        return -1;
 58c:	597d                	li	s2,-1
 58e:	bfc5                	j	57e <stat+0x34>

0000000000000590 <atoi>:

int atoi(const char *s)
{
 590:	1141                	addi	sp,sp,-16
 592:	e422                	sd	s0,8(sp)
 594:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 596:	00054683          	lbu	a3,0(a0)
 59a:	fd06879b          	addiw	a5,a3,-48
 59e:	0ff7f793          	zext.b	a5,a5
 5a2:	4625                	li	a2,9
 5a4:	02f66863          	bltu	a2,a5,5d4 <atoi+0x44>
 5a8:	872a                	mv	a4,a0
    n = 0;
 5aa:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5ac:	0705                	addi	a4,a4,1
 5ae:	0025179b          	slliw	a5,a0,0x2
 5b2:	9fa9                	addw	a5,a5,a0
 5b4:	0017979b          	slliw	a5,a5,0x1
 5b8:	9fb5                	addw	a5,a5,a3
 5ba:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5be:	00074683          	lbu	a3,0(a4)
 5c2:	fd06879b          	addiw	a5,a3,-48
 5c6:	0ff7f793          	zext.b	a5,a5
 5ca:	fef671e3          	bgeu	a2,a5,5ac <atoi+0x1c>
    return n;
}
 5ce:	6422                	ld	s0,8(sp)
 5d0:	0141                	addi	sp,sp,16
 5d2:	8082                	ret
    n = 0;
 5d4:	4501                	li	a0,0
 5d6:	bfe5                	j	5ce <atoi+0x3e>

00000000000005d8 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5d8:	1141                	addi	sp,sp,-16
 5da:	e422                	sd	s0,8(sp)
 5dc:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5de:	02b57463          	bgeu	a0,a1,606 <memmove+0x2e>
    {
        while (n-- > 0)
 5e2:	00c05f63          	blez	a2,600 <memmove+0x28>
 5e6:	1602                	slli	a2,a2,0x20
 5e8:	9201                	srli	a2,a2,0x20
 5ea:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 5ee:	872a                	mv	a4,a0
            *dst++ = *src++;
 5f0:	0585                	addi	a1,a1,1
 5f2:	0705                	addi	a4,a4,1
 5f4:	fff5c683          	lbu	a3,-1(a1)
 5f8:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 5fc:	fee79ae3          	bne	a5,a4,5f0 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 600:	6422                	ld	s0,8(sp)
 602:	0141                	addi	sp,sp,16
 604:	8082                	ret
        dst += n;
 606:	00c50733          	add	a4,a0,a2
        src += n;
 60a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 60c:	fec05ae3          	blez	a2,600 <memmove+0x28>
 610:	fff6079b          	addiw	a5,a2,-1
 614:	1782                	slli	a5,a5,0x20
 616:	9381                	srli	a5,a5,0x20
 618:	fff7c793          	not	a5,a5
 61c:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 61e:	15fd                	addi	a1,a1,-1
 620:	177d                	addi	a4,a4,-1
 622:	0005c683          	lbu	a3,0(a1)
 626:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 62a:	fee79ae3          	bne	a5,a4,61e <memmove+0x46>
 62e:	bfc9                	j	600 <memmove+0x28>

0000000000000630 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 630:	1141                	addi	sp,sp,-16
 632:	e422                	sd	s0,8(sp)
 634:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 636:	ca05                	beqz	a2,666 <memcmp+0x36>
 638:	fff6069b          	addiw	a3,a2,-1
 63c:	1682                	slli	a3,a3,0x20
 63e:	9281                	srli	a3,a3,0x20
 640:	0685                	addi	a3,a3,1
 642:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 644:	00054783          	lbu	a5,0(a0)
 648:	0005c703          	lbu	a4,0(a1)
 64c:	00e79863          	bne	a5,a4,65c <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 650:	0505                	addi	a0,a0,1
        p2++;
 652:	0585                	addi	a1,a1,1
    while (n-- > 0)
 654:	fed518e3          	bne	a0,a3,644 <memcmp+0x14>
    }
    return 0;
 658:	4501                	li	a0,0
 65a:	a019                	j	660 <memcmp+0x30>
            return *p1 - *p2;
 65c:	40e7853b          	subw	a0,a5,a4
}
 660:	6422                	ld	s0,8(sp)
 662:	0141                	addi	sp,sp,16
 664:	8082                	ret
    return 0;
 666:	4501                	li	a0,0
 668:	bfe5                	j	660 <memcmp+0x30>

000000000000066a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 66a:	1141                	addi	sp,sp,-16
 66c:	e406                	sd	ra,8(sp)
 66e:	e022                	sd	s0,0(sp)
 670:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 672:	00000097          	auipc	ra,0x0
 676:	f66080e7          	jalr	-154(ra) # 5d8 <memmove>
}
 67a:	60a2                	ld	ra,8(sp)
 67c:	6402                	ld	s0,0(sp)
 67e:	0141                	addi	sp,sp,16
 680:	8082                	ret

0000000000000682 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 682:	4885                	li	a7,1
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <exit>:
.global exit
exit:
 li a7, SYS_exit
 68a:	4889                	li	a7,2
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <wait>:
.global wait
wait:
 li a7, SYS_wait
 692:	488d                	li	a7,3
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 69a:	4891                	li	a7,4
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <read>:
.global read
read:
 li a7, SYS_read
 6a2:	4895                	li	a7,5
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <write>:
.global write
write:
 li a7, SYS_write
 6aa:	48c1                	li	a7,16
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <close>:
.global close
close:
 li a7, SYS_close
 6b2:	48d5                	li	a7,21
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <kill>:
.global kill
kill:
 li a7, SYS_kill
 6ba:	4899                	li	a7,6
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6c2:	489d                	li	a7,7
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <open>:
.global open
open:
 li a7, SYS_open
 6ca:	48bd                	li	a7,15
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6d2:	48c5                	li	a7,17
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6da:	48c9                	li	a7,18
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6e2:	48a1                	li	a7,8
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <link>:
.global link
link:
 li a7, SYS_link
 6ea:	48cd                	li	a7,19
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6f2:	48d1                	li	a7,20
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6fa:	48a5                	li	a7,9
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <dup>:
.global dup
dup:
 li a7, SYS_dup
 702:	48a9                	li	a7,10
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 70a:	48ad                	li	a7,11
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 712:	48b1                	li	a7,12
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 71a:	48b5                	li	a7,13
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 722:	48b9                	li	a7,14
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <ps>:
.global ps
ps:
 li a7, SYS_ps
 72a:	48d9                	li	a7,22
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 732:	48dd                	li	a7,23
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 73a:	48e1                	li	a7,24
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 742:	1101                	addi	sp,sp,-32
 744:	ec06                	sd	ra,24(sp)
 746:	e822                	sd	s0,16(sp)
 748:	1000                	addi	s0,sp,32
 74a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 74e:	4605                	li	a2,1
 750:	fef40593          	addi	a1,s0,-17
 754:	00000097          	auipc	ra,0x0
 758:	f56080e7          	jalr	-170(ra) # 6aa <write>
}
 75c:	60e2                	ld	ra,24(sp)
 75e:	6442                	ld	s0,16(sp)
 760:	6105                	addi	sp,sp,32
 762:	8082                	ret

0000000000000764 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 764:	7139                	addi	sp,sp,-64
 766:	fc06                	sd	ra,56(sp)
 768:	f822                	sd	s0,48(sp)
 76a:	f426                	sd	s1,40(sp)
 76c:	f04a                	sd	s2,32(sp)
 76e:	ec4e                	sd	s3,24(sp)
 770:	0080                	addi	s0,sp,64
 772:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 774:	c299                	beqz	a3,77a <printint+0x16>
 776:	0805c963          	bltz	a1,808 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 77a:	2581                	sext.w	a1,a1
  neg = 0;
 77c:	4881                	li	a7,0
 77e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 782:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 784:	2601                	sext.w	a2,a2
 786:	00000517          	auipc	a0,0x0
 78a:	4fa50513          	addi	a0,a0,1274 # c80 <digits>
 78e:	883a                	mv	a6,a4
 790:	2705                	addiw	a4,a4,1
 792:	02c5f7bb          	remuw	a5,a1,a2
 796:	1782                	slli	a5,a5,0x20
 798:	9381                	srli	a5,a5,0x20
 79a:	97aa                	add	a5,a5,a0
 79c:	0007c783          	lbu	a5,0(a5)
 7a0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7a4:	0005879b          	sext.w	a5,a1
 7a8:	02c5d5bb          	divuw	a1,a1,a2
 7ac:	0685                	addi	a3,a3,1
 7ae:	fec7f0e3          	bgeu	a5,a2,78e <printint+0x2a>
  if(neg)
 7b2:	00088c63          	beqz	a7,7ca <printint+0x66>
    buf[i++] = '-';
 7b6:	fd070793          	addi	a5,a4,-48
 7ba:	00878733          	add	a4,a5,s0
 7be:	02d00793          	li	a5,45
 7c2:	fef70823          	sb	a5,-16(a4)
 7c6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7ca:	02e05863          	blez	a4,7fa <printint+0x96>
 7ce:	fc040793          	addi	a5,s0,-64
 7d2:	00e78933          	add	s2,a5,a4
 7d6:	fff78993          	addi	s3,a5,-1
 7da:	99ba                	add	s3,s3,a4
 7dc:	377d                	addiw	a4,a4,-1
 7de:	1702                	slli	a4,a4,0x20
 7e0:	9301                	srli	a4,a4,0x20
 7e2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7e6:	fff94583          	lbu	a1,-1(s2)
 7ea:	8526                	mv	a0,s1
 7ec:	00000097          	auipc	ra,0x0
 7f0:	f56080e7          	jalr	-170(ra) # 742 <putc>
  while(--i >= 0)
 7f4:	197d                	addi	s2,s2,-1
 7f6:	ff3918e3          	bne	s2,s3,7e6 <printint+0x82>
}
 7fa:	70e2                	ld	ra,56(sp)
 7fc:	7442                	ld	s0,48(sp)
 7fe:	74a2                	ld	s1,40(sp)
 800:	7902                	ld	s2,32(sp)
 802:	69e2                	ld	s3,24(sp)
 804:	6121                	addi	sp,sp,64
 806:	8082                	ret
    x = -xx;
 808:	40b005bb          	negw	a1,a1
    neg = 1;
 80c:	4885                	li	a7,1
    x = -xx;
 80e:	bf85                	j	77e <printint+0x1a>

0000000000000810 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 810:	715d                	addi	sp,sp,-80
 812:	e486                	sd	ra,72(sp)
 814:	e0a2                	sd	s0,64(sp)
 816:	fc26                	sd	s1,56(sp)
 818:	f84a                	sd	s2,48(sp)
 81a:	f44e                	sd	s3,40(sp)
 81c:	f052                	sd	s4,32(sp)
 81e:	ec56                	sd	s5,24(sp)
 820:	e85a                	sd	s6,16(sp)
 822:	e45e                	sd	s7,8(sp)
 824:	e062                	sd	s8,0(sp)
 826:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 828:	0005c903          	lbu	s2,0(a1)
 82c:	18090c63          	beqz	s2,9c4 <vprintf+0x1b4>
 830:	8aaa                	mv	s5,a0
 832:	8bb2                	mv	s7,a2
 834:	00158493          	addi	s1,a1,1
  state = 0;
 838:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 83a:	02500a13          	li	s4,37
 83e:	4b55                	li	s6,21
 840:	a839                	j	85e <vprintf+0x4e>
        putc(fd, c);
 842:	85ca                	mv	a1,s2
 844:	8556                	mv	a0,s5
 846:	00000097          	auipc	ra,0x0
 84a:	efc080e7          	jalr	-260(ra) # 742 <putc>
 84e:	a019                	j	854 <vprintf+0x44>
    } else if(state == '%'){
 850:	01498d63          	beq	s3,s4,86a <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 854:	0485                	addi	s1,s1,1
 856:	fff4c903          	lbu	s2,-1(s1)
 85a:	16090563          	beqz	s2,9c4 <vprintf+0x1b4>
    if(state == 0){
 85e:	fe0999e3          	bnez	s3,850 <vprintf+0x40>
      if(c == '%'){
 862:	ff4910e3          	bne	s2,s4,842 <vprintf+0x32>
        state = '%';
 866:	89d2                	mv	s3,s4
 868:	b7f5                	j	854 <vprintf+0x44>
      if(c == 'd'){
 86a:	13490263          	beq	s2,s4,98e <vprintf+0x17e>
 86e:	f9d9079b          	addiw	a5,s2,-99
 872:	0ff7f793          	zext.b	a5,a5
 876:	12fb6563          	bltu	s6,a5,9a0 <vprintf+0x190>
 87a:	f9d9079b          	addiw	a5,s2,-99
 87e:	0ff7f713          	zext.b	a4,a5
 882:	10eb6f63          	bltu	s6,a4,9a0 <vprintf+0x190>
 886:	00271793          	slli	a5,a4,0x2
 88a:	00000717          	auipc	a4,0x0
 88e:	39e70713          	addi	a4,a4,926 # c28 <malloc+0x166>
 892:	97ba                	add	a5,a5,a4
 894:	439c                	lw	a5,0(a5)
 896:	97ba                	add	a5,a5,a4
 898:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 89a:	008b8913          	addi	s2,s7,8
 89e:	4685                	li	a3,1
 8a0:	4629                	li	a2,10
 8a2:	000ba583          	lw	a1,0(s7)
 8a6:	8556                	mv	a0,s5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	ebc080e7          	jalr	-324(ra) # 764 <printint>
 8b0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	b745                	j	854 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8b6:	008b8913          	addi	s2,s7,8
 8ba:	4681                	li	a3,0
 8bc:	4629                	li	a2,10
 8be:	000ba583          	lw	a1,0(s7)
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	ea0080e7          	jalr	-352(ra) # 764 <printint>
 8cc:	8bca                	mv	s7,s2
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	b751                	j	854 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8d2:	008b8913          	addi	s2,s7,8
 8d6:	4681                	li	a3,0
 8d8:	4641                	li	a2,16
 8da:	000ba583          	lw	a1,0(s7)
 8de:	8556                	mv	a0,s5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	e84080e7          	jalr	-380(ra) # 764 <printint>
 8e8:	8bca                	mv	s7,s2
      state = 0;
 8ea:	4981                	li	s3,0
 8ec:	b7a5                	j	854 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 8ee:	008b8c13          	addi	s8,s7,8
 8f2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8f6:	03000593          	li	a1,48
 8fa:	8556                	mv	a0,s5
 8fc:	00000097          	auipc	ra,0x0
 900:	e46080e7          	jalr	-442(ra) # 742 <putc>
  putc(fd, 'x');
 904:	07800593          	li	a1,120
 908:	8556                	mv	a0,s5
 90a:	00000097          	auipc	ra,0x0
 90e:	e38080e7          	jalr	-456(ra) # 742 <putc>
 912:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 914:	00000b97          	auipc	s7,0x0
 918:	36cb8b93          	addi	s7,s7,876 # c80 <digits>
 91c:	03c9d793          	srli	a5,s3,0x3c
 920:	97de                	add	a5,a5,s7
 922:	0007c583          	lbu	a1,0(a5)
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	e1a080e7          	jalr	-486(ra) # 742 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 930:	0992                	slli	s3,s3,0x4
 932:	397d                	addiw	s2,s2,-1
 934:	fe0914e3          	bnez	s2,91c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 938:	8be2                	mv	s7,s8
      state = 0;
 93a:	4981                	li	s3,0
 93c:	bf21                	j	854 <vprintf+0x44>
        s = va_arg(ap, char*);
 93e:	008b8993          	addi	s3,s7,8
 942:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 946:	02090163          	beqz	s2,968 <vprintf+0x158>
        while(*s != 0){
 94a:	00094583          	lbu	a1,0(s2)
 94e:	c9a5                	beqz	a1,9be <vprintf+0x1ae>
          putc(fd, *s);
 950:	8556                	mv	a0,s5
 952:	00000097          	auipc	ra,0x0
 956:	df0080e7          	jalr	-528(ra) # 742 <putc>
          s++;
 95a:	0905                	addi	s2,s2,1
        while(*s != 0){
 95c:	00094583          	lbu	a1,0(s2)
 960:	f9e5                	bnez	a1,950 <vprintf+0x140>
        s = va_arg(ap, char*);
 962:	8bce                	mv	s7,s3
      state = 0;
 964:	4981                	li	s3,0
 966:	b5fd                	j	854 <vprintf+0x44>
          s = "(null)";
 968:	00000917          	auipc	s2,0x0
 96c:	2b890913          	addi	s2,s2,696 # c20 <malloc+0x15e>
        while(*s != 0){
 970:	02800593          	li	a1,40
 974:	bff1                	j	950 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 976:	008b8913          	addi	s2,s7,8
 97a:	000bc583          	lbu	a1,0(s7)
 97e:	8556                	mv	a0,s5
 980:	00000097          	auipc	ra,0x0
 984:	dc2080e7          	jalr	-574(ra) # 742 <putc>
 988:	8bca                	mv	s7,s2
      state = 0;
 98a:	4981                	li	s3,0
 98c:	b5e1                	j	854 <vprintf+0x44>
        putc(fd, c);
 98e:	02500593          	li	a1,37
 992:	8556                	mv	a0,s5
 994:	00000097          	auipc	ra,0x0
 998:	dae080e7          	jalr	-594(ra) # 742 <putc>
      state = 0;
 99c:	4981                	li	s3,0
 99e:	bd5d                	j	854 <vprintf+0x44>
        putc(fd, '%');
 9a0:	02500593          	li	a1,37
 9a4:	8556                	mv	a0,s5
 9a6:	00000097          	auipc	ra,0x0
 9aa:	d9c080e7          	jalr	-612(ra) # 742 <putc>
        putc(fd, c);
 9ae:	85ca                	mv	a1,s2
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	d90080e7          	jalr	-624(ra) # 742 <putc>
      state = 0;
 9ba:	4981                	li	s3,0
 9bc:	bd61                	j	854 <vprintf+0x44>
        s = va_arg(ap, char*);
 9be:	8bce                	mv	s7,s3
      state = 0;
 9c0:	4981                	li	s3,0
 9c2:	bd49                	j	854 <vprintf+0x44>
    }
  }
}
 9c4:	60a6                	ld	ra,72(sp)
 9c6:	6406                	ld	s0,64(sp)
 9c8:	74e2                	ld	s1,56(sp)
 9ca:	7942                	ld	s2,48(sp)
 9cc:	79a2                	ld	s3,40(sp)
 9ce:	7a02                	ld	s4,32(sp)
 9d0:	6ae2                	ld	s5,24(sp)
 9d2:	6b42                	ld	s6,16(sp)
 9d4:	6ba2                	ld	s7,8(sp)
 9d6:	6c02                	ld	s8,0(sp)
 9d8:	6161                	addi	sp,sp,80
 9da:	8082                	ret

00000000000009dc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9dc:	715d                	addi	sp,sp,-80
 9de:	ec06                	sd	ra,24(sp)
 9e0:	e822                	sd	s0,16(sp)
 9e2:	1000                	addi	s0,sp,32
 9e4:	e010                	sd	a2,0(s0)
 9e6:	e414                	sd	a3,8(s0)
 9e8:	e818                	sd	a4,16(s0)
 9ea:	ec1c                	sd	a5,24(s0)
 9ec:	03043023          	sd	a6,32(s0)
 9f0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9f4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9f8:	8622                	mv	a2,s0
 9fa:	00000097          	auipc	ra,0x0
 9fe:	e16080e7          	jalr	-490(ra) # 810 <vprintf>
}
 a02:	60e2                	ld	ra,24(sp)
 a04:	6442                	ld	s0,16(sp)
 a06:	6161                	addi	sp,sp,80
 a08:	8082                	ret

0000000000000a0a <printf>:

void
printf(const char *fmt, ...)
{
 a0a:	711d                	addi	sp,sp,-96
 a0c:	ec06                	sd	ra,24(sp)
 a0e:	e822                	sd	s0,16(sp)
 a10:	1000                	addi	s0,sp,32
 a12:	e40c                	sd	a1,8(s0)
 a14:	e810                	sd	a2,16(s0)
 a16:	ec14                	sd	a3,24(s0)
 a18:	f018                	sd	a4,32(s0)
 a1a:	f41c                	sd	a5,40(s0)
 a1c:	03043823          	sd	a6,48(s0)
 a20:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a24:	00840613          	addi	a2,s0,8
 a28:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a2c:	85aa                	mv	a1,a0
 a2e:	4505                	li	a0,1
 a30:	00000097          	auipc	ra,0x0
 a34:	de0080e7          	jalr	-544(ra) # 810 <vprintf>
}
 a38:	60e2                	ld	ra,24(sp)
 a3a:	6442                	ld	s0,16(sp)
 a3c:	6125                	addi	sp,sp,96
 a3e:	8082                	ret

0000000000000a40 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a40:	1141                	addi	sp,sp,-16
 a42:	e422                	sd	s0,8(sp)
 a44:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a46:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a4a:	00000797          	auipc	a5,0x0
 a4e:	5ce7b783          	ld	a5,1486(a5) # 1018 <freep>
 a52:	a02d                	j	a7c <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a54:	4618                	lw	a4,8(a2)
 a56:	9f2d                	addw	a4,a4,a1
 a58:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a5c:	6398                	ld	a4,0(a5)
 a5e:	6310                	ld	a2,0(a4)
 a60:	a83d                	j	a9e <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a62:	ff852703          	lw	a4,-8(a0)
 a66:	9f31                	addw	a4,a4,a2
 a68:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a6a:	ff053683          	ld	a3,-16(a0)
 a6e:	a091                	j	ab2 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a70:	6398                	ld	a4,0(a5)
 a72:	00e7e463          	bltu	a5,a4,a7a <free+0x3a>
 a76:	00e6ea63          	bltu	a3,a4,a8a <free+0x4a>
{
 a7a:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a7c:	fed7fae3          	bgeu	a5,a3,a70 <free+0x30>
 a80:	6398                	ld	a4,0(a5)
 a82:	00e6e463          	bltu	a3,a4,a8a <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a86:	fee7eae3          	bltu	a5,a4,a7a <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 a8a:	ff852583          	lw	a1,-8(a0)
 a8e:	6390                	ld	a2,0(a5)
 a90:	02059813          	slli	a6,a1,0x20
 a94:	01c85713          	srli	a4,a6,0x1c
 a98:	9736                	add	a4,a4,a3
 a9a:	fae60de3          	beq	a2,a4,a54 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 a9e:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 aa2:	4790                	lw	a2,8(a5)
 aa4:	02061593          	slli	a1,a2,0x20
 aa8:	01c5d713          	srli	a4,a1,0x1c
 aac:	973e                	add	a4,a4,a5
 aae:	fae68ae3          	beq	a3,a4,a62 <free+0x22>
        p->s.ptr = bp->s.ptr;
 ab2:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 ab4:	00000717          	auipc	a4,0x0
 ab8:	56f73223          	sd	a5,1380(a4) # 1018 <freep>
}
 abc:	6422                	ld	s0,8(sp)
 abe:	0141                	addi	sp,sp,16
 ac0:	8082                	ret

0000000000000ac2 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 ac2:	7139                	addi	sp,sp,-64
 ac4:	fc06                	sd	ra,56(sp)
 ac6:	f822                	sd	s0,48(sp)
 ac8:	f426                	sd	s1,40(sp)
 aca:	f04a                	sd	s2,32(sp)
 acc:	ec4e                	sd	s3,24(sp)
 ace:	e852                	sd	s4,16(sp)
 ad0:	e456                	sd	s5,8(sp)
 ad2:	e05a                	sd	s6,0(sp)
 ad4:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 ad6:	02051493          	slli	s1,a0,0x20
 ada:	9081                	srli	s1,s1,0x20
 adc:	04bd                	addi	s1,s1,15
 ade:	8091                	srli	s1,s1,0x4
 ae0:	0014899b          	addiw	s3,s1,1
 ae4:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 ae6:	00000517          	auipc	a0,0x0
 aea:	53253503          	ld	a0,1330(a0) # 1018 <freep>
 aee:	c515                	beqz	a0,b1a <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 af0:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 af2:	4798                	lw	a4,8(a5)
 af4:	02977f63          	bgeu	a4,s1,b32 <malloc+0x70>
    if (nu < 4096)
 af8:	8a4e                	mv	s4,s3
 afa:	0009871b          	sext.w	a4,s3
 afe:	6685                	lui	a3,0x1
 b00:	00d77363          	bgeu	a4,a3,b06 <malloc+0x44>
 b04:	6a05                	lui	s4,0x1
 b06:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b0a:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b0e:	00000917          	auipc	s2,0x0
 b12:	50a90913          	addi	s2,s2,1290 # 1018 <freep>
    if (p == (char *)-1)
 b16:	5afd                	li	s5,-1
 b18:	a895                	j	b8c <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b1a:	00000797          	auipc	a5,0x0
 b1e:	58678793          	addi	a5,a5,1414 # 10a0 <base>
 b22:	00000717          	auipc	a4,0x0
 b26:	4ef73b23          	sd	a5,1270(a4) # 1018 <freep>
 b2a:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b2c:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b30:	b7e1                	j	af8 <malloc+0x36>
            if (p->s.size == nunits)
 b32:	02e48c63          	beq	s1,a4,b6a <malloc+0xa8>
                p->s.size -= nunits;
 b36:	4137073b          	subw	a4,a4,s3
 b3a:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b3c:	02071693          	slli	a3,a4,0x20
 b40:	01c6d713          	srli	a4,a3,0x1c
 b44:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b46:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b4a:	00000717          	auipc	a4,0x0
 b4e:	4ca73723          	sd	a0,1230(a4) # 1018 <freep>
            return (void *)(p + 1);
 b52:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b56:	70e2                	ld	ra,56(sp)
 b58:	7442                	ld	s0,48(sp)
 b5a:	74a2                	ld	s1,40(sp)
 b5c:	7902                	ld	s2,32(sp)
 b5e:	69e2                	ld	s3,24(sp)
 b60:	6a42                	ld	s4,16(sp)
 b62:	6aa2                	ld	s5,8(sp)
 b64:	6b02                	ld	s6,0(sp)
 b66:	6121                	addi	sp,sp,64
 b68:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b6a:	6398                	ld	a4,0(a5)
 b6c:	e118                	sd	a4,0(a0)
 b6e:	bff1                	j	b4a <malloc+0x88>
    hp->s.size = nu;
 b70:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b74:	0541                	addi	a0,a0,16
 b76:	00000097          	auipc	ra,0x0
 b7a:	eca080e7          	jalr	-310(ra) # a40 <free>
    return freep;
 b7e:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b82:	d971                	beqz	a0,b56 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b84:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 b86:	4798                	lw	a4,8(a5)
 b88:	fa9775e3          	bgeu	a4,s1,b32 <malloc+0x70>
        if (p == freep)
 b8c:	00093703          	ld	a4,0(s2)
 b90:	853e                	mv	a0,a5
 b92:	fef719e3          	bne	a4,a5,b84 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 b96:	8552                	mv	a0,s4
 b98:	00000097          	auipc	ra,0x0
 b9c:	b7a080e7          	jalr	-1158(ra) # 712 <sbrk>
    if (p == (char *)-1)
 ba0:	fd5518e3          	bne	a0,s5,b70 <malloc+0xae>
                return 0;
 ba4:	4501                	li	a0,0
 ba6:	bf45                	j	b56 <malloc+0x94>
