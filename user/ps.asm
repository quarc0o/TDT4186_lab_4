
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
  18:	72c080e7          	jalr	1836(ra) # 740 <ps>

    for (int i = 0; i < 64; i++)
  1c:	01450493          	addi	s1,a0,20
  20:	6785                	lui	a5,0x1
  22:	91478793          	addi	a5,a5,-1772 # 914 <vprintf+0xee>
  26:	00f50933          	add	s2,a0,a5
    {
        if (procs[i].state == UNUSED)
            break;
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  2a:	00001997          	auipc	s3,0x1
  2e:	b9698993          	addi	s3,s3,-1130 # bc0 <malloc+0xe8>
        if (procs[i].state == UNUSED)
  32:	fec4a683          	lw	a3,-20(s1)
  36:	ce89                	beqz	a3,50 <main+0x50>
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  38:	ff84a603          	lw	a2,-8(s1)
  3c:	85a6                	mv	a1,s1
  3e:	854e                	mv	a0,s3
  40:	00001097          	auipc	ra,0x1
  44:	9e0080e7          	jalr	-1568(ra) # a20 <printf>
    for (int i = 0; i < 64; i++)
  48:	02448493          	addi	s1,s1,36
  4c:	ff2493e3          	bne	s1,s2,32 <main+0x32>
    }
    exit(0);
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	64e080e7          	jalr	1614(ra) # 6a0 <exit>

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
  8e:	2c4080e7          	jalr	708(ra) # 34e <twhoami>
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
  da:	afa50513          	addi	a0,a0,-1286 # bd0 <malloc+0xf8>
  de:	00001097          	auipc	ra,0x1
  e2:	942080e7          	jalr	-1726(ra) # a20 <printf>
        exit(-1);
  e6:	557d                	li	a0,-1
  e8:	00000097          	auipc	ra,0x0
  ec:	5b8080e7          	jalr	1464(ra) # 6a0 <exit>
    {
        // give up the cpu for other threads
        tyield();
  f0:	00000097          	auipc	ra,0x0
  f4:	1dc080e7          	jalr	476(ra) # 2cc <tyield>
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
 10e:	244080e7          	jalr	580(ra) # 34e <twhoami>
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
 152:	17e080e7          	jalr	382(ra) # 2cc <tyield>
}
 156:	60e2                	ld	ra,24(sp)
 158:	6442                	ld	s0,16(sp)
 15a:	64a2                	ld	s1,8(sp)
 15c:	6105                	addi	sp,sp,32
 15e:	8082                	ret
        printf("releasing lock we are not holding");
 160:	00001517          	auipc	a0,0x1
 164:	a9850513          	addi	a0,a0,-1384 # bf8 <malloc+0x120>
 168:	00001097          	auipc	ra,0x1
 16c:	8b8080e7          	jalr	-1864(ra) # a20 <printf>
        exit(-1);
 170:	557d                	li	a0,-1
 172:	00000097          	auipc	ra,0x0
 176:	52e080e7          	jalr	1326(ra) # 6a0 <exit>

000000000000017a <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 17a:	00001517          	auipc	a0,0x1
 17e:	e9653503          	ld	a0,-362(a0) # 1010 <current_thread>
 182:	00001717          	auipc	a4,0x1
 186:	e9e70713          	addi	a4,a4,-354 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 18a:	4781                	li	a5,0
 18c:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 18e:	6314                	ld	a3,0(a4)
 190:	00a68763          	beq	a3,a0,19e <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 194:	2785                	addiw	a5,a5,1
 196:	0721                	addi	a4,a4,8
 198:	fec79be3          	bne	a5,a2,18e <tsched+0x14>
    int current_index = 0;
 19c:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 19e:	0017869b          	addiw	a3,a5,1
 1a2:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1a6:	00001817          	auipc	a6,0x1
 1aa:	e7a80813          	addi	a6,a6,-390 # 1020 <threads>
 1ae:	488d                	li	a7,3
 1b0:	a021                	j	1b8 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1b2:	2685                	addiw	a3,a3,1
 1b4:	04c68363          	beq	a3,a2,1fa <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1b8:	41f6d71b          	sraiw	a4,a3,0x1f
 1bc:	01c7571b          	srliw	a4,a4,0x1c
 1c0:	00d707bb          	addw	a5,a4,a3
 1c4:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1c6:	9f99                	subw	a5,a5,a4
 1c8:	078e                	slli	a5,a5,0x3
 1ca:	97c2                	add	a5,a5,a6
 1cc:	638c                	ld	a1,0(a5)
 1ce:	d1f5                	beqz	a1,1b2 <tsched+0x38>
 1d0:	5dbc                	lw	a5,120(a1)
 1d2:	ff1790e3          	bne	a5,a7,1b2 <tsched+0x38>
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e406                	sd	ra,8(sp)
 1da:	e022                	sd	s0,0(sp)
 1dc:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1de:	00001797          	auipc	a5,0x1
 1e2:	e2b7b923          	sd	a1,-462(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1e6:	05a1                	addi	a1,a1,8
 1e8:	0521                	addi	a0,a0,8
 1ea:	00000097          	auipc	ra,0x0
 1ee:	17c080e7          	jalr	380(ra) # 366 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 1f2:	60a2                	ld	ra,8(sp)
 1f4:	6402                	ld	s0,0(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret
 1fa:	8082                	ret

00000000000001fc <thread_wrapper>:
{
 1fc:	1101                	addi	sp,sp,-32
 1fe:	ec06                	sd	ra,24(sp)
 200:	e822                	sd	s0,16(sp)
 202:	e426                	sd	s1,8(sp)
 204:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 206:	00001497          	auipc	s1,0x1
 20a:	e0a48493          	addi	s1,s1,-502 # 1010 <current_thread>
 20e:	609c                	ld	a5,0(s1)
 210:	67d8                	ld	a4,136(a5)
 212:	63c8                	ld	a0,128(a5)
 214:	9702                	jalr	a4
    current_thread->state = EXITED;
 216:	609c                	ld	a5,0(s1)
 218:	4719                	li	a4,6
 21a:	dfb8                	sw	a4,120(a5)
    tsched();
 21c:	00000097          	auipc	ra,0x0
 220:	f5e080e7          	jalr	-162(ra) # 17a <tsched>
}
 224:	60e2                	ld	ra,24(sp)
 226:	6442                	ld	s0,16(sp)
 228:	64a2                	ld	s1,8(sp)
 22a:	6105                	addi	sp,sp,32
 22c:	8082                	ret

000000000000022e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 22e:	7179                	addi	sp,sp,-48
 230:	f406                	sd	ra,40(sp)
 232:	f022                	sd	s0,32(sp)
 234:	ec26                	sd	s1,24(sp)
 236:	e84a                	sd	s2,16(sp)
 238:	e44e                	sd	s3,8(sp)
 23a:	1800                	addi	s0,sp,48
 23c:	84aa                	mv	s1,a0
 23e:	89b2                	mv	s3,a2
 240:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 242:	09800513          	li	a0,152
 246:	00001097          	auipc	ra,0x1
 24a:	892080e7          	jalr	-1902(ra) # ad8 <malloc>
 24e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 250:	478d                	li	a5,3
 252:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 254:	609c                	ld	a5,0(s1)
 256:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 25a:	609c                	ld	a5,0(s1)
 25c:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 260:	6098                	ld	a4,0(s1)
 262:	00001797          	auipc	a5,0x1
 266:	d9e78793          	addi	a5,a5,-610 # 1000 <next_tid>
 26a:	4394                	lw	a3,0(a5)
 26c:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 270:	4398                	lw	a4,0(a5)
 272:	2705                	addiw	a4,a4,1
 274:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 276:	6505                	lui	a0,0x1
 278:	00001097          	auipc	ra,0x1
 27c:	860080e7          	jalr	-1952(ra) # ad8 <malloc>
 280:	609c                	ld	a5,0(s1)
 282:	6705                	lui	a4,0x1
 284:	953a                	add	a0,a0,a4
 286:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 288:	609c                	ld	a5,0(s1)
 28a:	00000717          	auipc	a4,0x0
 28e:	f7270713          	addi	a4,a4,-142 # 1fc <thread_wrapper>
 292:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 294:	00001717          	auipc	a4,0x1
 298:	d8c70713          	addi	a4,a4,-628 # 1020 <threads>
 29c:	4781                	li	a5,0
 29e:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2a0:	6314                	ld	a3,0(a4)
 2a2:	ce81                	beqz	a3,2ba <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 2a4:	2785                	addiw	a5,a5,1
 2a6:	0721                	addi	a4,a4,8
 2a8:	fec79ce3          	bne	a5,a2,2a0 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 2ac:	70a2                	ld	ra,40(sp)
 2ae:	7402                	ld	s0,32(sp)
 2b0:	64e2                	ld	s1,24(sp)
 2b2:	6942                	ld	s2,16(sp)
 2b4:	69a2                	ld	s3,8(sp)
 2b6:	6145                	addi	sp,sp,48
 2b8:	8082                	ret
            threads[i] = *thread;
 2ba:	6094                	ld	a3,0(s1)
 2bc:	078e                	slli	a5,a5,0x3
 2be:	00001717          	auipc	a4,0x1
 2c2:	d6270713          	addi	a4,a4,-670 # 1020 <threads>
 2c6:	97ba                	add	a5,a5,a4
 2c8:	e394                	sd	a3,0(a5)
            break;
 2ca:	b7cd                	j	2ac <tcreate+0x7e>

00000000000002cc <tyield>:
    return 0;
}


void tyield()
{
 2cc:	1141                	addi	sp,sp,-16
 2ce:	e406                	sd	ra,8(sp)
 2d0:	e022                	sd	s0,0(sp)
 2d2:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 2d4:	00001797          	auipc	a5,0x1
 2d8:	d3c7b783          	ld	a5,-708(a5) # 1010 <current_thread>
 2dc:	470d                	li	a4,3
 2de:	dfb8                	sw	a4,120(a5)
    tsched();
 2e0:	00000097          	auipc	ra,0x0
 2e4:	e9a080e7          	jalr	-358(ra) # 17a <tsched>
}
 2e8:	60a2                	ld	ra,8(sp)
 2ea:	6402                	ld	s0,0(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret

00000000000002f0 <tjoin>:
{
 2f0:	1101                	addi	sp,sp,-32
 2f2:	ec06                	sd	ra,24(sp)
 2f4:	e822                	sd	s0,16(sp)
 2f6:	e426                	sd	s1,8(sp)
 2f8:	e04a                	sd	s2,0(sp)
 2fa:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 2fc:	00001797          	auipc	a5,0x1
 300:	d2478793          	addi	a5,a5,-732 # 1020 <threads>
 304:	00001697          	auipc	a3,0x1
 308:	d9c68693          	addi	a3,a3,-612 # 10a0 <base>
 30c:	a021                	j	314 <tjoin+0x24>
 30e:	07a1                	addi	a5,a5,8
 310:	02d78b63          	beq	a5,a3,346 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 314:	6384                	ld	s1,0(a5)
 316:	dce5                	beqz	s1,30e <tjoin+0x1e>
 318:	0004c703          	lbu	a4,0(s1)
 31c:	fea719e3          	bne	a4,a0,30e <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 320:	5cb8                	lw	a4,120(s1)
 322:	4799                	li	a5,6
 324:	4919                	li	s2,6
 326:	02f70263          	beq	a4,a5,34a <tjoin+0x5a>
        tyield();
 32a:	00000097          	auipc	ra,0x0
 32e:	fa2080e7          	jalr	-94(ra) # 2cc <tyield>
    while (target_thread->state != EXITED) {
 332:	5cbc                	lw	a5,120(s1)
 334:	ff279be3          	bne	a5,s2,32a <tjoin+0x3a>
    return 0;
 338:	4501                	li	a0,0
}
 33a:	60e2                	ld	ra,24(sp)
 33c:	6442                	ld	s0,16(sp)
 33e:	64a2                	ld	s1,8(sp)
 340:	6902                	ld	s2,0(sp)
 342:	6105                	addi	sp,sp,32
 344:	8082                	ret
        return -1;
 346:	557d                	li	a0,-1
 348:	bfcd                	j	33a <tjoin+0x4a>
    return 0;
 34a:	4501                	li	a0,0
 34c:	b7fd                	j	33a <tjoin+0x4a>

000000000000034e <twhoami>:

uint8 twhoami()
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 354:	00001797          	auipc	a5,0x1
 358:	cbc7b783          	ld	a5,-836(a5) # 1010 <current_thread>
 35c:	0007c503          	lbu	a0,0(a5)
 360:	6422                	ld	s0,8(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret

0000000000000366 <tswtch>:
 366:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 36a:	00253423          	sd	sp,8(a0)
 36e:	e900                	sd	s0,16(a0)
 370:	ed04                	sd	s1,24(a0)
 372:	03253023          	sd	s2,32(a0)
 376:	03353423          	sd	s3,40(a0)
 37a:	03453823          	sd	s4,48(a0)
 37e:	03553c23          	sd	s5,56(a0)
 382:	05653023          	sd	s6,64(a0)
 386:	05753423          	sd	s7,72(a0)
 38a:	05853823          	sd	s8,80(a0)
 38e:	05953c23          	sd	s9,88(a0)
 392:	07a53023          	sd	s10,96(a0)
 396:	07b53423          	sd	s11,104(a0)
 39a:	0005b083          	ld	ra,0(a1)
 39e:	0085b103          	ld	sp,8(a1)
 3a2:	6980                	ld	s0,16(a1)
 3a4:	6d84                	ld	s1,24(a1)
 3a6:	0205b903          	ld	s2,32(a1)
 3aa:	0285b983          	ld	s3,40(a1)
 3ae:	0305ba03          	ld	s4,48(a1)
 3b2:	0385ba83          	ld	s5,56(a1)
 3b6:	0405bb03          	ld	s6,64(a1)
 3ba:	0485bb83          	ld	s7,72(a1)
 3be:	0505bc03          	ld	s8,80(a1)
 3c2:	0585bc83          	ld	s9,88(a1)
 3c6:	0605bd03          	ld	s10,96(a1)
 3ca:	0685bd83          	ld	s11,104(a1)
 3ce:	8082                	ret

00000000000003d0 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3d0:	1101                	addi	sp,sp,-32
 3d2:	ec06                	sd	ra,24(sp)
 3d4:	e822                	sd	s0,16(sp)
 3d6:	e426                	sd	s1,8(sp)
 3d8:	e04a                	sd	s2,0(sp)
 3da:	1000                	addi	s0,sp,32
 3dc:	84aa                	mv	s1,a0
 3de:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3e0:	09800513          	li	a0,152
 3e4:	00000097          	auipc	ra,0x0
 3e8:	6f4080e7          	jalr	1780(ra) # ad8 <malloc>

    main_thread->tid = 1;
 3ec:	4785                	li	a5,1
 3ee:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 3f2:	4791                	li	a5,4
 3f4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3f6:	00001797          	auipc	a5,0x1
 3fa:	c0a7bd23          	sd	a0,-998(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3fe:	00001797          	auipc	a5,0x1
 402:	c2278793          	addi	a5,a5,-990 # 1020 <threads>
 406:	00001717          	auipc	a4,0x1
 40a:	c9a70713          	addi	a4,a4,-870 # 10a0 <base>
        threads[i] = NULL;
 40e:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 412:	07a1                	addi	a5,a5,8
 414:	fee79de3          	bne	a5,a4,40e <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 418:	00001797          	auipc	a5,0x1
 41c:	c0a7b423          	sd	a0,-1016(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 420:	85ca                	mv	a1,s2
 422:	8526                	mv	a0,s1
 424:	00000097          	auipc	ra,0x0
 428:	bdc080e7          	jalr	-1060(ra) # 0 <main>
    //tsched();

    exit(res);
 42c:	00000097          	auipc	ra,0x0
 430:	274080e7          	jalr	628(ra) # 6a0 <exit>

0000000000000434 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 434:	1141                	addi	sp,sp,-16
 436:	e422                	sd	s0,8(sp)
 438:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 43a:	87aa                	mv	a5,a0
 43c:	0585                	addi	a1,a1,1
 43e:	0785                	addi	a5,a5,1
 440:	fff5c703          	lbu	a4,-1(a1)
 444:	fee78fa3          	sb	a4,-1(a5)
 448:	fb75                	bnez	a4,43c <strcpy+0x8>
        ;
    return os;
}
 44a:	6422                	ld	s0,8(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret

0000000000000450 <strcmp>:

int strcmp(const char *p, const char *q)
{
 450:	1141                	addi	sp,sp,-16
 452:	e422                	sd	s0,8(sp)
 454:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 456:	00054783          	lbu	a5,0(a0)
 45a:	cb91                	beqz	a5,46e <strcmp+0x1e>
 45c:	0005c703          	lbu	a4,0(a1)
 460:	00f71763          	bne	a4,a5,46e <strcmp+0x1e>
        p++, q++;
 464:	0505                	addi	a0,a0,1
 466:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 468:	00054783          	lbu	a5,0(a0)
 46c:	fbe5                	bnez	a5,45c <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 46e:	0005c503          	lbu	a0,0(a1)
}
 472:	40a7853b          	subw	a0,a5,a0
 476:	6422                	ld	s0,8(sp)
 478:	0141                	addi	sp,sp,16
 47a:	8082                	ret

000000000000047c <strlen>:

uint strlen(const char *s)
{
 47c:	1141                	addi	sp,sp,-16
 47e:	e422                	sd	s0,8(sp)
 480:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 482:	00054783          	lbu	a5,0(a0)
 486:	cf91                	beqz	a5,4a2 <strlen+0x26>
 488:	0505                	addi	a0,a0,1
 48a:	87aa                	mv	a5,a0
 48c:	86be                	mv	a3,a5
 48e:	0785                	addi	a5,a5,1
 490:	fff7c703          	lbu	a4,-1(a5)
 494:	ff65                	bnez	a4,48c <strlen+0x10>
 496:	40a6853b          	subw	a0,a3,a0
 49a:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 49c:	6422                	ld	s0,8(sp)
 49e:	0141                	addi	sp,sp,16
 4a0:	8082                	ret
    for (n = 0; s[n]; n++)
 4a2:	4501                	li	a0,0
 4a4:	bfe5                	j	49c <strlen+0x20>

00000000000004a6 <memset>:

void *
memset(void *dst, int c, uint n)
{
 4a6:	1141                	addi	sp,sp,-16
 4a8:	e422                	sd	s0,8(sp)
 4aa:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4ac:	ca19                	beqz	a2,4c2 <memset+0x1c>
 4ae:	87aa                	mv	a5,a0
 4b0:	1602                	slli	a2,a2,0x20
 4b2:	9201                	srli	a2,a2,0x20
 4b4:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4b8:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4bc:	0785                	addi	a5,a5,1
 4be:	fee79de3          	bne	a5,a4,4b8 <memset+0x12>
    }
    return dst;
}
 4c2:	6422                	ld	s0,8(sp)
 4c4:	0141                	addi	sp,sp,16
 4c6:	8082                	ret

00000000000004c8 <strchr>:

char *
strchr(const char *s, char c)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e422                	sd	s0,8(sp)
 4cc:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4ce:	00054783          	lbu	a5,0(a0)
 4d2:	cb99                	beqz	a5,4e8 <strchr+0x20>
        if (*s == c)
 4d4:	00f58763          	beq	a1,a5,4e2 <strchr+0x1a>
    for (; *s; s++)
 4d8:	0505                	addi	a0,a0,1
 4da:	00054783          	lbu	a5,0(a0)
 4de:	fbfd                	bnez	a5,4d4 <strchr+0xc>
            return (char *)s;
    return 0;
 4e0:	4501                	li	a0,0
}
 4e2:	6422                	ld	s0,8(sp)
 4e4:	0141                	addi	sp,sp,16
 4e6:	8082                	ret
    return 0;
 4e8:	4501                	li	a0,0
 4ea:	bfe5                	j	4e2 <strchr+0x1a>

00000000000004ec <gets>:

char *
gets(char *buf, int max)
{
 4ec:	711d                	addi	sp,sp,-96
 4ee:	ec86                	sd	ra,88(sp)
 4f0:	e8a2                	sd	s0,80(sp)
 4f2:	e4a6                	sd	s1,72(sp)
 4f4:	e0ca                	sd	s2,64(sp)
 4f6:	fc4e                	sd	s3,56(sp)
 4f8:	f852                	sd	s4,48(sp)
 4fa:	f456                	sd	s5,40(sp)
 4fc:	f05a                	sd	s6,32(sp)
 4fe:	ec5e                	sd	s7,24(sp)
 500:	1080                	addi	s0,sp,96
 502:	8baa                	mv	s7,a0
 504:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 506:	892a                	mv	s2,a0
 508:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 50a:	4aa9                	li	s5,10
 50c:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 50e:	89a6                	mv	s3,s1
 510:	2485                	addiw	s1,s1,1
 512:	0344d863          	bge	s1,s4,542 <gets+0x56>
        cc = read(0, &c, 1);
 516:	4605                	li	a2,1
 518:	faf40593          	addi	a1,s0,-81
 51c:	4501                	li	a0,0
 51e:	00000097          	auipc	ra,0x0
 522:	19a080e7          	jalr	410(ra) # 6b8 <read>
        if (cc < 1)
 526:	00a05e63          	blez	a0,542 <gets+0x56>
        buf[i++] = c;
 52a:	faf44783          	lbu	a5,-81(s0)
 52e:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 532:	01578763          	beq	a5,s5,540 <gets+0x54>
 536:	0905                	addi	s2,s2,1
 538:	fd679be3          	bne	a5,s6,50e <gets+0x22>
    for (i = 0; i + 1 < max;)
 53c:	89a6                	mv	s3,s1
 53e:	a011                	j	542 <gets+0x56>
 540:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 542:	99de                	add	s3,s3,s7
 544:	00098023          	sb	zero,0(s3)
    return buf;
}
 548:	855e                	mv	a0,s7
 54a:	60e6                	ld	ra,88(sp)
 54c:	6446                	ld	s0,80(sp)
 54e:	64a6                	ld	s1,72(sp)
 550:	6906                	ld	s2,64(sp)
 552:	79e2                	ld	s3,56(sp)
 554:	7a42                	ld	s4,48(sp)
 556:	7aa2                	ld	s5,40(sp)
 558:	7b02                	ld	s6,32(sp)
 55a:	6be2                	ld	s7,24(sp)
 55c:	6125                	addi	sp,sp,96
 55e:	8082                	ret

0000000000000560 <stat>:

int stat(const char *n, struct stat *st)
{
 560:	1101                	addi	sp,sp,-32
 562:	ec06                	sd	ra,24(sp)
 564:	e822                	sd	s0,16(sp)
 566:	e426                	sd	s1,8(sp)
 568:	e04a                	sd	s2,0(sp)
 56a:	1000                	addi	s0,sp,32
 56c:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 56e:	4581                	li	a1,0
 570:	00000097          	auipc	ra,0x0
 574:	170080e7          	jalr	368(ra) # 6e0 <open>
    if (fd < 0)
 578:	02054563          	bltz	a0,5a2 <stat+0x42>
 57c:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 57e:	85ca                	mv	a1,s2
 580:	00000097          	auipc	ra,0x0
 584:	178080e7          	jalr	376(ra) # 6f8 <fstat>
 588:	892a                	mv	s2,a0
    close(fd);
 58a:	8526                	mv	a0,s1
 58c:	00000097          	auipc	ra,0x0
 590:	13c080e7          	jalr	316(ra) # 6c8 <close>
    return r;
}
 594:	854a                	mv	a0,s2
 596:	60e2                	ld	ra,24(sp)
 598:	6442                	ld	s0,16(sp)
 59a:	64a2                	ld	s1,8(sp)
 59c:	6902                	ld	s2,0(sp)
 59e:	6105                	addi	sp,sp,32
 5a0:	8082                	ret
        return -1;
 5a2:	597d                	li	s2,-1
 5a4:	bfc5                	j	594 <stat+0x34>

00000000000005a6 <atoi>:

int atoi(const char *s)
{
 5a6:	1141                	addi	sp,sp,-16
 5a8:	e422                	sd	s0,8(sp)
 5aa:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5ac:	00054683          	lbu	a3,0(a0)
 5b0:	fd06879b          	addiw	a5,a3,-48
 5b4:	0ff7f793          	zext.b	a5,a5
 5b8:	4625                	li	a2,9
 5ba:	02f66863          	bltu	a2,a5,5ea <atoi+0x44>
 5be:	872a                	mv	a4,a0
    n = 0;
 5c0:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5c2:	0705                	addi	a4,a4,1
 5c4:	0025179b          	slliw	a5,a0,0x2
 5c8:	9fa9                	addw	a5,a5,a0
 5ca:	0017979b          	slliw	a5,a5,0x1
 5ce:	9fb5                	addw	a5,a5,a3
 5d0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5d4:	00074683          	lbu	a3,0(a4)
 5d8:	fd06879b          	addiw	a5,a3,-48
 5dc:	0ff7f793          	zext.b	a5,a5
 5e0:	fef671e3          	bgeu	a2,a5,5c2 <atoi+0x1c>
    return n;
}
 5e4:	6422                	ld	s0,8(sp)
 5e6:	0141                	addi	sp,sp,16
 5e8:	8082                	ret
    n = 0;
 5ea:	4501                	li	a0,0
 5ec:	bfe5                	j	5e4 <atoi+0x3e>

00000000000005ee <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5ee:	1141                	addi	sp,sp,-16
 5f0:	e422                	sd	s0,8(sp)
 5f2:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5f4:	02b57463          	bgeu	a0,a1,61c <memmove+0x2e>
    {
        while (n-- > 0)
 5f8:	00c05f63          	blez	a2,616 <memmove+0x28>
 5fc:	1602                	slli	a2,a2,0x20
 5fe:	9201                	srli	a2,a2,0x20
 600:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 604:	872a                	mv	a4,a0
            *dst++ = *src++;
 606:	0585                	addi	a1,a1,1
 608:	0705                	addi	a4,a4,1
 60a:	fff5c683          	lbu	a3,-1(a1)
 60e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 612:	fee79ae3          	bne	a5,a4,606 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 616:	6422                	ld	s0,8(sp)
 618:	0141                	addi	sp,sp,16
 61a:	8082                	ret
        dst += n;
 61c:	00c50733          	add	a4,a0,a2
        src += n;
 620:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 622:	fec05ae3          	blez	a2,616 <memmove+0x28>
 626:	fff6079b          	addiw	a5,a2,-1
 62a:	1782                	slli	a5,a5,0x20
 62c:	9381                	srli	a5,a5,0x20
 62e:	fff7c793          	not	a5,a5
 632:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 634:	15fd                	addi	a1,a1,-1
 636:	177d                	addi	a4,a4,-1
 638:	0005c683          	lbu	a3,0(a1)
 63c:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 640:	fee79ae3          	bne	a5,a4,634 <memmove+0x46>
 644:	bfc9                	j	616 <memmove+0x28>

0000000000000646 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 646:	1141                	addi	sp,sp,-16
 648:	e422                	sd	s0,8(sp)
 64a:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 64c:	ca05                	beqz	a2,67c <memcmp+0x36>
 64e:	fff6069b          	addiw	a3,a2,-1
 652:	1682                	slli	a3,a3,0x20
 654:	9281                	srli	a3,a3,0x20
 656:	0685                	addi	a3,a3,1
 658:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 65a:	00054783          	lbu	a5,0(a0)
 65e:	0005c703          	lbu	a4,0(a1)
 662:	00e79863          	bne	a5,a4,672 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 666:	0505                	addi	a0,a0,1
        p2++;
 668:	0585                	addi	a1,a1,1
    while (n-- > 0)
 66a:	fed518e3          	bne	a0,a3,65a <memcmp+0x14>
    }
    return 0;
 66e:	4501                	li	a0,0
 670:	a019                	j	676 <memcmp+0x30>
            return *p1 - *p2;
 672:	40e7853b          	subw	a0,a5,a4
}
 676:	6422                	ld	s0,8(sp)
 678:	0141                	addi	sp,sp,16
 67a:	8082                	ret
    return 0;
 67c:	4501                	li	a0,0
 67e:	bfe5                	j	676 <memcmp+0x30>

0000000000000680 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 680:	1141                	addi	sp,sp,-16
 682:	e406                	sd	ra,8(sp)
 684:	e022                	sd	s0,0(sp)
 686:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 688:	00000097          	auipc	ra,0x0
 68c:	f66080e7          	jalr	-154(ra) # 5ee <memmove>
}
 690:	60a2                	ld	ra,8(sp)
 692:	6402                	ld	s0,0(sp)
 694:	0141                	addi	sp,sp,16
 696:	8082                	ret

0000000000000698 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 698:	4885                	li	a7,1
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6a0:	4889                	li	a7,2
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6a8:	488d                	li	a7,3
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6b0:	4891                	li	a7,4
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <read>:
.global read
read:
 li a7, SYS_read
 6b8:	4895                	li	a7,5
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <write>:
.global write
write:
 li a7, SYS_write
 6c0:	48c1                	li	a7,16
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <close>:
.global close
close:
 li a7, SYS_close
 6c8:	48d5                	li	a7,21
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6d0:	4899                	li	a7,6
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6d8:	489d                	li	a7,7
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <open>:
.global open
open:
 li a7, SYS_open
 6e0:	48bd                	li	a7,15
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6e8:	48c5                	li	a7,17
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6f0:	48c9                	li	a7,18
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6f8:	48a1                	li	a7,8
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <link>:
.global link
link:
 li a7, SYS_link
 700:	48cd                	li	a7,19
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 708:	48d1                	li	a7,20
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 710:	48a5                	li	a7,9
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <dup>:
.global dup
dup:
 li a7, SYS_dup
 718:	48a9                	li	a7,10
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 720:	48ad                	li	a7,11
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 728:	48b1                	li	a7,12
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 730:	48b5                	li	a7,13
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 738:	48b9                	li	a7,14
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <ps>:
.global ps
ps:
 li a7, SYS_ps
 740:	48d9                	li	a7,22
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 748:	48dd                	li	a7,23
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 750:	48e1                	li	a7,24
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 758:	1101                	addi	sp,sp,-32
 75a:	ec06                	sd	ra,24(sp)
 75c:	e822                	sd	s0,16(sp)
 75e:	1000                	addi	s0,sp,32
 760:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 764:	4605                	li	a2,1
 766:	fef40593          	addi	a1,s0,-17
 76a:	00000097          	auipc	ra,0x0
 76e:	f56080e7          	jalr	-170(ra) # 6c0 <write>
}
 772:	60e2                	ld	ra,24(sp)
 774:	6442                	ld	s0,16(sp)
 776:	6105                	addi	sp,sp,32
 778:	8082                	ret

000000000000077a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 77a:	7139                	addi	sp,sp,-64
 77c:	fc06                	sd	ra,56(sp)
 77e:	f822                	sd	s0,48(sp)
 780:	f426                	sd	s1,40(sp)
 782:	f04a                	sd	s2,32(sp)
 784:	ec4e                	sd	s3,24(sp)
 786:	0080                	addi	s0,sp,64
 788:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 78a:	c299                	beqz	a3,790 <printint+0x16>
 78c:	0805c963          	bltz	a1,81e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 790:	2581                	sext.w	a1,a1
  neg = 0;
 792:	4881                	li	a7,0
 794:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 798:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 79a:	2601                	sext.w	a2,a2
 79c:	00000517          	auipc	a0,0x0
 7a0:	4e450513          	addi	a0,a0,1252 # c80 <digits>
 7a4:	883a                	mv	a6,a4
 7a6:	2705                	addiw	a4,a4,1
 7a8:	02c5f7bb          	remuw	a5,a1,a2
 7ac:	1782                	slli	a5,a5,0x20
 7ae:	9381                	srli	a5,a5,0x20
 7b0:	97aa                	add	a5,a5,a0
 7b2:	0007c783          	lbu	a5,0(a5)
 7b6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7ba:	0005879b          	sext.w	a5,a1
 7be:	02c5d5bb          	divuw	a1,a1,a2
 7c2:	0685                	addi	a3,a3,1
 7c4:	fec7f0e3          	bgeu	a5,a2,7a4 <printint+0x2a>
  if(neg)
 7c8:	00088c63          	beqz	a7,7e0 <printint+0x66>
    buf[i++] = '-';
 7cc:	fd070793          	addi	a5,a4,-48
 7d0:	00878733          	add	a4,a5,s0
 7d4:	02d00793          	li	a5,45
 7d8:	fef70823          	sb	a5,-16(a4)
 7dc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7e0:	02e05863          	blez	a4,810 <printint+0x96>
 7e4:	fc040793          	addi	a5,s0,-64
 7e8:	00e78933          	add	s2,a5,a4
 7ec:	fff78993          	addi	s3,a5,-1
 7f0:	99ba                	add	s3,s3,a4
 7f2:	377d                	addiw	a4,a4,-1
 7f4:	1702                	slli	a4,a4,0x20
 7f6:	9301                	srli	a4,a4,0x20
 7f8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7fc:	fff94583          	lbu	a1,-1(s2)
 800:	8526                	mv	a0,s1
 802:	00000097          	auipc	ra,0x0
 806:	f56080e7          	jalr	-170(ra) # 758 <putc>
  while(--i >= 0)
 80a:	197d                	addi	s2,s2,-1
 80c:	ff3918e3          	bne	s2,s3,7fc <printint+0x82>
}
 810:	70e2                	ld	ra,56(sp)
 812:	7442                	ld	s0,48(sp)
 814:	74a2                	ld	s1,40(sp)
 816:	7902                	ld	s2,32(sp)
 818:	69e2                	ld	s3,24(sp)
 81a:	6121                	addi	sp,sp,64
 81c:	8082                	ret
    x = -xx;
 81e:	40b005bb          	negw	a1,a1
    neg = 1;
 822:	4885                	li	a7,1
    x = -xx;
 824:	bf85                	j	794 <printint+0x1a>

0000000000000826 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 826:	715d                	addi	sp,sp,-80
 828:	e486                	sd	ra,72(sp)
 82a:	e0a2                	sd	s0,64(sp)
 82c:	fc26                	sd	s1,56(sp)
 82e:	f84a                	sd	s2,48(sp)
 830:	f44e                	sd	s3,40(sp)
 832:	f052                	sd	s4,32(sp)
 834:	ec56                	sd	s5,24(sp)
 836:	e85a                	sd	s6,16(sp)
 838:	e45e                	sd	s7,8(sp)
 83a:	e062                	sd	s8,0(sp)
 83c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 83e:	0005c903          	lbu	s2,0(a1)
 842:	18090c63          	beqz	s2,9da <vprintf+0x1b4>
 846:	8aaa                	mv	s5,a0
 848:	8bb2                	mv	s7,a2
 84a:	00158493          	addi	s1,a1,1
  state = 0;
 84e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 850:	02500a13          	li	s4,37
 854:	4b55                	li	s6,21
 856:	a839                	j	874 <vprintf+0x4e>
        putc(fd, c);
 858:	85ca                	mv	a1,s2
 85a:	8556                	mv	a0,s5
 85c:	00000097          	auipc	ra,0x0
 860:	efc080e7          	jalr	-260(ra) # 758 <putc>
 864:	a019                	j	86a <vprintf+0x44>
    } else if(state == '%'){
 866:	01498d63          	beq	s3,s4,880 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 86a:	0485                	addi	s1,s1,1
 86c:	fff4c903          	lbu	s2,-1(s1)
 870:	16090563          	beqz	s2,9da <vprintf+0x1b4>
    if(state == 0){
 874:	fe0999e3          	bnez	s3,866 <vprintf+0x40>
      if(c == '%'){
 878:	ff4910e3          	bne	s2,s4,858 <vprintf+0x32>
        state = '%';
 87c:	89d2                	mv	s3,s4
 87e:	b7f5                	j	86a <vprintf+0x44>
      if(c == 'd'){
 880:	13490263          	beq	s2,s4,9a4 <vprintf+0x17e>
 884:	f9d9079b          	addiw	a5,s2,-99
 888:	0ff7f793          	zext.b	a5,a5
 88c:	12fb6563          	bltu	s6,a5,9b6 <vprintf+0x190>
 890:	f9d9079b          	addiw	a5,s2,-99
 894:	0ff7f713          	zext.b	a4,a5
 898:	10eb6f63          	bltu	s6,a4,9b6 <vprintf+0x190>
 89c:	00271793          	slli	a5,a4,0x2
 8a0:	00000717          	auipc	a4,0x0
 8a4:	38870713          	addi	a4,a4,904 # c28 <malloc+0x150>
 8a8:	97ba                	add	a5,a5,a4
 8aa:	439c                	lw	a5,0(a5)
 8ac:	97ba                	add	a5,a5,a4
 8ae:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8b0:	008b8913          	addi	s2,s7,8
 8b4:	4685                	li	a3,1
 8b6:	4629                	li	a2,10
 8b8:	000ba583          	lw	a1,0(s7)
 8bc:	8556                	mv	a0,s5
 8be:	00000097          	auipc	ra,0x0
 8c2:	ebc080e7          	jalr	-324(ra) # 77a <printint>
 8c6:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	b745                	j	86a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8cc:	008b8913          	addi	s2,s7,8
 8d0:	4681                	li	a3,0
 8d2:	4629                	li	a2,10
 8d4:	000ba583          	lw	a1,0(s7)
 8d8:	8556                	mv	a0,s5
 8da:	00000097          	auipc	ra,0x0
 8de:	ea0080e7          	jalr	-352(ra) # 77a <printint>
 8e2:	8bca                	mv	s7,s2
      state = 0;
 8e4:	4981                	li	s3,0
 8e6:	b751                	j	86a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8e8:	008b8913          	addi	s2,s7,8
 8ec:	4681                	li	a3,0
 8ee:	4641                	li	a2,16
 8f0:	000ba583          	lw	a1,0(s7)
 8f4:	8556                	mv	a0,s5
 8f6:	00000097          	auipc	ra,0x0
 8fa:	e84080e7          	jalr	-380(ra) # 77a <printint>
 8fe:	8bca                	mv	s7,s2
      state = 0;
 900:	4981                	li	s3,0
 902:	b7a5                	j	86a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 904:	008b8c13          	addi	s8,s7,8
 908:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 90c:	03000593          	li	a1,48
 910:	8556                	mv	a0,s5
 912:	00000097          	auipc	ra,0x0
 916:	e46080e7          	jalr	-442(ra) # 758 <putc>
  putc(fd, 'x');
 91a:	07800593          	li	a1,120
 91e:	8556                	mv	a0,s5
 920:	00000097          	auipc	ra,0x0
 924:	e38080e7          	jalr	-456(ra) # 758 <putc>
 928:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 92a:	00000b97          	auipc	s7,0x0
 92e:	356b8b93          	addi	s7,s7,854 # c80 <digits>
 932:	03c9d793          	srli	a5,s3,0x3c
 936:	97de                	add	a5,a5,s7
 938:	0007c583          	lbu	a1,0(a5)
 93c:	8556                	mv	a0,s5
 93e:	00000097          	auipc	ra,0x0
 942:	e1a080e7          	jalr	-486(ra) # 758 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 946:	0992                	slli	s3,s3,0x4
 948:	397d                	addiw	s2,s2,-1
 94a:	fe0914e3          	bnez	s2,932 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 94e:	8be2                	mv	s7,s8
      state = 0;
 950:	4981                	li	s3,0
 952:	bf21                	j	86a <vprintf+0x44>
        s = va_arg(ap, char*);
 954:	008b8993          	addi	s3,s7,8
 958:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 95c:	02090163          	beqz	s2,97e <vprintf+0x158>
        while(*s != 0){
 960:	00094583          	lbu	a1,0(s2)
 964:	c9a5                	beqz	a1,9d4 <vprintf+0x1ae>
          putc(fd, *s);
 966:	8556                	mv	a0,s5
 968:	00000097          	auipc	ra,0x0
 96c:	df0080e7          	jalr	-528(ra) # 758 <putc>
          s++;
 970:	0905                	addi	s2,s2,1
        while(*s != 0){
 972:	00094583          	lbu	a1,0(s2)
 976:	f9e5                	bnez	a1,966 <vprintf+0x140>
        s = va_arg(ap, char*);
 978:	8bce                	mv	s7,s3
      state = 0;
 97a:	4981                	li	s3,0
 97c:	b5fd                	j	86a <vprintf+0x44>
          s = "(null)";
 97e:	00000917          	auipc	s2,0x0
 982:	2a290913          	addi	s2,s2,674 # c20 <malloc+0x148>
        while(*s != 0){
 986:	02800593          	li	a1,40
 98a:	bff1                	j	966 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 98c:	008b8913          	addi	s2,s7,8
 990:	000bc583          	lbu	a1,0(s7)
 994:	8556                	mv	a0,s5
 996:	00000097          	auipc	ra,0x0
 99a:	dc2080e7          	jalr	-574(ra) # 758 <putc>
 99e:	8bca                	mv	s7,s2
      state = 0;
 9a0:	4981                	li	s3,0
 9a2:	b5e1                	j	86a <vprintf+0x44>
        putc(fd, c);
 9a4:	02500593          	li	a1,37
 9a8:	8556                	mv	a0,s5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	dae080e7          	jalr	-594(ra) # 758 <putc>
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	bd5d                	j	86a <vprintf+0x44>
        putc(fd, '%');
 9b6:	02500593          	li	a1,37
 9ba:	8556                	mv	a0,s5
 9bc:	00000097          	auipc	ra,0x0
 9c0:	d9c080e7          	jalr	-612(ra) # 758 <putc>
        putc(fd, c);
 9c4:	85ca                	mv	a1,s2
 9c6:	8556                	mv	a0,s5
 9c8:	00000097          	auipc	ra,0x0
 9cc:	d90080e7          	jalr	-624(ra) # 758 <putc>
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	bd61                	j	86a <vprintf+0x44>
        s = va_arg(ap, char*);
 9d4:	8bce                	mv	s7,s3
      state = 0;
 9d6:	4981                	li	s3,0
 9d8:	bd49                	j	86a <vprintf+0x44>
    }
  }
}
 9da:	60a6                	ld	ra,72(sp)
 9dc:	6406                	ld	s0,64(sp)
 9de:	74e2                	ld	s1,56(sp)
 9e0:	7942                	ld	s2,48(sp)
 9e2:	79a2                	ld	s3,40(sp)
 9e4:	7a02                	ld	s4,32(sp)
 9e6:	6ae2                	ld	s5,24(sp)
 9e8:	6b42                	ld	s6,16(sp)
 9ea:	6ba2                	ld	s7,8(sp)
 9ec:	6c02                	ld	s8,0(sp)
 9ee:	6161                	addi	sp,sp,80
 9f0:	8082                	ret

00000000000009f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f2:	715d                	addi	sp,sp,-80
 9f4:	ec06                	sd	ra,24(sp)
 9f6:	e822                	sd	s0,16(sp)
 9f8:	1000                	addi	s0,sp,32
 9fa:	e010                	sd	a2,0(s0)
 9fc:	e414                	sd	a3,8(s0)
 9fe:	e818                	sd	a4,16(s0)
 a00:	ec1c                	sd	a5,24(s0)
 a02:	03043023          	sd	a6,32(s0)
 a06:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a0a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a0e:	8622                	mv	a2,s0
 a10:	00000097          	auipc	ra,0x0
 a14:	e16080e7          	jalr	-490(ra) # 826 <vprintf>
}
 a18:	60e2                	ld	ra,24(sp)
 a1a:	6442                	ld	s0,16(sp)
 a1c:	6161                	addi	sp,sp,80
 a1e:	8082                	ret

0000000000000a20 <printf>:

void
printf(const char *fmt, ...)
{
 a20:	711d                	addi	sp,sp,-96
 a22:	ec06                	sd	ra,24(sp)
 a24:	e822                	sd	s0,16(sp)
 a26:	1000                	addi	s0,sp,32
 a28:	e40c                	sd	a1,8(s0)
 a2a:	e810                	sd	a2,16(s0)
 a2c:	ec14                	sd	a3,24(s0)
 a2e:	f018                	sd	a4,32(s0)
 a30:	f41c                	sd	a5,40(s0)
 a32:	03043823          	sd	a6,48(s0)
 a36:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a3a:	00840613          	addi	a2,s0,8
 a3e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a42:	85aa                	mv	a1,a0
 a44:	4505                	li	a0,1
 a46:	00000097          	auipc	ra,0x0
 a4a:	de0080e7          	jalr	-544(ra) # 826 <vprintf>
}
 a4e:	60e2                	ld	ra,24(sp)
 a50:	6442                	ld	s0,16(sp)
 a52:	6125                	addi	sp,sp,96
 a54:	8082                	ret

0000000000000a56 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a56:	1141                	addi	sp,sp,-16
 a58:	e422                	sd	s0,8(sp)
 a5a:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a5c:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a60:	00000797          	auipc	a5,0x0
 a64:	5b87b783          	ld	a5,1464(a5) # 1018 <freep>
 a68:	a02d                	j	a92 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a6a:	4618                	lw	a4,8(a2)
 a6c:	9f2d                	addw	a4,a4,a1
 a6e:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a72:	6398                	ld	a4,0(a5)
 a74:	6310                	ld	a2,0(a4)
 a76:	a83d                	j	ab4 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a78:	ff852703          	lw	a4,-8(a0)
 a7c:	9f31                	addw	a4,a4,a2
 a7e:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a80:	ff053683          	ld	a3,-16(a0)
 a84:	a091                	j	ac8 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a86:	6398                	ld	a4,0(a5)
 a88:	00e7e463          	bltu	a5,a4,a90 <free+0x3a>
 a8c:	00e6ea63          	bltu	a3,a4,aa0 <free+0x4a>
{
 a90:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a92:	fed7fae3          	bgeu	a5,a3,a86 <free+0x30>
 a96:	6398                	ld	a4,0(a5)
 a98:	00e6e463          	bltu	a3,a4,aa0 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a9c:	fee7eae3          	bltu	a5,a4,a90 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 aa0:	ff852583          	lw	a1,-8(a0)
 aa4:	6390                	ld	a2,0(a5)
 aa6:	02059813          	slli	a6,a1,0x20
 aaa:	01c85713          	srli	a4,a6,0x1c
 aae:	9736                	add	a4,a4,a3
 ab0:	fae60de3          	beq	a2,a4,a6a <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 ab4:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 ab8:	4790                	lw	a2,8(a5)
 aba:	02061593          	slli	a1,a2,0x20
 abe:	01c5d713          	srli	a4,a1,0x1c
 ac2:	973e                	add	a4,a4,a5
 ac4:	fae68ae3          	beq	a3,a4,a78 <free+0x22>
        p->s.ptr = bp->s.ptr;
 ac8:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 aca:	00000717          	auipc	a4,0x0
 ace:	54f73723          	sd	a5,1358(a4) # 1018 <freep>
}
 ad2:	6422                	ld	s0,8(sp)
 ad4:	0141                	addi	sp,sp,16
 ad6:	8082                	ret

0000000000000ad8 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 ad8:	7139                	addi	sp,sp,-64
 ada:	fc06                	sd	ra,56(sp)
 adc:	f822                	sd	s0,48(sp)
 ade:	f426                	sd	s1,40(sp)
 ae0:	f04a                	sd	s2,32(sp)
 ae2:	ec4e                	sd	s3,24(sp)
 ae4:	e852                	sd	s4,16(sp)
 ae6:	e456                	sd	s5,8(sp)
 ae8:	e05a                	sd	s6,0(sp)
 aea:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 aec:	02051493          	slli	s1,a0,0x20
 af0:	9081                	srli	s1,s1,0x20
 af2:	04bd                	addi	s1,s1,15
 af4:	8091                	srli	s1,s1,0x4
 af6:	0014899b          	addiw	s3,s1,1
 afa:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 afc:	00000517          	auipc	a0,0x0
 b00:	51c53503          	ld	a0,1308(a0) # 1018 <freep>
 b04:	c515                	beqz	a0,b30 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b06:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b08:	4798                	lw	a4,8(a5)
 b0a:	02977f63          	bgeu	a4,s1,b48 <malloc+0x70>
    if (nu < 4096)
 b0e:	8a4e                	mv	s4,s3
 b10:	0009871b          	sext.w	a4,s3
 b14:	6685                	lui	a3,0x1
 b16:	00d77363          	bgeu	a4,a3,b1c <malloc+0x44>
 b1a:	6a05                	lui	s4,0x1
 b1c:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b20:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b24:	00000917          	auipc	s2,0x0
 b28:	4f490913          	addi	s2,s2,1268 # 1018 <freep>
    if (p == (char *)-1)
 b2c:	5afd                	li	s5,-1
 b2e:	a895                	j	ba2 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b30:	00000797          	auipc	a5,0x0
 b34:	57078793          	addi	a5,a5,1392 # 10a0 <base>
 b38:	00000717          	auipc	a4,0x0
 b3c:	4ef73023          	sd	a5,1248(a4) # 1018 <freep>
 b40:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b42:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b46:	b7e1                	j	b0e <malloc+0x36>
            if (p->s.size == nunits)
 b48:	02e48c63          	beq	s1,a4,b80 <malloc+0xa8>
                p->s.size -= nunits;
 b4c:	4137073b          	subw	a4,a4,s3
 b50:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b52:	02071693          	slli	a3,a4,0x20
 b56:	01c6d713          	srli	a4,a3,0x1c
 b5a:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b5c:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b60:	00000717          	auipc	a4,0x0
 b64:	4aa73c23          	sd	a0,1208(a4) # 1018 <freep>
            return (void *)(p + 1);
 b68:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b6c:	70e2                	ld	ra,56(sp)
 b6e:	7442                	ld	s0,48(sp)
 b70:	74a2                	ld	s1,40(sp)
 b72:	7902                	ld	s2,32(sp)
 b74:	69e2                	ld	s3,24(sp)
 b76:	6a42                	ld	s4,16(sp)
 b78:	6aa2                	ld	s5,8(sp)
 b7a:	6b02                	ld	s6,0(sp)
 b7c:	6121                	addi	sp,sp,64
 b7e:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b80:	6398                	ld	a4,0(a5)
 b82:	e118                	sd	a4,0(a0)
 b84:	bff1                	j	b60 <malloc+0x88>
    hp->s.size = nu;
 b86:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b8a:	0541                	addi	a0,a0,16
 b8c:	00000097          	auipc	ra,0x0
 b90:	eca080e7          	jalr	-310(ra) # a56 <free>
    return freep;
 b94:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b98:	d971                	beqz	a0,b6c <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b9a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 b9c:	4798                	lw	a4,8(a5)
 b9e:	fa9775e3          	bgeu	a4,s1,b48 <malloc+0x70>
        if (p == freep)
 ba2:	00093703          	ld	a4,0(s2)
 ba6:	853e                	mv	a0,a5
 ba8:	fef719e3          	bne	a4,a5,b9a <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bac:	8552                	mv	a0,s4
 bae:	00000097          	auipc	ra,0x0
 bb2:	b7a080e7          	jalr	-1158(ra) # 728 <sbrk>
    if (p == (char *)-1)
 bb6:	fd5518e3          	bne	a0,s5,b86 <malloc+0xae>
                return 0;
 bba:	4501                	li	a0,0
 bbc:	bf45                	j	b6c <malloc+0x94>
