
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
  14:	bc058593          	addi	a1,a1,-1088 # bd0 <malloc+0xf2>
  18:	4509                	li	a0,2
  1a:	00001097          	auipc	ra,0x1
  1e:	9de080e7          	jalr	-1570(ra) # 9f8 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	682080e7          	jalr	1666(ra) # 6a6 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	6d4080e7          	jalr	1748(ra) # 706 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	666080e7          	jalr	1638(ra) # 6a6 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	b9c58593          	addi	a1,a1,-1124 # be8 <malloc+0x10a>
  54:	4509                	li	a0,2
  56:	00001097          	auipc	ra,0x1
  5a:	9a2080e7          	jalr	-1630(ra) # 9f8 <fprintf>
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
  94:	2c4080e7          	jalr	708(ra) # 354 <twhoami>
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
  e0:	b2450513          	addi	a0,a0,-1244 # c00 <malloc+0x122>
  e4:	00001097          	auipc	ra,0x1
  e8:	942080e7          	jalr	-1726(ra) # a26 <printf>
        exit(-1);
  ec:	557d                	li	a0,-1
  ee:	00000097          	auipc	ra,0x0
  f2:	5b8080e7          	jalr	1464(ra) # 6a6 <exit>
    {
        // give up the cpu for other threads
        tyield();
  f6:	00000097          	auipc	ra,0x0
  fa:	1dc080e7          	jalr	476(ra) # 2d2 <tyield>
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
 114:	244080e7          	jalr	580(ra) # 354 <twhoami>
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
 158:	17e080e7          	jalr	382(ra) # 2d2 <tyield>
}
 15c:	60e2                	ld	ra,24(sp)
 15e:	6442                	ld	s0,16(sp)
 160:	64a2                	ld	s1,8(sp)
 162:	6105                	addi	sp,sp,32
 164:	8082                	ret
        printf("releasing lock we are not holding");
 166:	00001517          	auipc	a0,0x1
 16a:	ac250513          	addi	a0,a0,-1342 # c28 <malloc+0x14a>
 16e:	00001097          	auipc	ra,0x1
 172:	8b8080e7          	jalr	-1864(ra) # a26 <printf>
        exit(-1);
 176:	557d                	li	a0,-1
 178:	00000097          	auipc	ra,0x0
 17c:	52e080e7          	jalr	1326(ra) # 6a6 <exit>

0000000000000180 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 180:	00001517          	auipc	a0,0x1
 184:	e9053503          	ld	a0,-368(a0) # 1010 <current_thread>
 188:	00001717          	auipc	a4,0x1
 18c:	e9870713          	addi	a4,a4,-360 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 190:	4781                	li	a5,0
 192:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 194:	6314                	ld	a3,0(a4)
 196:	00a68763          	beq	a3,a0,1a4 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 19a:	2785                	addiw	a5,a5,1
 19c:	0721                	addi	a4,a4,8
 19e:	fec79be3          	bne	a5,a2,194 <tsched+0x14>
    int current_index = 0;
 1a2:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 1a4:	0017869b          	addiw	a3,a5,1
 1a8:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1ac:	00001817          	auipc	a6,0x1
 1b0:	e7480813          	addi	a6,a6,-396 # 1020 <threads>
 1b4:	488d                	li	a7,3
 1b6:	a021                	j	1be <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 1b8:	2685                	addiw	a3,a3,1
 1ba:	04c68363          	beq	a3,a2,200 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 1be:	41f6d71b          	sraiw	a4,a3,0x1f
 1c2:	01c7571b          	srliw	a4,a4,0x1c
 1c6:	00d707bb          	addw	a5,a4,a3
 1ca:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1cc:	9f99                	subw	a5,a5,a4
 1ce:	078e                	slli	a5,a5,0x3
 1d0:	97c2                	add	a5,a5,a6
 1d2:	638c                	ld	a1,0(a5)
 1d4:	d1f5                	beqz	a1,1b8 <tsched+0x38>
 1d6:	5dbc                	lw	a5,120(a1)
 1d8:	ff1790e3          	bne	a5,a7,1b8 <tsched+0x38>
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e406                	sd	ra,8(sp)
 1e0:	e022                	sd	s0,0(sp)
 1e2:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 1e4:	00001797          	auipc	a5,0x1
 1e8:	e2b7b623          	sd	a1,-468(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1ec:	05a1                	addi	a1,a1,8
 1ee:	0521                	addi	a0,a0,8
 1f0:	00000097          	auipc	ra,0x0
 1f4:	17c080e7          	jalr	380(ra) # 36c <tswtch>
        //printf("Thread switch complete\n");
    }
}
 1f8:	60a2                	ld	ra,8(sp)
 1fa:	6402                	ld	s0,0(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret
 200:	8082                	ret

0000000000000202 <thread_wrapper>:
{
 202:	1101                	addi	sp,sp,-32
 204:	ec06                	sd	ra,24(sp)
 206:	e822                	sd	s0,16(sp)
 208:	e426                	sd	s1,8(sp)
 20a:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 20c:	00001497          	auipc	s1,0x1
 210:	e0448493          	addi	s1,s1,-508 # 1010 <current_thread>
 214:	609c                	ld	a5,0(s1)
 216:	67d8                	ld	a4,136(a5)
 218:	63c8                	ld	a0,128(a5)
 21a:	9702                	jalr	a4
    current_thread->state = EXITED;
 21c:	609c                	ld	a5,0(s1)
 21e:	4719                	li	a4,6
 220:	dfb8                	sw	a4,120(a5)
    tsched();
 222:	00000097          	auipc	ra,0x0
 226:	f5e080e7          	jalr	-162(ra) # 180 <tsched>
}
 22a:	60e2                	ld	ra,24(sp)
 22c:	6442                	ld	s0,16(sp)
 22e:	64a2                	ld	s1,8(sp)
 230:	6105                	addi	sp,sp,32
 232:	8082                	ret

0000000000000234 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 234:	7179                	addi	sp,sp,-48
 236:	f406                	sd	ra,40(sp)
 238:	f022                	sd	s0,32(sp)
 23a:	ec26                	sd	s1,24(sp)
 23c:	e84a                	sd	s2,16(sp)
 23e:	e44e                	sd	s3,8(sp)
 240:	1800                	addi	s0,sp,48
 242:	84aa                	mv	s1,a0
 244:	89b2                	mv	s3,a2
 246:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 248:	09800513          	li	a0,152
 24c:	00001097          	auipc	ra,0x1
 250:	892080e7          	jalr	-1902(ra) # ade <malloc>
 254:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 256:	478d                	li	a5,3
 258:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 25a:	609c                	ld	a5,0(s1)
 25c:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 260:	609c                	ld	a5,0(s1)
 262:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 266:	6098                	ld	a4,0(s1)
 268:	00001797          	auipc	a5,0x1
 26c:	d9878793          	addi	a5,a5,-616 # 1000 <next_tid>
 270:	4394                	lw	a3,0(a5)
 272:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 276:	4398                	lw	a4,0(a5)
 278:	2705                	addiw	a4,a4,1
 27a:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 27c:	6505                	lui	a0,0x1
 27e:	00001097          	auipc	ra,0x1
 282:	860080e7          	jalr	-1952(ra) # ade <malloc>
 286:	609c                	ld	a5,0(s1)
 288:	6705                	lui	a4,0x1
 28a:	953a                	add	a0,a0,a4
 28c:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 28e:	609c                	ld	a5,0(s1)
 290:	00000717          	auipc	a4,0x0
 294:	f7270713          	addi	a4,a4,-142 # 202 <thread_wrapper>
 298:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 29a:	00001717          	auipc	a4,0x1
 29e:	d8670713          	addi	a4,a4,-634 # 1020 <threads>
 2a2:	4781                	li	a5,0
 2a4:	4641                	li	a2,16
        if (threads[i] == NULL) {
 2a6:	6314                	ld	a3,0(a4)
 2a8:	ce81                	beqz	a3,2c0 <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 2aa:	2785                	addiw	a5,a5,1
 2ac:	0721                	addi	a4,a4,8
 2ae:	fec79ce3          	bne	a5,a2,2a6 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 2b2:	70a2                	ld	ra,40(sp)
 2b4:	7402                	ld	s0,32(sp)
 2b6:	64e2                	ld	s1,24(sp)
 2b8:	6942                	ld	s2,16(sp)
 2ba:	69a2                	ld	s3,8(sp)
 2bc:	6145                	addi	sp,sp,48
 2be:	8082                	ret
            threads[i] = *thread;
 2c0:	6094                	ld	a3,0(s1)
 2c2:	078e                	slli	a5,a5,0x3
 2c4:	00001717          	auipc	a4,0x1
 2c8:	d5c70713          	addi	a4,a4,-676 # 1020 <threads>
 2cc:	97ba                	add	a5,a5,a4
 2ce:	e394                	sd	a3,0(a5)
            break;
 2d0:	b7cd                	j	2b2 <tcreate+0x7e>

00000000000002d2 <tyield>:
    return 0;
}


void tyield()
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 2da:	00001797          	auipc	a5,0x1
 2de:	d367b783          	ld	a5,-714(a5) # 1010 <current_thread>
 2e2:	470d                	li	a4,3
 2e4:	dfb8                	sw	a4,120(a5)
    tsched();
 2e6:	00000097          	auipc	ra,0x0
 2ea:	e9a080e7          	jalr	-358(ra) # 180 <tsched>
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <tjoin>:
{
 2f6:	1101                	addi	sp,sp,-32
 2f8:	ec06                	sd	ra,24(sp)
 2fa:	e822                	sd	s0,16(sp)
 2fc:	e426                	sd	s1,8(sp)
 2fe:	e04a                	sd	s2,0(sp)
 300:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 302:	00001797          	auipc	a5,0x1
 306:	d1e78793          	addi	a5,a5,-738 # 1020 <threads>
 30a:	00001697          	auipc	a3,0x1
 30e:	d9668693          	addi	a3,a3,-618 # 10a0 <base>
 312:	a021                	j	31a <tjoin+0x24>
 314:	07a1                	addi	a5,a5,8
 316:	02d78b63          	beq	a5,a3,34c <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 31a:	6384                	ld	s1,0(a5)
 31c:	dce5                	beqz	s1,314 <tjoin+0x1e>
 31e:	0004c703          	lbu	a4,0(s1)
 322:	fea719e3          	bne	a4,a0,314 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 326:	5cb8                	lw	a4,120(s1)
 328:	4799                	li	a5,6
 32a:	4919                	li	s2,6
 32c:	02f70263          	beq	a4,a5,350 <tjoin+0x5a>
        tyield();
 330:	00000097          	auipc	ra,0x0
 334:	fa2080e7          	jalr	-94(ra) # 2d2 <tyield>
    while (target_thread->state != EXITED) {
 338:	5cbc                	lw	a5,120(s1)
 33a:	ff279be3          	bne	a5,s2,330 <tjoin+0x3a>
    return 0;
 33e:	4501                	li	a0,0
}
 340:	60e2                	ld	ra,24(sp)
 342:	6442                	ld	s0,16(sp)
 344:	64a2                	ld	s1,8(sp)
 346:	6902                	ld	s2,0(sp)
 348:	6105                	addi	sp,sp,32
 34a:	8082                	ret
        return -1;
 34c:	557d                	li	a0,-1
 34e:	bfcd                	j	340 <tjoin+0x4a>
    return 0;
 350:	4501                	li	a0,0
 352:	b7fd                	j	340 <tjoin+0x4a>

0000000000000354 <twhoami>:

uint8 twhoami()
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 35a:	00001797          	auipc	a5,0x1
 35e:	cb67b783          	ld	a5,-842(a5) # 1010 <current_thread>
 362:	0007c503          	lbu	a0,0(a5)
 366:	6422                	ld	s0,8(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <tswtch>:
 36c:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 370:	00253423          	sd	sp,8(a0)
 374:	e900                	sd	s0,16(a0)
 376:	ed04                	sd	s1,24(a0)
 378:	03253023          	sd	s2,32(a0)
 37c:	03353423          	sd	s3,40(a0)
 380:	03453823          	sd	s4,48(a0)
 384:	03553c23          	sd	s5,56(a0)
 388:	05653023          	sd	s6,64(a0)
 38c:	05753423          	sd	s7,72(a0)
 390:	05853823          	sd	s8,80(a0)
 394:	05953c23          	sd	s9,88(a0)
 398:	07a53023          	sd	s10,96(a0)
 39c:	07b53423          	sd	s11,104(a0)
 3a0:	0005b083          	ld	ra,0(a1)
 3a4:	0085b103          	ld	sp,8(a1)
 3a8:	6980                	ld	s0,16(a1)
 3aa:	6d84                	ld	s1,24(a1)
 3ac:	0205b903          	ld	s2,32(a1)
 3b0:	0285b983          	ld	s3,40(a1)
 3b4:	0305ba03          	ld	s4,48(a1)
 3b8:	0385ba83          	ld	s5,56(a1)
 3bc:	0405bb03          	ld	s6,64(a1)
 3c0:	0485bb83          	ld	s7,72(a1)
 3c4:	0505bc03          	ld	s8,80(a1)
 3c8:	0585bc83          	ld	s9,88(a1)
 3cc:	0605bd03          	ld	s10,96(a1)
 3d0:	0685bd83          	ld	s11,104(a1)
 3d4:	8082                	ret

00000000000003d6 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3d6:	1101                	addi	sp,sp,-32
 3d8:	ec06                	sd	ra,24(sp)
 3da:	e822                	sd	s0,16(sp)
 3dc:	e426                	sd	s1,8(sp)
 3de:	e04a                	sd	s2,0(sp)
 3e0:	1000                	addi	s0,sp,32
 3e2:	84aa                	mv	s1,a0
 3e4:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3e6:	09800513          	li	a0,152
 3ea:	00000097          	auipc	ra,0x0
 3ee:	6f4080e7          	jalr	1780(ra) # ade <malloc>

    main_thread->tid = 1;
 3f2:	4785                	li	a5,1
 3f4:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 3f8:	4791                	li	a5,4
 3fa:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3fc:	00001797          	auipc	a5,0x1
 400:	c0a7ba23          	sd	a0,-1004(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 404:	00001797          	auipc	a5,0x1
 408:	c1c78793          	addi	a5,a5,-996 # 1020 <threads>
 40c:	00001717          	auipc	a4,0x1
 410:	c9470713          	addi	a4,a4,-876 # 10a0 <base>
        threads[i] = NULL;
 414:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 418:	07a1                	addi	a5,a5,8
 41a:	fee79de3          	bne	a5,a4,414 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 41e:	00001797          	auipc	a5,0x1
 422:	c0a7b123          	sd	a0,-1022(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 426:	85ca                	mv	a1,s2
 428:	8526                	mv	a0,s1
 42a:	00000097          	auipc	ra,0x0
 42e:	bd6080e7          	jalr	-1066(ra) # 0 <main>
    //tsched();

    exit(res);
 432:	00000097          	auipc	ra,0x0
 436:	274080e7          	jalr	628(ra) # 6a6 <exit>

000000000000043a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 43a:	1141                	addi	sp,sp,-16
 43c:	e422                	sd	s0,8(sp)
 43e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 440:	87aa                	mv	a5,a0
 442:	0585                	addi	a1,a1,1
 444:	0785                	addi	a5,a5,1
 446:	fff5c703          	lbu	a4,-1(a1)
 44a:	fee78fa3          	sb	a4,-1(a5)
 44e:	fb75                	bnez	a4,442 <strcpy+0x8>
        ;
    return os;
}
 450:	6422                	ld	s0,8(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret

0000000000000456 <strcmp>:

int strcmp(const char *p, const char *q)
{
 456:	1141                	addi	sp,sp,-16
 458:	e422                	sd	s0,8(sp)
 45a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 45c:	00054783          	lbu	a5,0(a0)
 460:	cb91                	beqz	a5,474 <strcmp+0x1e>
 462:	0005c703          	lbu	a4,0(a1)
 466:	00f71763          	bne	a4,a5,474 <strcmp+0x1e>
        p++, q++;
 46a:	0505                	addi	a0,a0,1
 46c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 46e:	00054783          	lbu	a5,0(a0)
 472:	fbe5                	bnez	a5,462 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 474:	0005c503          	lbu	a0,0(a1)
}
 478:	40a7853b          	subw	a0,a5,a0
 47c:	6422                	ld	s0,8(sp)
 47e:	0141                	addi	sp,sp,16
 480:	8082                	ret

0000000000000482 <strlen>:

uint strlen(const char *s)
{
 482:	1141                	addi	sp,sp,-16
 484:	e422                	sd	s0,8(sp)
 486:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 488:	00054783          	lbu	a5,0(a0)
 48c:	cf91                	beqz	a5,4a8 <strlen+0x26>
 48e:	0505                	addi	a0,a0,1
 490:	87aa                	mv	a5,a0
 492:	86be                	mv	a3,a5
 494:	0785                	addi	a5,a5,1
 496:	fff7c703          	lbu	a4,-1(a5)
 49a:	ff65                	bnez	a4,492 <strlen+0x10>
 49c:	40a6853b          	subw	a0,a3,a0
 4a0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4a2:	6422                	ld	s0,8(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret
    for (n = 0; s[n]; n++)
 4a8:	4501                	li	a0,0
 4aa:	bfe5                	j	4a2 <strlen+0x20>

00000000000004ac <memset>:

void *
memset(void *dst, int c, uint n)
{
 4ac:	1141                	addi	sp,sp,-16
 4ae:	e422                	sd	s0,8(sp)
 4b0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4b2:	ca19                	beqz	a2,4c8 <memset+0x1c>
 4b4:	87aa                	mv	a5,a0
 4b6:	1602                	slli	a2,a2,0x20
 4b8:	9201                	srli	a2,a2,0x20
 4ba:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4be:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4c2:	0785                	addi	a5,a5,1
 4c4:	fee79de3          	bne	a5,a4,4be <memset+0x12>
    }
    return dst;
}
 4c8:	6422                	ld	s0,8(sp)
 4ca:	0141                	addi	sp,sp,16
 4cc:	8082                	ret

00000000000004ce <strchr>:

char *
strchr(const char *s, char c)
{
 4ce:	1141                	addi	sp,sp,-16
 4d0:	e422                	sd	s0,8(sp)
 4d2:	0800                	addi	s0,sp,16
    for (; *s; s++)
 4d4:	00054783          	lbu	a5,0(a0)
 4d8:	cb99                	beqz	a5,4ee <strchr+0x20>
        if (*s == c)
 4da:	00f58763          	beq	a1,a5,4e8 <strchr+0x1a>
    for (; *s; s++)
 4de:	0505                	addi	a0,a0,1
 4e0:	00054783          	lbu	a5,0(a0)
 4e4:	fbfd                	bnez	a5,4da <strchr+0xc>
            return (char *)s;
    return 0;
 4e6:	4501                	li	a0,0
}
 4e8:	6422                	ld	s0,8(sp)
 4ea:	0141                	addi	sp,sp,16
 4ec:	8082                	ret
    return 0;
 4ee:	4501                	li	a0,0
 4f0:	bfe5                	j	4e8 <strchr+0x1a>

00000000000004f2 <gets>:

char *
gets(char *buf, int max)
{
 4f2:	711d                	addi	sp,sp,-96
 4f4:	ec86                	sd	ra,88(sp)
 4f6:	e8a2                	sd	s0,80(sp)
 4f8:	e4a6                	sd	s1,72(sp)
 4fa:	e0ca                	sd	s2,64(sp)
 4fc:	fc4e                	sd	s3,56(sp)
 4fe:	f852                	sd	s4,48(sp)
 500:	f456                	sd	s5,40(sp)
 502:	f05a                	sd	s6,32(sp)
 504:	ec5e                	sd	s7,24(sp)
 506:	1080                	addi	s0,sp,96
 508:	8baa                	mv	s7,a0
 50a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 50c:	892a                	mv	s2,a0
 50e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 510:	4aa9                	li	s5,10
 512:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 514:	89a6                	mv	s3,s1
 516:	2485                	addiw	s1,s1,1
 518:	0344d863          	bge	s1,s4,548 <gets+0x56>
        cc = read(0, &c, 1);
 51c:	4605                	li	a2,1
 51e:	faf40593          	addi	a1,s0,-81
 522:	4501                	li	a0,0
 524:	00000097          	auipc	ra,0x0
 528:	19a080e7          	jalr	410(ra) # 6be <read>
        if (cc < 1)
 52c:	00a05e63          	blez	a0,548 <gets+0x56>
        buf[i++] = c;
 530:	faf44783          	lbu	a5,-81(s0)
 534:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 538:	01578763          	beq	a5,s5,546 <gets+0x54>
 53c:	0905                	addi	s2,s2,1
 53e:	fd679be3          	bne	a5,s6,514 <gets+0x22>
    for (i = 0; i + 1 < max;)
 542:	89a6                	mv	s3,s1
 544:	a011                	j	548 <gets+0x56>
 546:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 548:	99de                	add	s3,s3,s7
 54a:	00098023          	sb	zero,0(s3)
    return buf;
}
 54e:	855e                	mv	a0,s7
 550:	60e6                	ld	ra,88(sp)
 552:	6446                	ld	s0,80(sp)
 554:	64a6                	ld	s1,72(sp)
 556:	6906                	ld	s2,64(sp)
 558:	79e2                	ld	s3,56(sp)
 55a:	7a42                	ld	s4,48(sp)
 55c:	7aa2                	ld	s5,40(sp)
 55e:	7b02                	ld	s6,32(sp)
 560:	6be2                	ld	s7,24(sp)
 562:	6125                	addi	sp,sp,96
 564:	8082                	ret

0000000000000566 <stat>:

int stat(const char *n, struct stat *st)
{
 566:	1101                	addi	sp,sp,-32
 568:	ec06                	sd	ra,24(sp)
 56a:	e822                	sd	s0,16(sp)
 56c:	e426                	sd	s1,8(sp)
 56e:	e04a                	sd	s2,0(sp)
 570:	1000                	addi	s0,sp,32
 572:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 574:	4581                	li	a1,0
 576:	00000097          	auipc	ra,0x0
 57a:	170080e7          	jalr	368(ra) # 6e6 <open>
    if (fd < 0)
 57e:	02054563          	bltz	a0,5a8 <stat+0x42>
 582:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 584:	85ca                	mv	a1,s2
 586:	00000097          	auipc	ra,0x0
 58a:	178080e7          	jalr	376(ra) # 6fe <fstat>
 58e:	892a                	mv	s2,a0
    close(fd);
 590:	8526                	mv	a0,s1
 592:	00000097          	auipc	ra,0x0
 596:	13c080e7          	jalr	316(ra) # 6ce <close>
    return r;
}
 59a:	854a                	mv	a0,s2
 59c:	60e2                	ld	ra,24(sp)
 59e:	6442                	ld	s0,16(sp)
 5a0:	64a2                	ld	s1,8(sp)
 5a2:	6902                	ld	s2,0(sp)
 5a4:	6105                	addi	sp,sp,32
 5a6:	8082                	ret
        return -1;
 5a8:	597d                	li	s2,-1
 5aa:	bfc5                	j	59a <stat+0x34>

00000000000005ac <atoi>:

int atoi(const char *s)
{
 5ac:	1141                	addi	sp,sp,-16
 5ae:	e422                	sd	s0,8(sp)
 5b0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5b2:	00054683          	lbu	a3,0(a0)
 5b6:	fd06879b          	addiw	a5,a3,-48
 5ba:	0ff7f793          	zext.b	a5,a5
 5be:	4625                	li	a2,9
 5c0:	02f66863          	bltu	a2,a5,5f0 <atoi+0x44>
 5c4:	872a                	mv	a4,a0
    n = 0;
 5c6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5c8:	0705                	addi	a4,a4,1
 5ca:	0025179b          	slliw	a5,a0,0x2
 5ce:	9fa9                	addw	a5,a5,a0
 5d0:	0017979b          	slliw	a5,a5,0x1
 5d4:	9fb5                	addw	a5,a5,a3
 5d6:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 5da:	00074683          	lbu	a3,0(a4)
 5de:	fd06879b          	addiw	a5,a3,-48
 5e2:	0ff7f793          	zext.b	a5,a5
 5e6:	fef671e3          	bgeu	a2,a5,5c8 <atoi+0x1c>
    return n;
}
 5ea:	6422                	ld	s0,8(sp)
 5ec:	0141                	addi	sp,sp,16
 5ee:	8082                	ret
    n = 0;
 5f0:	4501                	li	a0,0
 5f2:	bfe5                	j	5ea <atoi+0x3e>

00000000000005f4 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 5f4:	1141                	addi	sp,sp,-16
 5f6:	e422                	sd	s0,8(sp)
 5f8:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 5fa:	02b57463          	bgeu	a0,a1,622 <memmove+0x2e>
    {
        while (n-- > 0)
 5fe:	00c05f63          	blez	a2,61c <memmove+0x28>
 602:	1602                	slli	a2,a2,0x20
 604:	9201                	srli	a2,a2,0x20
 606:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 60a:	872a                	mv	a4,a0
            *dst++ = *src++;
 60c:	0585                	addi	a1,a1,1
 60e:	0705                	addi	a4,a4,1
 610:	fff5c683          	lbu	a3,-1(a1)
 614:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 618:	fee79ae3          	bne	a5,a4,60c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 61c:	6422                	ld	s0,8(sp)
 61e:	0141                	addi	sp,sp,16
 620:	8082                	ret
        dst += n;
 622:	00c50733          	add	a4,a0,a2
        src += n;
 626:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 628:	fec05ae3          	blez	a2,61c <memmove+0x28>
 62c:	fff6079b          	addiw	a5,a2,-1
 630:	1782                	slli	a5,a5,0x20
 632:	9381                	srli	a5,a5,0x20
 634:	fff7c793          	not	a5,a5
 638:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 63a:	15fd                	addi	a1,a1,-1
 63c:	177d                	addi	a4,a4,-1
 63e:	0005c683          	lbu	a3,0(a1)
 642:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 646:	fee79ae3          	bne	a5,a4,63a <memmove+0x46>
 64a:	bfc9                	j	61c <memmove+0x28>

000000000000064c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 64c:	1141                	addi	sp,sp,-16
 64e:	e422                	sd	s0,8(sp)
 650:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 652:	ca05                	beqz	a2,682 <memcmp+0x36>
 654:	fff6069b          	addiw	a3,a2,-1
 658:	1682                	slli	a3,a3,0x20
 65a:	9281                	srli	a3,a3,0x20
 65c:	0685                	addi	a3,a3,1
 65e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 660:	00054783          	lbu	a5,0(a0)
 664:	0005c703          	lbu	a4,0(a1)
 668:	00e79863          	bne	a5,a4,678 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 66c:	0505                	addi	a0,a0,1
        p2++;
 66e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 670:	fed518e3          	bne	a0,a3,660 <memcmp+0x14>
    }
    return 0;
 674:	4501                	li	a0,0
 676:	a019                	j	67c <memcmp+0x30>
            return *p1 - *p2;
 678:	40e7853b          	subw	a0,a5,a4
}
 67c:	6422                	ld	s0,8(sp)
 67e:	0141                	addi	sp,sp,16
 680:	8082                	ret
    return 0;
 682:	4501                	li	a0,0
 684:	bfe5                	j	67c <memcmp+0x30>

0000000000000686 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 686:	1141                	addi	sp,sp,-16
 688:	e406                	sd	ra,8(sp)
 68a:	e022                	sd	s0,0(sp)
 68c:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 68e:	00000097          	auipc	ra,0x0
 692:	f66080e7          	jalr	-154(ra) # 5f4 <memmove>
}
 696:	60a2                	ld	ra,8(sp)
 698:	6402                	ld	s0,0(sp)
 69a:	0141                	addi	sp,sp,16
 69c:	8082                	ret

000000000000069e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 69e:	4885                	li	a7,1
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6a6:	4889                	li	a7,2
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <wait>:
.global wait
wait:
 li a7, SYS_wait
 6ae:	488d                	li	a7,3
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6b6:	4891                	li	a7,4
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <read>:
.global read
read:
 li a7, SYS_read
 6be:	4895                	li	a7,5
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <write>:
.global write
write:
 li a7, SYS_write
 6c6:	48c1                	li	a7,16
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <close>:
.global close
close:
 li a7, SYS_close
 6ce:	48d5                	li	a7,21
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6d6:	4899                	li	a7,6
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <exec>:
.global exec
exec:
 li a7, SYS_exec
 6de:	489d                	li	a7,7
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <open>:
.global open
open:
 li a7, SYS_open
 6e6:	48bd                	li	a7,15
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6ee:	48c5                	li	a7,17
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6f6:	48c9                	li	a7,18
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6fe:	48a1                	li	a7,8
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <link>:
.global link
link:
 li a7, SYS_link
 706:	48cd                	li	a7,19
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 70e:	48d1                	li	a7,20
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 716:	48a5                	li	a7,9
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <dup>:
.global dup
dup:
 li a7, SYS_dup
 71e:	48a9                	li	a7,10
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 726:	48ad                	li	a7,11
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 72e:	48b1                	li	a7,12
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 736:	48b5                	li	a7,13
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 73e:	48b9                	li	a7,14
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <ps>:
.global ps
ps:
 li a7, SYS_ps
 746:	48d9                	li	a7,22
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 74e:	48dd                	li	a7,23
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 756:	48e1                	li	a7,24
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 75e:	1101                	addi	sp,sp,-32
 760:	ec06                	sd	ra,24(sp)
 762:	e822                	sd	s0,16(sp)
 764:	1000                	addi	s0,sp,32
 766:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 76a:	4605                	li	a2,1
 76c:	fef40593          	addi	a1,s0,-17
 770:	00000097          	auipc	ra,0x0
 774:	f56080e7          	jalr	-170(ra) # 6c6 <write>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6105                	addi	sp,sp,32
 77e:	8082                	ret

0000000000000780 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 780:	7139                	addi	sp,sp,-64
 782:	fc06                	sd	ra,56(sp)
 784:	f822                	sd	s0,48(sp)
 786:	f426                	sd	s1,40(sp)
 788:	f04a                	sd	s2,32(sp)
 78a:	ec4e                	sd	s3,24(sp)
 78c:	0080                	addi	s0,sp,64
 78e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 790:	c299                	beqz	a3,796 <printint+0x16>
 792:	0805c963          	bltz	a1,824 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 796:	2581                	sext.w	a1,a1
  neg = 0;
 798:	4881                	li	a7,0
 79a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 79e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7a0:	2601                	sext.w	a2,a2
 7a2:	00000517          	auipc	a0,0x0
 7a6:	50e50513          	addi	a0,a0,1294 # cb0 <digits>
 7aa:	883a                	mv	a6,a4
 7ac:	2705                	addiw	a4,a4,1
 7ae:	02c5f7bb          	remuw	a5,a1,a2
 7b2:	1782                	slli	a5,a5,0x20
 7b4:	9381                	srli	a5,a5,0x20
 7b6:	97aa                	add	a5,a5,a0
 7b8:	0007c783          	lbu	a5,0(a5)
 7bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7c0:	0005879b          	sext.w	a5,a1
 7c4:	02c5d5bb          	divuw	a1,a1,a2
 7c8:	0685                	addi	a3,a3,1
 7ca:	fec7f0e3          	bgeu	a5,a2,7aa <printint+0x2a>
  if(neg)
 7ce:	00088c63          	beqz	a7,7e6 <printint+0x66>
    buf[i++] = '-';
 7d2:	fd070793          	addi	a5,a4,-48
 7d6:	00878733          	add	a4,a5,s0
 7da:	02d00793          	li	a5,45
 7de:	fef70823          	sb	a5,-16(a4)
 7e2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7e6:	02e05863          	blez	a4,816 <printint+0x96>
 7ea:	fc040793          	addi	a5,s0,-64
 7ee:	00e78933          	add	s2,a5,a4
 7f2:	fff78993          	addi	s3,a5,-1
 7f6:	99ba                	add	s3,s3,a4
 7f8:	377d                	addiw	a4,a4,-1
 7fa:	1702                	slli	a4,a4,0x20
 7fc:	9301                	srli	a4,a4,0x20
 7fe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 802:	fff94583          	lbu	a1,-1(s2)
 806:	8526                	mv	a0,s1
 808:	00000097          	auipc	ra,0x0
 80c:	f56080e7          	jalr	-170(ra) # 75e <putc>
  while(--i >= 0)
 810:	197d                	addi	s2,s2,-1
 812:	ff3918e3          	bne	s2,s3,802 <printint+0x82>
}
 816:	70e2                	ld	ra,56(sp)
 818:	7442                	ld	s0,48(sp)
 81a:	74a2                	ld	s1,40(sp)
 81c:	7902                	ld	s2,32(sp)
 81e:	69e2                	ld	s3,24(sp)
 820:	6121                	addi	sp,sp,64
 822:	8082                	ret
    x = -xx;
 824:	40b005bb          	negw	a1,a1
    neg = 1;
 828:	4885                	li	a7,1
    x = -xx;
 82a:	bf85                	j	79a <printint+0x1a>

000000000000082c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82c:	715d                	addi	sp,sp,-80
 82e:	e486                	sd	ra,72(sp)
 830:	e0a2                	sd	s0,64(sp)
 832:	fc26                	sd	s1,56(sp)
 834:	f84a                	sd	s2,48(sp)
 836:	f44e                	sd	s3,40(sp)
 838:	f052                	sd	s4,32(sp)
 83a:	ec56                	sd	s5,24(sp)
 83c:	e85a                	sd	s6,16(sp)
 83e:	e45e                	sd	s7,8(sp)
 840:	e062                	sd	s8,0(sp)
 842:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 844:	0005c903          	lbu	s2,0(a1)
 848:	18090c63          	beqz	s2,9e0 <vprintf+0x1b4>
 84c:	8aaa                	mv	s5,a0
 84e:	8bb2                	mv	s7,a2
 850:	00158493          	addi	s1,a1,1
  state = 0;
 854:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 856:	02500a13          	li	s4,37
 85a:	4b55                	li	s6,21
 85c:	a839                	j	87a <vprintf+0x4e>
        putc(fd, c);
 85e:	85ca                	mv	a1,s2
 860:	8556                	mv	a0,s5
 862:	00000097          	auipc	ra,0x0
 866:	efc080e7          	jalr	-260(ra) # 75e <putc>
 86a:	a019                	j	870 <vprintf+0x44>
    } else if(state == '%'){
 86c:	01498d63          	beq	s3,s4,886 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 870:	0485                	addi	s1,s1,1
 872:	fff4c903          	lbu	s2,-1(s1)
 876:	16090563          	beqz	s2,9e0 <vprintf+0x1b4>
    if(state == 0){
 87a:	fe0999e3          	bnez	s3,86c <vprintf+0x40>
      if(c == '%'){
 87e:	ff4910e3          	bne	s2,s4,85e <vprintf+0x32>
        state = '%';
 882:	89d2                	mv	s3,s4
 884:	b7f5                	j	870 <vprintf+0x44>
      if(c == 'd'){
 886:	13490263          	beq	s2,s4,9aa <vprintf+0x17e>
 88a:	f9d9079b          	addiw	a5,s2,-99
 88e:	0ff7f793          	zext.b	a5,a5
 892:	12fb6563          	bltu	s6,a5,9bc <vprintf+0x190>
 896:	f9d9079b          	addiw	a5,s2,-99
 89a:	0ff7f713          	zext.b	a4,a5
 89e:	10eb6f63          	bltu	s6,a4,9bc <vprintf+0x190>
 8a2:	00271793          	slli	a5,a4,0x2
 8a6:	00000717          	auipc	a4,0x0
 8aa:	3b270713          	addi	a4,a4,946 # c58 <malloc+0x17a>
 8ae:	97ba                	add	a5,a5,a4
 8b0:	439c                	lw	a5,0(a5)
 8b2:	97ba                	add	a5,a5,a4
 8b4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8b6:	008b8913          	addi	s2,s7,8
 8ba:	4685                	li	a3,1
 8bc:	4629                	li	a2,10
 8be:	000ba583          	lw	a1,0(s7)
 8c2:	8556                	mv	a0,s5
 8c4:	00000097          	auipc	ra,0x0
 8c8:	ebc080e7          	jalr	-324(ra) # 780 <printint>
 8cc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	b745                	j	870 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d2:	008b8913          	addi	s2,s7,8
 8d6:	4681                	li	a3,0
 8d8:	4629                	li	a2,10
 8da:	000ba583          	lw	a1,0(s7)
 8de:	8556                	mv	a0,s5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	ea0080e7          	jalr	-352(ra) # 780 <printint>
 8e8:	8bca                	mv	s7,s2
      state = 0;
 8ea:	4981                	li	s3,0
 8ec:	b751                	j	870 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 8ee:	008b8913          	addi	s2,s7,8
 8f2:	4681                	li	a3,0
 8f4:	4641                	li	a2,16
 8f6:	000ba583          	lw	a1,0(s7)
 8fa:	8556                	mv	a0,s5
 8fc:	00000097          	auipc	ra,0x0
 900:	e84080e7          	jalr	-380(ra) # 780 <printint>
 904:	8bca                	mv	s7,s2
      state = 0;
 906:	4981                	li	s3,0
 908:	b7a5                	j	870 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 90a:	008b8c13          	addi	s8,s7,8
 90e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 912:	03000593          	li	a1,48
 916:	8556                	mv	a0,s5
 918:	00000097          	auipc	ra,0x0
 91c:	e46080e7          	jalr	-442(ra) # 75e <putc>
  putc(fd, 'x');
 920:	07800593          	li	a1,120
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	e38080e7          	jalr	-456(ra) # 75e <putc>
 92e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 930:	00000b97          	auipc	s7,0x0
 934:	380b8b93          	addi	s7,s7,896 # cb0 <digits>
 938:	03c9d793          	srli	a5,s3,0x3c
 93c:	97de                	add	a5,a5,s7
 93e:	0007c583          	lbu	a1,0(a5)
 942:	8556                	mv	a0,s5
 944:	00000097          	auipc	ra,0x0
 948:	e1a080e7          	jalr	-486(ra) # 75e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 94c:	0992                	slli	s3,s3,0x4
 94e:	397d                	addiw	s2,s2,-1
 950:	fe0914e3          	bnez	s2,938 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 954:	8be2                	mv	s7,s8
      state = 0;
 956:	4981                	li	s3,0
 958:	bf21                	j	870 <vprintf+0x44>
        s = va_arg(ap, char*);
 95a:	008b8993          	addi	s3,s7,8
 95e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 962:	02090163          	beqz	s2,984 <vprintf+0x158>
        while(*s != 0){
 966:	00094583          	lbu	a1,0(s2)
 96a:	c9a5                	beqz	a1,9da <vprintf+0x1ae>
          putc(fd, *s);
 96c:	8556                	mv	a0,s5
 96e:	00000097          	auipc	ra,0x0
 972:	df0080e7          	jalr	-528(ra) # 75e <putc>
          s++;
 976:	0905                	addi	s2,s2,1
        while(*s != 0){
 978:	00094583          	lbu	a1,0(s2)
 97c:	f9e5                	bnez	a1,96c <vprintf+0x140>
        s = va_arg(ap, char*);
 97e:	8bce                	mv	s7,s3
      state = 0;
 980:	4981                	li	s3,0
 982:	b5fd                	j	870 <vprintf+0x44>
          s = "(null)";
 984:	00000917          	auipc	s2,0x0
 988:	2cc90913          	addi	s2,s2,716 # c50 <malloc+0x172>
        while(*s != 0){
 98c:	02800593          	li	a1,40
 990:	bff1                	j	96c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 992:	008b8913          	addi	s2,s7,8
 996:	000bc583          	lbu	a1,0(s7)
 99a:	8556                	mv	a0,s5
 99c:	00000097          	auipc	ra,0x0
 9a0:	dc2080e7          	jalr	-574(ra) # 75e <putc>
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	b5e1                	j	870 <vprintf+0x44>
        putc(fd, c);
 9aa:	02500593          	li	a1,37
 9ae:	8556                	mv	a0,s5
 9b0:	00000097          	auipc	ra,0x0
 9b4:	dae080e7          	jalr	-594(ra) # 75e <putc>
      state = 0;
 9b8:	4981                	li	s3,0
 9ba:	bd5d                	j	870 <vprintf+0x44>
        putc(fd, '%');
 9bc:	02500593          	li	a1,37
 9c0:	8556                	mv	a0,s5
 9c2:	00000097          	auipc	ra,0x0
 9c6:	d9c080e7          	jalr	-612(ra) # 75e <putc>
        putc(fd, c);
 9ca:	85ca                	mv	a1,s2
 9cc:	8556                	mv	a0,s5
 9ce:	00000097          	auipc	ra,0x0
 9d2:	d90080e7          	jalr	-624(ra) # 75e <putc>
      state = 0;
 9d6:	4981                	li	s3,0
 9d8:	bd61                	j	870 <vprintf+0x44>
        s = va_arg(ap, char*);
 9da:	8bce                	mv	s7,s3
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	bd49                	j	870 <vprintf+0x44>
    }
  }
}
 9e0:	60a6                	ld	ra,72(sp)
 9e2:	6406                	ld	s0,64(sp)
 9e4:	74e2                	ld	s1,56(sp)
 9e6:	7942                	ld	s2,48(sp)
 9e8:	79a2                	ld	s3,40(sp)
 9ea:	7a02                	ld	s4,32(sp)
 9ec:	6ae2                	ld	s5,24(sp)
 9ee:	6b42                	ld	s6,16(sp)
 9f0:	6ba2                	ld	s7,8(sp)
 9f2:	6c02                	ld	s8,0(sp)
 9f4:	6161                	addi	sp,sp,80
 9f6:	8082                	ret

00000000000009f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f8:	715d                	addi	sp,sp,-80
 9fa:	ec06                	sd	ra,24(sp)
 9fc:	e822                	sd	s0,16(sp)
 9fe:	1000                	addi	s0,sp,32
 a00:	e010                	sd	a2,0(s0)
 a02:	e414                	sd	a3,8(s0)
 a04:	e818                	sd	a4,16(s0)
 a06:	ec1c                	sd	a5,24(s0)
 a08:	03043023          	sd	a6,32(s0)
 a0c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a10:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a14:	8622                	mv	a2,s0
 a16:	00000097          	auipc	ra,0x0
 a1a:	e16080e7          	jalr	-490(ra) # 82c <vprintf>
}
 a1e:	60e2                	ld	ra,24(sp)
 a20:	6442                	ld	s0,16(sp)
 a22:	6161                	addi	sp,sp,80
 a24:	8082                	ret

0000000000000a26 <printf>:

void
printf(const char *fmt, ...)
{
 a26:	711d                	addi	sp,sp,-96
 a28:	ec06                	sd	ra,24(sp)
 a2a:	e822                	sd	s0,16(sp)
 a2c:	1000                	addi	s0,sp,32
 a2e:	e40c                	sd	a1,8(s0)
 a30:	e810                	sd	a2,16(s0)
 a32:	ec14                	sd	a3,24(s0)
 a34:	f018                	sd	a4,32(s0)
 a36:	f41c                	sd	a5,40(s0)
 a38:	03043823          	sd	a6,48(s0)
 a3c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a40:	00840613          	addi	a2,s0,8
 a44:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a48:	85aa                	mv	a1,a0
 a4a:	4505                	li	a0,1
 a4c:	00000097          	auipc	ra,0x0
 a50:	de0080e7          	jalr	-544(ra) # 82c <vprintf>
}
 a54:	60e2                	ld	ra,24(sp)
 a56:	6442                	ld	s0,16(sp)
 a58:	6125                	addi	sp,sp,96
 a5a:	8082                	ret

0000000000000a5c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a5c:	1141                	addi	sp,sp,-16
 a5e:	e422                	sd	s0,8(sp)
 a60:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a62:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a66:	00000797          	auipc	a5,0x0
 a6a:	5b27b783          	ld	a5,1458(a5) # 1018 <freep>
 a6e:	a02d                	j	a98 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 a70:	4618                	lw	a4,8(a2)
 a72:	9f2d                	addw	a4,a4,a1
 a74:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 a78:	6398                	ld	a4,0(a5)
 a7a:	6310                	ld	a2,0(a4)
 a7c:	a83d                	j	aba <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 a7e:	ff852703          	lw	a4,-8(a0)
 a82:	9f31                	addw	a4,a4,a2
 a84:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 a86:	ff053683          	ld	a3,-16(a0)
 a8a:	a091                	j	ace <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8c:	6398                	ld	a4,0(a5)
 a8e:	00e7e463          	bltu	a5,a4,a96 <free+0x3a>
 a92:	00e6ea63          	bltu	a3,a4,aa6 <free+0x4a>
{
 a96:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a98:	fed7fae3          	bgeu	a5,a3,a8c <free+0x30>
 a9c:	6398                	ld	a4,0(a5)
 a9e:	00e6e463          	bltu	a3,a4,aa6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	fee7eae3          	bltu	a5,a4,a96 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 aa6:	ff852583          	lw	a1,-8(a0)
 aaa:	6390                	ld	a2,0(a5)
 aac:	02059813          	slli	a6,a1,0x20
 ab0:	01c85713          	srli	a4,a6,0x1c
 ab4:	9736                	add	a4,a4,a3
 ab6:	fae60de3          	beq	a2,a4,a70 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 aba:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 abe:	4790                	lw	a2,8(a5)
 ac0:	02061593          	slli	a1,a2,0x20
 ac4:	01c5d713          	srli	a4,a1,0x1c
 ac8:	973e                	add	a4,a4,a5
 aca:	fae68ae3          	beq	a3,a4,a7e <free+0x22>
        p->s.ptr = bp->s.ptr;
 ace:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 ad0:	00000717          	auipc	a4,0x0
 ad4:	54f73423          	sd	a5,1352(a4) # 1018 <freep>
}
 ad8:	6422                	ld	s0,8(sp)
 ada:	0141                	addi	sp,sp,16
 adc:	8082                	ret

0000000000000ade <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 ade:	7139                	addi	sp,sp,-64
 ae0:	fc06                	sd	ra,56(sp)
 ae2:	f822                	sd	s0,48(sp)
 ae4:	f426                	sd	s1,40(sp)
 ae6:	f04a                	sd	s2,32(sp)
 ae8:	ec4e                	sd	s3,24(sp)
 aea:	e852                	sd	s4,16(sp)
 aec:	e456                	sd	s5,8(sp)
 aee:	e05a                	sd	s6,0(sp)
 af0:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 af2:	02051493          	slli	s1,a0,0x20
 af6:	9081                	srli	s1,s1,0x20
 af8:	04bd                	addi	s1,s1,15
 afa:	8091                	srli	s1,s1,0x4
 afc:	0014899b          	addiw	s3,s1,1
 b00:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b02:	00000517          	auipc	a0,0x0
 b06:	51653503          	ld	a0,1302(a0) # 1018 <freep>
 b0a:	c515                	beqz	a0,b36 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b0c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b0e:	4798                	lw	a4,8(a5)
 b10:	02977f63          	bgeu	a4,s1,b4e <malloc+0x70>
    if (nu < 4096)
 b14:	8a4e                	mv	s4,s3
 b16:	0009871b          	sext.w	a4,s3
 b1a:	6685                	lui	a3,0x1
 b1c:	00d77363          	bgeu	a4,a3,b22 <malloc+0x44>
 b20:	6a05                	lui	s4,0x1
 b22:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b26:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b2a:	00000917          	auipc	s2,0x0
 b2e:	4ee90913          	addi	s2,s2,1262 # 1018 <freep>
    if (p == (char *)-1)
 b32:	5afd                	li	s5,-1
 b34:	a895                	j	ba8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b36:	00000797          	auipc	a5,0x0
 b3a:	56a78793          	addi	a5,a5,1386 # 10a0 <base>
 b3e:	00000717          	auipc	a4,0x0
 b42:	4cf73d23          	sd	a5,1242(a4) # 1018 <freep>
 b46:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b48:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b4c:	b7e1                	j	b14 <malloc+0x36>
            if (p->s.size == nunits)
 b4e:	02e48c63          	beq	s1,a4,b86 <malloc+0xa8>
                p->s.size -= nunits;
 b52:	4137073b          	subw	a4,a4,s3
 b56:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b58:	02071693          	slli	a3,a4,0x20
 b5c:	01c6d713          	srli	a4,a3,0x1c
 b60:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b62:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b66:	00000717          	auipc	a4,0x0
 b6a:	4aa73923          	sd	a0,1202(a4) # 1018 <freep>
            return (void *)(p + 1);
 b6e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 b72:	70e2                	ld	ra,56(sp)
 b74:	7442                	ld	s0,48(sp)
 b76:	74a2                	ld	s1,40(sp)
 b78:	7902                	ld	s2,32(sp)
 b7a:	69e2                	ld	s3,24(sp)
 b7c:	6a42                	ld	s4,16(sp)
 b7e:	6aa2                	ld	s5,8(sp)
 b80:	6b02                	ld	s6,0(sp)
 b82:	6121                	addi	sp,sp,64
 b84:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 b86:	6398                	ld	a4,0(a5)
 b88:	e118                	sd	a4,0(a0)
 b8a:	bff1                	j	b66 <malloc+0x88>
    hp->s.size = nu;
 b8c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 b90:	0541                	addi	a0,a0,16
 b92:	00000097          	auipc	ra,0x0
 b96:	eca080e7          	jalr	-310(ra) # a5c <free>
    return freep;
 b9a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 b9e:	d971                	beqz	a0,b72 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ba0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ba2:	4798                	lw	a4,8(a5)
 ba4:	fa9775e3          	bgeu	a4,s1,b4e <malloc+0x70>
        if (p == freep)
 ba8:	00093703          	ld	a4,0(s2)
 bac:	853e                	mv	a0,a5
 bae:	fef719e3          	bne	a4,a5,ba0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 bb2:	8552                	mv	a0,s4
 bb4:	00000097          	auipc	ra,0x0
 bb8:	b7a080e7          	jalr	-1158(ra) # 72e <sbrk>
    if (p == (char *)-1)
 bbc:	fd5518e3          	bne	a0,s5,b8c <malloc+0xae>
                return 0;
 bc0:	4501                	li	a0,0
 bc2:	bf45                	j	b72 <malloc+0x94>
